
package com.botica_backend.rest.services;

import com.botica_backend.entities.Sede;
import com.botica_backend.sessions.SedeSession;
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
@Path("sedes")
public class SedeRest {
    
    @EJB
    SedeSession sedeSession;
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(Sede sede) {
        sedeSession.create(sede);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, Sede sede) {
        sedeSession.update(sede);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        sedeSession.remove(sedeSession.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Sede> findAll() {
        return sedeSession.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Sede findById(@PathParam("id") Integer id) {
        return sedeSession.find(id);
    }
}
