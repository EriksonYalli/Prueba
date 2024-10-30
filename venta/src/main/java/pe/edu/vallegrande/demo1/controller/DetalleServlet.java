package pe.edu.vallegrande.demo1.controller;

import pe.edu.vallegrande.demo1.dto.DetalleDTO;
import pe.edu.vallegrande.demo1.dto.DetalleDTO;
import pe.edu.vallegrande.demo1.service.DetalleSERVICE;
import pe.edu.vallegrande.demo1.service.DetalleSERVICE;
import com.google.gson.Gson;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/detalle")
public class DetalleServlet extends HttpServlet {

    private DetalleSERVICE detalleSERVICE = new DetalleSERVICE();
    private static final String LISTAR = "jsp/detalle.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            action = "listar";
        }

        String acceso = "";
        switch (action) {
            case "listar":
                acceso = LISTAR;
                break;
            default:
                acceso = LISTAR;  // Acción por defecto
                break;
        }

        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("agregar".equals(action)) {
                // Recoger los parámetros del formulario
                int ventaID = Integer.parseInt(request.getParameter("ventaID"));
                int productoID = Integer.parseInt(request.getParameter("productoID"));
                String nombreProducto = request.getParameter("nombreProducto");
                int cantidad = Integer.parseInt(request.getParameter("cantidad"));
                BigDecimal precioVenta = new BigDecimal(request.getParameter("precioVenta"));
                BigDecimal descuento = new BigDecimal(request.getParameter("descuento"));
                BigDecimal montoRecibido = new BigDecimal(request.getParameter("montoRecibido"));

                String estadoDetalle = request.getParameter("estadoDetalle");

                // Calcular subtotal y vuelto
                BigDecimal subtotal = (precioVenta.multiply(new BigDecimal(cantidad))).subtract(descuento);
                BigDecimal vuelto = montoRecibido.compareTo(subtotal) >= 0 ? montoRecibido.subtract(subtotal) : BigDecimal.ZERO;
                String fechaVenta = "2024-10-26"; // Ajusta esto según tu lógica o usa una variable adecuada

                // Ahora crea la instancia de `DetalleDTO` con todos los parámetros
                DetalleDTO nuevoDetalle= new DetalleDTO(0, ventaID, productoID, nombreProducto, cantidad, precioVenta, descuento, subtotal, montoRecibido, vuelto, fechaVenta, estadoDetalle);

                // Guardar el detalle de venta en la base de datos
                detalleSERVICE.agregarDetalleVenta(nuevoDetalle);

                // Redirigir de vuelta a la página de detalles de ventas
                response.sendRedirect("detalle?action=listar");

        }
    }
}
