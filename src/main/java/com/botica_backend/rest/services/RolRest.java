
package com.botica_backend.rest.services;

import com.botica_backend.entities.Rol;
import com.botica_backend.sessions.RolSession;
import java.util.List;
import javax.annotation.security.RolesAllowed;
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
@Path("roles")
public class RolRest {
    
    @EJB
    RolSession rolSession;
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(Rol rol) {
        rolSession.create(rol);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, Rol rol) {
        rolSession.update(rol);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        rolSession.remove(rolSession.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Rol> findAll() {
        return rolSession.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Rol findById(@PathParam("id") Integer id) {
        return rolSession.find(id);
    }
}
