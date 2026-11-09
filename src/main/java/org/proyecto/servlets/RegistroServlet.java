package org.proyecto.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.proyecto.dao.UsuarioDao;
import org.proyecto.entities.Usuario;

import java.io.IOException;

@WebServlet("/registro")
public class RegistroServlet extends HttpServlet {

    UsuarioDao usuarioDao;

    @Override
    public void init() {
        usuarioDao = new UsuarioDao();
    }

    // GET: solo muestra el formulario
    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.getRequestDispatcher("/registro.jsp").forward(req, res);
    }

    // POST: valida, guarda y redirige
    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Tiene que ir antes de leer los parámetros, si no se rompen las tildes
        req.setCharacterEncoding("UTF-8");

        String nombre = limpiar(req.getParameter("txtNombre"));
        String apellido = limpiar(req.getParameter("txtApellido"));
        String correo = limpiar(req.getParameter("txtCorreo"));
        String clave = req.getParameter("txtClave");
        String clave2 = req.getParameter("txtClave2");

        // Validación en el servidor (el navegador también valida, pero se puede saltear)
        String error = validar(nombre, apellido, correo, clave, clave2);

        if (error == null && usuarioDao.existeNombreOCorreo(nombre, correo)) {
            error = "El nombre de usuario o el correo ya están registrados.";
        }

        if (error != null) {
            // Vuelvo al formulario con el mensaje y lo que escribió (menos las contraseñas)
            req.setAttribute("error", error);
            req.setAttribute("nombre", nombre);
            req.setAttribute("apellido", apellido);
            req.setAttribute("correo", correo);
            req.getRequestDispatcher("/registro.jsp").forward(req, res);
            return;
        }

        Usuario usuario = new Usuario();
        usuario.setNombre(nombre);
        usuario.setApellido(apellido);
        usuario.setCorreo(correo);
        usuario.setClave(clave); // el DAO la guarda con hash
        usuarioDao.insert(usuario);

        // Redirect: si la persona actualiza la página, no se vuelve a registrar
        res.sendRedirect(req.getContextPath() + "/login?registro=ok");
    }

    // Devuelve un mensaje de error, o null si todo está bien
    private String validar(String nombre, String apellido, String correo, String clave, String clave2) {
        if (nombre.isEmpty() || apellido.isEmpty() || correo.isEmpty() || clave == null || clave.isEmpty()) {
            return "Completá todos los campos.";
        }
        if (nombre.length() > 145 || apellido.length() > 145 || correo.length() > 145) {
            return "Los datos son demasiado largos (máximo 145 caracteres).";
        }
        if (!correo.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            return "El correo no tiene un formato válido.";
        }
        if (clave.length() < 6) {
            return "La contraseña debe tener al menos 6 caracteres.";
        }
        if (clave.length() > 72) {
            return "La contraseña puede tener como máximo 72 caracteres.";
        }
        if (!clave.equals(clave2)) {
            return "Las contraseñas no coinciden.";
        }
        return null;
    }

    // Saca los espacios de los costados; si el dato no llegó, devuelve texto vacío
    private String limpiar(String texto) {
        return texto == null ? "" : texto.trim();
    }
}