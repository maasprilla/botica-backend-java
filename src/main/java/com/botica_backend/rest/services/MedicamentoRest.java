/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.rest.services;

import com.botica_backend.entities.Ciudad;
import com.botica_backend.entities.Medicamento;
import com.botica_backend.sessions.MedicamentoSession;
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
 * @author adsi1
 */
@Stateless
@Path("medicamentos")
public class MedicamentoRest {
        
    @EJB
    MedicamentoSession medicamentoSession;
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create (Medicamento medicamento){
        medicamentoSession.create(medicamento);
    }
            
   @PUT
   @Path("{id}")
   @Consumes(MediaType.APPLICATION_JSON)
   public void update(@PathParam("id") Integer id, Medicamento medicamento){
       medicamentoSession.update(medicamento);
   }
   
    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        medicamentoSession.remove(medicamentoSession.find(id));
    }
   
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Medicamento> findAll() {
        return medicamentoSession.findAll();
    }
    
    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public Medicamento findById(@PathParam("id") Integer id) {
        return medicamentoSession.find(id);
    }
    
    @GET
    @Path("nombre/{nombre}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Medicamento> findByNombre(@PathParam("nombre") String nombre) {
        return medicamentoSession.findByNombre(nombre);
    }
}
