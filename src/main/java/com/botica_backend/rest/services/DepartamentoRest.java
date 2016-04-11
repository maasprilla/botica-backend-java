
package com.botica_backend.rest.services;

import com.botica_backend.entities.Departamento;
import com.botica_backend.sessions.DepartamentoSession;
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
@Path("departamentos")
public class DepartamentoRest {
    
    @EJB
    DepartamentoSession departamentoSession;
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(Departamento departamento) {
        departamentoSession.create(departamento);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, Departamento departamento) {
        departamentoSession.update(departamento);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        departamentoSession.remove(departamentoSession.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Departamento> findAll() {
        return departamentoSession.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Departamento findById(@PathParam("id") Integer id) {
        return departamentoSession.find(id);
    }
}
