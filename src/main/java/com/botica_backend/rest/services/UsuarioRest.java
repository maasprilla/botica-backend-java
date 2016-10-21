package com.botica_backend.rest.services;

import com.botica_backend.entities.Sede;
import com.botica_backend.entities.Usuario;
import com.botica_backend.rest.auth.DigestUtil;
import com.botica_backend.sessions.SedeSession;
import com.botica_backend.sessions.UsuarioSession;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 *
 * @author usuario
 */
@Stateless
@Path("usuarios")
public class UsuarioRest {

    @EJB
    UsuarioSession usuarioSession;
    
    @EJB
    SedeSession sedeSession;
    
    

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response create(Usuario usuario) {
        GsonBuilder builder = new GsonBuilder();
        Gson gson = builder.create();
        if (usuarioSession.findByEmail(usuario.getEmail()) == null) {
            try {
                usuario.setPassword(DigestUtil.generateDigest(usuario.getPassword()));
            } catch (NoSuchAlgorithmException | UnsupportedEncodingException ex) {
                Logger.getLogger(UsuarioRest.class.getName()).log(Level.SEVERE, null, ex);
            }
            usuarioSession.create(usuario);
            if(usuario.getIdRol().getIdRol().equals("DROG")){
                Sede sede=new Sede(null, usuario.getNombre(), usuario.getDireccion(), usuario.getEmail(), usuario.getTelefono());
                sede.setIdDrogueria(usuario);
                sedeSession.create(sede);
            }
            return Response.ok()
                    .entity(gson.toJson("ACEPTADO"))
                    .build();

        } else {
            return Response
                    .status(Response.Status.CONFLICT)
                    .entity(gson.toJson("el email ya se encuentra registrado"))
                    .build();

        }
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, Usuario usuario) {
        try {
            usuario.setPassword(DigestUtil.generateDigest(usuario.getPassword()));
        } catch (NoSuchAlgorithmException | UnsupportedEncodingException ex) {
            Logger.getLogger(UsuarioRest.class.getName()).log(Level.SEVERE, null, ex);
        }
        usuarioSession.update(usuario);

    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        usuarioSession.remove(usuarioSession.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Usuario> findAll() {
        return usuarioSession.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Usuario findById(@PathParam("id") Integer id) {
        return usuarioSession.find(id);
    }

    @GET
    @Path("roles/{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Usuario> findAllByRol(@PathParam("id") String id) {
        return usuarioSession.findAllByRol(id);
    }

    @GET
    @Path("nombredrogueria/{nombre}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Usuario> findDrogueriaByNombre(@PathParam("nombre") String nombre) {
        return usuarioSession.findDrogueriaByNombre(nombre);
    }

    @GET
    @Path("idcodigo/{id}/{codigo}")
    @Produces(MediaType.APPLICATION_JSON)
    public Usuario findByIdAndCode(@PathParam("id") String id, @PathParam("codigo") String codigo) {
        return usuarioSession.findByIdAndCode(Integer.parseInt(id), codigo);
    }
}
