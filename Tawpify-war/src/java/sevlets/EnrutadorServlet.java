/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sevlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.Utils;

/**
 *
 * @author Asde
 */
@WebServlet(name = "EnrutadorServlet", urlPatterns = {"/EnrutadorServlet"})
public class EnrutadorServlet extends HttpServlet {

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
        int ruta = Integer.parseInt(request.getAttribute(Utils.RUTA).toString());
        HttpSession session = request.getSession();

        switch (ruta) {
            case Utils.RUTA_CANCIONES:
                response.sendRedirect(Utils.APP_PATH + Utils.CANCIONES);
                break;
            case Utils.RUTA_ALBUMES:
                response.sendRedirect(Utils.APP_PATH + Utils.ALBUMES);
                break;
            case Utils.RUTA_ARTISTAS:
                response.sendRedirect(Utils.APP_PATH + Utils.ARTISTAS);
                break;
            case Utils.RUTA_GENEROS:
                response.sendRedirect(Utils.APP_PATH + Utils.GENEROS);
                break;
            case Utils.RUTA_LISTAS:
                response.sendRedirect(Utils.APP_PATH + Utils.LISTAS);
                break;
            case Utils.RUTA_USUARIOS:
                response.sendRedirect(Utils.APP_PATH + Utils.USUARIOS);
                break;
            case Utils.RUTA_ERROR:
                session.removeAttribute("artistas");
                session.removeAttribute("albumes");
                session.removeAttribute("canciones");
                session.removeAttribute("listasReproduccion");
                session.removeAttribute("generos");
                session.removeAttribute("usuarios");

                session.removeAttribute("cancionSeleccionada");
                session.removeAttribute("albumSeleccionado");
                session.removeAttribute("albumesSeleccionados");
                session.removeAttribute("artistaSeleccionado");
                session.removeAttribute("artistaSeleccionados");
                session.removeAttribute("listaSeleccionada");

                String mensajeError = session.getAttribute("mensajeError").toString();
                session.removeAttribute("mensajeError");

                request.setAttribute("mensajeError", mensajeError);
                RequestDispatcher rd = request.getRequestDispatcher(Utils.ERROR);
                rd.forward(request, response);
                break;
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
        processRequest(request, response);
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

}
