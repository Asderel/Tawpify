/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package session;

import entities.Artista;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Asde
 */
@Stateless
public class ArtistaFacade extends AbstractFacade<Artista> {

    @PersistenceContext(unitName = "Tawpify-ejbPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public ArtistaFacade() {
        super(Artista.class);
    }
}
