package pe.edu.vallegrande.controller;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import pe.edu.vallegrande.Dto.CitasDetalleDto;
import pe.edu.vallegrande.Dto.CitasDto;
import pe.edu.vallegrande.Dto.ClienteDto;
import pe.edu.vallegrande.Dto.ServicioDto;
import pe.edu.vallegrande.service.CitaService;
import pe.edu.vallegrande.service.ClienteService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ExportarPDFController", urlPatterns = {"/exportarCitasPDF", "/exportarClientesPDF", "/exportarPersonasJuridicasPDF"})
public class ExportarPDFController extends HttpServlet {
    private CitaService citaService = new CitaService();
    private ClienteService clienteService = new ClienteService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getServletPath(); // Ruta actual
        response.setContentType("application/pdf");

        switch (action) {
            case "/exportarClientesPDF":
                exportarClientesPDF(response);
                break;
            case "/exportarPersonasJuridicasPDF":
                exportarPersonasJuridicasPDF(response);
                break;
            case "/exportarCitasPDF":
                exportarCitasPDF(response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Ruta no válida");
        }
    }

    private void exportarClientesPDF(HttpServletResponse response) throws IOException {
        response.setHeader("Content-Disposition", "attachment; filename=ClientesNaturales.pdf");

        try {
            // Crear el documento PDF
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // Título con estilo en una celda de la tabla
            Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, BaseColor.WHITE);

            // Crear tabla para el título
            PdfPTable tablaTitulo = new PdfPTable(1); // Una columna
            tablaTitulo.setWidthPercentage(100);
            tablaTitulo.setSpacingAfter(10); // Espacio después de la tabla

            // Crear la celda para el título
            PdfPCell celdaTitulo = new PdfPCell(new Phrase("Listado de Clientes Naturales", fontTitulo));
            celdaTitulo.setHorizontalAlignment(Element.ALIGN_CENTER);
            celdaTitulo.setBackgroundColor(new BaseColor(0, 51, 102)); // Color de fondo del título
            celdaTitulo.setBorder(Rectangle.NO_BORDER); // Sin borde

            // Agregar la celda a la tabla
            tablaTitulo.addCell(celdaTitulo);

            // Agregar la tabla con el título al documento
            document.add(tablaTitulo);
            document.add(new Paragraph(" ")); // Espacio después del título

            // Agregar un espacio en blanco
            document.add(new Paragraph(" "));

            // Obtener los clientes naturales
            List<ClienteDto> clientes = clienteService.listarPersonasNaturalesActivas(); // Implementa este método

            // Crear tabla principal
            PdfPTable tabla = new PdfPTable(11); // 11 columnas para coincidir con la tabla
            tabla.setWidthPercentage(100);
            tabla.setWidths(new float[]{1, 2, 2, 2, 2, 2, 2, 2, 3, 3, 1}); // Ajusta los anchos de columna

            // Encabezados de columna con colores de fondo
            String[] headers = {"ID", "Tipo de persona", "Nombre", "Apellido", "Tipo de Documento",
                    "N° Documento", "F. Nacimiento", "Teléfono", "Dirección", "Email", "Estado"};

            Font fontHeader = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, BaseColor.WHITE);
            for (String header : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(header, fontHeader));
                cell.setBackgroundColor(new BaseColor(0, 51, 102)); // Fondo azul oscuro
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPadding(5);
                tabla.addCell(cell);
            }

            // Rellenar datos de los clientes
            Font fontData = FontFactory.getFont(FontFactory.HELVETICA, 10);
            for (ClienteDto cliente : clientes) {
                tabla.addCell(new PdfPCell(new Phrase(String.valueOf(cliente.getId()), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getTypePerson(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getName(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getLastName(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getDocumentType(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getDocumentNumber(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getBirthdate().toString(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getPhone(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getAddress(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getEmail(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getStatus(), fontData)));
            }

            // Agregar la tabla al documento
            document.add(tabla);

            // Cerrar el documento
            document.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al generar el PDF");
        }
    }


    private void exportarCitasPDF(HttpServletResponse response) throws IOException {
        response.setHeader("Content-Disposition", "attachment; filename=Citas.pdf");

        try {
            // Crear el documento PDF
            Document document = new Document();
            PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // Establecer fuente y color
            Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.DARK_GRAY);
            Font fontSubtitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, BaseColor.DARK_GRAY);
            Font fontCuerpo = FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.BLACK);

            // Título del documento
            Paragraph titulo = new Paragraph("Listado de Citas y Detalles", fontTitulo);
            titulo.setAlignment(Element.ALIGN_CENTER);
            document.add(titulo);
            document.add(new Paragraph(" "));

            // Descripción
            Paragraph descripcion = new Paragraph("Este documento contiene un listado detallado de las citas realizadas, "
                    + "incluyendo información sobre el cliente, vehículo, trabajador y detalles de la cita.", fontCuerpo);
            descripcion.setAlignment(Element.ALIGN_LEFT);
            document.add(descripcion);
            document.add(new Paragraph(" "));

            // Obtener las citas con sus detalles
            List<CitasDto> citas = citaService.obtenerCitasConDetalles();
            for (CitasDto cita : citas) {
                // Crear tabla para cada cita
                PdfPTable tablaCita = new PdfPTable(7); // Número de columnas para las citas
                tablaCita.setWidthPercentage(100);
                tablaCita.setWidths(new float[]{1, 2, 2, 3, 2, 2, 2}); // Anchos de las columnas
                tablaCita.setSpacingBefore(10f); // Espacio antes de la tabla
                tablaCita.setSpacingAfter(10f);  // Espacio después de la tabla

                // Encabezados de la tabla de citas con color y formato
                PdfPCell cell = new PdfPCell(new Phrase("ID Cita", fontSubtitulo));
                cell.setBackgroundColor(BaseColor.CYAN);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaCita.addCell(cell);

                cell = new PdfPCell(new Phrase("Fecha", fontSubtitulo));
                cell.setBackgroundColor(BaseColor.CYAN);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaCita.addCell(cell);

                cell = new PdfPCell(new Phrase("Hora", fontSubtitulo));
                cell.setBackgroundColor(BaseColor.CYAN);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaCita.addCell(cell);

                cell = new PdfPCell(new Phrase("Descripción", fontSubtitulo));
                cell.setBackgroundColor(BaseColor.CYAN);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaCita.addCell(cell);

                cell = new PdfPCell(new Phrase("Cliente", fontSubtitulo));
                cell.setBackgroundColor(BaseColor.CYAN);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaCita.addCell(cell);

                cell = new PdfPCell(new Phrase("Vehículo", fontSubtitulo));
                cell.setBackgroundColor(BaseColor.CYAN);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaCita.addCell(cell);

                cell = new PdfPCell(new Phrase("Empleado", fontSubtitulo));
                cell.setBackgroundColor(BaseColor.CYAN);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                tablaCita.addCell(cell);

                // Datos de la cita
                tablaCita.addCell(String.valueOf(cita.getId()));
                tablaCita.addCell(String.valueOf(cita.getDate()));
                tablaCita.addCell(String.valueOf(cita.getHour()));
                tablaCita.addCell(cita.getDescription());

                // Cliente (nombre completo + tipo)
                String clienteNombre = "Cliente no disponible";
                if (cita.getCustomer() != null) {
                    String typePerson = cita.getCustomer().getTypePerson();
                    if (typePerson != null) {
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
                }
                tablaCita.addCell(clienteNombre);

                // Vehículo (placa)
                String placaVehiculo = cita.getVehicle() != null && cita.getVehicle().getPlate() != null
                        ? cita.getVehicle().getPlate()
                        : "Placa no disponible";
                tablaCita.addCell(placaVehiculo);

                // Trabajador (nombre completo)
                String trabajadorNombre = cita.getWorker() != null
                        ? cita.getWorker().getName() + " " + cita.getWorker().getLastName()
                        : "Trabajador no disponible";
                tablaCita.addCell(trabajadorNombre);

                // Agregar la tabla de la cita al documento
                document.add(tablaCita);

                // Agregar detalles de la cita
                if (cita.getDetalles() != null && !cita.getDetalles().isEmpty()) {
                    // Crear tabla para los detalles
                    PdfPTable tablaDetalles = new PdfPTable(5); // Número de columnas para los detalles
                    tablaDetalles.setWidthPercentage(100);
                    tablaDetalles.setWidths(new float[]{1, 3, 2, 2, 2}); // Anchos de las columnas

                    // Encabezados de la tabla de detalles con color
                    cell = new PdfPCell(new Phrase("ID Detalle", fontSubtitulo));
                    cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    tablaDetalles.addCell(cell);

                    cell = new PdfPCell(new Phrase("Descripción", fontSubtitulo));
                    cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    tablaDetalles.addCell(cell);

                    cell = new PdfPCell(new Phrase("Resultado", fontSubtitulo));
                    cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    tablaDetalles.addCell(cell);

                    cell = new PdfPCell(new Phrase("Costo", fontSubtitulo));
                    cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    tablaDetalles.addCell(cell);

                    cell = new PdfPCell(new Phrase("Servicio", fontSubtitulo));
                    cell.setBackgroundColor(BaseColor.LIGHT_GRAY);
                    cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                    tablaDetalles.addCell(cell);

                    // Datos de los detalles
                    for (CitasDetalleDto detalle : cita.getDetalles()) {
                        tablaDetalles.addCell(String.valueOf(detalle.getId()));
                        tablaDetalles.addCell(detalle.getDescription() != null ? detalle.getDescription() : "Descripción no disponible");
                        tablaDetalles.addCell(detalle.getResult() != null ? detalle.getResult() : "Resultado no disponible");
                        tablaDetalles.addCell(String.valueOf(detalle.getCost()));

                        // Servicio (nombre del servicio)
                        String servicioNombre = "Servicio no disponible";
                        if (detalle.getServiceId() != 0) {
                            ServicioDto servicio = CitaService.obtenerServicioPorId(detalle.getServiceId());
                            if (servicio != null) {
                                servicioNombre = servicio.getName();
                            }
                        }
                        tablaDetalles.addCell(servicioNombre);
                    }

                    // Agregar la tabla de detalles al documento
                    document.add(tablaDetalles);
                    document.add(new Paragraph(" ")); // Espacio entre detalles
                }
            }

            document.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al generar el PDF");
        }
    }

    private void exportarPersonasJuridicasPDF(HttpServletResponse response) throws IOException {
        response.setHeader("Content-Disposition", "attachment; filename=PersonasJuridicas.pdf");

        try {
            // Crear el documento PDF
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // Título
            Font fontTitulo = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, BaseColor.WHITE);
            PdfPTable tablaTitulo = new PdfPTable(1);
            tablaTitulo.setWidthPercentage(100);
            tablaTitulo.setSpacingAfter(10);

            PdfPCell celdaTitulo = new PdfPCell(new Phrase("Listado de Personas Jurídicas", fontTitulo));
            celdaTitulo.setHorizontalAlignment(Element.ALIGN_CENTER);
            celdaTitulo.setBackgroundColor(new BaseColor(0, 51, 102)); // Azul oscuro
            celdaTitulo.setBorder(Rectangle.NO_BORDER);

            tablaTitulo.addCell(celdaTitulo);
            document.add(tablaTitulo);
            document.add(new Paragraph(" "));

            // Obtener las personas jurídicas
            List<ClienteDto> personasJuridicas = clienteService.listarPersonasJuridicasActivas(); // Implementar este método

            // Crear tabla de datos
            PdfPTable tabla = new PdfPTable(8); // 8 columnas para la tabla
            tabla.setWidthPercentage(100);
            tabla.setWidths(new float[]{1, 2, 3, 2, 2, 2, 2, 2});

            // Encabezados
            String[] headers = {"ID", "Tipo de Persona", "Razón Social", "RUC", "Dirección", "Teléfono", "Email", "Estado"};
            Font fontHeader = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, BaseColor.WHITE);
            for (String header : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(header, fontHeader));
                cell.setBackgroundColor(new BaseColor(0, 51, 102)); // Fondo azul
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                cell.setPadding(5);
                tabla.addCell(cell);
            }

            // Rellenar los datos de las personas jurídicas
            Font fontData = FontFactory.getFont(FontFactory.HELVETICA, 10);
            for (ClienteDto cliente : personasJuridicas) {
                tabla.addCell(new PdfPCell(new Phrase(String.valueOf(cliente.getId()), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getTypePerson(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getCompanyName(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getRuc(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getAddress(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getPhone(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getEmail(), fontData)));
                tabla.addCell(new PdfPCell(new Phrase(cliente.getStatus(), fontData)));
            }

            // Agregar la tabla al documento
            document.add(tabla);

            // Cerrar el documento
            document.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al generar el PDF");
        }
    }


}
