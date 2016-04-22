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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Luis
 */
@Entity
@Table(name = "auditoria_pedidos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AuditoriaPedido.findAll", query = "SELECT a FROM AuditoriaPedido a"),
    @NamedQuery(name = "AuditoriaPedido.findByIdAuditoriaPedidos", query = "SELECT a FROM AuditoriaPedido a WHERE a.idAuditoriaPedidos = :idAuditoriaPedidos"),
    @NamedQuery(name = "AuditoriaPedido.findByDireccionOld", query = "SELECT a FROM AuditoriaPedido a WHERE a.direccionOld = :direccionOld"),
    @NamedQuery(name = "AuditoriaPedido.findByDescripcionOld", query = "SELECT a FROM AuditoriaPedido a WHERE a.descripcionOld = :descripcionOld"),
    @NamedQuery(name = "AuditoriaPedido.findByCiudadOld", query = "SELECT a FROM AuditoriaPedido a WHERE a.ciudadOld = :ciudadOld"),
    @NamedQuery(name = "AuditoriaPedido.findByFechaOld", query = "SELECT a FROM AuditoriaPedido a WHERE a.fechaOld = :fechaOld"),
    @NamedQuery(name = "AuditoriaPedido.findByDireccionNew", query = "SELECT a FROM AuditoriaPedido a WHERE a.direccionNew = :direccionNew"),
    @NamedQuery(name = "AuditoriaPedido.findByDescripcionNew", query = "SELECT a FROM AuditoriaPedido a WHERE a.descripcionNew = :descripcionNew"),
    @NamedQuery(name = "AuditoriaPedido.findByCiudadNew", query = "SELECT a FROM AuditoriaPedido a WHERE a.ciudadNew = :ciudadNew"),
    @NamedQuery(name = "AuditoriaPedido.findByFechaNew", query = "SELECT a FROM AuditoriaPedido a WHERE a.fechaNew = :fechaNew")})
public class AuditoriaPedido implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_auditoria_pedidos")
    private Integer idAuditoriaPedidos;
    @Size(max = 45)
    @Column(name = "direccion_old")
    private String direccionOld;
    @Size(max = 200)
    @Column(name = "descripcion_old")
    private String descripcionOld;
    @Size(max = 45)
    @Column(name = "ciudad_old")
    private String ciudadOld;
    @Column(name = "fecha_old")
    @Temporal(TemporalType.DATE)
    private Date fechaOld;
    @Size(max = 45)
    @Column(name = "direccion_new")
    private String direccionNew;
    @Size(max = 200)
    @Column(name = "descripcion_new")
    private String descripcionNew;
    @Size(max = 45)
    @Column(name = "ciudad_new")
    private String ciudadNew;
    @Column(name = "fecha_new")
    @Temporal(TemporalType.DATE)
    private Date fechaNew;

    public AuditoriaPedido() {
    }

    public AuditoriaPedido(Integer idAuditoriaPedidos) {
        this.idAuditoriaPedidos = idAuditoriaPedidos;
    }

    public Integer getIdAuditoriaPedidos() {
        return idAuditoriaPedidos;
    }

    public void setIdAuditoriaPedidos(Integer idAuditoriaPedidos) {
        this.idAuditoriaPedidos = idAuditoriaPedidos;
    }

    public String getDireccionOld() {
        return direccionOld;
    }

    public void setDireccionOld(String direccionOld) {
        this.direccionOld = direccionOld;
    }

    public String getDescripcionOld() {
        return descripcionOld;
    }

    public void setDescripcionOld(String descripcionOld) {
        this.descripcionOld = descripcionOld;
    }

    public String getCiudadOld() {
        return ciudadOld;
    }

    public void setCiudadOld(String ciudadOld) {
        this.ciudadOld = ciudadOld;
    }

    public Date getFechaOld() {
        return fechaOld;
    }

    public void setFechaOld(Date fechaOld) {
        this.fechaOld = fechaOld;
    }

    public String getDireccionNew() {
        return direccionNew;
    }

    public void setDireccionNew(String direccionNew) {
        this.direccionNew = direccionNew;
    }

    public String getDescripcionNew() {
        return descripcionNew;
    }

    public void setDescripcionNew(String descripcionNew) {
        this.descripcionNew = descripcionNew;
    }

    public String getCiudadNew() {
        return ciudadNew;
    }

    public void setCiudadNew(String ciudadNew) {
        this.ciudadNew = ciudadNew;
    }

    public Date getFechaNew() {
        return fechaNew;
    }

    public void setFechaNew(Date fechaNew) {
        this.fechaNew = fechaNew;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idAuditoriaPedidos != null ? idAuditoriaPedidos.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AuditoriaPedido)) {
            return false;
        }
        AuditoriaPedido other = (AuditoriaPedido) object;
        if ((this.idAuditoriaPedidos == null && other.idAuditoriaPedidos != null) || (this.idAuditoriaPedidos != null && !this.idAuditoriaPedidos.equals(other.idAuditoriaPedidos))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.botica_backend.entities.AuditoriaPedido[ idAuditoriaPedidos=" + idAuditoriaPedidos + " ]";
    }
    
}
