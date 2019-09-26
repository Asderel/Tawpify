/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import entities.Album;
import entities.Artista;
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
public class AlbumFacade extends AbstractFacade<Album> {

    @PersistenceContext(unitName = "Tawpify-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public AlbumFacade() {
        super(Album.class);
    }

    public Album selectAlbumById(int idAlbum) {
        Query q = em.createQuery("SELECT a FROM Album a WHERE a.idAlbum = :idAlbum");
        q.setParameter("idAlbum", idAlbum);

        return (Album) q.getSingleResult();
    }

    public List<Album> filtrarAlbumes(Collection<Artista> a) {
        StringBuilder sb = new StringBuilder();
        sb.append("SELECT a FROM Album a");

        if (a != null && !a.isEmpty()) {
            sb.append(" WHERE a.idArtista IN :a");
        }

        Query q = em.createQuery(sb.toString());

        if (a != null && !a.isEmpty()) {
            q.setParameter("a", a);
        }

        return q.getResultList();
    }

}
