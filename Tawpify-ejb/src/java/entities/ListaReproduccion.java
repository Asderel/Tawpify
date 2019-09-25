/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Asde
 */
@Entity
@Table(name = "lista_reproduccion")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "ListaReproduccion.findAll", query = "SELECT l FROM ListaReproduccion l")
    , @NamedQuery(name = "ListaReproduccion.findByIdListaReproduccion", query = "SELECT l FROM ListaReproduccion l WHERE l.idListaReproduccion = :idListaReproduccion")
    , @NamedQuery(name = "ListaReproduccion.findByNombre", query = "SELECT l FROM ListaReproduccion l WHERE l.nombre = :nombre")
    , @NamedQuery(name = "ListaReproduccion.findByFechaCreacion", query = "SELECT l FROM ListaReproduccion l WHERE l.fechaCreacion = :fechaCreacion")})
public class ListaReproduccion implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_lista_reproduccion")
    private Integer idListaReproduccion;
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
    @ManyToMany(mappedBy = "listaReproduccionCollection")
    private Collection<Cancion> cancionCollection;
    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario")
    @ManyToOne(optional = false)
    private Usuario idUsuario;

    public ListaReproduccion() {
    }

    public ListaReproduccion(Integer idListaReproduccion) {
        this.idListaReproduccion = idListaReproduccion;
    }

    public ListaReproduccion(Integer idListaReproduccion, String nombre, Date fechaCreacion) {
        this.idListaReproduccion = idListaReproduccion;
        this.nombre = nombre;
        this.fechaCreacion = fechaCreacion;
    }

    public Integer getIdListaReproduccion() {
        return idListaReproduccion;
    }

    public void setIdListaReproduccion(Integer idListaReproduccion) {
        this.idListaReproduccion = idListaReproduccion;
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

    @XmlTransient
    public Collection<Cancion> getCancionCollection() {
        return cancionCollection;
    }

    public void setCancionCollection(Collection<Cancion> cancionCollection) {
        this.cancionCollection = cancionCollection;
    }

    public Usuario getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Usuario idUsuario) {
        this.idUsuario = idUsuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idListaReproduccion != null ? idListaReproduccion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ListaReproduccion)) {
            return false;
        }
        ListaReproduccion other = (ListaReproduccion) object;
        if ((this.idListaReproduccion == null && other.idListaReproduccion != null) || (this.idListaReproduccion != null && !this.idListaReproduccion.equals(other.idListaReproduccion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ListaReproduccion[ idListaReproduccion=" + idListaReproduccion + " ]";
    }

}
