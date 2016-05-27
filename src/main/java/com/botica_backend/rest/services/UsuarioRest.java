package com.botica_backend.rest.services;

import com.botica_backend.entities.Usuario;
import com.botica_backend.sessions.UsuarioSession;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.util.List;
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

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public Response create(Usuario usuario) {
        GsonBuilder builder = new GsonBuilder();
        Gson gson = builder.create();
        if (usuarioSession.findByEmail(usuario.getEmail()) == null) {
            usuarioSession.create(usuario);
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
        Usuario user = usuarioSession.find(id);

        user.setNombre(usuario.getNombre());
        user.setApellido(usuario.getApellido());
        user.setDni(usuario.getDni());
        user.setEmail(usuario.getEmail());
        user.setFechaNac(usuario.getFechaNac());
        user.setIdRol(usuario.getIdRol());
        user.setIdUsuario(usuario.getIdUsuario());
        user.setImgPerfil(usuario.getImgPerfil());
        user.setCiudad(usuario.getCiudad());
        user.setDireccion(usuario.getDireccion());
        user.setTelefono(usuario.getTelefono());
        user.setLatitud(usuario.getLatitud());
        user.setLongitud(usuario.getLongitud());
        

        if (user.getIdRol().getIdRol().equals("DROG")) {
            user.setNombreDrogueria(usuario.getNombreDrogueria());
            user.setInvima(usuario.getInvima());
            user.setNit(usuario.getNit());
            user.setCamaracomercio(usuario.getCamaracomercio());
        }

        usuarioSession.update(user);

    }
    
    @PUT
    @Path("passconfirm/{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void updatePass(@PathParam("id") Integer id, Usuario usuario) {
        Usuario user = usuarioSession.find(id);
        String newpass=usuario.getCamaracomercio();
        user.setPassword(newpass);
        usuarioSession.update(user);
          int x=0;
//        usuarioSession.update(user);

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
    @Path("idcodigo/{id}/{codigo}")
    @Produces(MediaType.APPLICATION_JSON)
    public Usuario findByIdAndCode(@PathParam("id") String id, @PathParam("codigo") String codigo) {      
        return usuarioSession.findByIdAndCode(Integer.parseInt(id), codigo);
    }
}
