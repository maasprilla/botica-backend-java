/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.sessions;

import com.botica_backend.entities.ZonaEnvio;
import static com.botica_backend.entities.ZonaEnvio_.idZonaEnvio;
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
public class ZonaEnvioSession {

    @PersistenceContext
    private EntityManager entityManager;
    
    
    public void create (ZonaEnvio zona) {
        entityManager.persist(zona);
    }
    
    public void update (ZonaEnvio zona){
        entityManager.merge(zona);
        
    }
    public void remove (ZonaEnvio zona){
        entityManager.remove(zona);
        
    }
    public List<ZonaEnvio> findAll(){
          CriteriaQuery cq = entityManager.getCriteriaBuilder().createQuery();
        cq.select(cq.from(ZonaEnvio.class));
        return entityManager.createQuery(cq).getResultList();
    }
    
    public ZonaEnvio find(int id) {
        try {
            return (ZonaEnvio) entityManager.createNamedQuery("Sede.findByIdZonaEnvio")
                    .setParameter("idZonaEnvio", idZonaEnvio)
                    .getSingleResult();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }

    }
}
