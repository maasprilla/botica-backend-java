/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.sessions;

import com.botica_backend.entities.Rol;
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
public class RolSession {

    @PersistenceContext
    private EntityManager entityManager;
    
    
    public void create (Rol rol) {
        entityManager.persist(rol);
    }
    
    public void update (Rol rol){
        entityManager.merge(rol);
        
    }
    public void remove (Rol rol){
        entityManager.remove(rol);
        
    }
    public List<Rol> findAll(){
          CriteriaQuery cq = entityManager.getCriteriaBuilder().createQuery();
        cq.select(cq.from(Rol.class));
        return entityManager.createQuery(cq).getResultList();
    }
    
        public Rol find(int id) {

        return entityManager.find(Rol.class, id);
    }
}
