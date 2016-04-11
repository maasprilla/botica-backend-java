/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.sessions;

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
public class UsuarioSession {

    @PersistenceContext
    private EntityManager entityManager;

    public void create(Usuario usuario) {
        entityManager.persist(usuario);
    }

    public void update(Usuario usuario) {
        entityManager.merge(usuario);

    }

    public void remove(Usuario usuario) {
        entityManager.remove(usuario);

    }

    public List<Usuario> findAll() {
        CriteriaQuery cq = entityManager.getCriteriaBuilder().createQuery();
        cq.select(cq.from(Usuario.class));
        return entityManager.createQuery(cq).getResultList();
    }

    public Usuario find(int id) {

        return entityManager.find(Usuario.class, id);
    }

    public Usuario findByRol(int idRol) {
        try {
            return (Usuario) entityManager.createNamedQuery("Usuario.findByRol")
                    .setParameter("idRoles", idRol)
                    .getSingleResult();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }

    }

    public Usuario findByCiudad(int idCiudad) {
        try {
            return (Usuario) entityManager.createNamedQuery("Usuario.findByCiudad")
                    .setParameter("ciudad", idCiudad)
                    .getSingleResult();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }

    }

    public Usuario findByCedula(int numeroCedula) {
        try {
            return (Usuario) entityManager.createNamedQuery("Usuario.findByCedula")
                    .setParameter("cedula", numeroCedula)
                    .getSingleResult();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }

    }

    public Usuario findByCamaraComercio(String camaracomercio) {
        try {
            return (Usuario) entityManager.createNamedQuery("Usuario.findByCamaraComercio")
                    .setParameter("camaracomercio", camaracomercio)
                    .getSingleResult();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }

    }

    public Usuario findByEmail(String email) {
        try {
            return (Usuario) entityManager.createNamedQuery("Usuario.findByEmail")
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }

    }

}
