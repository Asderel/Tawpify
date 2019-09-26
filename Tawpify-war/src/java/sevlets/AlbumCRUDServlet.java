package sevlets;

import entities.Artista;
import entities.Album;
import entities.Cancion;
import entities.Genero;
import entities.ListaReproduccion;
import java.io.IOException;
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
import session.GeneroFacade;
import session.ListaReproduccionFacade;
import utils.Utils;

/**
 *
 * @author Asde
 */
@WebServlet(name = "AlbumCRUDServlet", urlPatterns = {"/AlbumCRUDServlet"})
public class AlbumCRUDServlet extends HttpServlet {

    @EJB
    ArtistaFacade artistaFacade;

    @EJB
    AlbumFacade albumFacade;

    @EJB
    ListaReproduccionFacade listaReproduccionFacade;

    @EJB
    CancionFacade cancionFacade;

    @EJB
    GeneroFacade generoFacade;

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
        response.setContentType("text/html;charset=UTF-8");
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

        List<Artista> artistas = artistaFacade.findAll();
        List<Album> albumes = albumFacade.findAll();
        List<Genero> generos = generoFacade.findAll();
        List<ListaReproduccion> listasReproduccion = listaReproduccionFacade.findAll();

        session.setAttribute("artistas", artistas);
        session.setAttribute("albumes", albumes);
        session.setAttribute("generos", generos);
        session.setAttribute("listasReproduccion", listasReproduccion);

        RequestDispatcher rd = getServletContext().getRequestDispatcher("/albumes.jsp");
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
        Album albumSeleccionado = null;

        List<Artista> artistas;
        List<Album> albumes = null;
        List<Genero> generos;

        switch (opcode) {
            case Utils.OP_MODIFICAR:
                albumFacade.edit(modificarAlbum(request));

                break;
            case Utils.OP_BORRAR:
                eliminarAlbum(request);

                break;
            case Utils.OP_CREAR:
                albumFacade.create(crearAlbum(request, null));

                session.removeAttribute("artistas");
                session.removeAttribute("albumes");
                session.removeAttribute("generos");
                break;
            case Utils.OP_FILTRAR:
                albumes = filtrarAlbumes(request);

                break;
            case Utils.OP_REDIRECCION_MODIFICAR:
                albumSeleccionado = cargarAlbum(request);

                session.setAttribute("albumSeleccionado", albumSeleccionado);
                rd = getServletContext().getRequestDispatcher("/nuevoAlbum.jsp");
                rd.forward(request, response);
                break;
            case Utils.OP_LISTAR:
                albumSeleccionado = cargarAlbum(request);

                session.setAttribute("albumSeleccionado", albumSeleccionado);
                rd = getServletContext().getRequestDispatcher("/nuevoAlbum.jsp");
                rd.forward(request, response);
                break;
            case Utils.OP_CREAR_CANCION_ALBUM:
                incluirCancionAlbum(request);

//                artistas = artistaFacade.findAll();
//                albumes = albumFacade.findAll();
//                generos = generoFacade.findAll();
                session.removeAttribute("artistas");
                session.removeAttribute("albumes");
                session.removeAttribute("generos");

//                session.setAttribute("artistas", artistas);
//                session.setAttribute("albumes", albumes);
//                session.setAttribute("generos", generos);
                albumSeleccionado = cargarAlbum(request);
                session.removeAttribute("albumSeleccionado");
                session.setAttribute("albumSeleccionado", albumSeleccionado);

//                rd = getServletContext().getRequestDispatcher("/nuevoAlbum.jsp");
//                rd.forward(request, response);
                break;
            case Utils.OP_BORRAR_CANCION_ALBUM:
                eliminarCancionAlbum(request);

//                artistas = artistaFacade.findAll();
//                albumes = albumFacade.findAll();
//                generos = generoFacade.findAll();
                session.removeAttribute("artistas");
                session.removeAttribute("albumes");
                session.removeAttribute("generos");

//                session.setAttribute("artistas", artistas);
//                session.setAttribute("albumes", albumes);
//                session.setAttribute("generos", generos);
                albumSeleccionado = cargarAlbum(request);
                session.removeAttribute("albumSeleccionado");
                session.setAttribute("albumSeleccionado", albumSeleccionado);

//                rd = getServletContext().getRequestDispatcher("/nuevoAlbum.jsp");
//                rd.forward(request, response);
                break;
            case Utils.OP_INCLUIR_CANCION_LISTA:
                incluirCancionEnLista(request, false);
                break;
            case Utils.OP_INCLUIR_ALBUM_LISTA:
                incluirCancionEnLista(request, true);
                break;
        }

        if (opcode != Utils.OP_FILTRAR) {
            albumes = albumFacade.findAll();
        }

        artistas = artistaFacade.findAll();
        generos = generoFacade.findAll();

        session.setAttribute("artistas", artistas);
        session.setAttribute("albumes", albumes);
        session.setAttribute("generos", generos);

        rd = getServletContext().getRequestDispatcher("/albumes.jsp");
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

    private Album cargarAlbum(HttpServletRequest request) {
        int idAlbum = Integer.parseInt(request.getParameter(Utils.IDALBUMINPUT));

        return albumFacade.find(idAlbum);
    }

    private Album crearAlbum(HttpServletRequest request, Album album) {
        Album al = album;
        if (al == null) {
            al = new Album();
        }

        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

        try {
            Date fechaSalida = formatter.parse(request.getParameter(Utils.FECHASALIDAINPUT));
            String nombre = request.getParameter(Utils.NOMBREINPUT);

            if (request.getParameterValues(Utils.IDGENEROSSELECCIONADOSALBUM) != null) {
                String idGeneros[] = request.getParameterValues(Utils.IDGENEROSSELECCIONADOSALBUM);

                List<Genero> generos = new ArrayList<>();

                for (String idg : idGeneros) {
                    generos.add(generoFacade.find(Integer.parseInt(idg)));
                }
                al.setGeneroCollection(generos);
            }

            int idArtista = Integer.parseInt(request.getParameter(Utils.ARTISTASELECCIONADOSNPUT));
            Artista a = artistaFacade.find(idArtista);

            // SETTTER
            al.setNombre(nombre);
            al.setFechaSalida(fechaSalida);
            al.setIdArtista(a);
        } catch (ParseException ex) {
            Logger.getLogger(AlbumCRUDServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        return al;
    }

    private Album modificarAlbum(HttpServletRequest request) {
        Album al = cargarAlbum(request);
        crearAlbum(request, al);
        return al;
    }

    private void eliminarAlbum(HttpServletRequest request) {
        Album al = cargarAlbum(request);

        albumFacade.remove(al);
    }

    private List<Album> filtrarAlbumes(HttpServletRequest request) {
        String[] idArtistas = request.getParameterValues(Utils.ARTISTASSELECCIONADOSNPUT) != null ? request.getParameterValues(Utils.ARTISTASSELECCIONADOSNPUT) : null;
        List<Artista> artistas = null;

        if (idArtistas != null) {
            artistas = new ArrayList();
            for (String a : idArtistas) {
                artistas.add(artistaFacade.find(Integer.parseInt(a)));
            }
        }
        return albumFacade.filtrarAlbumes(artistas);
    }

    private void incluirCancionAlbum(HttpServletRequest request) {
        Album albumSeleccionado = cargarAlbum(request);

        int idCancion = request.getParameter(Utils.IDCANCIONINPUT) != null && !request.getParameter(Utils.IDCANCIONINPUT).isEmpty()
                ? Integer.parseInt(request.getParameter(Utils.IDCANCIONINPUT)) : 0;

        if (idCancion != 0) {
            cancionFacade.edit(crearCancionAlbum(idCancion, albumSeleccionado, request));
        } else {
            cancionFacade.create(crearCancionAlbum(idCancion, albumSeleccionado, request));
        }
    }

    private Cancion crearCancionAlbum(int idCancion, Album albumSeleccionado, HttpServletRequest request) {
        Cancion c = new Cancion();
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

        try {
            Date fechaSalida = formatter.parse(request.getParameter(Utils.FECHASALIDAINPUT));

            if (idCancion != 0) {
                cancionFacade.find(idCancion);
            }

            String nombre = request.getParameter(Utils.NOMBREINPUT);
            String url = request.getParameter(Utils.URLINPUT);

            // SETTTER
            c.setNombre(nombre);
            c.setFechaSalida(fechaSalida);
            c.setUrl(url);
            c.setIdAlbum(albumSeleccionado);
        } catch (ParseException ex) {
            Logger.getLogger(CancionCRUDServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        return c;
    }

    private void eliminarCancionAlbum(HttpServletRequest request) {
        int idCancion = request.getParameter(Utils.IDCANCIONINPUT) != null && !request.getParameter(Utils.IDCANCIONINPUT).isEmpty()
                ? Integer.parseInt(request.getParameter(Utils.IDCANCIONINPUT)) : 0;

        if (idCancion != 0) {
            cancionFacade.remove(cancionFacade.find(idCancion));
        }
    }

    private void incluirCancionEnLista(HttpServletRequest request, boolean album) {
        ListaReproduccion l = listaReproduccionFacade.find(Integer.parseInt(request.getParameter(Utils.IDLISTAREPRODUCCIONINPUT)));

        if (!album) {
            Cancion c = cancionFacade.find(Integer.parseInt(request.getParameter(Utils.IDCANCIONINPUT)));

            if (!c.getListaReproduccionCollection().contains(l)) {
                c.getListaReproduccionCollection().add(l);
                cancionFacade.edit(c);
            }
        } else {
            Album a = albumFacade.find(Integer.parseInt(request.getParameter(Utils.IDALBUMINPUT)));

            for (Cancion cancion : a.getCancionCollection()) {
                if (!cancion.getListaReproduccionCollection().contains(l)) {
                    cancion.getListaReproduccionCollection().add(l);
                    cancionFacade.edit(cancion);
                }
            }
        }
    }
}
