package org.proyecto.servlets;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.proyecto.dao.ProductoDao;
import org.proyecto.entities.Producto;

import java.util.ArrayList;
import java.util.List;

@WebServlet("/productos")
public class ProductosServlet extends HttpServlet {

    ProductoDao productoDao;

    @Override
    public void init() {
        productoDao = new ProductoDao();
    }

    @Override
    public void doGet(HttpServletRequest req, HttpServletResponse res) {

        //Get devuelve la lista de todos los empleados pasando atributo
        String accion = req.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        RequestDispatcher rd = null;
        switch (accion) {
            case "listar":
                List<Producto> lista = new ArrayList<>();
                lista = productoDao.getAll();

                //Seteo los atributos de la requets
                req.setAttribute("lista", lista);

                //Envio con el distpacher
                rd = req.getRequestDispatcher("listado-productos.jsp");

                try {
                    rd.forward(req, res); //redirijo al listado-productos.jsp
                } catch (Exception e) {
                    System.out.println("No se pudo obtener el listado");
                }
                break;
            case "nuevo":
                rd = req.getRequestDispatcher("formulario-producto.jsp");
                try {
                    rd.forward(req, res); //redirijo a formulario-producto.jsp
                } catch (Exception e) {
                    System.out.println("No se pudo abrir el formulario");
                }
                break;
            case "editar":
                String strId = req.getParameter("id");
                int idProducto = Integer.parseInt(strId);

                //BUsco x ide si existe el producto en la base de datos
                Producto producto = productoDao.getById(idProducto);

                //tengo que pasar el producto al formulario para que muestre sus datos
                req.setAttribute("producto", producto);//Seteo el atributo para el formulario
                rd = req.getRequestDispatcher("formulario-producto.jsp");
                try {
                    rd.forward(req, res); //redirijo a formulario-producto.jsp
                } catch (Exception e) {
                    System.out.println("No se pudo abrir el formulario");
                }
                break;
            default:
                System.out.println("Acción no válida");
        }
    }

    @Override
    public void doPost(HttpServletRequest req, HttpServletResponse res) {
        //Se encarga de guardar uno nuevo o actualizar uno existente
        String strId = req.getParameter("txtId");
        String strNombre = req.getParameter("txtNombre");
        String strPrecio = req.getParameter("txtPrecio");
        String strDescripcion = req.getParameter("txtDescripcion");
        String strUrlImagen = req.getParameter("txtUrlImagen");
        String strUrlML = req.getParameter("txtUrlML");
        String strIdCategoria = req.getParameter("txtIdCategoria");

        //2- Creo producto seteando los datos
        Producto producto = new Producto();
        producto.setNombre(strNombre);
        producto.setDescripcion(strDescripcion);

        //3- Parseo los datos numericos
        if (strPrecio != null && !strPrecio.isEmpty()) {
            producto.setPrecio(Double.parseDouble(strPrecio));
        }

        //if (strUrlImagen != null && !strUrlImagen.isEmpty()) {
        //  producto.setUrlImagen(strUrlImagen);
        //}

        //Guardo
        if (strId == null || strId.isEmpty()) {
            //es nuevo producto
            productoDao.insert(producto);
        } else {
            producto.setIdProducto(Integer.parseInt(strId));
            productoDao.update(producto);
        }

        RequestDispatcher rd = req.getRequestDispatcher("index.jsp");
        try {
            rd.forward(req, res);
        } catch (Exception e) {
            System.out.println("No se pudo redirigir al index");
        }
    }

}
