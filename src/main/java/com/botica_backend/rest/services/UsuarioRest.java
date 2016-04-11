
package com.botica_backend.rest.services;

import com.botica_backend.entities.Usuario;
import com.botica_backend.sessions.UsuarioSession;
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
    public void create(Usuario usuario) {
        usuarioSession.create(usuario);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, Usuario usuario) {
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
}
