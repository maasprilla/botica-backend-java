/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Luis
 */
@Entity
@Table(name = "calificaciones")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Calificacion.findAll", query = "SELECT c FROM Calificacion c"),
    @NamedQuery(name = "Calificacion.findByIdUsuario", query = "SELECT c FROM Calificacion c WHERE c.calificacionPK.idUsuario = :idUsuario"),
    @NamedQuery(name = "Calificacion.findByCalificacion", query = "SELECT c FROM Calificacion c WHERE c.calificacion = :calificacion"),
    @NamedQuery(name = "Calificacion.findByIdSede", query = "SELECT c FROM Calificacion c WHERE c.calificacionPK.idSede = :idSede"),
    @NamedQuery(name = "Calificacion.findByObservacion", query = "SELECT c FROM Calificacion c WHERE c.observacion = :observacion")})
public class Calificacion implements Serializable {
    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected CalificacionPK calificacionPK;
    @Basic(optional = false)
    @NotNull
    @Column(name = "calificacion")
    private short calificacion;
    @Size(max = 255)
    @Column(name = "observacion")
    private String observacion;
    @JoinColumn(name = "id_sede", referencedColumnName = "id_sede", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Sede sede;
    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Usuario usuario;

    public Calificacion() {
    }

    public Calificacion(CalificacionPK calificacionPK) {
        this.calificacionPK = calificacionPK;
    }

    public Calificacion(CalificacionPK calificacionPK, short calificacion) {
        this.calificacionPK = calificacionPK;
        this.calificacion = calificacion;
    }

    public Calificacion(int idUsuario, int idSede) {
        this.calificacionPK = new CalificacionPK(idUsuario, idSede);
    }

    public CalificacionPK getCalificacionPK() {
        return calificacionPK;
    }

    public void setCalificacionPK(CalificacionPK calificacionPK) {
        this.calificacionPK = calificacionPK;
    }

    public short getCalificacion() {
        return calificacion;
    }

    public void setCalificacion(short calificacion) {
        this.calificacion = calificacion;
    }

    public String getObservacion() {
        return observacion;
    }

    public void setObservacion(String observacion) {
        this.observacion = observacion;
    }

    public Sede getSede() {
        return sede;
    }

    public void setSede(Sede sede) {
        this.sede = sede;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (calificacionPK != null ? calificacionPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Calificacion)) {
            return false;
        }
        Calificacion other = (Calificacion) object;
        if ((this.calificacionPK == null && other.calificacionPK != null) || (this.calificacionPK != null && !this.calificacionPK.equals(other.calificacionPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.botica_backend.entities.Calificacion[ calificacionPK=" + calificacionPK + " ]";
    }
    
}
