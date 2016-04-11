
package com.botica_backend.rest.services;

import com.botica_backend.entities.Calificacion;
import com.botica_backend.sessions.CalificacionSession;
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
@Path("calificacion")
public class CalificacionRest {
    
    @EJB
    CalificacionSession calificacionSession;
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(Calificacion calificacion) {
        calificacionSession.create(calificacion);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, Calificacion calificacion) {
        calificacionSession.update(calificacion);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        calificacionSession.remove(calificacionSession.findbyUsuario(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Calificacion> findAll() {
        return calificacionSession.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Calificacion findById(@PathParam("id") Integer id) {
        return calificacionSession.findbyUsuario(id);
    }
}
