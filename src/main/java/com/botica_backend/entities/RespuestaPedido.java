/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Luis
 */
@Entity
@Table(name = "respuesta_pedido")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "RespuestaPedido.findAll", query = "SELECT r FROM RespuestaPedido r"),
    @NamedQuery(name = "RespuestaPedido.findByIdRespuestaPedido", query = "SELECT r FROM RespuestaPedido r WHERE r.idRespuestaPedido = :idRespuestaPedido"),
    @NamedQuery(name = "RespuestaPedido.findByDescripcion", query = "SELECT r FROM RespuestaPedido r WHERE r.descripcion = :descripcion")})
public class RespuestaPedido implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_respuesta_pedido")
    private Integer idRespuestaPedido;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "descripcion")
    private String descripcion;
    @JoinColumn(name = "id_pedido", referencedColumnName = "id_pedido")
    @ManyToOne(optional = false)
    private Pedido idPedido;
    @JoinColumn(name = "id_sede", referencedColumnName = "id_sede")
    @ManyToOne(optional = false)
    private Sede idSede;

    public RespuestaPedido() {
    }

    public RespuestaPedido(Integer idRespuestaPedido) {
        this.idRespuestaPedido = idRespuestaPedido;
    }



    public Integer getIdRespuestaPedido() {
        return idRespuestaPedido;
    }

    public void setIdRespuestaPedido(Integer idRespuestaPedido) {
        this.idRespuestaPedido = idRespuestaPedido;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }




    public Pedido getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(Pedido idPedido) {
        this.idPedido = idPedido;
    }

    public Sede getIdSede() {
        return idSede;
    }

    public void setIdSede(Sede idSede) {
        this.idSede = idSede;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idRespuestaPedido != null ? idRespuestaPedido.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof RespuestaPedido)) {
            return false;
        }
        RespuestaPedido other = (RespuestaPedido) object;
        if ((this.idRespuestaPedido == null && other.idRespuestaPedido != null) || (this.idRespuestaPedido != null && !this.idRespuestaPedido.equals(other.idRespuestaPedido))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.botica_backend.entities.RespuestaPedido[ idRespuestaPedido=" + idRespuestaPedido + " ]";
    }

  
    
}
