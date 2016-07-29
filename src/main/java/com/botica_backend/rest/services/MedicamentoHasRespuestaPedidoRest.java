/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.rest.services;

import com.botica_backend.entities.MedicamentoHasRespuestaPedido;
import com.botica_backend.sessions.MedicamentoHasRespuestaPedidoSession;
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
 * @author Luis
 */
@Stateless
@Path("medicamentoshasrespuestaspedidos")
public class MedicamentoHasRespuestaPedidoRest {

    @EJB
    MedicamentoHasRespuestaPedidoSession medicamentoHasRespuestaPedidoSession;

    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(MedicamentoHasRespuestaPedido medicamentoHasRespuestaPedido) {
        medicamentoHasRespuestaPedidoSession.create(medicamentoHasRespuestaPedido);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, MedicamentoHasRespuestaPedido medicamentoHasRespuestaPedido) {
        medicamentoHasRespuestaPedidoSession.update(medicamentoHasRespuestaPedido);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        medicamentoHasRespuestaPedidoSession.remove(medicamentoHasRespuestaPedidoSession.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<MedicamentoHasRespuestaPedido> findAll() {
        return medicamentoHasRespuestaPedidoSession.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public MedicamentoHasRespuestaPedido findById(@PathParam("id") Integer id) {
        return medicamentoHasRespuestaPedidoSession.find(id);
    }

    @GET
    @Path("respuestapedido/{idRespuestaPedido}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<MedicamentoHasRespuestaPedido> findByIdRespuestaPedido(@PathParam("idRespuestaPedido") Integer id) {
        return medicamentoHasRespuestaPedidoSession.findByIdRespuestaPedido(id);
    }
}
