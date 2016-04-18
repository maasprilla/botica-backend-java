/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.rest.auth;

import com.botica_backend.entities.Rol;
import com.botica_backend.entities.Usuario;
import com.botica_backend.sessions.UsuarioSession;
import com.nimbusds.jose.JOSEException;
import com.nimbusds.jwt.JWTClaimsSet;
import java.io.IOException;
import java.security.Principal;
import java.text.ParseException;
import javax.annotation.Priority;
import javax.ejb.EJB;
import javax.ws.rs.Priorities;
import javax.ws.rs.container.ContainerRequestContext;
import javax.ws.rs.container.ContainerRequestFilter;
import javax.ws.rs.container.ContainerResponseContext;
import javax.ws.rs.container.ContainerResponseFilter;
import javax.ws.rs.core.HttpHeaders;
import javax.ws.rs.core.SecurityContext;
import javax.ws.rs.ext.Provider;
import org.joda.time.DateTime;

/**
 *
 * @author adsi1
 */
@Provider
@Priority(Priorities.AUTHENTICATION)
public class SecurityFilter implements ContainerRequestFilter, ContainerResponseFilter {
    @EJB
    private UsuarioSession usuarioSession ;
    @Override
    public void filter(ContainerRequestContext requestContext) throws IOException {
        SecurityContext originalContext = requestContext.getSecurityContext();
        String authHeader = requestContext.getHeaderString(HttpHeaders.AUTHORIZATION);
        if (authHeader == null || authHeader.isEmpty() || authHeader.split(" ").length != 2) {
            Authorizer authorizer = new Authorizer(new Rol(),
                    "",
                    originalContext.isSecure());
                    requestContext.setSecurityContext(authorizer);
            
        } else {
            JWTClaimsSet claimSet = null;
            try {
                claimSet = (JWTClaimsSet) AuthUtils.decodeToken(authHeader);
            } catch (ParseException e) {
                throw new IOException("Error al codificar JW");
                
            } catch (JOSEException e) {
                throw new IOException("Token invalido");
            }

            // ensure that the token is not expired
            if (new DateTime(claimSet.getExpirationTime()).isBefore(DateTime.now())) {
                throw new IOException("El token no ha expirado");
            } else {
                Usuario user = usuarioSession.find(Integer.parseInt(claimSet.getSubject()));
                Authorizer authorizer = new Authorizer(user.getIdRol(), 
                user.getEmail(),
                originalContext.isSecure());
                requestContext.setSecurityContext(authorizer);
            }
        }
    }

    @Override
    public void filter(ContainerRequestContext requestContext, ContainerResponseContext responseContext) throws IOException {
        responseContext.getHeaders().putSingle("Access-Control-Allow-Origin", "*");
        responseContext.getHeaders().putSingle("Access-Control-Allow-Methods", "OPTIONS, GET, POST, PUT, DELETE");
        responseContext.getHeaders().putSingle("Access-Control-Allow-Headers", "Content-Type, Authorization");
    }

    public static class Authorizer implements SecurityContext{
        
        Rol rol;
        String username;
        boolean isSecure;

        public Authorizer(Rol rol, String username, boolean isSecure) {
            this.rol = rol;
            this.username = username;
            this.isSecure = isSecure;
        }
        
        
        @Override
        public Principal getUserPrincipal() {
        return new User(username);
        }
        

        @Override
        public boolean isUserInRole(String role) {
        return rol.getIdRol().equals(Integer.parseInt(role));
        }

        @Override
        public boolean isSecure() {
            return isSecure;
        }

        @Override
        public String getAuthenticationScheme() {
            return "JWT";
        }
        
    }
    
   public static class User implements Principal{
       String name;

        public User(String name) {
            this.name = name;
        }
       

        @Override
        public String getName() {
        return name;
        }
        
   }
    
}
