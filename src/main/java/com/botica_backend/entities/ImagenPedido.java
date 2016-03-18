/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.botica_backend.entities;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
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
@Table(name = "imagenes_pedidos")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ImagenPedido.findAll", query = "SELECT i FROM ImagenPedido i"),
    @NamedQuery(name = "ImagenPedido.findByIdImagenPedido", query = "SELECT i FROM ImagenPedido i WHERE i.idImagenPedido = :idImagenPedido"),
    @NamedQuery(name = "ImagenPedido.findByUrl", query = "SELECT i FROM ImagenPedido i WHERE i.url = :url")})
public class ImagenPedido implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_imagen_pedido")
    private Integer idImagenPedido;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 45)
    @Column(name = "url")
    private String url;
    @JoinTable(name = "detalle_pedidos", joinColumns = {
        @JoinColumn(name = "id_imagen_pedido", referencedColumnName = "id_imagen_pedido")}, inverseJoinColumns = {
        @JoinColumn(name = "id_pedido", referencedColumnName = "id_pedido")})
    @ManyToMany
    private List<Pedido> pedidoList;

    public ImagenPedido() {
    }

    public ImagenPedido(Integer idImagenPedido) {
        this.idImagenPedido = idImagenPedido;
    }

    public ImagenPedido(Integer idImagenPedido, String url) {
        this.idImagenPedido = idImagenPedido;
        this.url = url;
    }

    public Integer getIdImagenPedido() {
        return idImagenPedido;
    }

    public void setIdImagenPedido(Integer idImagenPedido) {
        this.idImagenPedido = idImagenPedido;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
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
        hash += (idImagenPedido != null ? idImagenPedido.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ImagenPedido)) {
            return false;
        }
        ImagenPedido other = (ImagenPedido) object;
        if ((this.idImagenPedido == null && other.idImagenPedido != null) || (this.idImagenPedido != null && !this.idImagenPedido.equals(other.idImagenPedido))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.botica_backend.entities.ImagenPedido[ idImagenPedido=" + idImagenPedido + " ]";
    }
    
}
