package com.botica_backend.rest.services;

import com.botica_backend.entities.MedicamentoHasRespuestaPedido;
import com.botica_backend.entities.PedidoHasMedicamento;
import com.botica_backend.entities.RespuestaPedido;
import com.botica_backend.sessions.RespuestaPedidoSession;
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
@Path("respuestaspedidos")
public class RespuestaPedidoRest {

    @EJB
    RespuestaPedidoSession respuestaPedidoSession;

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(RespuestaPedido respuestaPedido) {
        for (MedicamentoHasRespuestaPedido item : respuestaPedido.getMedicamentoHasRespuestaPedidoList()) {
            item.setIdRespuestaPedido(respuestaPedido);
        }
        respuestaPedidoSession.create(respuestaPedido);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, RespuestaPedido respuestaPedido) {
        respuestaPedidoSession.update(respuestaPedido);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        respuestaPedidoSession.remove(respuestaPedidoSession.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<RespuestaPedido> findAll() {
        return respuestaPedidoSession.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public RespuestaPedido findById(@PathParam("id") Integer id) {
        return respuestaPedidoSession.find(id);
    }

    @GET
    @Path("usuario/{idUsuario}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<RespuestaPedido> findByIdUsuario(@PathParam("idUsuario") Integer id) {
        return respuestaPedidoSession.findByIdUsuario(id);
    }
}
