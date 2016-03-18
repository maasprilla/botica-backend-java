/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.sessions;

import com.botica_backend.entities.Ciudad;
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
public class CiudadSession {

    @PersistenceContext
    private EntityManager entityManager;
    
    
    public void create (Ciudad ciudad) {
        entityManager.persist(ciudad);
    }
    
    public void update (Ciudad ciudad){
        entityManager.merge(ciudad);
        
    }
    public void remove (Ciudad ciudad){
        entityManager.remove(ciudad);
        
    }
    public List<Ciudad> findAll(){
          CriteriaQuery cq = entityManager.getCriteriaBuilder().createQuery();
        cq.select(cq.from(Ciudad.class));
        return entityManager.createQuery(cq).getResultList();
    }
}
