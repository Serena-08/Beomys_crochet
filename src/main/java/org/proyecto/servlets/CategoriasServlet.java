package org.proyecto.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.proyecto.dao.CategoriaDao;
import org.proyecto.entities.Categoria;
import org.proyecto.entities.Usuario;

import java.io.IOException;
import java.util.List;

@WebServlet("/categorias")
public class CategoriasServlet extends HttpServlet {

    CategoriaDao categoriaDao;

    @Override
    public void init() {
        categoriaDao = new CategoriaDao();
    }

    // Mismo control de permisos que ProductosServlet (el día 5 se unifican en una sola clase)
    private boolean tienePermiso(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession sesion = req.getSession(false);
        Usuario usuario = (sesion == null) ? null : (Usuario) sesion.getAttribute("usuario");

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

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        // Toda la gestión de categorías es solo para administradores
        if (!tienePermiso(req, res)) {
            return;
        }

        String accion = req.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "listar": {
                List<Categoria> lista = categoriaDao.getAll();
                req.setAttribute("lista", lista);
                req.getRequestDispatcher("/listaCategorias.jsp").forward(req, res);
                break;
            }
            case "nuevo": {
                req.getRequestDispatcher("/formulario-categoria.jsp").forward(req, res);
                break;
            }
            case "editar": {
                int id = aEntero(req.getParameter("idCategoria"));
                if (id < 0 || !categoriaDao.exists(id)) {
                    res.sendError(HttpServletResponse.SC_NOT_FOUND, "La categoría no existe");
                    return;
                }
                req.setAttribute("categoria", categoriaDao.getById(id));
                req.getRequestDispatcher("/formulario-categoria.jsp").forward(req, res);
                break;
            }
            case "borrar": {
                int id = aEntero(req.getParameter("idCategoria"));
                if (id < 0 || !categoriaDao.exists(id)) {
                    res.sendError(HttpServletResponse.SC_NOT_FOUND, "La categoría no existe");
                    return;
                }
                categoriaDao.delete(id);
                res.sendRedirect(req.getContextPath() + "/categorias");
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

        String strId = req.getParameter("txtIdCategoria");
        String nombre = req.getParameter("txtCategoria");
        nombre = (nombre == null) ? "" : nombre.trim();

        Categoria categoria = new Categoria();
        categoria.setCategoria(nombre);

        // Si llegó un id es una edición: compruebo que la categoría exista
        boolean esEdicion = strId != null && !strId.isEmpty();
        if (esEdicion) {
            int id = aEntero(strId);
            if (id < 0 || !categoriaDao.exists(id)) {
                res.sendError(HttpServletResponse.SC_NOT_FOUND, "La categoría no existe");
                return;
            }
            categoria.setIdCategoria(id);
        }

        // Validación en el servidor
        String error = null;
        if (nombre.isEmpty()) {
            error = "Escribí el nombre de la categoría.";
        } else if (nombre.length() > 145) {
            error = "El nombre es demasiado largo (máximo 145 caracteres).";
        }

        if (error != null) {
            // Vuelvo al formulario con el mensaje y lo que se escribió
            req.setAttribute("error", error);
            req.setAttribute("categoria", categoria);
            req.getRequestDispatcher("/formulario-categoria.jsp").forward(req, res);
            return;
        }

        if (esEdicion) {
            categoriaDao.update(categoria);
        } else {
            categoriaDao.insert(categoria);
        }

        // Redirect: al actualizar la página no se vuelve a enviar el formulario
        res.sendRedirect(req.getContextPath() + "/categorias");
    }
}