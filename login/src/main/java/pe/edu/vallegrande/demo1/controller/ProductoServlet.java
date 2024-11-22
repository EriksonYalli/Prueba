package pe.edu.vallegrande.demo1.controller;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import pe.edu.vallegrande.demo1.dto.ClienteDTO;
import pe.edu.vallegrande.demo1.dto.ProductoDTO;
import pe.edu.vallegrande.demo1.service.ClienteSERVICE;
import pe.edu.vallegrande.demo1.service.ProductoSERVICE;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/producto")
public class ProductoServlet extends HttpServlet {

    private ProductoSERVICE productoService = new ProductoSERVICE();
    private static final String LISTAR = "index.jsp?page=listarProducto";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String marca = request.getParameter("marca");
        String categoria = request.getParameter("categoria");// Obtener el parámetro de marca


        if (marca != null && !marca.isEmpty()) {
            // Si se ha seleccionado una marca, filtrar productos por marca
            List<ProductoDTO> productosPorMarca = productoService.listarProductosPorMarca(marca);
            request.setAttribute("productos", productosPorMarca);
            request.getRequestDispatcher(LISTAR).forward(request, response);
            return;
        }

        switch (action) {
            case "listar":
                System.out.println("ksa");
                response.sendRedirect("index.jsp?page=listarProducto");
                break;

            case "editar":
                String accesoEditar = editarPorId(request);
                request.getRequestDispatcher(accesoEditar).forward(request, response);
                break;

            case "eliminar":
                elimarProductoID(request);
                response.sendRedirect("index.jsp?page=listarProducto"); // Redirige después de eliminar
                return;

            case "restaurar":
                restaurarProductoID(request);
                response.sendRedirect("index.jsp?page=listarProductoInactivos"); // Redirige después de restaurar
                return;


            case "Inactivos":
                System.out.println("oawd");
                response.sendRedirect("index.jsp?page=listarProductoInactivos");
                break;

            case "inicio":
                response.sendRedirect("index.jsp?page=inicio");
                return;

            case "buscarProducto":
                System.out.println("buscandoProducto");
                String code = request.getParameter("code");

                // Busca al cliente utilizando el servicio
                ProductoDTO producto = ProductoSERVICE.buscarProducto(code);

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");

                // Crea la respuesta en JSON
                JSONObject jsonResponse = new JSONObject();

                if (producto != null) {
                    jsonResponse.put("nombre", producto.getNombre());
                    jsonResponse.put("precioVenta", producto.getPrecioVenta());
                } else {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                }

                response.getWriter().write(jsonResponse.toString());
                break;


            default:
                response.sendRedirect("index.jsp?page=listarProducto");

                break;


        }
    }

    private void elimarProductoID(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        productoService.eliminarProductoID(id);
    }

    private void restaurarProductoID(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        productoService.restaurarProductoID(id);
    }

    private String editarPorId(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        ProductoDTO producto = productoService.editarPorId(id);
        if (producto != null) {
            request.setAttribute("pepito123", producto);
            return "index.jsp?page=editarProducto";
        } else {
            request.setAttribute("error", "Producto no encontrado");
            return LISTAR;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("agregar".equals(action)) {
            agregarProducto(request);
            response.sendRedirect("producto?action=listar"); // Redirige después de agregar

        }

        else if ("actualizar".equals(action)) {
            modificarProducto(request);
            response.sendRedirect("producto?action=listar"); // Redirige después de actualizar
        }
    }

    private void agregarProducto(HttpServletRequest request) {
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");
        String marca = request.getParameter("marca");
        String categoria = request.getParameter("categoria");
        BigDecimal precioVenta = new BigDecimal(request.getParameter("precioVenta"));
        BigDecimal descuento = new BigDecimal(request.getParameter("descuento"));
        int stock = Integer.parseInt(request.getParameter("stock"));
        String estatus = request.getParameter("estatus");
        String fechaIngreso = request.getParameter("fechaIngreso");

        ProductoDTO nuevoProducto = new ProductoDTO(0, nombre, descripcion, marca, categoria, precioVenta, descuento, stock, estatus, fechaIngreso);
        productoService.agregarProducto(nuevoProducto);
    }

    private void modificarProducto(HttpServletRequest request) {
        ProductoDTO producto = new ProductoDTO();
        producto.setProductoID(Integer.parseInt(request.getParameter("id")));
        producto.setNombre(request.getParameter("nombre"));
        producto.setDescripcion(request.getParameter("descripcion"));
        producto.setMarca(request.getParameter("marca"));
        producto.setCategoria(request.getParameter("categoria"));
        producto.setPrecioVenta(new BigDecimal(request.getParameter("precioVenta")));
        producto.setDescuento(new BigDecimal(request.getParameter("descuento")));
        producto.setStock(Integer.parseInt(request.getParameter("stock")));
        producto.setEstatus(request.getParameter("estatus"));
        producto.setFechaIngreso(request.getParameter("fechaIngreso"));

        productoService.actualizarProducto(producto);
    }
}
