package sevlets;

import entities.Album;
import entities.Artista;
import entities.Cancion;
import entities.ListaReproduccion;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
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

        session.setAttribute("canciones", canciones);
        session.setAttribute("artistas", artistas);
        session.setAttribute("albumes", albumes);
        session.setAttribute("listasReproduccion", listasReproduccion);

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
        HttpSession session = request.getSession();
        int opcode = Integer.parseInt(request.getParameter(Utils.OPCODE));
        Cancion cancionSeleccionada;
        List<Cancion> canciones = new ArrayList<>();
        List<Artista> artistas = artistaFacade.findAll();

        switch (opcode) {
            case Utils.OP_MODIFICAR:
                modificarCancion(request);
                break;
            case Utils.OP_BORRAR:
                eliminarCancion(request);
                break;
            case Utils.OP_CREAR:

                crearCancion(request, null);
                session.removeAttribute("artistas");
                session.removeAttribute("albumes");
                break;
            case Utils.OP_FILTRAR:
                canciones = filtrarCanciones(request);
                break;
            case Utils.OP_INCLUIR_CANCION_LISTA:
                incluirCancionEnLista(request);
                break;
            case Utils.OP_REDIRECCION_CREAR_CANCION:
                Album albumSeleccionado = albumFacade.find(Integer.parseInt(request.getParameter(Utils.IDALBUMINPUT)));
                artistas.remove(albumSeleccionado.getIdArtista());

                request.setAttribute("albumSeleccionado", albumSeleccionado);
                session.setAttribute("artistas", artistas);
                rd = getServletContext().getRequestDispatcher("/nuevaCancion.jsp");
                rd.forward(request, response);
                break;
            case Utils.OP_REDIRECCION_MODIFICAR:
                cancionSeleccionada = cargarCancion(request);
                artistas.remove(cancionSeleccionada.getIdAlbum().getIdArtista());

                request.setAttribute("cancionSeleccionada", cancionSeleccionada);
                session.setAttribute("artistas", artistas);
                rd = getServletContext().getRequestDispatcher("/nuevaCancion.jsp");
                rd.forward(request, response);
                break;
        }

        if (opcode != Utils.OP_FILTRAR) {
            canciones = cancionFacade.findAll();
        }

        List<Album> albumes = albumFacade.findAll();
        List<ListaReproduccion> listasReproduccion = listaReproduccionFacade.findAll();

        session.setAttribute("canciones", canciones);
        session.setAttribute("artistas", artistas);
        session.setAttribute("albumes", albumes);
        session.setAttribute("listasReproduccion", listasReproduccion);

        if (opcode != Utils.OP_REDIRECCION_CREAR_CANCION && opcode != Utils.OP_REDIRECCION_MODIFICAR) {
            request.setAttribute(Utils.RUTA, Utils.RUTA_CANCIONES);
            rd = getServletContext().getRequestDispatcher("/EnrutadorServlet");
            rd.forward(request, response);
        }
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

    private Cancion crearCancion(HttpServletRequest request, Cancion cancion) {
        Cancion c = cancion;
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

        if (c == null) {
            c = new Cancion();
        }

        try {
            Date fechaSalida = formatter.parse(request.getParameter(Utils.FECHASALIDAINPUT));
            String nombre = request.getParameter(Utils.NOMBREINPUT);
            String url = request.getParameter(Utils.URLINPUT);
            Artista aAux;
            List<Artista> colaboradores = new ArrayList<>();
            String idArtistas[] = null;
            Collection<Artista> relacionAnterior = cancion != null ? c.getArtistaCollection() : null;

            if (request.getParameterValues(Utils.ARTISTASSELECCIONADOSNPUT) != null) {
                idArtistas = request.getParameterValues(Utils.ARTISTASSELECCIONADOSNPUT);

                for (String idA : idArtistas) {
                    aAux = artistaFacade.find(Integer.parseInt(idA));
                    colaboradores.add(aAux);
                }

                c.setArtistaCollection(colaboradores);
            }

            int idAlbum = Integer.parseInt(request.getParameter(Utils.IDALBUMINPUT));
            Album al = albumFacade.find(idAlbum);

            // SETTTER
            c.setNombre(nombre);
            c.setFechaSalida(fechaSalida);
            c.setUrl(url);
            c.setIdAlbum(al);

            if (c.getIdCancion() == null || c.getIdCancion() == 0) {
                cancionFacade.create(c);
            } else {
                cancionFacade.edit(c);

                if (relacionAnterior != null && !relacionAnterior.isEmpty()) {
                    for (Artista a : relacionAnterior) {
                        a.getCancionCollection().remove(c);
                        artistaFacade.edit(a);
                    }
                }
            }

            if (c.getIdAlbum() != null && idArtistas != null) {
                for (String idA : idArtistas) {
                    aAux = artistaFacade.find(Integer.parseInt(idA));

                    if (!aAux.getCancionCollection().contains(c)) {
                        aAux.getCancionCollection().add(c);
                        artistaFacade.edit(aAux);
                    }
                }
            }

        } catch (ParseException ex) {
            Logger.getLogger(CancionCRUDServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        return c;
    }

    private Cancion modificarCancion(HttpServletRequest request) {
        Cancion c = cargarCancion(request);
        crearCancion(request, c);
        return c;
    }

    private void eliminarCancion(HttpServletRequest request) {
        Cancion c = cargarCancion(request);

        cancionFacade.remove(c);
    }

    private List<Cancion> filtrarCanciones(HttpServletRequest request) {
        String[] idArtistas = request.getParameterValues(Utils.ARTISTASSELECCIONADOSNPUT) != null ? request.getParameterValues(Utils.ARTISTASSELECCIONADOSNPUT) : null;
        String[] idAlbumes = request.getParameterValues(Utils.ALBUMSELECCIONADOINPUT) != null ? request.getParameterValues(Utils.ALBUMSELECCIONADOINPUT) : null;
        List<Artista> artistas = null;
        List<Album> albumes = null;

        if (idArtistas != null) {
            artistas = new ArrayList();
            for (String a : idArtistas) {
                artistas.add(artistaFacade.find(Integer.parseInt(a)));
            }
        }

        if (idAlbumes != null) {
            albumes = new ArrayList();
            for (String al : idAlbumes) {
                albumes.add(albumFacade.find(Integer.parseInt(al)));
            }
        }

        return cancionFacade.filtrarCanciones(artistas, albumes);
    }

    private void incluirCancionEnLista(HttpServletRequest request) {
        Cancion c = cargarCancion(request);
        ListaReproduccion l = listaReproduccionFacade.find(Integer.parseInt(request.getParameter(Utils.IDLISTAREPRODUCCIONINPUT)));

        if (!c.getListaReproduccionCollection().contains(l)) {
            c.getListaReproduccionCollection().add(l);
            cancionFacade.edit(c);

            l.getCancionCollection().add(c);
            listaReproduccionFacade.edit(l);
        }
    }
}
