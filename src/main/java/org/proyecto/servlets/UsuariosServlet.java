package org.proyecto.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.proyecto.dao.RolDao;
import org.proyecto.dao.UsuarioDao;
import org.proyecto.entities.Rol;
import org.proyecto.entities.Usuario;

import java.io.IOException;
import java.util.List;

@WebServlet("/usuarios")
public class UsuariosServlet extends HttpServlet {

    UsuarioDao usuarioDao;
    RolDao rolDao;

    @Override
    public void init() {
        usuarioDao = new UsuarioDao();
        rolDao = new RolDao();
    }

    // El usuario que inició sesión (o null si no hay sesión)
    private Usuario usuarioLogueado(HttpServletRequest req) {
        HttpSession sesion = req.getSession(false);
        return (sesion == null) ? null : (Usuario) sesion.getAttribute("usuario");
    }

    // Mismo control de permisos que los otros servlets (el día 5 se unifican en una sola clase)
    private boolean tienePermiso(HttpServletRequest req, HttpServletResponse res) throws IOException {
        Usuario usuario = usuarioLogueado(req);

        if (usuario == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return false;
        }
        if (!"ADMIN".equals(usuario.getRol())) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Solo los administradores pueden hacer esto");
            return false;
        }
        return true;
    }

    // Convierte un texto a número; si es null o no es un número, devuelve -1
    private int aEntero(String texto) {
        try {
            return Integer.parseInt(texto);
        } catch (NumberFormatException e) {
            return -1;
        }
    }

    // Saca los espacios de los costados; si el dato no llegó, devuelve texto vacío
    private String limpiar(String texto) {
        return texto == null ? "" : texto.trim();
    }

    // Busca un rol por su id dentro de la lista; devuelve null si no existe
    private Rol buscarRol(List<Rol> roles, int idRol) {
        for (Rol rol : roles) {
            if (rol.getIdRol() == idRol) {
                return rol;
            }
        }
        return null;
    }

    // Muestra la lista de usuarios, con un mensaje de error opcional
    private void mostrarLista(HttpServletRequest req, HttpServletResponse res, String error)
            throws ServletException, IOException {
        req.setAttribute("lista", usuarioDao.getAllConRol());
        req.setAttribute("error", error);
        req.getRequestDispatcher("/listaUsuarios.jsp").forward(req, res);
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Toda la gestión de usuarios es solo para administradores
        if (!tienePermiso(req, res)) {
            return;
        }

        String accion = req.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "listar": {
                mostrarLista(req, res, null);
                break;
            }
            case "nuevo": {
                req.setAttribute("roles", rolDao.getAll());
                req.getRequestDispatcher("/formulario-usuario.jsp").forward(req, res);
                break;
            }
            case "editar": {
                int id = aEntero(req.getParameter("idUsuario"));
                if (id < 0 || !usuarioDao.exists(id)) {
                    res.sendError(HttpServletResponse.SC_NOT_FOUND, "El usuario no existe");
                    return;
                }
                req.setAttribute("usuarioEditar", usuarioDao.getById(id));
                req.setAttribute("roles", rolDao.getAll());
                req.getRequestDispatcher("/formulario-usuario.jsp").forward(req, res);
                break;
            }
            case "borrar": {
                int id = aEntero(req.getParameter("idUsuario"));
                if (id < 0 || !usuarioDao.exists(id)) {
                    res.sendError(HttpServletResponse.SC_NOT_FOUND, "El usuario no existe");
                    return;
                }
                if (id == usuarioLogueado(req).getIdUsuario()) {
                    mostrarLista(req, res, "No podés borrar tu propia cuenta.");
                    return;
                }
                if (usuarioDao.tienePedidos(id)) {
                    mostrarLista(req, res, "No se puede borrar: el usuario tiene pedidos.");
                    return;
                }
                usuarioDao.delete(id);
                res.sendRedirect(req.getContextPath() + "/usuarios");
                break;
            }
            default:
                res.sendError(HttpServletResponse.SC_BAD_REQUEST, "Acción no válida");
        }
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Antes de leer los parámetros, para que no se rompan las tildes
        req.setCharacterEncoding("UTF-8");

        if (!tienePermiso(req, res)) {
            return;
        }

        String strId = req.getParameter("txtIdUsuario");
        String nombre = limpiar(req.getParameter("txtNombre"));
        String apellido = limpiar(req.getParameter("txtApellido"));
        String correo = limpiar(req.getParameter("txtCorreo"));
        String clave = req.getParameter("txtClave");
        int idRol = aEntero(req.getParameter("txtIdRol"));
        if (clave == null) {
            clave = "";
        }

        // Si llegó un id es una edición: compruebo que el usuario exista
        boolean esEdicion = strId != null && !strId.isEmpty();
        int id = 0;
        Usuario existente = null;
        if (esEdicion) {
            id = aEntero(strId);
            if (id < 0 || !usuarioDao.exists(id)) {
                res.sendError(HttpServletResponse.SC_NOT_FOUND, "El usuario no existe");
                return;
            }
            existente = usuarioDao.getById(id);
        }

        List<Rol> roles = rolDao.getAll();
        Rol rolElegido = buscarRol(roles, idRol);

        // Validación en el servidor
        String error = validar(nombre, apellido, correo, clave, esEdicion);
        if (error == null && rolElegido == null) {
            error = "Elegí un rol válido.";
        }
        if (error == null && usuarioDao.existeNombreOCorreoDeOtro(nombre, correo, id)) {
            error = "El nombre de usuario o el correo ya están registrados.";
        }
        if (error == null && esEdicion && id == usuarioLogueado(req).getIdUsuario()
                && !"ADMIN".equals(rolElegido.getNombre())) {
            error = "No podés quitarte tu propio rol de administrador.";
        }

        Usuario usuario = new Usuario();
        usuario.setIdUsuario(id);
        usuario.setNombre(nombre);
        usuario.setApellido(apellido);
        usuario.setCorreo(correo);
        usuario.setIdRol(Math.max(idRol, 0));

        if (error != null) {
            // Vuelvo al formulario con el mensaje y lo que se escribió (menos la contraseña)
            req.setAttribute("error", error);
            req.setAttribute("usuarioEditar", usuario);
            req.setAttribute("roles", roles);
            req.getRequestDispatcher("/formulario-usuario.jsp").forward(req, res);
            return;
        }

        // Al editar, si la clave quedó vacía se conserva la actual (que ya está con hash)
        if (esEdicion && clave.isEmpty()) {
            usuario.setClave(existente.getClave());
        } else {
            usuario.setClave(clave);
        }

        if (esEdicion) {
            usuarioDao.update(usuario);
        } else {
            usuarioDao.insert(usuario);
        }

        // Redirect: al actualizar la página no se vuelve a enviar el formulario
        res.sendRedirect(req.getContextPath() + "/usuarios");
    }

    // Devuelve un mensaje de error, o null si todo está bien
    private String validar(String nombre, String apellido, String correo, String clave, boolean esEdicion) {
        if (nombre.isEmpty() || apellido.isEmpty() || correo.isEmpty()) {
            return "Completá el nombre, el apellido y el correo.";
        }
        if (nombre.length() > 145 || apellido.length() > 145 || correo.length() > 145) {
            return "Los datos son demasiado largos (máximo 145 caracteres).";
        }
        if (!correo.matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
            return "El correo no tiene un formato válido.";
        }
        // Al crear la clave es obligatoria; al editar solo se valida si se escribió una nueva
        if (!esEdicion || !clave.isEmpty()) {
            if (clave.length() < 6) {
                return "La contraseña debe tener al menos 6 caracteres.";
            }
            if (clave.length() > 72) {
                return "La contraseña puede tener como máximo 72 caracteres.";
            }
        }
        return null;
    }
}