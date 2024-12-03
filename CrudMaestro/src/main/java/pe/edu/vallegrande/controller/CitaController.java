package pe.edu.vallegrande.controller;

import com.google.gson.Gson;
import pe.edu.vallegrande.Dto.*;
import pe.edu.vallegrande.service.CitaService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cita")
public class CitaController extends HttpServlet {

    private CitaService citaService = new CitaService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json; charset=UTF-8"); // Establecer UTF-8
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        System.out.println("doGet - Action: " + action);

        if ("new".equals(action)) {
            // Obtener clientes, empleados y vehículos para mostrar en la vista
            List<ClienteDto> clientes = citaService.obtenerClientes();
            request.setAttribute("clientes", clientes);
            System.out.println("Clientes obtenidos: " + clientes.size());

            List<WorkerDto> empleados = citaService.obtenerEmpleados();  // Obtener empleados
            request.setAttribute("empleados", empleados);
            System.out.println("Empleados obtenidos: " + empleados.size());

            String clienteId = request.getParameter("clienteId");
            if (clienteId != null) {
                List<VehicleDto> vehicles = citaService.obtenerVehiculosPorCliente(Integer.parseInt(clienteId));
                request.setAttribute("vehicles", vehicles);
                System.out.println("Vehículos para cliente " + clienteId + ": " + vehicles.size());
            }

            // Obtener los servicios disponibles
            List<ServicioDto> servicios = citaService.obtenerServicios();  // Obtener los servicios
            request.setAttribute("servicios", servicios);
            System.out.println("Servicios obtenidos: " + servicios.size());

            // Llamar al formulario para la nueva cita
            request.getRequestDispatcher("formCita.jsp").forward(request, response);

        } else if ("view".equals(action)) {
            try {
                // Obtener todas las citas con sus detalles
                List<CitasDto> citas = citaService.obtenerCitasConDetalles();  // Utilizando el nuevo método

                // Recuperar los datos asociados a cada cita (cliente, trabajador y vehículo)
                for (CitasDto cita : citas) {
                    ClienteDto cliente = citaService.obtenerClientePorId(cita.getCustomerId());
                    cita.setCustomer(cliente);  // Asignar el cliente a la cita

                    WorkerDto trabajador = citaService.obtenerTrabajadorPorId(cita.getWorkerId());
                    cita.setWorker(trabajador);  // Asignar el trabajador a la cita

                    VehicleDto vehiculo = citaService.obtenerVehiculoPorId(cita.getVehicleId());
                    cita.setVehicle(vehiculo);  // Asignar el vehículo a la cita
                }

                // Establecer las citas con sus detalles para el JSP
                request.setAttribute("citas", citas);

                // Enviar la respuesta al JSP
                request.getRequestDispatcher("viewCita.jsp").forward(request, response);

            } catch (Exception e) {
                // Manejo de errores, en caso de que falle la obtención de citas
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al obtener las citas");
                e.printStackTrace();  // Esto ayudará a diagnosticar el error en los logs
            }

        } else if ("getVehicles".equals(action)) {
            // Responder con los vehículos asociados a un cliente específico
            String clienteId = request.getParameter("clienteId");
            if (clienteId != null) {
                List<VehicleDto> vehicles = citaService.obtenerVehiculosPorCliente(Integer.parseInt(clienteId));
                // Convertir la lista de vehículos a JSON
                String jsonResponse = new Gson().toJson(vehicles);
                response.setContentType("application/json");
                response.getWriter().write(jsonResponse);
                System.out.println("Vehículos para cliente " + clienteId + " enviados en formato JSON.");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        System.out.println("doPost - Action: " + action);

        if ("create".equals(action)) {
            // Obtener datos principales de la cita
            String date = request.getParameter("date");
            String hour = request.getParameter("hour");
            String description = request.getParameter("description");
            int vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            int workerId = Integer.parseInt(request.getParameter("workerId"));

            System.out.println("Datos de la cita: fecha=" + date + ", hora=" + hour + ", descripción=" + description +
                    ", vehicleId=" + vehicleId + ", customerId=" + customerId + ", workerId=" + workerId);

            // Procesar múltiples detalles
            List<CitasDetalleDto> detalles = new ArrayList<>();
            String[] descriptions = request.getParameterValues("details[][description]");
            String[] results = request.getParameterValues("details[][result]");
            String[] costs = request.getParameterValues("details[][cost]");
            String[] serviceIds = request.getParameterValues("details[][serviceId]");

            if (descriptions != null) {
                for (int i = 0; i < descriptions.length; i++) {
                    CitasDetalleDto detalle = new CitasDetalleDto();
                    detalle.setDescription(descriptions[i]);
                    detalle.setResult(results[i]);
                    detalle.setCost(Double.parseDouble(costs[i]));
                    detalle.setServiceId(Integer.parseInt(serviceIds[i]));
                    detalles.add(detalle);
                    System.out.println("Detalle agregado: " + detalle);
                }
            }

            // Llamada al servicio para insertar la cita con múltiples detalles
            boolean success = citaService.insertarCitaConDetalles(date, hour, description, vehicleId, customerId, workerId, detalles);

            if (success) {
                System.out.println("Cita registrada exitosamente.");
                // Redirigir a la lista de citas o a una página de confirmación
                response.sendRedirect("cita?action=view");
            } else {
                System.out.println("Error al crear la cita.");
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al crear la cita.");
            }
        }
    }

}

