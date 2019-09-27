/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sevlets;

import entities.Artista;
import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import session.ArtistaFacade;
import utils.Utils;

/**
 *
 * @author Asde
 */
@WebServlet(name = "ArtistaCRUDServlet", urlPatterns = {"/ArtistaCRUDServlet"})
public class ArtistaCRUDServlet extends HttpServlet {

    @EJB
    ArtistaFacade artistaFacade;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int opcode = Integer.parseInt(request.getParameter(Utils.OPCODE));

        List<Artista> artistas = artistaFacade.findAll();

        request.setAttribute("artistas", artistas);

        RequestDispatcher rd = getServletContext().getRequestDispatcher("/artistas.jsp");
        rd.forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd;
        int opcode = Integer.parseInt(request.getParameter(Utils.OPCODE));

        switch (opcode) {
            case Utils.OP_MODIFICAR:
                artistaFacade.edit(modificarArtista(request));
                break;
            case Utils.OP_BORRAR:
                eliminarArtista(request);
                break;
            case Utils.OP_CREAR:
                artistaFacade.create(crearArtista(request));
                break;
        }

        List<Artista> artistas = artistaFacade.findAll();
        request.setAttribute("artistas", artistas);

        rd = getServletContext().getRequestDispatcher("/artistas.jsp");
        rd.forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>


    private Artista cargarArtista(HttpServletRequest request) {
        int idArtista = Integer.parseInt(request.getParameter(Utils.IDARTISTAINPUT));

        return artistaFacade.find(idArtista);
    }

    private Artista crearArtista(HttpServletRequest request) {
        Artista g = new Artista();

        String nombre = request.getParameter(Utils.NOMBREINPUT);
        g.setNombre(nombre);

        return g;
    }

    private Artista modificarArtista(HttpServletRequest request) {
        Artista g = artistaFacade.find(Integer.parseInt(request.getParameter(Utils.IDARTISTAINPUT)));

        String nombre = request.getParameter(Utils.NOMBREINPUT);
        g.setNombre(nombre);

        return g;
    }

    private void eliminarArtista(HttpServletRequest request) {
        Artista u = cargarArtista(request);

        artistaFacade.remove(u);
    }
}
