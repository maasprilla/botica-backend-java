package com.botica_backend.rest.services;

import com.botica_backend.entities.MedicamentoHasRespuestaPedido;
import com.botica_backend.entities.PedidoHasMedicamento;
import com.botica_backend.entities.RespuestaPedido;
import com.botica_backend.entities.Sede;
import com.botica_backend.entities.Usuario;
import com.botica_backend.rest.auth.AuthUtils;
import com.botica_backend.sessions.RespuestaPedidoSession;
import com.botica_backend.sessions.UsuarioSession;
import com.nimbusds.jose.JOSEException;
import java.text.ParseException;
import java.util.List;
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

/**
 *
 * @author usuario
 */
@Stateless
@Path("respuestaspedidos")
public class RespuestaPedidoRest {

    @EJB
    RespuestaPedidoSession respuestaPedidoSession;
    
    @EJB
    UsuarioSession usuarioSession;
    
    @Context
    private HttpServletRequest request;

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(RespuestaPedido respuestaPedido) {
        try{
        Usuario currentDrog=usuarioSession.find(Integer.parseInt(AuthUtils.getSubject(request.getHeader(AuthUtils.AUTH_HEADER_KEY))));
        Sede sede=currentDrog.getSedeList().get(0);
        for (MedicamentoHasRespuestaPedido item : respuestaPedido.getMedicamentoHasRespuestaPedidoList()) {
            item.setIdRespuestaPedido(respuestaPedido);
        }
        respuestaPedido.setIdSede(sede);
        respuestaPedidoSession.create(respuestaPedido);
        } catch (ParseException | JOSEException ex) {
            //Logger.getLogger(PedidoRest.class.getName()).log(Level.SEVERE, null, ex);
            //poner 
        }
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
    @Path("usuario")
    @Produces(MediaType.APPLICATION_JSON)
    public List<RespuestaPedido> findByIdUsuario() {
        try {
            return respuestaPedidoSession.findByIdUsuario(new Usuario(Integer.parseInt(AuthUtils.getSubject(request.getHeader(AuthUtils.AUTH_HEADER_KEY)))));
        } catch (ParseException | JOSEException ex) {
            //Logger.getLogger(PedidoRest.class.getName()).log(Level.SEVERE, null, ex);
            //poner 
            return null;
        }
        
    }
    
    @GET
    @Path("drogueria")
    @Produces(MediaType.APPLICATION_JSON)
    public List<RespuestaPedido> findByIdDrogueria() {
        try {
            return respuestaPedidoSession.findByIdDrogueria(new Usuario(Integer.parseInt(AuthUtils.getSubject(request.getHeader(AuthUtils.AUTH_HEADER_KEY)))));
        } catch (ParseException | JOSEException ex) {
            //Logger.getLogger(PedidoRest.class.getName()).log(Level.SEVERE, null, ex);
            //poner 
            return null;
        }
        
    }
}
