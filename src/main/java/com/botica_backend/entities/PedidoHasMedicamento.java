/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Luis
 */
@Entity
@Table(name = "pedidos_has_medicamentos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PedidoHasMedicamento.findAll", query = "SELECT p FROM PedidoHasMedicamento p"),
    @NamedQuery(name = "PedidoHasMedicamento.findByIdPedidoHasMedicamento", query = "SELECT p FROM PedidoHasMedicamento p WHERE p.idPedidoHasMedicamento = :idPedidoHasMedicamento"),
    @NamedQuery(name = "PedidoHasMedicamento.findByCantidad", query = "SELECT p FROM PedidoHasMedicamento p WHERE p.cantidad = :cantidad")})
public class PedidoHasMedicamento implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_pedido_has_medicamento")
    private Integer idPedidoHasMedicamento;
    @Size(max = 45)
    @Column(name = "cantidad")
    private String cantidad;
    @JoinColumn(name = "id_medicamento", referencedColumnName = "id_medicamento")
    @ManyToOne(optional = false)
    private Medicamento idMedicamento;
    @JoinColumn(name = "id_pedido", referencedColumnName = "id_pedido")
    @ManyToOne(optional = false)
    private Pedido idPedido;

    public PedidoHasMedicamento() {
    }

    public PedidoHasMedicamento(Integer idPedidoHasMedicamento) {
        this.idPedidoHasMedicamento = idPedidoHasMedicamento;
    }

    public Integer getIdPedidoHasMedicamento() {
        return idPedidoHasMedicamento;
    }

    public void setIdPedidoHasMedicamento(Integer idPedidoHasMedicamento) {
        this.idPedidoHasMedicamento = idPedidoHasMedicamento;
    }

    public String getCantidad() {
        return cantidad;
    }

    public void setCantidad(String cantidad) {
        this.cantidad = cantidad;
    }

    public Medicamento getIdMedicamento() {
        return idMedicamento;
    }

    public void setIdMedicamento(Medicamento idMedicamento) {
        this.idMedicamento = idMedicamento;
    }

    public Pedido getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(Pedido idPedido) {
        this.idPedido = idPedido;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idPedidoHasMedicamento != null ? idPedidoHasMedicamento.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PedidoHasMedicamento)) {
            return false;
        }
        PedidoHasMedicamento other = (PedidoHasMedicamento) object;
        if ((this.idPedidoHasMedicamento == null && other.idPedidoHasMedicamento != null) || (this.idPedidoHasMedicamento != null && !this.idPedidoHasMedicamento.equals(other.idPedidoHasMedicamento))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.botica_backend.entities.PedidoHasMedicamento[ idPedidoHasMedicamento=" + idPedidoHasMedicamento + " ]";
    }
    
}
