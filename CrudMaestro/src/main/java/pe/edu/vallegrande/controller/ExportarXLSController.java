package pe.edu.vallegrande.controller;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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
import java.io.OutputStream;
import java.util.List;

@WebServlet(name = "ExportarXLSController", urlPatterns = {"/exportarCitasXLS", "/exportarClientesXLS", "/exportarPersonasJuridicasXLS"})
public class ExportarXLSController extends HttpServlet {
    private CitaService citaService = new CitaService();
    private ClienteService clienteService = new ClienteService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getServletPath(); // Ruta actual
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

        switch (action) {
            case "/exportarClientesXLS":
                exportarClientesXLS(response);
                break;
            case "/exportarPersonasJuridicasXLS":
                exportarPersonasJuridicasXLS(response);
                break;
            case "/exportarCitasXLS":
                exportarCitasXLS(response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Ruta no válida");
        }
    }

    private void exportarClientesXLS(HttpServletResponse response) throws IOException {
        response.setHeader("Content-Disposition", "attachment; filename=ClientesNaturales.xlsx");

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Clientes Naturales");
            Row headerRow = sheet.createRow(0);

            // Crear encabezados de columna
            String[] headers = {"ID", "TipoDePersona", "Nombre", "Apellido", "TipoDeDocumento", "NumeroDocumento", "FechaNacimiento", "Telefono", "Direccion", "Email", "Estado"};
            for (int i = 0; i < headers.length; i++) {
                headerRow.createCell(i).setCellValue(headers[i]);
            }

            // Obtener los clientes naturales
            List<ClienteDto> clientes = clienteService.listarPersonasNaturalesActivas();

            // Llenar la hoja con los datos
            int rowNum = 1;
            for (ClienteDto cliente : clientes) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(cliente.getId());
                row.createCell(1).setCellValue(cliente.getTypePerson());
                row.createCell(2).setCellValue(cliente.getName());
                row.createCell(3).setCellValue(cliente.getLastName());
                row.createCell(4).setCellValue(cliente.getDocumentType());
                row.createCell(5).setCellValue(cliente.getDocumentNumber());
                row.createCell(6).setCellValue(cliente.getBirthdate().toString());
                row.createCell(7).setCellValue(cliente.getPhone());
                row.createCell(8).setCellValue(cliente.getAddress());
                row.createCell(9).setCellValue(cliente.getEmail());
                row.createCell(10).setCellValue(cliente.getStatus());
            }

            // Ajustar el tamaño de las columnas
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Enviar la respuesta con el archivo Excel
            OutputStream out = response.getOutputStream();
            workbook.write(out);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al generar el archivo Excel");
        }
    }

    private void exportarCitasXLS(HttpServletResponse response) throws IOException {
        response.setHeader("Content-Disposition", "attachment; filename=CitasConDetalles.xlsx");

        try (Workbook workbook = new XSSFWorkbook()) {
            // Crear la hoja
            Sheet sheet = workbook.createSheet("Citas");

            // Crear el estilo para las celdas
            CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFillForegroundColor(IndexedColors.LIGHT_BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            headerStyle.setBorderBottom(BorderStyle.THIN);
            headerStyle.setBorderTop(BorderStyle.THIN);
            headerStyle.setBorderLeft(BorderStyle.THIN);
            headerStyle.setBorderRight(BorderStyle.THIN);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);
            headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);

            // Estilo para las celdas de datos
            CellStyle dataStyle = workbook.createCellStyle();
            dataStyle.setBorderBottom(BorderStyle.THIN);
            dataStyle.setBorderTop(BorderStyle.THIN);
            dataStyle.setBorderLeft(BorderStyle.THIN);
            dataStyle.setBorderRight(BorderStyle.THIN);
            dataStyle.setAlignment(HorizontalAlignment.LEFT);
            dataStyle.setVerticalAlignment(VerticalAlignment.CENTER);

            // Crear la fila de encabezados
            Row headerRow = sheet.createRow(0);
            String[] headers = {"ID Cita", "Fecha", "Hora", "Descripcion", "Cliente", "Vehiculo", "Empleado", "ID Detalle", "Descripcion Detalle", "Costo Detalle", "Servicio", "Resultado Servicio"};
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // Obtener las citas con sus detalles
            List<CitasDto> citas = citaService.obtenerCitasConDetalles();
            int rowNum = 1;

            // Llenar la hoja con los datos de las citas y sus detalles
            for (CitasDto cita : citas) {
                // Datos de la cita
                String clienteNombre = "Cliente no disponible";
                if (cita.getCustomer() != null) {
                    if (cita.getCustomer().getTypePerson().equals("Juridica")) {
                        clienteNombre = cita.getCustomer().getCompanyName(); // Cliente Jurídico, mostrando el nombre de la empresa
                    } else {
                        clienteNombre = cita.getCustomer().getName() + " " + cita.getCustomer().getLastName(); // Cliente Natural
                    }
                }

                String placaVehiculo = cita.getVehicle() != null ? cita.getVehicle().getPlate() : "Placa no disponible";
                String trabajadorNombre = cita.getWorker() != null
                        ? cita.getWorker().getName() + " " + cita.getWorker().getLastName()
                        : "Trabajador no disponible";

                // Crear una fila para la cita
                Row row = sheet.createRow(rowNum++);
                createCell(row, 0, String.valueOf(cita.getId()), dataStyle);
                createCell(row, 1, cita.getDate().toString(), dataStyle);
                createCell(row, 2, String.valueOf(cita.getHour()), dataStyle);
                createCell(row, 3, cita.getDescription(), dataStyle);
                createCell(row, 4, clienteNombre, dataStyle);
                createCell(row, 5, placaVehiculo, dataStyle);
                createCell(row, 6, trabajadorNombre, dataStyle);

                // Agregar los detalles de la cita
                for (CitasDetalleDto detalle : cita.getDetalles()) {
                    Row detailRow = sheet.createRow(rowNum++);
                    createCell(detailRow, 7, String.valueOf(detalle.getId()), dataStyle);
                    createCell(detailRow, 8, detalle.getDescription(), dataStyle);
                    createCell(detailRow, 9, String.valueOf(detalle.getCost()), dataStyle);

                    // Obtener el servicio asociado usando el ID del servicio
                    if (detalle.getServiceId() != 0) {
                        // Aquí debes obtener el servicio usando el ID del servicio (detalle.getServiceId())
                        ServicioDto servicio = CitaService.obtenerServicioPorId(detalle.getServiceId());

                        if (servicio != null) {
                            createCell(detailRow, 10, servicio.getName(), dataStyle); // Nombre del servicio
                            createCell(detailRow, 11, servicio.getDescription(), dataStyle); // Resultado del servicio
                        } else {
                            createCell(detailRow, 10, "Servicio no disponible", dataStyle);
                            createCell(detailRow, 11, "Resultado no disponible", dataStyle);
                        }
                    } else {
                        createCell(detailRow, 10, "ID de servicio no disponible", dataStyle);
                        createCell(detailRow, 11, "Resultado no disponible", dataStyle);
                    }
                }
            }

            // Ajustar el tamaño de las columnas
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Enviar la respuesta con el archivo Excel
            OutputStream out = response.getOutputStream();
            workbook.write(out);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al generar el archivo Excel");
        }
    }

    private void createCell(Row row, int columnIndex, String value, CellStyle style) {
        Cell cell = row.createCell(columnIndex);
        cell.setCellValue(value);
        cell.setCellStyle(style);
    }

    private void exportarPersonasJuridicasXLS(HttpServletResponse response) throws IOException {
        response.setHeader("Content-Disposition", "attachment; filename=PersonasJuridicas.xlsx");

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Personas Jurídicas");
            Row headerRow = sheet.createRow(0);

            // Crear encabezados de columna
            String[] headers = {"ID", "TipoDePersona", "RazonSocial", "RUC", "Direccion", "Telefono", "Email", "Estado"};
            for (int i = 0; i < headers.length; i++) {
                headerRow.createCell(i).setCellValue(headers[i]);
            }

            // Obtener las personas jurídicas
            List<ClienteDto> personasJuridicas = clienteService.listarPersonasJuridicasActivas();

            // Llenar la hoja con los datos
            int rowNum = 1;
            for (ClienteDto cliente : personasJuridicas) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(cliente.getId());
                row.createCell(1).setCellValue(cliente.getTypePerson());
                row.createCell(2).setCellValue(cliente.getCompanyName());
                row.createCell(3).setCellValue(cliente.getRuc());
                row.createCell(4).setCellValue(cliente.getAddress());
                row.createCell(5).setCellValue(cliente.getPhone());
                row.createCell(6).setCellValue(cliente.getEmail());
                row.createCell(7).setCellValue(cliente.getStatus());
            }

            // Ajustar el tamaño de las columnas
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Enviar la respuesta con el archivo Excel
            OutputStream out = response.getOutputStream();
            workbook.write(out);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al generar el archivo Excel");
        }
    }
}
