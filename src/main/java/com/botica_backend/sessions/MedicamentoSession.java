/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.sessions;

import com.botica_backend.entities.Medicamento;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;

/**
 *
 * @author adsi1
 */
@Stateless
public class MedicamentoSession {
@PersistenceContext
    private EntityManager entityManager;

public void create(Medicamento medicamento){
    entityManager.persist(medicamento);
}

public void update(Medicamento medicamento){
    entityManager.merge(medicamento);
}

public void remove(Medicamento medicamento){
    entityManager.remove(medicamento);
}

public List<Medicamento> findAll(){
    CriteriaQuery cq = entityManager.getCriteriaBuilder().createQuery();
    cq.select(cq.from(Medicamento.class));
    return entityManager.createQuery(cq).getResultList();
    
}
public Medicamento find(int id) {

        return entityManager.find(Medicamento.class, id);

}
}