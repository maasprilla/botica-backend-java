
package com.botica_backend.rest.services;

import com.botica_backend.entities.Factura;
import com.botica_backend.sessions.FacturaSession;
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
@Path("facturas")
public class FacturaRest {
    
    @EJB
    FacturaSession facturaSession;
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(Factura factura) {
        facturaSession.create(factura);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, Factura factura) {
        facturaSession.update(factura);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        facturaSession.remove(facturaSession.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Factura> findAll() {
        return facturaSession.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Factura findById(@PathParam("id") Integer id) {
        return facturaSession.find(id);
    }
}
