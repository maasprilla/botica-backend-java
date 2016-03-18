/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.sessions;

import com.botica_backend.entities.Departamento;
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
public class DepartamentoSession {

     @PersistenceContext
    private EntityManager entityManager;

    public void create(Departamento departamento) {
        entityManager.persist(departamento);
    }
    
    public void update(Departamento departamento) {
        entityManager.merge(departamento);
    }
    
    public void remove(Departamento departamento) {
        entityManager.remove(departamento);
    }

    public List<Departamento> findAll() {
        CriteriaQuery cq = entityManager.getCriteriaBuilder().createQuery();
        cq.select(cq.from(Departamento.class));
        return entityManager.createQuery(cq).getResultList();
    }
}
