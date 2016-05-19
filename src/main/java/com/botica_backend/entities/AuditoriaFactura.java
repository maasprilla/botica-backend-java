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
@Table(name = "auditoria_facturas")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "AuditoriaFactura.findAll", query = "SELECT a FROM AuditoriaFactura a"),
    @NamedQuery(name = "AuditoriaFactura.findByIdAuditoria", query = "SELECT a FROM AuditoriaFactura a WHERE a.idAuditoria = :idAuditoria"),
    @NamedQuery(name = "AuditoriaFactura.findByCodigoOld", query = "SELECT a FROM AuditoriaFactura a WHERE a.codigoOld = :codigoOld"),
    @NamedQuery(name = "AuditoriaFactura.findByDescripcionOld", query = "SELECT a FROM AuditoriaFactura a WHERE a.descripcionOld = :descripcionOld"),
    @NamedQuery(name = "AuditoriaFactura.findByFechaCompraOld", query = "SELECT a FROM AuditoriaFactura a WHERE a.fechaCompraOld = :fechaCompraOld"),
    @NamedQuery(name = "AuditoriaFactura.findByTotalFacturaOld", query = "SELECT a FROM AuditoriaFactura a WHERE a.totalFacturaOld = :totalFacturaOld"),
    @NamedQuery(name = "AuditoriaFactura.findByCantidadProductosOld", query = "SELECT a FROM AuditoriaFactura a WHERE a.cantidadProductosOld = :cantidadProductosOld"),
    @NamedQuery(name = "AuditoriaFactura.findByModalidadPagoOld", query = "SELECT a FROM AuditoriaFactura a WHERE a.modalidadPagoOld = :modalidadPagoOld"),
    @NamedQuery(name = "AuditoriaFactura.findByNitOld", query = "SELECT a FROM AuditoriaFactura a WHERE a.nitOld = :nitOld"),
    @NamedQuery(name = "AuditoriaFactura.findByCodigoNew", query = "SELECT a FROM AuditoriaFactura a WHERE a.codigoNew = :codigoNew"),
    @NamedQuery(name = "AuditoriaFactura.findByIdFacturaOld", query = "SELECT a FROM AuditoriaFactura a WHERE a.idFacturaOld = :idFacturaOld"),
    @NamedQuery(name = "AuditoriaFactura.findByDescripcionNew", query = "SELECT a FROM AuditoriaFactura a WHERE a.descripcionNew = :descripcionNew"),
    @NamedQuery(name = "AuditoriaFactura.findByFechaCompraNew", query = "SELECT a FROM AuditoriaFactura a WHERE a.fechaCompraNew = :fechaCompraNew"),
    @NamedQuery(name = "AuditoriaFactura.findByTotalFacturaNew", query = "SELECT a FROM AuditoriaFactura a WHERE a.totalFacturaNew = :totalFacturaNew"),
    @NamedQuery(name = "AuditoriaFactura.findByCantidadProductosNew", query = "SELECT a FROM AuditoriaFactura a WHERE a.cantidadProductosNew = :cantidadProductosNew"),
    @NamedQuery(name = "AuditoriaFactura.findByModalidadPagoNew", query = "SELECT a FROM AuditoriaFactura a WHERE a.modalidadPagoNew = :modalidadPagoNew"),
    @NamedQuery(name = "AuditoriaFactura.findByNitNew", query = "SELECT a FROM AuditoriaFactura a WHERE a.nitNew = :nitNew"),
    @NamedQuery(name = "AuditoriaFactura.findByIdFacturaNew", query = "SELECT a FROM AuditoriaFactura a WHERE a.idFacturaNew = :idFacturaNew")})
public class AuditoriaFactura implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_auditoria")
    private Integer idAuditoria;
    @Size(max = 45)
    @Column(name = "codigo_old")
    private String codigoOld;
    @Size(max = 200)
    @Column(name = "descripcion_old")
    private String descripcionOld;
    @Column(name = "fecha_compra_old")
    @Temporal(TemporalType.DATE)
    private Date fechaCompraOld;
    @Column(name = "total_factura_old")
    private Integer totalFacturaOld;
    @Column(name = "cantidad_productos_old")
    private Integer cantidadProductosOld;
    @Size(max = 45)
    @Column(name = "modalidad_pago_old")
    private String modalidadPagoOld;
    @Column(name = "nit_old")
    private Integer nitOld;
    @Size(max = 45)
    @Column(name = "codigo_new")
    private String codigoNew;
    @Size(max = 45)
    @Column(name = "id_factura_old")
    private String idFacturaOld;
    @Size(max = 200)
    @Column(name = "descripcion_new")
    private String descripcionNew;
    @Column(name = "fecha_compra_new")
    @Temporal(TemporalType.DATE)
    private Date fechaCompraNew;
    @Column(name = "total_factura_new")
    private Integer totalFacturaNew;
    @Column(name = "cantidad_productos_new")
    private Integer cantidadProductosNew;
    @Size(max = 45)
    @Column(name = "modalidad_pago_new")
    private String modalidadPagoNew;
    @Column(name = "nit_new")
    private Integer nitNew;
    @Size(max = 45)
    @Column(name = "id_factura_new")
    private String idFacturaNew;

    public AuditoriaFactura() {
    }

    public AuditoriaFactura(Integer idAuditoria) {
        this.idAuditoria = idAuditoria;
    }

    public Integer getIdAuditoria() {
        return idAuditoria;
    }

    public void setIdAuditoria(Integer idAuditoria) {
        this.idAuditoria = idAuditoria;
    }

    public String getCodigoOld() {
        return codigoOld;
    }

    public void setCodigoOld(String codigoOld) {
        this.codigoOld = codigoOld;
    }

    public String getDescripcionOld() {
        return descripcionOld;
    }

    public void setDescripcionOld(String descripcionOld) {
        this.descripcionOld = descripcionOld;
    }

    public Date getFechaCompraOld() {
        return fechaCompraOld;
    }

    public void setFechaCompraOld(Date fechaCompraOld) {
        this.fechaCompraOld = fechaCompraOld;
    }

    public Integer getTotalFacturaOld() {
        return totalFacturaOld;
    }

    public void setTotalFacturaOld(Integer totalFacturaOld) {
        this.totalFacturaOld = totalFacturaOld;
    }

    public Integer getCantidadProductosOld() {
        return cantidadProductosOld;
    }

    public void setCantidadProductosOld(Integer cantidadProductosOld) {
        this.cantidadProductosOld = cantidadProductosOld;
    }

    public String getModalidadPagoOld() {
        return modalidadPagoOld;
    }

    public void setModalidadPagoOld(String modalidadPagoOld) {
        this.modalidadPagoOld = modalidadPagoOld;
    }

    public Integer getNitOld() {
        return nitOld;
    }

    public void setNitOld(Integer nitOld) {
        this.nitOld = nitOld;
    }

    public String getCodigoNew() {
        return codigoNew;
    }

    public void setCodigoNew(String codigoNew) {
        this.codigoNew = codigoNew;
    }

    public String getIdFacturaOld() {
        return idFacturaOld;
    }

    public void setIdFacturaOld(String idFacturaOld) {
        this.idFacturaOld = idFacturaOld;
    }

    public String getDescripcionNew() {
        return descripcionNew;
    }

    public void setDescripcionNew(String descripcionNew) {
        this.descripcionNew = descripcionNew;
    }

    public Date getFechaCompraNew() {
        return fechaCompraNew;
    }

    public void setFechaCompraNew(Date fechaCompraNew) {
        this.fechaCompraNew = fechaCompraNew;
    }

    public Integer getTotalFacturaNew() {
        return totalFacturaNew;
    }

    public void setTotalFacturaNew(Integer totalFacturaNew) {
        this.totalFacturaNew = totalFacturaNew;
    }

    public Integer getCantidadProductosNew() {
        return cantidadProductosNew;
    }

    public void setCantidadProductosNew(Integer cantidadProductosNew) {
        this.cantidadProductosNew = cantidadProductosNew;
    }

    public String getModalidadPagoNew() {
        return modalidadPagoNew;
    }

    public void setModalidadPagoNew(String modalidadPagoNew) {
        this.modalidadPagoNew = modalidadPagoNew;
    }

    public Integer getNitNew() {
        return nitNew;
    }

    public void setNitNew(Integer nitNew) {
        this.nitNew = nitNew;
    }

    public String getIdFacturaNew() {
        return idFacturaNew;
    }

    public void setIdFacturaNew(String idFacturaNew) {
        this.idFacturaNew = idFacturaNew;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idAuditoria != null ? idAuditoria.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof AuditoriaFactura)) {
            return false;
        }
        AuditoriaFactura other = (AuditoriaFactura) object;
        if ((this.idAuditoria == null && other.idAuditoria != null) || (this.idAuditoria != null && !this.idAuditoria.equals(other.idAuditoria))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.botica_backend.entities.AuditoriaFactura[ idAuditoria=" + idAuditoria + " ]";
    }
    
}
