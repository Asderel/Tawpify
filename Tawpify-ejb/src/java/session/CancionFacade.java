/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import entities.Album;
import entities.Artista;
import entities.Cancion;
import java.util.Collection;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

/**
 *
 * @author Asde
 */
@Stateless
public class CancionFacade extends AbstractFacade<Cancion> {

    @PersistenceContext(unitName = "Tawpify-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public CancionFacade() {
        super(Cancion.class);
    }

    public List<Cancion> filtrarCanciones(Collection<Artista> a, Collection<Album> al) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT c FROM Cancion c");

        if(a != null && !a.isEmpty() && al != null) {
            sb.append(" WHERE c.idAlbum IN :al OR c.idAlbum.idArtista IN :a");
        } else if(a != null && !a.isEmpty()) {
            sb.append(" WHERE c.idAlbum.idArtista IN :a");
        }else if(al != null && !al.isEmpty()) {
            sb.append(" WHERE c.idAlbum IN :al");
        }

        Query q = em.createQuery(sb.toString());

        if(a != null && !a.isEmpty() && al != null) {
            q.setParameter("al", al).setParameter("a", a);
        } else if(a != null && !a.isEmpty()) {
            q.setParameter("a", a);
        }else if(al != null && !al.isEmpty()) {
            q.setParameter("al", al);
        }

        return q.getResultList();
    }

}
