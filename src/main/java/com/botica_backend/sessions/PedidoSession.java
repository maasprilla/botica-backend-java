/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.sessions;

import com.botica_backend.entities.Pedido;
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
public class PedidoSession {

    @PersistenceContext
    private EntityManager entityManager;

    public void create(Pedido pedido) {
        entityManager.persist(pedido);
    }

    public void update(Pedido pedido) {
        entityManager.merge(pedido);
    }

    public void remove(Pedido pedido) {
        entityManager.remove(pedido);
    }

    public List<Pedido> findAll() {
        CriteriaQuery cq = entityManager.getCriteriaBuilder().createQuery();
        cq.select(cq.from(Pedido.class));
        return entityManager.createQuery(cq).getResultList();
    }

    public Pedido findByUsuario(int idUsuario) {
        try {
            return (Pedido) entityManager.createNamedQuery("Pedido.findByUsuario")
                    .setParameter("idusuarios", idUsuario)
                    .getSingleResult();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }

    }

    public List<Pedido> findByEstadoPedidoAndUsuario(int idEstadoPedido, Usuario idUsuario) {
        try {
            return (List<Pedido>) entityManager.createNamedQuery("Pedido.findByEstadoPedidoAndUsuario")
                    .setParameter("idEstadoPedido", idEstadoPedido)
                    .setParameter("idUsuario", idUsuario)
                    .getResultList();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }

    }
    
    public List<Pedido> findByConcretadoAndDrogueria(Usuario idDrogueria) {
        try {
            return (List<Pedido>) entityManager.createNamedQuery("Pedido.findByConcretadoAndDrogueria")
                    .setParameter("idUsuario", idDrogueria)
                    .getResultList();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }

    }
    
    public List<Pedido> findByEstadoPedido(int idEstadoPedido) {
        try {
            return (List<Pedido>) entityManager.createNamedQuery("Pedido.findByEstadoPedido")
                    .setParameter("idEstadoPedido", idEstadoPedido)
                    .getResultList();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }

    }

    public Pedido find(int id) {
        return entityManager.find(Pedido.class, id);

    }
}
