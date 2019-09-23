/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
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
 * @author Asde
 */
@Entity
@Table(name = "lista_reproduccion")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ListaReproduccion.findAll", query = "SELECT l FROM ListaReproduccion l")
    , @NamedQuery(name = "ListaReproduccion.findByIdCancion", query = "SELECT l FROM ListaReproduccion l WHERE l.listaReproduccionPK.idCancion = :idCancion")
    , @NamedQuery(name = "ListaReproduccion.findByIdUsuario", query = "SELECT l FROM ListaReproduccion l WHERE l.listaReproduccionPK.idUsuario = :idUsuario")
    , @NamedQuery(name = "ListaReproduccion.findByNombre", query = "SELECT l FROM ListaReproduccion l WHERE l.nombre = :nombre")
    , @NamedQuery(name = "ListaReproduccion.findByFechaCreacion", query = "SELECT l FROM ListaReproduccion l WHERE l.fechaCreacion = :fechaCreacion")})
public class ListaReproduccion implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected ListaReproduccionPK listaReproduccionPK;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha_creacion")
    @Temporal(TemporalType.DATE)
    private Date fechaCreacion;
    @JoinColumn(name = "id_cancion", referencedColumnName = "id_cancion", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Cancion cancion;
    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Usuario usuario;

    public ListaReproduccion() {
    }

    public ListaReproduccion(ListaReproduccionPK listaReproduccionPK) {
        this.listaReproduccionPK = listaReproduccionPK;
    }

    public ListaReproduccion(ListaReproduccionPK listaReproduccionPK, String nombre, Date fechaCreacion) {
        this.listaReproduccionPK = listaReproduccionPK;
        this.nombre = nombre;
        this.fechaCreacion = fechaCreacion;
    }

    public ListaReproduccion(int idCancion, int idUsuario) {
        this.listaReproduccionPK = new ListaReproduccionPK(idCancion, idUsuario);
    }

    public ListaReproduccionPK getListaReproduccionPK() {
        return listaReproduccionPK;
    }

    public void setListaReproduccionPK(ListaReproduccionPK listaReproduccionPK) {
        this.listaReproduccionPK = listaReproduccionPK;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public Cancion getCancion() {
        return cancion;
    }

    public void setCancion(Cancion cancion) {
        this.cancion = cancion;
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
        hash += (listaReproduccionPK != null ? listaReproduccionPK.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ListaReproduccion)) {
            return false;
        }
        ListaReproduccion other = (ListaReproduccion) object;
        if ((this.listaReproduccionPK == null && other.listaReproduccionPK != null) || (this.listaReproduccionPK != null && !this.listaReproduccionPK.equals(other.listaReproduccionPK))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ListaReproduccion[ listaReproduccionPK=" + listaReproduccionPK + " ]";
    }

}
