package sevlets;

import entities.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet LoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LoginServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        processRequest(request, response);
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
        HttpSession session = request.getSession();
        RequestDispatcher rd;

        Usuario u;
        int opcode = Integer.parseInt(request.getParameter(Utils.OPCODE));

        switch (opcode) {
            case Utils.OP_LOGIN:
                u = logUsuario(request);
                session.setAttribute("usuarioConectado", u);
                rd = getServletContext().getRequestDispatcher("/index.jsp");
                rd.forward(request, response);
                break;
            case Utils.OP_REGISTRAR:
                u = crearUsuario(request);
                usuarioFacade.create(u);
                session.setAttribute("usuarioConectado", u);
                rd = getServletContext().getRequestDispatcher("/index.jsp");
                rd.forward(request, response);
                break;
            case Utils.OP_MODIFICAR:
                usuarioFacade.edit(modificarUsuario(request));
                rd = getServletContext().getRequestDispatcher("/UsuarioCRUDServlet");
                rd.forward(request, response);
                break;
            case Utils.OP_CREAR:
                usuarioFacade.create(crearUsuarioAdministracion(request));
                rd = getServletContext().getRequestDispatcher("/UsuarioCRUDServlet");
                rd.forward(request, response);
                break;
            default:
                response.sendRedirect(Utils.APP_PATH + "/login.jsp");
                break;
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

    private Usuario crearUsuario(HttpServletRequest request) {
        Usuario u = new Usuario();

        String nombre = request.getParameter(Utils.NOMBREINPUT);
        String apodo = request.getParameter(Utils.APODOINPUT);
        String email = request.getParameter(Utils.EMAILINPUT);
        String pass = request.getParameter(Utils.CONTRASENAINPUT);

        u.setNombre(nombre);
        u.setApodo(apodo);
        u.setEmail(email);
        u.setContrasena(pass);
        u.setAdministrador(0);

        return u;
    }

    private Usuario crearUsuarioAdministracion(HttpServletRequest request) {
        Usuario u = new Usuario();

        String nombre = request.getParameter(Utils.NOMBREINPUT);
        String apodo = request.getParameter(Utils.APODOINPUT);
        String email = request.getParameter(Utils.EMAILINPUT);
        String pass = request.getParameter(Utils.CONTRASENAINPUT);
        int administrador = request.getParameter(Utils.ADMINISTRADORINPUT) == null || request.getParameter(Utils.ADMINISTRADORINPUT).equalsIgnoreCase("") || request.getParameter(Utils.ADMINISTRADORINPUT).equalsIgnoreCase("off")
                ? 0 : 1;

        u.setNombre(nombre);
        u.setApodo(apodo);
        u.setEmail(email);
        u.setContrasena(pass);
        u.setAdministrador(administrador);

        return u;
    }

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
        int administrador = request.getParameter(Utils.ADMINISTRADORINPUT) == null || request.getParameter(Utils.ADMINISTRADORINPUT).equalsIgnoreCase("") || request.getParameter(Utils.ADMINISTRADORINPUT).equalsIgnoreCase("off")
                ? 0 : 1;

        u.setNombre(nombre);
        u.setApodo(apodo);
        u.setEmail(email);
        u.setContrasena(pass);
        u.setAdministrador(administrador);

        return u;
    }

    private Usuario logUsuario(HttpServletRequest request) {
        String email = request.getParameter(Utils.EMAILINPUT);
        String pass = request.getParameter(Utils.CONTRASENAINPUT);

        return usuarioFacade.login(email, pass);
    }
}
