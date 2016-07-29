/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.entities;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author adsi1
 */
@Entity
@Table(name = "medicamentos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Medicamento.findAll", query = "SELECT m FROM Medicamento m"),
    @NamedQuery(name = "Medicamento.findByIdMedicamento", query = "SELECT m FROM Medicamento m WHERE m.idMedicamento = :idMedicamento"),
    @NamedQuery(name = "Medicamento.findByNombre", query = "SELECT m FROM Medicamento m WHERE m.nombre like :nombre"),
    @NamedQuery(name = "Medicamento.findByRegistroSanitario", query = "SELECT m FROM Medicamento m WHERE m.registroSanitario = :registroSanitario"),
    @NamedQuery(name = "Medicamento.findByEstadoRegistro", query = "SELECT m FROM Medicamento m WHERE m.estadoRegistro = :estadoRegistro"),
    @NamedQuery(name = "Medicamento.findByFechaVencimiento", query = "SELECT m FROM Medicamento m WHERE m.fechaVencimiento = :fechaVencimiento"),
    @NamedQuery(name = "Medicamento.findByModalidad", query = "SELECT m FROM Medicamento m WHERE m.modalidad = :modalidad"),
    @NamedQuery(name = "Medicamento.findByTitular", query = "SELECT m FROM Medicamento m WHERE m.titular = :titular")})
public class Medicamento implements Serializable {
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idMedicamento")
    private List<PedidoHasMedicamento> pedidoHasMedicamentoList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idMedicamento")
    private List<MedicamentoHasRespuestaPedido> medicamentoHasRespuestaPedidoList;

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "id_medicamento")
    private String idMedicamento;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 200)
    @Column(name = "nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "registro_sanitario")
    private String registroSanitario;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "estado_registro")
    private String estadoRegistro;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha_vencimiento")
    @Temporal(TemporalType.DATE)
    private Date fechaVencimiento;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "modalidad")
    private String modalidad;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 100)
    @Column(name = "titular")
    private String titular;

    
    @ManyToMany(mappedBy = "medicamentoList")
    private List<Pedido> pedidoList;

    public Medicamento() {
    }

    public Medicamento(String idMedicamento) {
        this.idMedicamento = idMedicamento;
    }

    public Medicamento(String idMedicamento, String nombre, String registroSanitario, String estadoRegistro, Date fechaVencimiento, String modalidad, String titular) {
        this.idMedicamento = idMedicamento;
        this.nombre = nombre;
        this.registroSanitario = registroSanitario;
        this.estadoRegistro = estadoRegistro;
        this.fechaVencimiento = fechaVencimiento;
        this.modalidad = modalidad;
        this.titular = titular;
    }

    public String getIdMedicamento() {
        return idMedicamento;
    }

    public void setIdMedicamento(String idMedicamento) {
        this.idMedicamento = idMedicamento;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getRegistroSanitario() {
        return registroSanitario;
    }

    public void setRegistroSanitario(String registroSanitario) {
        this.registroSanitario = registroSanitario;
    }

    public String getEstadoRegistro() {
        return estadoRegistro;
    }

    public void setEstadoRegistro(String estadoRegistro) {
        this.estadoRegistro = estadoRegistro;
    }

    public Date getFechaVencimiento() {
        return fechaVencimiento;
    }

    public void setFechaVencimiento(Date fechaVencimiento) {
        this.fechaVencimiento = fechaVencimiento;
    }

    public String getModalidad() {
        return modalidad;
    }

    public void setModalidad(String modalidad) {
        this.modalidad = modalidad;
    }

    public String getTitular() {
        return titular;
    }

    public void setTitular(String titular) {
        this.titular = titular;
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
        hash += (idMedicamento != null ? idMedicamento.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Medicamento other = (Medicamento) obj;
        if (!Objects.equals(this.idMedicamento, other.idMedicamento)) {
            return false;
        }
        if (!Objects.equals(this.nombre, other.nombre)) {
            return false;
        }
        if (!Objects.equals(this.registroSanitario, other.registroSanitario)) {
            return false;
        }
        if (!Objects.equals(this.estadoRegistro, other.estadoRegistro)) {
            return false;
        }
        if (!Objects.equals(this.modalidad, other.modalidad)) {
            return false;
        }
        if (!Objects.equals(this.titular, other.titular)) {
            return false;
        }
        if (!Objects.equals(this.fechaVencimiento, other.fechaVencimiento)) {
            return false;
        }
//        if (!Objects.equals(this.pedidoList, other.pedidoList)) {
//            return false;
//        }
        return true;
    }

    @Override
    public String toString() {
        return "com.botica_backend.entities.Medicamento[ idMedicamento=" + idMedicamento + " ]";
    }

    @XmlTransient
    public List<PedidoHasMedicamento> getPedidoHasMedicamentoList() {
        return pedidoHasMedicamentoList;
    }

    public void setPedidoHasMedicamentoList(List<PedidoHasMedicamento> pedidoHasMedicamentoList) {
        this.pedidoHasMedicamentoList = pedidoHasMedicamentoList;
    }

    @XmlTransient
    public List<MedicamentoHasRespuestaPedido> getMedicamentoHasRespuestaPedidoList() {
        return medicamentoHasRespuestaPedidoList;
    }

    public void setMedicamentoHasRespuestaPedidoList(List<MedicamentoHasRespuestaPedido> medicamentoHasRespuestaPedidoList) {
        this.medicamentoHasRespuestaPedidoList = medicamentoHasRespuestaPedidoList;
    }

}
