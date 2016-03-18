/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.sessions;

import com.botica_backend.entities.Sede;
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
public class SedeSession {

    @PersistenceContext
    private EntityManager entityManager;

    public void create(Sede sede) {
        entityManager.persist(sede);
    }

    public void update(Sede sede) {
        entityManager.merge(sede);

    }

    public void remove(Sede sede) {
        entityManager.remove(sede);

    }

    public List<Sede> findAll() {
        CriteriaQuery cq = entityManager.getCriteriaBuilder().createQuery();
        cq.select(cq.from(Sede.class));
        return entityManager.createQuery(cq).getResultList();
    }
}
