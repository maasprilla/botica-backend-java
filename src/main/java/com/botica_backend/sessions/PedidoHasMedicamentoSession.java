/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.sessions;

import com.botica_backend.entities.PedidoHasMedicamento;
import com.botica_backend.entities.PedidoHasMedicamento;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.NonUniqueResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;

/**
 *
 * @author Familia
 */
@Stateless
public class PedidoHasMedicamentoSession {

    @PersistenceContext
    private EntityManager entityManager;

    public void create(PedidoHasMedicamento pedidoHasMedicamento) {
        entityManager.persist(pedidoHasMedicamento);
    }

    public void update(PedidoHasMedicamento pedidoHasMedicamento) {
        entityManager.merge(pedidoHasMedicamento);

    }

    public void remove(PedidoHasMedicamento pedidoHasMedicamento) {
        entityManager.remove(pedidoHasMedicamento);

    }

    public List<PedidoHasMedicamento> findAll() {
        CriteriaQuery cq = entityManager.getCriteriaBuilder().createQuery();
        cq.select(cq.from(PedidoHasMedicamento.class));
        return entityManager.createQuery(cq).getResultList();
    }

    public PedidoHasMedicamento find(int id) {
        return entityManager.find(PedidoHasMedicamento.class, id);
    }

}
