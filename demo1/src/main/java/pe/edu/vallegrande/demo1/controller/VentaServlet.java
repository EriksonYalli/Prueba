package pe.edu.vallegrande.demo1.controller;

import org.json.JSONArray;
import org.json.JSONObject;
import pe.edu.vallegrande.demo1.dto.VentaDTO;
import pe.edu.vallegrande.demo1.dto.DetalleVentaDTO;
import pe.edu.vallegrande.demo1.service.VentaSERVICE;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/venta")
public class VentaServlet extends HttpServlet {

    private final VentaSERVICE ventaService = new VentaSERVICE();
    private static final String LISTAR = "jsp/venta.jsp?page=venta";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("listar".equals(action)) {
            listarVentas(request, response);
        } else if ("venta_detalle".equals(action)) {
            response.sendRedirect("index.jsp?page=venta_detalle");
        }  else {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"message\": \"Acción no soportada\"}");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("agregar".equals(action)) {
            agregarVenta(request, response);
        } else if ("generarVenta".equals(action)) {
            System.out.println("Generando venta...");
            String clienteID = request.getParameter("clienteID");
            String nombre = request.getParameter("nombreCliente");
            String apellido = request.getParameter("apellidoCliente");
            System.out.println(clienteID + nombre + apellido);
            agregarVenta(request, response);

        }
    }

    // Método para listar todas las ventas
    private void listarVentas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<VentaDTO> ventas = ventaService.listarVentas();
        request.setAttribute("ventas", ventas);
        request.getRequestDispatcher("jsp/venta.jsp").forward(request, response);
    }


    // Método para agregar una nueva venta con sus detalles
    private void agregarVenta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Validación y conversión de clienteID
            String clienteIDParam = request.getParameter("clienteID");
            int clienteID = Integer.parseInt(clienteIDParam);

            // Validación y conversión de totalProductosVendidos
            String totalProductosParam = request.getParameter("totalProductosVendidos");
            String total = request.getParameter("totalVenta");
            BigDecimal precioTotal = new BigDecimal(total);
            // Crear y asignar valores a VentaDTO
            VentaDTO venta = new VentaDTO();
            venta.setClienteID(clienteID);
            venta.setPrecioTotal(precioTotal);


            String[] cantidades = request.getParameterValues("productoCantidad[]");
            int sumaTotal = 0;  // Variable para almacenar la suma total

// Convertir el array de String a int y sumar los valores
            if (cantidades != null) {
                for (String cantidad : cantidades) {
                    try {
                        sumaTotal += Integer.parseInt(cantidad);  // Convertir y sumar
                    } catch (NumberFormatException e) {
                        // Manejar el caso donde la conversión no sea posible
                        System.out.println("Error al convertir la cantidad: " + cantidad);
                    }
                }
            }

            System.out.println("La suma total es: " + sumaTotal);


            venta.setTotalProductosVendidos(sumaTotal);
            ventaService.insertSale(venta);

            // Obtener detalles de venta desde los parámetros
            String[] productoID = request.getParameterValues("productoID[]");
            String[] preciosUnitarios = request.getParameterValues("productoPrecio[]");
            String[] totalesDetalle = request.getParameterValues("productoSubtotal[]");

            if (productoID != null && cantidades != null && preciosUnitarios != null && totalesDetalle != null &&
                    productoID.length == cantidades.length && cantidades.length == preciosUnitarios.length &&
                    preciosUnitarios.length == totalesDetalle.length) {

                System.out.println("Detalles de venta recibidos:");

                for (int i = 0; i < productoID.length; i++) {
                    System.out.println("Producto ID: " + productoID[i]);
                    System.out.println("Cantidad: " + cantidades[i]);
                    System.out.println("Precio Unitario: " + preciosUnitarios[i]);
                    System.out.println("Total Detalle: " + totalesDetalle[i]);
                    System.out.println("---------------------------");
                }
            } else {
                System.out.println("Los datos de la venta están incompletos o desincronizados.");
            }

            List<DetalleVentaDTO> detalles = new ArrayList<>();
            for (int i = 0; i < productoID.length; i++) {
                DetalleVentaDTO detalle = new DetalleVentaDTO();
                detalle.setProductoID(Integer.parseInt(productoID[i]));
                detalle.setCantidad(Integer.parseInt(cantidades[i]));
                detalle.setPrecioUnitario(new BigDecimal(preciosUnitarios[i]));
                detalle.setTotalDetalle(new BigDecimal(totalesDetalle[i]));
                detalles.add(detalle);
            }
            // Guardar la venta con sus detalles

            ventaService.insertSaleDetails(clienteID, detalles);

            // Redirigir a la lista de ventas después de guardar
            response.sendRedirect("venta?action=venta_detalle");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Formato de número incorrecto.");
            listarVentas(request, response);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }


}
