/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sevlets;

import entities.Genero;
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
import session.GeneroFacade;
import utils.Utils;

/**
 *
 * @author Asde
 */
@WebServlet(name = "GeneroCRUDServlet", urlPatterns = {"/GeneroCRUDServlet"})
public class GeneroCRUDServlet extends HttpServlet {

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

        List<Genero> generos = generoFacade.findAll();

        request.setAttribute("generos", generos);

        RequestDispatcher rd = getServletContext().getRequestDispatcher("/generos.jsp");
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
                generoFacade.edit(modificarGenero(request));
                break;
            case Utils.OP_BORRAR:
                eliminarGenero(request);
                break;
            case Utils.OP_CREAR:
                generoFacade.create(crearGenero(request));
                break;
        }

        List<Genero> generos = generoFacade.findAll();
        request.setAttribute("generos", generos);

        rd = getServletContext().getRequestDispatcher("/generos.jsp");
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

    private Genero cargarGenero(HttpServletRequest request) {
        int idGenero = Integer.parseInt(request.getParameter(Utils.IDGENEROINPUT));

        return generoFacade.find(idGenero);
    }

    private Genero crearGenero(HttpServletRequest request) {
        Genero g = new Genero();

        String nombre = request.getParameter(Utils.NOMBREINPUT);
        g.setNombre(nombre);

        return g;
    }

    private Genero modificarGenero(HttpServletRequest request) {
        Genero g = cargarGenero(request);

        String nombre = request.getParameter(Utils.NOMBREINPUT);

        g.setNombre(nombre);

        return g;
    }

    private void eliminarGenero(HttpServletRequest request) {
        Genero u = cargarGenero(request);

        generoFacade.remove(u);
    }
}
