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
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/venta")
public class VentaServlet extends HttpServlet {

    private final VentaSERVICE ventaService = new VentaSERVICE();
    private static final String LISTAR = "jsp/venta_detalle.jsp?page=venta";

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

            // Obtener el JSON de los datos de la venta
            String ventaDataJson = request.getParameter("ventaData");

            if (ventaDataJson != null && !ventaDataJson.isEmpty()) {
                JSONObject ventaData = new JSONObject(ventaDataJson);

                // Datos del cliente
                JSONObject clienteData = ventaData.getJSONObject("cliente");
                String dniCliente = clienteData.getString("dni");
                String nombreCliente = clienteData.getString("nombre");
                String apellidoCliente = clienteData.getString("apellido");

                System.out.println("Cliente: " + dniCliente + " " + nombreCliente + " " + apellidoCliente);

                // Lista de productos
                JSONArray productosArray = ventaData.getJSONArray("productos");

                for (int i = 0; i < productosArray.length(); i++) {
                    JSONObject producto = productosArray.getJSONObject(i);

                    String nombre = producto.getString("nombre");
                    double precio = producto.getDouble("precio");
                    int cantidad = producto.getInt("cantidad");

                    // Procesar cada producto
                    System.out.println("Producto: " + nombre + ", Precio: " + precio + ", Cantidad: " + cantidad);
                }

                // Guardar la venta (puedes invocar un servicio aquí)
                // Ejemplo: ventaService.guardarVenta(cliente, productos);

                response.setContentType("application/json");
                response.getWriter().write("{\"message\": \"Venta generada con éxito\"}");
            } else {
                System.out.println("No se recibieron datos de la venta.");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"message\": \"No se recibieron datos de la venta\"}");
            }
        }
    }

    // Método para listar todas las ventas
    private void listarVentas(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<VentaDTO> ventas = ventaService.listarVentas();
        request.setAttribute("ventas", ventas);
        request.getRequestDispatcher("jsp/venta_detalle.jsp").forward(request, response);
    }


    // Método para agregar una nueva venta con sus detalles
    private void agregarVenta(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Validación y conversión de clienteID
            String clienteIDParam = request.getParameter("clienteID");
            if (clienteIDParam == null || clienteIDParam.isEmpty()) {
                request.setAttribute("error", "Error: ClienteID está vacío o nulo.");
                listarVentas(request, response);
                return;
            }
            int clienteID = Integer.parseInt(clienteIDParam);

            // Validación y conversión de totalProductosVendidos
            String totalProductosParam = request.getParameter("totalProductosVendidos");
            if (totalProductosParam == null || totalProductosParam.isEmpty()) {
                request.setAttribute("error", "Error: Total de productos vendidos está vacío o nulo.");
                listarVentas(request, response);
                return;
            }
            int totalProductosVendidos = Integer.parseInt(totalProductosParam);

            // Validación y conversión de precioTotal
            String precioTotalParam = request.getParameter("precioTotal");
            if (precioTotalParam == null || precioTotalParam.isEmpty()) {
                request.setAttribute("error", "Error: Precio total está vacío o nulo.");
                listarVentas(request, response);
                return;
            }
            BigDecimal precioTotal = new BigDecimal(precioTotalParam);

            // Fecha de la venta
            Date fechaVenta = new Date();  // Fecha actual

            // Crear y asignar valores a VentaDTO
            VentaDTO venta = new VentaDTO();
            venta.setClienteID(clienteID);
            venta.setFechaVenta(fechaVenta);
            venta.setTotalProductosVendidos(totalProductosVendidos);
            venta.setPrecioTotal(precioTotal);

            // Obtener detalles de venta desde los parámetros
            String[] productoIDs = request.getParameterValues("productoID");
            String[] cantidades = request.getParameterValues("cantidad");
            String[] preciosUnitarios = request.getParameterValues("precioUnitario");
            String[] descuentos = request.getParameterValues("descuento");
            String[] totalesDetalle = request.getParameterValues("totalDetalle");

            List<DetalleVentaDTO> detalles = new ArrayList<>();
            for (int i = 0; i < productoIDs.length; i++) {
                DetalleVentaDTO detalle = new DetalleVentaDTO();
                detalle.setProductoID(Integer.parseInt(productoIDs[i]));
                detalle.setCantidad(Integer.parseInt(cantidades[i]));
                detalle.setPrecioUnitario(new BigDecimal(preciosUnitarios[i]));
                detalle.setDescuento(new BigDecimal(descuentos[i]));
                detalle.setTotalDetalle(new BigDecimal(totalesDetalle[i]));
                detalles.add(detalle);
            }
            venta.setDetalles(detalles);

            // Guardar la venta con sus detalles
            ventaService.agregarVenta(venta);

            // Redirigir a la lista de ventas después de guardar
            response.sendRedirect("venta?action=listar");

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Formato de número incorrecto.");
            listarVentas(request, response);
        }
    }


}
