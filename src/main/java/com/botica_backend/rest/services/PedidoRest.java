
package com.botica_backend.rest.services;

import com.botica_backend.entities.Pedido;
import com.botica_backend.sessions.PedidoSession;
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
@Path("pedidos")
public class PedidoRest {
    
    @EJB
    PedidoSession pedidoSession;
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(Pedido pedido) {
        pedidoSession.create(pedido);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, Pedido pedido) {
        pedidoSession.update(pedido);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        pedidoSession.remove(pedidoSession.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Pedido> findAll() {
        return pedidoSession.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Pedido findById(@PathParam("id") Integer id) {
        return pedidoSession.find(id);
    }
}
