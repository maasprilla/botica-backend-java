package com.botica_backend.rest.auth;

import com.botica_backend.entities.Usuario;
import com.botica_backend.rest.services.UsuarioRest;
import com.botica_backend.sessions.UsuarioSession;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.nimbusds.jose.JOSEException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 *
 * @author usuario
 */
@Path("auth")
public class AuthREST {

    public static final String CLIENT_ID_KEY = "client_id", REDIRECT_URI_KEY = "redirect_uri",
            CLIENT_SECRET = "client_secret", CODE_KEY = "code", GRANT_TYPE_KEY = "grant_type",
            AUTH_CODE = "authorization_code";

    public static final String NOT_FOUND_MSG = "User not found", LOGING_ERROR_MSG = "Wrong email and/or password";

    @EJB
    private UsuarioSession usuarioSession;

    @POST
    @Path("login")
    @Consumes({MediaType.APPLICATION_JSON})
    @Produces({MediaType.APPLICATION_JSON})
    public Response login(Usuario user, @Context final HttpServletRequest request) throws JOSEException {
        final Usuario foundUser;
        GsonBuilder builder = new GsonBuilder();
        Gson gson = builder.create();
        try {
            user.setPassword(DigestUtil.generateDigest(user.getPassword()));
            foundUser = usuarioSession.findByEmail(user.getEmail());
            if (foundUser == null) {
                return Response.status(Response.Status.UNAUTHORIZED).entity(gson.toJson(NOT_FOUND_MSG)).build();
            } else if (user.getPassword().equals(foundUser.getPassword())) {
                final Token token = AuthUtils.createToken(request.getRemoteHost(), foundUser);
                return Response.ok().entity(gson.toJson(token)).build();
            }
        } catch (NoSuchAlgorithmException | UnsupportedEncodingException ex) {
            Logger.getLogger(UsuarioRest.class.getName()).log(Level.SEVERE, null, ex);
        }

        return Response.status(Response.Status.UNAUTHORIZED).entity(gson.toJson(LOGING_ERROR_MSG)).build();
    }
}
