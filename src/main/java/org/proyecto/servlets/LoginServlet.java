package org.proyecto.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.proyecto.dao.UsuarioDao;
import org.proyecto.entities.Usuario;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    UsuarioDao usuarioDao = null;


    @Override
    public void init() {
        usuarioDao = new UsuarioDao();
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) {
        String accion = req.getParameter("accion");
        if (accion == null) accion = "ingresar";

        RequestDispatcher rd = null;

        switch (accion) {
            case "ingresar":
                rd = req.getRequestDispatcher("login.jsp");
                try {
                    rd.forward(req, res);
                } catch (Exception e) {
                    System.out.println(e.getMessage() + "  " + e.getCause());
                }
                break;
            case "salir":
                if (req.getSession().getId() != null) {
                    req.getSession().invalidate();
                    req.setAttribute("mensaje", "Sesion cerrada");
                }
                rd = req.getRequestDispatcher("index.jsp");
                try {
                    rd.forward(req, res);
                } catch (Exception e) {
                    System.out.println(e.getMessage() + "  " + e.getCause());
                }
                break;
            default:
        }
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) {

        String strUsuario = req.getParameter("");
        String strClave = req.getParameter("");
        //Recibo los datos del formulario

        if (req.getParameter("txtNombre") != null)
            strUsuario = req.getParameter("txtNombre");
        if (req.getParameter("txtClave") != null)
            strClave = req.getParameter("txtClave");

        //Usamos el dao para chequear en la BD si el usuario y la clave existen
        RequestDispatcher rd;

        Usuario usuario = usuarioDao.getByNombreYClave(strUsuario, strClave);
        if (usuario != null) {
            HttpSession sesion = req.getSession();
            sesion.setAttribute("usuario", usuario);
            sesion.setAttribute("mensaje", "Logueo exitoso");
            sesion.setAttribute("nombre", usuario.getNombre());
            sesion.setMaxInactiveInterval(5 * 60); //5 minutos
            rd = req.getRequestDispatcher("index.jsp");
        } else {
            rd = req.getRequestDispatcher("login.jsp");
        }
        try {
            rd.forward(req, res);
        } catch (Exception e) {
            System.out.println("El servlet del login no pudo redirigir");

        }
    }


}






