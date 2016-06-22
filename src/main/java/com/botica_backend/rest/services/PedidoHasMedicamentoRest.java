package com.botica_backend.rest.services;

import com.botica_backend.entities.PedidoHasMedicamento;
import com.botica_backend.sessions.PedidoHasMedicamentoSession;
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
@Path("pedidoHasMedicamentos")
public class PedidoHasMedicamentoRest {

    @EJB
    PedidoHasMedicamentoSession pedidoHasMedicamentoSession;

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(PedidoHasMedicamento pedidoHasMedicamento) {
        pedidoHasMedicamentoSession.create(pedidoHasMedicamento);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, PedidoHasMedicamento pedidoHasMedicamento) {
        pedidoHasMedicamentoSession.update(pedidoHasMedicamento);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        pedidoHasMedicamentoSession.remove(pedidoHasMedicamentoSession.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<PedidoHasMedicamento> findAll() {
        return pedidoHasMedicamentoSession.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public PedidoHasMedicamento findById(@PathParam("id") Integer id) {
        return pedidoHasMedicamentoSession.find(id);
    }
}
