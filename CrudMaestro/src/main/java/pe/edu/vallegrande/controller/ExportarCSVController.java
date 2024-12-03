package pe.edu.vallegrande.controller;

import pe.edu.vallegrande.Dto.CitasDto;
import pe.edu.vallegrande.Dto.ClienteDto;
import pe.edu.vallegrande.service.CitaService;
import pe.edu.vallegrande.service.ClienteService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "ExportarCSVController", urlPatterns = {"/exportarCitasCSV", "/exportarClientesCSV", "/exportarPersonasJuridicasCSV"})
public class ExportarCSVController extends HttpServlet {
    private CitaService citaService = new CitaService();
    private ClienteService clienteService = new ClienteService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getServletPath(); // Ruta actual
        response.setContentType("application/json; charset=UTF-8"); // Establecer UTF-8
        response.setCharacterEncoding("UTF-8");

        switch (action) {
            case "/exportarClientesCSV":
                exportarClientesCSV(response);
                break;
            case "/exportarPersonasJuridicasCSV":
                exportarPersonasJuridicasCSV(response);
                break;
            case "/exportarCitasCSV":
                exportarCitasCSV(response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Ruta no válida");
        }
    }

    private void exportarClientesCSV(HttpServletResponse response) throws IOException {
        response.setHeader("Content-Disposition", "attachment; filename=ClientesNaturales.csv");

        PrintWriter writer = response.getWriter();
        // Escribir los encabezados del CSV
        writer.println("ID, Tipo de persona, Nombre, Apellido, Tipo de Documento, N° Documento, F. Nacimiento, Teléfono, Dirección, Email, Estado");

        // Obtener los clientes naturales
        List<ClienteDto> clientes = clienteService.listarPersonasNaturalesActivas(); // Implementa este método

        // Escribir los datos de los clientes
        for (ClienteDto cliente : clientes) {
            writer.println(String.format("%d, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s",
                    cliente.getId(),
                    cliente.getTypePerson(),
                    cliente.getName(),
                    cliente.getLastName(),
                    cliente.getDocumentType(),
                    cliente.getDocumentNumber(),
                    cliente.getBirthdate(),
                    cliente.getPhone(),
                    cliente.getAddress(),
                    cliente.getEmail(),
                    cliente.getStatus()));
        }
        writer.flush();
    }

    private void exportarCitasCSV(HttpServletResponse response) throws IOException {
        response.setHeader("Content-Disposition", "attachment; filename=Citas.csv");

        PrintWriter writer = response.getWriter();
        // Escribir los encabezados del CSV
        writer.println("ID Cita, Fecha, Hora, Descripción, Cliente, Vehículo, Empleado");

        // Obtener las citas
        List<CitasDto> citas = citaService.obtenerCitasConDetalles();
        for (CitasDto cita : citas) {
            // Cliente (nombre completo + tipo)
            String clienteNombre = "Cliente no disponible";
            if (cita.getCustomer() != null) {
                String typePerson = cita.getCustomer().getTypePerson();
                if ("jurídica".equalsIgnoreCase(typePerson) || "juridica".equalsIgnoreCase(typePerson)) {
                    clienteNombre = cita.getCustomer().getCompanyName() != null && !cita.getCustomer().getCompanyName().isEmpty()
                            ? cita.getCustomer().getCompanyName()
                            : "Empresa sin nombre";
                } else {
                    String nombreCompleto = (cita.getCustomer().getName() != null ? cita.getCustomer().getName() : "")
                            + " " + (cita.getCustomer().getLastName() != null ? cita.getCustomer().getLastName() : "");
                    clienteNombre = nombreCompleto.isEmpty() ? "Nombre no disponible" : nombreCompleto;
                }
            }

            // Vehículo (placa)
            String placaVehiculo = cita.getVehicle() != null && cita.getVehicle().getPlate() != null
                    ? cita.getVehicle().getPlate()
                    : "Placa no disponible";

            // Trabajador (nombre completo)
            String trabajadorNombre = cita.getWorker() != null
                    ? cita.getWorker().getName() + " " + cita.getWorker().getLastName()
                    : "Trabajador no disponible";

            // Escribir los datos de la cita
            writer.println(String.format("%d, %s, %s, %s, %s, %s, %s",
                    cita.getId(),
                    cita.getDate(),
                    cita.getHour(),
                    cita.getDescription(),
                    clienteNombre,
                    placaVehiculo,
                    trabajadorNombre));
        }
        writer.flush();
    }

    private void exportarPersonasJuridicasCSV(HttpServletResponse response) throws IOException {
        response.setHeader("Content-Disposition", "attachment; filename=PersonasJuridicas.csv");

        PrintWriter writer = response.getWriter();
        // Escribir los encabezados del CSV
        writer.println("ID, Tipo de Persona, Razón Social, RUC, Dirección, Teléfono, Email, Estado");

        // Obtener las personas jurídicas
        List<ClienteDto> personasJuridicas = clienteService.listarPersonasJuridicasActivas(); // Implementar este método

        // Escribir los datos de las personas jurídicas
        for (ClienteDto cliente : personasJuridicas) {
            writer.println(String.format("%d, %s, %s, %s, %s, %s, %s, %s",
                    cliente.getId(),
                    cliente.getTypePerson(),
                    cliente.getCompanyName(),
                    cliente.getRuc(),
                    cliente.getAddress(),
                    cliente.getPhone(),
                    cliente.getEmail(),
                    cliente.getStatus()));
        }
        writer.flush();
    }
}
