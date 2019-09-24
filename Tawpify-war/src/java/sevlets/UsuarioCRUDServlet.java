package sevlets;

import entities.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

        int opcode = Integer.parseInt(request.getParameter(Utils.OPCODE));

        if (opcode == Utils.OP_LISTAR) {
            List<Usuario> usuarios = usuarioFacade.findAll();

            request.setAttribute("usuarios", usuarios);
        } else if (opcode == Utils.OP_MODIFICAR) {
            Usuario usuarioSeleccionado = cargarUsuario(request);
            request.setAttribute("usuarioSeleccionado", usuarioSeleccionado);
        }

        RequestDispatcher rd = getServletContext().getRequestDispatcher("/usuarios.jsp");
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

        int opcode = Integer.parseInt(request.getParameter(Utils.OPCODE));

        if (opcode == Utils.OP_MODIFICAR) {
            usuarioFacade.edit(modificarUsuario(request));
        } else if (opcode == Utils.OP_BORRAR) {
            eliminarUsuario(request);
        }

        List<Usuario> usuarios = usuarioFacade.findAll();
        request.setAttribute("usuarios", usuarios);

        RequestDispatcher rd = getServletContext().getRequestDispatcher("/usuarios.jsp");
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

    private Usuario cargarUsuario(HttpServletRequest request) {
        int idUsuario = Integer.parseInt(request.getParameter(Utils.IDUSUARIOINPUT));

        return usuarioFacade.find(idUsuario);
    }

    private Usuario modificarUsuario(HttpServletRequest request) {
        Usuario u = cargarUsuario(request);

        String nombre = request.getParameter(Utils.NOMBREINPUT);
        String apodo = request.getParameter(Utils.APODOINPUT);
        String email = request.getParameter(Utils.EMAILINPUT);
        String pass = request.getParameter(Utils.CONTRASENAINPUT);
        int administrador = Integer.parseInt(request.getParameter(Utils.ADMINISTRADORINPUT));

        u.setNombre(nombre);
        u.setApodo(apodo);
        u.setEmail(email);
        u.setContrasena(pass);
        u.setAdministrador(administrador);

        return u;
    }

    private void eliminarUsuario(HttpServletRequest request) {
        int idUsuario = Integer.parseInt(request.getParameter(Utils.IDUSUARIOINPUT));

        Usuario u = usuarioFacade.find(idUsuario);

        usuarioFacade.remove(u);
    }
}
