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
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinColumns;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
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
@Table(name = "pedidos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Pedido.findAll", query = "SELECT p FROM Pedido p"),
    @NamedQuery(name = "Pedido.findByIdPedido", query = "SELECT p FROM Pedido p WHERE p.idPedido = :idPedido"),
    @NamedQuery(name = "Pedido.findByDireccion", query = "SELECT p FROM Pedido p WHERE p.direccion = :direccion"),
    @NamedQuery(name = "Pedido.findByDescripcion", query = "SELECT p FROM Pedido p WHERE p.descripcion = :descripcion"),
    @NamedQuery(name = "Pedido.findByUsuario", query = "SELECT p FROM Pedido p WHERE p.idusuario.idUsuario = :idusuario"),
    @NamedQuery(name = "Pedido.findByEstadoPedido", query = "SELECT p FROM Pedido p WHERE p.idEstadoPedido.idEstadoPedido = :idEstadoPedido"),
    @NamedQuery(name = "Pedido.findByFecha", query = "SELECT p FROM Pedido p WHERE p.fecha = :fecha")})
public class Pedido implements Serializable {
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idPedido")
    private List<RespuestaPedido> respuestaPedidoList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idPedido")
    private List<PedidoHasMedicamento> pedidoHasMedicamentoList;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_pedido")
    private Integer idPedido;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "direccion")
    private String direccion;
    @Size(max = 200)
    @Column(name = "descripcion")
    private String descripcion;
    @Basic(optional = false)
    @Column(name = "fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;
    @JoinColumns({
        @JoinColumn(name = "id_ciudad", referencedColumnName = "id_ciudad"),
        @JoinColumn(name = "id_departamento", referencedColumnName = "id_departamento")})
    @ManyToOne(optional = false)
    private Ciudad ciudad;
    @JoinColumn(name = "id_sede", referencedColumnName = "id_sede")
    @ManyToOne
    private Sede idSede;
    @JoinColumn(name = "idusuario", referencedColumnName = "id_usuario")
    @ManyToOne(optional = false)
    private Usuario idusuario;
    @JoinColumn(name = "id_zona_envio", referencedColumnName = "id_zona_envio")
    @ManyToOne
    private ZonaEnvio idZonaEnvio;

    @JoinTable(name = "pedidos_has_medicamentos", joinColumns = {
        @JoinColumn(name = "id_pedido", referencedColumnName = "id_pedido")}, inverseJoinColumns = {
        @JoinColumn(name = "id_medicamento", referencedColumnName = "id_medicamento")})
    @ManyToMany
    private List<Medicamento> medicamentoList;

    @JoinColumn(name = "id_estado_pedido", referencedColumnName = "id_estado_pedido")
    @ManyToOne(optional = false)
    private EstadoPedido idEstadoPedido;

    public Pedido() {
    }

    public Pedido(Integer idPedido) {
        this.idPedido = idPedido;
    }

    public Pedido(Integer idPedido, String direccion, Date fecha) {
        this.idPedido = idPedido;
        this.direccion = direccion;
        this.fecha = fecha;
    }

    public Integer getIdPedido() {
        return idPedido;
    }

    public void setIdPedido(Integer idPedido) {
        this.idPedido = idPedido;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public Ciudad getCiudad() {
        return ciudad;
    }

    public void setCiudad(Ciudad ciudad) {
        this.ciudad = ciudad;
    }

    public Sede getIdSede() {
        return idSede;
    }

    public void setIdSede(Sede idSede) {
        this.idSede = idSede;
    }

    public Usuario getIdusuario() {
        return idusuario;
    }

    public void setIdusuario(Usuario idusuario) {
        this.idusuario = idusuario;
    }

    public ZonaEnvio getIdZonaEnvio() {
        return idZonaEnvio;
    }

    public void setIdZonaEnvio(ZonaEnvio idZonaEnvio) {
        this.idZonaEnvio = idZonaEnvio;
    }

    public List<Medicamento> getMedicamentoList() {
        return medicamentoList;
    }

    public void setMedicamentoList(List<Medicamento> medicamentoList) {
        this.medicamentoList = medicamentoList;
    }

    public EstadoPedido getIdEstadoPedido() {
        return idEstadoPedido;
    }

    public void setIdEstadoPedido(EstadoPedido idEstadoPedido) {
        this.idEstadoPedido = idEstadoPedido;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idPedido != null ? idPedido.hashCode() : 0);
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
        final Pedido other = (Pedido) obj;
        if (!Objects.equals(this.direccion, other.direccion)) {
            return false;
        }
        if (!Objects.equals(this.descripcion, other.descripcion)) {
            return false;
        }
        if (!Objects.equals(this.idPedido, other.idPedido)) {
            return false;
        }
        if (!Objects.equals(this.fecha, other.fecha)) {
            return false;
        }
        if (!Objects.equals(this.ciudad, other.ciudad)) {
            return false;
        }
        if (!Objects.equals(this.idSede, other.idSede)) {
            return false;
        }
        if (!Objects.equals(this.idusuario, other.idusuario)) {
            return false;
        }
        if (!Objects.equals(this.idZonaEnvio, other.idZonaEnvio)) {
            return false;
        }
//        if (!Objects.equals(this.medicamentoList, other.medicamentoList)) {
//            return false;
//        }
        return true;
    }

    @Override
    public String toString() {
        return "com.botica_backend.entities.Pedido[ idPedido=" + idPedido + " ]";
    }

    @XmlTransient
    public List<RespuestaPedido> getRespuestaPedidoList() {
        return respuestaPedidoList;
    }

    public void setRespuestaPedidoList(List<RespuestaPedido> respuestaPedidoList) {
        this.respuestaPedidoList = respuestaPedidoList;
    }

    public List<PedidoHasMedicamento> getPedidoHasMedicamentoList() {
        return pedidoHasMedicamentoList;
    }

    public void setPedidoHasMedicamentoList(List<PedidoHasMedicamento> pedidoHasMedicamentoList) {
        this.pedidoHasMedicamentoList = pedidoHasMedicamentoList;
    }

}
