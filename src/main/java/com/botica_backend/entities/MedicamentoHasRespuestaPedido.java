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
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Luis
 */
@Entity
@Table(name = "medicamentos_has_respuesta_pedido")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "MedicamentoHasRespuestaPedido.findAll", query = "SELECT m FROM MedicamentoHasRespuestaPedido m"),
    @NamedQuery(name = "MedicamentoHasRespuestaPedido.findByIdMedicamentoHasRespuesta", query = "SELECT m FROM MedicamentoHasRespuestaPedido m WHERE m.idMedicamentoHasRespuesta = :idMedicamentoHasRespuesta"),
    @NamedQuery(name = "MedicamentoHasRespuestaPedido.findByEstadoMedicamento", query = "SELECT m FROM MedicamentoHasRespuestaPedido m WHERE m.estadoMedicamento = :estadoMedicamento"),
    @NamedQuery(name = "MedicamentoHasRespuestaPedido.findByIdRespuestaPedido", query = "SELECT m FROM MedicamentoHasRespuestaPedido m WHERE m.idRespuestaPedido.idRespuestaPedido = :idRespuestaPedido"),
    @NamedQuery(name = "MedicamentoHasRespuestaPedido.findByCantidad", query = "SELECT m FROM MedicamentoHasRespuestaPedido m WHERE m.cantidad = :cantidad"),
    @NamedQuery(name = "MedicamentoHasRespuestaPedido.findByPrecio", query = "SELECT m FROM MedicamentoHasRespuestaPedido m WHERE m.precio = :precio")})
public class MedicamentoHasRespuestaPedido implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_medicamento_has_respuesta")
    private Integer idMedicamentoHasRespuesta;
    @Column(name = "estado_medicamento")
    private Boolean estadoMedicamento;
    @Column(name = "cantidad")
    private Integer cantidad;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "precio")
    private Double precio;
    @JoinColumn(name = "id_medicamento", referencedColumnName = "id_medicamento")
    @ManyToOne(optional = false)
    private Medicamento idMedicamento;
    @JoinColumn(name = "id_respuesta_pedido", referencedColumnName = "id_respuesta_pedido")
    @ManyToOne(optional = false)
    private RespuestaPedido idRespuestaPedido;

    public MedicamentoHasRespuestaPedido() {
    }

    public MedicamentoHasRespuestaPedido(Integer idMedicamentoHasRespuesta) {
        this.idMedicamentoHasRespuesta = idMedicamentoHasRespuesta;
    }

    public Integer getIdMedicamentoHasRespuesta() {
        return idMedicamentoHasRespuesta;
    }

    public void setIdMedicamentoHasRespuesta(Integer idMedicamentoHasRespuesta) {
        this.idMedicamentoHasRespuesta = idMedicamentoHasRespuesta;
    }

    public Boolean getEstadoMedicamento() {
        return estadoMedicamento;
    }

    public void setEstadoMedicamento(Boolean estadoMedicamento) {
        this.estadoMedicamento = estadoMedicamento;
    }

    public Integer getCantidad() {
        return cantidad;
    }

    public void setCantidad(Integer cantidad) {
        this.cantidad = cantidad;
    }

    public Double getPrecio() {
        return precio;
    }

    public void setPrecio(Double precio) {
        this.precio = precio;
    }

    
    public Medicamento getIdMedicamento() {
        return idMedicamento;
    }

    public void setIdMedicamento(Medicamento idMedicamento) {
        this.idMedicamento = idMedicamento;
    }

    @XmlTransient
    public RespuestaPedido getIdRespuestaPedido() {
        return idRespuestaPedido;
    }

    public void setIdRespuestaPedido(RespuestaPedido idRespuestaPedido) {
        this.idRespuestaPedido = idRespuestaPedido;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idMedicamentoHasRespuesta != null ? idMedicamentoHasRespuesta.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof MedicamentoHasRespuestaPedido)) {
            return false;
        }
        MedicamentoHasRespuestaPedido other = (MedicamentoHasRespuestaPedido) object;
        if ((this.idMedicamentoHasRespuesta == null && other.idMedicamentoHasRespuesta != null) || (this.idMedicamentoHasRespuesta != null && !this.idMedicamentoHasRespuesta.equals(other.idMedicamentoHasRespuesta))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.botica_backend.entities.MedicamentoHasRespuestaPedido[ idMedicamentoHasRespuesta=" + idMedicamentoHasRespuesta + " ]";
    }
    
}
