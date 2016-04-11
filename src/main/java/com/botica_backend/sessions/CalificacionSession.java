/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.sessions;

import com.botica_backend.entities.Calificacion;
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
public class CalificacionSession {

    @PersistenceContext
    private EntityManager entityManager;

    public void create(Calificacion calificacion) {
        entityManager.persist(calificacion);
    }

    public void update(Calificacion calificacion) {
        entityManager.merge(calificacion);

    }

    public void remove(Calificacion calificacion) {
        entityManager.remove(calificacion);

    }

    public List<Calificacion> findAll() {
        CriteriaQuery cq = entityManager.getCriteriaBuilder().createQuery();
        cq.select(cq.from(Calificacion.class));
        return entityManager.createQuery(cq).getResultList();
    }

    public Calificacion findbyUsuario(int id) {
        try {
            return (Calificacion) entityManager.createNamedQuery("Calificacion.findByIdUsuario")
                    .setParameter("idUsuario", id)
                    .getSingleResult();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }

    }

    public Calificacion findbySede(int id) {
        try {
            return (Calificacion) entityManager.createNamedQuery("Calificacion.findByIdSede")
                    .setParameter("idSede", id)
                    .getSingleResult();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }

    }
}
