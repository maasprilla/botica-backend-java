package com.botica_backend.rest.services;

import com.botica_backend.entities.Ciudad;
import com.botica_backend.entities.Usuario;
import com.botica_backend.sessions.CiudadSession;
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
@Path("ciudades")
public class CiudadRest {

    @EJB
    CiudadSession ciudadSession;

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(Ciudad ciudad) {
        ciudadSession.create(ciudad);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, Ciudad ciudad) {
        ciudadSession.update(ciudad);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        ciudadSession.remove(ciudadSession.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Ciudad> findAll() {
        return ciudadSession.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Ciudad findById(@PathParam("id") Integer id) {
        return ciudadSession.find(id);
    }

    @GET
    @Path("nombre/{nombre}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Ciudad> findByNombre(@PathParam("nombre") String nombre) {
        return ciudadSession.findByNombre(nombre);
    }
}
