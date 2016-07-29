/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.sessions;

import com.botica_backend.entities.Ciudad;
import com.botica_backend.entities.MedicamentoHasRespuestaPedido;
import static com.botica_backend.entities.MedicamentoHasRespuestaPedido_.idRespuestaPedido;
import com.botica_backend.entities.RespuestaPedido;
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
 * @author adsi1
 */
@Stateless
public class MedicamentoHasRespuestaPedidoSession {

    @PersistenceContext
    private EntityManager entityManager;

    public void create(MedicamentoHasRespuestaPedido medicamentoHasRespuestaPedido) {
        entityManager.persist(medicamentoHasRespuestaPedido);
    }

    public void update(MedicamentoHasRespuestaPedido medicamentoHasRespuestaPedido) {
        entityManager.merge(medicamentoHasRespuestaPedido);
    }

    public void remove(MedicamentoHasRespuestaPedido medicamentoHasRespuestaPedido) {
        entityManager.remove(medicamentoHasRespuestaPedido);
    }

    public List<MedicamentoHasRespuestaPedido> findAll() {
        CriteriaQuery cq = entityManager.getCriteriaBuilder().createQuery();
        cq.select(cq.from(MedicamentoHasRespuestaPedido.class));
        return entityManager.createQuery(cq).getResultList();

    }

    public MedicamentoHasRespuestaPedido find(int id) {

        return entityManager.find(MedicamentoHasRespuestaPedido.class, id);

    }

    public List<MedicamentoHasRespuestaPedido> findByIdRespuestaPedido(Integer idRespuestaPedido) {
        try {
            return (List<MedicamentoHasRespuestaPedido>) entityManager.createNamedQuery("MedicamentoHasRespuestaPedido.findByIdRespuestaPedido")
                    .setParameter("idRespuestaPedido", idRespuestaPedido)
                    .getResultList();
        } catch (NonUniqueResultException ex) {
            throw ex;
        } catch (NoResultException ex) {
            return null;
        }

    }

}
