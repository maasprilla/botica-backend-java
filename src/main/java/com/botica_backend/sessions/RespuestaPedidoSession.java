/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.sessions;

import com.botica_backend.entities.RespuestaPedido;
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
public class RespuestaPedidoSession {
@PersistenceContext
    private EntityManager entityManager;

    public void create(RespuestaPedido respuestaPedido) {
        entityManager.persist(respuestaPedido);
    }
    
    public void update(RespuestaPedido respuestaPedido) {
        entityManager.merge(respuestaPedido);
    }
    
    public void remove(RespuestaPedido respuestaPedido) {
        entityManager.remove(respuestaPedido);
    }

    public List<RespuestaPedido> findAll() {
        CriteriaQuery cq = entityManager.getCriteriaBuilder().createQuery();
        cq.select(cq.from(RespuestaPedido.class));
        return entityManager.createQuery(cq).getResultList();
    }
}
