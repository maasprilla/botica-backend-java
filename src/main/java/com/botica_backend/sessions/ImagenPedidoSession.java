/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.sessions;

import com.botica_backend.entities.ImagenPedido;
import com.botica_backend.entities.Usuario;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;

/**
 *
 * @author Familia
 */
@Stateless
public class ImagenPedidoSession {

    @PersistenceContext
    private EntityManager entityManager;

    public void create(ImagenPedido imagenpedido) {
        entityManager.persist(imagenpedido);
    }

    public void update(ImagenPedido imagenpedido) {
        entityManager.merge(imagenpedido);
    }

    public void remove(ImagenPedido imagenpedido) {
        entityManager.remove(imagenpedido);
    }

    public List<ImagenPedido> findAll() {
        CriteriaQuery cq = entityManager.getCriteriaBuilder().createQuery();
        cq.select(cq.from(ImagenPedido.class));
        return entityManager.createQuery(cq).getResultList();
    }

    public ImagenPedido find(int id) {

        return entityManager.find(ImagenPedido.class, id);
    }
}
