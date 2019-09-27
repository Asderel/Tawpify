package sevlets;

import entities.Cancion;
import entities.ListaReproduccion;
import entities.Usuario;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.Instant;
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
import session.CancionFacade;
import session.ListaReproduccionFacade;
import utils.Utils;

/**
 *
 * @author Asde
 */
@WebServlet(name = "ListaReproduccionCRUDServlet", urlPatterns = {"/ListaReproduccionCRUDServlet"})
public class ListaReproduccionCRUDServlet extends HttpServlet {

    @EJB
    ListaReproduccionFacade listaReproduccionFacade;

    @EJB
    CancionFacade cancionFacade;

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

        Usuario u = (Usuario) session.getAttribute("usuarioConectado");

        List<ListaReproduccion> listasReproduccion = cargarListasReproduccion(u);
        List<Cancion> canciones = cancionFacade.findAll();

        session.setAttribute("listasReproduccion", listasReproduccion);
        session.setAttribute("canciones", canciones);

        RequestDispatcher rd = getServletContext().getRequestDispatcher("/listasReproduccion.jsp");
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
        Usuario u = (Usuario) session.getAttribute("usuarioConectado");
        int opcode = Integer.parseInt(request.getParameter(Utils.OPCODE));
        ListaReproduccion listaSeleccionada = null;

        List<ListaReproduccion> listasReproduccion;

        switch (opcode) {
            case Utils.OP_MODIFICAR:

                listaReproduccionFacade.edit(modificarListaReproduccion(request, u));
                break;
            case Utils.OP_BORRAR:

                eliminarListaReproduccion(request);
                break;
            case Utils.OP_CREAR:

                listaReproduccionFacade.create(crearListaReproduccion(request, null, u));
                break;
            case Utils.OP_BORRAR_CANCION_LISTA:

                listaSeleccionada = eliminarCancionLista(request);

                session.setAttribute("listaSeleccionada", listaSeleccionada);
                rd = getServletContext().getRequestDispatcher("/listaReproduccion.jsp");
                rd.forward(request, response);
                break;
            case Utils.OP_LISTAR:
                listaSeleccionada = cargarListaReproduccion(request);

                session.setAttribute("listaSeleccionada", listaSeleccionada);
                rd = getServletContext().getRequestDispatcher("/listaReproduccion.jsp");
                rd.forward(request, response);
                break;
        }

        listasReproduccion = cargarListasReproduccion(u);

        session.setAttribute("listasReproduccion", listasReproduccion);

        rd = getServletContext().getRequestDispatcher("/listasReproduccion.jsp");
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

    private ListaReproduccion cargarListaReproduccion(HttpServletRequest request) {
        int idAlbum = Integer.parseInt(request.getParameter(Utils.IDLISTAREPRODUCCIONINPUT));

        return listaReproduccionFacade.find(idAlbum);
    }

    private List<ListaReproduccion> cargarListasReproduccion(Usuario usuario) {
        return usuario.getAdministrador() == 1
                ? listaReproduccionFacade.selectListasReproduccionByUsuario(usuario)
                : listaReproduccionFacade.findAll();
    }

    private ListaReproduccion crearListaReproduccion(HttpServletRequest request, ListaReproduccion lista, Usuario usuario) {
        ListaReproduccion l = lista;
        Date fechaSalida;
        SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");

        try {

            if (l == null) {
                l = new ListaReproduccion();
                fechaSalida = Date.from(Instant.now());
            } else {
                fechaSalida = formatter.parse(request.getParameter(Utils.FECHASALIDAINPUT));
            }

            String nombre = request.getParameter(Utils.NOMBREINPUT);

            // SETTER
            l.setNombre(nombre);
            l.setFechaCreacion(fechaSalida);
            l.setIdUsuario(usuario);

        } catch (ParseException ex) {
            Logger.getLogger(AlbumCRUDServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return l;
    }

    private ListaReproduccion modificarListaReproduccion(HttpServletRequest request, Usuario u) {
        ListaReproduccion l = cargarListaReproduccion(request);
        crearListaReproduccion(request, l, u);
        return l;
    }

    private void eliminarListaReproduccion(HttpServletRequest request) {
        ListaReproduccion l = cargarListaReproduccion(request);

        listaReproduccionFacade.remove(l);
    }

    private ListaReproduccion eliminarCancionLista(HttpServletRequest request) {
        ListaReproduccion l = cargarListaReproduccion(request);
        Cancion cancion = cancionFacade.find(Integer.parseInt(request.getParameter(Utils.IDCANCIONINPUT)));

        cancion.getListaReproduccionCollection().remove(l);
        l.getCancionCollection().remove(cancion);

        cancionFacade.edit(cancion);
        listaReproduccionFacade.edit(l);

        return l;
    }
}
