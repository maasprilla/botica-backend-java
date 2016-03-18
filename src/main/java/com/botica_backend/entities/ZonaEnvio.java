/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Luis
 */
@Entity
@Table(name = "zona_envios")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ZonaEnvio.findAll", query = "SELECT z FROM ZonaEnvio z"),
    @NamedQuery(name = "ZonaEnvio.findByIdZonaEnvio", query = "SELECT z FROM ZonaEnvio z WHERE z.idZonaEnvio = :idZonaEnvio"),
    @NamedQuery(name = "ZonaEnvio.findByDescripcionZona", query = "SELECT z FROM ZonaEnvio z WHERE z.descripcionZona = :descripcionZona")})
public class ZonaEnvio implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_zona_envio")
    private Integer idZonaEnvio;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "descripcion_zona")
    private String descripcionZona;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idZonaEnvio")
    private List<Pedido> pedidoList;

    public ZonaEnvio() {
    }

    public ZonaEnvio(Integer idZonaEnvio) {
        this.idZonaEnvio = idZonaEnvio;
    }

    public ZonaEnvio(Integer idZonaEnvio, String descripcionZona) {
        this.idZonaEnvio = idZonaEnvio;
        this.descripcionZona = descripcionZona;
    }

    public Integer getIdZonaEnvio() {
        return idZonaEnvio;
    }

    public void setIdZonaEnvio(Integer idZonaEnvio) {
        this.idZonaEnvio = idZonaEnvio;
    }

    public String getDescripcionZona() {
        return descripcionZona;
    }

    public void setDescripcionZona(String descripcionZona) {
        this.descripcionZona = descripcionZona;
    }

    @XmlTransient
    public List<Pedido> getPedidoList() {
        return pedidoList;
    }

    public void setPedidoList(List<Pedido> pedidoList) {
        this.pedidoList = pedidoList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idZonaEnvio != null ? idZonaEnvio.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ZonaEnvio)) {
            return false;
        }
        ZonaEnvio other = (ZonaEnvio) object;
        if ((this.idZonaEnvio == null && other.idZonaEnvio != null) || (this.idZonaEnvio != null && !this.idZonaEnvio.equals(other.idZonaEnvio))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.botica_backend.entities.ZonaEnvio[ idZonaEnvio=" + idZonaEnvio + " ]";
    }
    
}
