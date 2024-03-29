package sevlets;

import entities.Usuario;
import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import session.UsuarioFacade;
import utils.Utils;

/**
 *
 * @author Asde
 */
@WebServlet(name = "UsuarioCRUDServlet", urlPatterns = {"/UsuarioCRUDServlet"})
public class UsuarioCRUDServlet extends HttpServlet {

    @EJB
    UsuarioFacade usuarioFacade;

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

        try {
            int opcode = Integer.parseInt(request.getParameter(Utils.OPCODE));

//        if (opcode == Utils.OP_LISTAR) {
            List<Usuario> usuarios = usuarioFacade.findAll();

            request.setAttribute("usuarios", usuarios);
//        }

            RequestDispatcher rd = getServletContext().getRequestDispatcher("/usuarios.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("mensajeError", "Ooops. Algo ha ido mal prueba a intentarlo de nuevo");
            request.setAttribute(Utils.RUTA, Utils.RUTA_ERROR);

            RequestDispatcher rd = getServletContext().getRequestDispatcher("/EnrutadorServlet");
            rd.forward(request, response);
        }
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
        try {

            HttpSession session = request.getSession();
            boolean logout = false;

            RequestDispatcher rd = null;
            int opcode = Integer.parseInt(request.getParameter(Utils.OPCODE));

            switch (opcode) {
                case Utils.OP_REDIRECCION_MODIFICAR:
                    Usuario usuarioSeleccionado = cargarUsuario(request);
                    request.setAttribute("usuarioSeleccionado", usuarioSeleccionado);
                    request.setAttribute("opcode", opcode);
                    rd = getServletContext().getRequestDispatcher("/login.jsp");
                    break;
                case Utils.OP_BORRAR:
                    logout = eliminarUsuario(request, session);
                    if (logout) {
                        response.sendRedirect(Utils.APP_PATH + "/index.jsp");
                        session.removeAttribute("usuarioConectado");
                    } else {
                        rd = getServletContext().getRequestDispatcher("/usuarios.jsp");
                    }
                    break;
                default:
                    // Venimos de la creacion / modificacion del ususario
                    rd = getServletContext().getRequestDispatcher("/usuarios.jsp");
                    break;
            }

            if (!logout) {
                List<Usuario> usuarios = usuarioFacade.findAll();
                request.setAttribute("usuarios", usuarios);

                rd.forward(request, response);
            }

        } catch (Exception e) {
            HttpSession session = request.getSession();
            session.setAttribute("mensajeError", "Ooops. Algo ha ido mal prueba a intentarlo de nuevo");
            request.setAttribute(Utils.RUTA, Utils.RUTA_ERROR);

            RequestDispatcher rd = getServletContext().getRequestDispatcher("/EnrutadorServlet");
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

    private Usuario cargarUsuario(HttpServletRequest request) throws Exception {
        int idUsuario = Integer.parseInt(request.getParameter(Utils.IDUSUARIOINPUT));

        return usuarioFacade.find(idUsuario);
    }

    private boolean eliminarUsuario(HttpServletRequest request, HttpSession session) throws Exception {
        int idUsuario = Integer.parseInt(request.getParameter(Utils.IDUSUARIOINPUT));
        boolean resp;

        Usuario u = usuarioFacade.find(idUsuario);

        resp = session.getAttribute("usuarioConectado") != null ? u.getIdUsuario().equals(((Usuario) session.getAttribute("usuarioConectado")).getIdUsuario()) : false;

        usuarioFacade.remove(u);

        return resp;
    }
}
