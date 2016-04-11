
package com.botica_backend.rest.services;

import com.botica_backend.entities.ImagenPedido;
import com.botica_backend.sessions.ImagenPedidoSession;
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
@Path("imagenespedidos")
public class ImagenPedidoRest {
    
    @EJB
    ImagenPedidoSession imagenpedidoSession;
    
    @POST
    @Consumes(MediaType.APPLICATION_JSON)
    public void create(ImagenPedido imagenpedido) {
        imagenpedidoSession.create(imagenpedido);
    }

    @PUT
    @Path("{id}")
    @Consumes(MediaType.APPLICATION_JSON)
    public void update(@PathParam("id") Integer id, ImagenPedido imagenpedido) {
        imagenpedidoSession.update(imagenpedido);
    }

    @DELETE
    @Path("{id}")
    public void remove(@PathParam("id") Integer id) {
        imagenpedidoSession.remove(imagenpedidoSession.find(id));
    }

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<ImagenPedido> findAll() {
        return imagenpedidoSession.findAll();
    }

    @GET
    @Path("{id}")
    @Produces(MediaType.APPLICATION_JSON)
    public ImagenPedido findById(@PathParam("id") Integer id) {
        return imagenpedidoSession.find(id);
    }
}
