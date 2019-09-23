/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;
import javax.validation.constraints.NotNull;

/**
 *
 * @author Asde
 */
@Embeddable
public class ListaReproduccionPK implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "id_cancion")
    private int idCancion;
    @Basic(optional = false)
    @NotNull
    @Column(name = "id_usuario")
    private int idUsuario;

    public ListaReproduccionPK() {
    }

    public ListaReproduccionPK(int idCancion, int idUsuario) {
        this.idCancion = idCancion;
        this.idUsuario = idUsuario;
    }

    public int getIdCancion() {
        return idCancion;
    }

    public void setIdCancion(int idCancion) {
        this.idCancion = idCancion;
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (int) idCancion;
        hash += (int) idUsuario;
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ListaReproduccionPK)) {
            return false;
        }
        ListaReproduccionPK other = (ListaReproduccionPK) object;
        if (this.idCancion != other.idCancion) {
            return false;
        }
        if (this.idUsuario != other.idUsuario) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "entities.ListaReproduccionPK[ idCancion=" + idCancion + ", idUsuario=" + idUsuario + " ]";
    }

}
