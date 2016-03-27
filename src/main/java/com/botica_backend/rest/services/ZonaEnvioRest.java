
package com.botica_backend.rest.services;

import com.botica_backend.entities.ZonaEnvio;
import com.botica_backend.sessions.ZonaEnvioSession;
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
@Path("zonasenvios")
public class ZonaEnvioRest {
    
    @EJB
    ZonaEnvioSession zonaEnvioSession;
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(ZonaEnvio zonaEnvio) {
        zonaEnvioSession.create(zonaEnvio);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, ZonaEnvio zonaEnvio) {
        zonaEnvioSession.update(zonaEnvio);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        zonaEnvioSession.remove(zonaEnvioSession.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<ZonaEnvio> findAll() {
        return zonaEnvioSession.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public ZonaEnvio findById(@PathParam("id") Integer id) {
        return zonaEnvioSession.find(id);
    }
}
