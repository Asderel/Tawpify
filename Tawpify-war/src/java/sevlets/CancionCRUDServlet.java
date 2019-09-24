/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sevlets;

import entities.Album;
import entities.Artista;
import entities.Cancion;
import entities.ListaReproduccion;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import session.AlbumFacade;
import session.ArtistaFacade;
import session.CancionFacade;
import session.ListaReproduccionFacade;
import utils.Utils;

/**
 *
 * @author Asde
 */
@WebServlet(name = "CancionCRUDServlet", urlPatterns = {"/CancionCRUDServlet"})
public class CancionCRUDServlet extends HttpServlet {

    @EJB
    CancionFacade cancionFacade;

    @EJB
    ArtistaFacade artistaFacade;

    @EJB
    AlbumFacade albumFacade;

    @EJB
    ListaReproduccionFacade listaReproduccionFacade;

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
        HttpSession session = request.getSession();
        int opcode = Integer.parseInt(request.getParameter(Utils.OPCODE));

        List<Cancion> canciones = cancionFacade.findAll();
        List<Artista> artistas = artistaFacade.findAll();
        List<Album> albumes = albumFacade.findAll();
        List<ListaReproduccion> listasReproduccion = listaReproduccionFacade.findAll();

        request.setAttribute("canciones", canciones);
        session.setAttribute("artistas", artistas);
        session.setAttribute("albumes", albumes);
        request.setAttribute("listasReproduccion", listasReproduccion);

        RequestDispatcher rd = getServletContext().getRequestDispatcher("/canciones.jsp");
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
                cancionFacade.edit(modificarCancion(request));
                break;
            case Utils.OP_BORRAR:
                eliminarCancion(request);
                break;
            case Utils.OP_CREAR:
                cancionFacade.create(crearCancion(request));
                break;
            case Utils.OP_FILTRAR:
                cancionFacade.create(crearCancion(request));
                break;
        }

        List<Cancion> canciones = cancionFacade.findAll();
        request.setAttribute("canciones", canciones);

        rd = getServletContext().getRequestDispatcher("/canciones.jsp");
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

    private Cancion cargarCancion(HttpServletRequest request) {
        int idCancion = Integer.parseInt(request.getParameter(Utils.IDCANCIONINPUT));

        return cancionFacade.find(idCancion);
    }

    private Cancion crearCancion(HttpServletRequest request) {
        Cancion c = new Cancion();
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

        try {
            Date fechaSalida = formatter.parse(request.getParameter(Utils.FECHASALIDAINPUT));
            String nombre = request.getParameter(Utils.NOMBREINPUT);
            String url = request.getParameter(Utils.URLINPUT);

            int idArtista = Integer.parseInt(request.getParameter(Utils.ARTISTASELECCIONADOSNPUT));
            Artista a = artistaFacade.find(idArtista);

            if (request.getParameterValues(Utils.ARTISTASSELECCIONADOSNPUT) != null) {
                String idArtistas[] = request.getParameterValues(Utils.ARTISTASSELECCIONADOSNPUT);

                List<Artista> colaboradores = new ArrayList<>();

                for (String idA : idArtistas) {
                    colaboradores.add(artistaFacade.find(Integer.parseInt(idA)));
                }
                c.setArtistaCollection(colaboradores);
            }

            int idAlbum = Integer.parseInt(request.getParameter(Utils.ALBUMSELECCIONADOINPUT));
            Album al = albumFacade.find(idAlbum);

            // SETTTER

            c.setNombre(nombre);
            c.setFechaSalida(fechaSalida);
            c.setUrl(url);
            c.setIdAlbum(al);
        } catch (ParseException ex) {
            Logger.getLogger(CancionCRUDServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        return c;
    }

    private Cancion modificarCancion(HttpServletRequest request) {
        Cancion g = cargarCancion(request);

         //TODO CON CUIDADO

         eliminarCancion(request);
         crearCancion(request);

        return g;
    }

    private void eliminarCancion(HttpServletRequest request) {
        Cancion c = cargarCancion(request);

        cancionFacade.remove(c);
    }

    private List<Cancion> filtrarCanciones(RequestDispatcher request) {

        return null;
    }

    private void incluirCancionEnLista(RequestDispatcher request) {
    }
}
