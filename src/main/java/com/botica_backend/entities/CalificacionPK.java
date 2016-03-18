/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 *
 * @author Luis
 */
@Embeddable
public class CalificacionPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_usuario")
    private int idUsuario;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_sede")
    private int idSede;

    public CalificacionPK() {
    }

    public CalificacionPK(int idUsuario, int idSede) {
        this.idUsuario = idUsuario;
        this.idSede = idSede;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public int getIdSede() {
        return idSede;
    }

    public void setIdSede(int idSede) {
        this.idSede = idSede;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idUsuario;
        hash += (int) idSede;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CalificacionPK)) {
            return false;
        }
        CalificacionPK other = (CalificacionPK) object;
        if (this.idUsuario != other.idUsuario) {
            return false;
        }
        if (this.idSede != other.idSede) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.botica_backend.entities.CalificacionPK[ idUsuario=" + idUsuario + ", idSede=" + idSede + " ]";
    }
    
}
