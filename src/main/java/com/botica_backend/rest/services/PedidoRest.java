package com.botica_backend.rest.services;

import com.botica_backend.entities.Pedido;
import com.botica_backend.entities.PedidoHasMedicamento;
import com.botica_backend.entities.Usuario;
import com.botica_backend.rest.auth.AuthUtils;
import com.botica_backend.sessions.PedidoSession;
import com.nimbusds.jose.JOSEException;
import java.text.ParseException;
import java.util.List;
import java.util.logging.Level;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.DELETE;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import org.glassfish.hk2.utilities.reflection.Logger;

/**
 *
 * @author usuario
 */
@Stateless
@Path("pedidos")
public class PedidoRest {

    @EJB
    PedidoSession pedidoSession;

    @Context
    private HttpServletRequest request;

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(Pedido pedido) {
        for (PedidoHasMedicamento item : pedido.getPedidoHasMedicamentoList()) {
            item.setIdPedido(pedido);
        }
        pedidoSession.create(pedido);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, Pedido pedido) {
        for (PedidoHasMedicamento item : pedido.getPedidoHasMedicamentoList()) {
            item.setIdPedido(pedido);
        }
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

    @GET
    @Path("estadoPedidoAndUsuario/{idEstadoPedido}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Pedido> findByidEstadoPedidoAndUsuario(@PathParam("idEstadoPedido") Integer id) {
        try {
            return pedidoSession.findByEstadoPedidoAndUsuario(id, new Usuario(Integer.parseInt(AuthUtils.getSubject(request.getHeader(AuthUtils.AUTH_HEADER_KEY)))));
        } catch (ParseException | JOSEException ex) {
            //Logger.getLogger(PedidoRest.class.getName()).log(Level.SEVERE, null, ex);
            //poner 
            return null;
        }

    }
    
    @GET
    @Path("pedidoConcretadoDrogueria")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Pedido> findByConcretadoAndDrogueria() {
        try {
            return pedidoSession.findByConcretadoAndDrogueria(new Usuario(Integer.parseInt(AuthUtils.getSubject(request.getHeader(AuthUtils.AUTH_HEADER_KEY)))));
        } catch (ParseException | JOSEException ex) {
            //Logger.getLogger(PedidoRest.class.getName()).log(Level.SEVERE, null, ex);
            //poner 
            return null;
        }

    }

    @GET
    @Path("estadoPedido/{idEstadoPedido}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Pedido> findByidEstadoPedido(@PathParam("idEstadoPedido") Integer id) {
        return pedidoSession.findByEstadoPedido(id);

    }

}
