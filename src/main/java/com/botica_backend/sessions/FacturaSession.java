/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.sessions;

import com.botica_backend.entities.Factura;
import com.botica_backend.entities.Usuario;
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
public class FacturaSession {

    @PersistenceContext
    private EntityManager entityManager;

    public void create(Factura factura) {
        entityManager.persist(factura);
    }

    public void update(Factura factura) {
        entityManager.merge(factura);
    }

    public void remove(Factura factura) {
        entityManager.remove(factura);
    }

    public List<Factura> findAll() {
        CriteriaQuery cq = entityManager.getCriteriaBuilder().createQuery();
        cq.select(cq.from(Factura.class));
        return entityManager.createQuery(cq).getResultList();
    }

    public Factura find(int id) {
        try {
            return (Factura) entityManager.createNamedQuery("Factura.findByIdFactura")
                    .setParameter("idFactura", id)
                    .getSingleResult();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }

    }
}
