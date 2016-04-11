
package com.botica_backend.rest.services;

import com.botica_backend.entities.Pais;
import com.botica_backend.sessions.PaisSession;
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
@Path("paises")
public class PaisRest {
    
    @EJB
    PaisSession paisSession;
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(Pais pais) {
        paisSession.create(pais);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, Pais pais) {
        paisSession.update(pais);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        paisSession.remove(paisSession.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Pais> findAll() {
        return paisSession.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Pais findById(@PathParam("id") Integer id) {
        return paisSession.find(id);
    }
}
