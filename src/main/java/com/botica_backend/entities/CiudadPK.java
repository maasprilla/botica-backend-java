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
public class CiudadPK implements Serializable {
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_ciudad")
    private int idCiudad;
    @Basic(optional = false)
    @NotNull
    @Column(name = "iddepartamento")
    private int iddepartamento;

    public CiudadPK() {
    }

    public CiudadPK(int idCiudad, int iddepartamento) {
        this.idCiudad = idCiudad;
        this.iddepartamento = iddepartamento;
    }

    public int getIdCiudad() {
        return idCiudad;
    }

    public void setIdCiudad(int idCiudad) {
        this.idCiudad = idCiudad;
    }

    public int getIddepartamento() {
        return iddepartamento;
    }

    public void setIddepartamento(int iddepartamento) {
        this.iddepartamento = iddepartamento;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idCiudad;
        hash += (int) iddepartamento;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CiudadPK)) {
            return false;
        }
        CiudadPK other = (CiudadPK) object;
        if (this.idCiudad != other.idCiudad) {
            return false;
        }
        if (this.iddepartamento != other.iddepartamento) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.botica_backend.entities.CiudadPK[ idCiudad=" + idCiudad + ", iddepartamento=" + iddepartamento + " ]";
    }
    
}
