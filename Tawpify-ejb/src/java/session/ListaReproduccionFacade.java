/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import entities.ListaReproduccion;
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
public class ListaReproduccionFacade extends AbstractFacade<ListaReproduccion> {

    @PersistenceContext(unitName = "Tawpify-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ListaReproduccionFacade() {
        super(ListaReproduccion.class);
    }


    public List<ListaReproduccion> selectListasReproduccionByUsuario(int idUsuario) {
        Query q = em.createQuery("SELECT l FROM ListaReproduccion l WHERE l.listaReproduccionPK.idUsuario = :idUsuario");

        q.setParameter("idUsuario", idUsuario);
        return q.getResultList();
    }
}
