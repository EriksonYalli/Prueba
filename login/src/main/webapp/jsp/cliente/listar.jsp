<%@ page import="pe.edu.vallegrande.demo1.service.ClienteSERVICE" %>
<%@ page import="pe.edu.vallegrande.demo1.dto.ClienteDTO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>







<div class="container-fluid" id="container">
    <!-- Título de la página -->
    <h1 class="text-center my-4">Listado de Clientes</h1>



    <div class="07">
        <!-- Botón de exportación a Excel con color verde personalizado y tamaño más grande -->
        <button type="button" class="btn btn-success px-4 py-2 me-2" style="background-color: #28a745; border-color: #28a745;"
                onclick="exportTableToExcel('productTable', 'productos_inactivos')">
            <i class="bi bi-file-earmark-spreadsheet-fill"></i> Exportar a Excel
        </button>



        <!-- Botón de exportación a PDF con color rojo personalizado y tamaño más grande -->
        <button type="button" class="btn btn-danger px-4 py-2" style="background-color: #dc3545; border-color: #dc3545;"
                onclick="exportTableToPDF()">
            <i class="bi bi-file-earmark-pdf-fill"></i> Exportar a PDF
        </button>
    </div>





    <!-- Botón para agregar un nuevo cliente -->
    <div class="d-flex justify-content-end mb-3">
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalAgregarCliente">
            Agregar Nuevo Cliente <i class="bi bi-person-plus"></i>
        </button>

        <a href="cliente?action=Inactivos" class="btn btn-danger ms-2">
            Inactivos <i class="bi bi-person-x"></i>
        </a>

    </div>
        <jsp:include page="agregar.jsp"></jsp:include>
    </div>


    <!-- Tabla de clientes -->
    <div class="table-responsive">
        <table id="productTable" class="table table-bordered table-striped text-center">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Tipo Documento</th>
                <th>Número Documento</th>
                <th>Fecha Nacimiento</th>
                <th>Celular</th>
                <th>Email</th>
                <th>Dirección</th>
                <th>Fecha Registro</th>
                <th>Estatus</th>
                <th>Acción</th>
            </tr>
            </thead>
            <tbody>
            <%-- Generación dinámica de la lista de clientes --%>
            <%
                ClienteSERVICE clienteService = new ClienteSERVICE();
                List<ClienteDTO> clientes = clienteService.listarClientes();
                for (ClienteDTO cliente : clientes) {
            %>
            <tr>
                <td><%= cliente.getClienteID() %></td>
                <td><%= cliente.getNombre() %></td>
                <td><%= cliente.getApellido() %></td>
                <td><%= cliente.getTipoDocumento() %></td>
                <td><%= cliente.getNumeroDocumento() %></td>
                <td><%= cliente.getFechaNacimiento() %></td>
                <td><%= cliente.getCelular() %></td>
                <td><%= cliente.getEmail() %></td>
                <td><%= cliente.getDireccion() %></td>
                <td><%= cliente.getFechaRegistro() %></td>
                <td><%= cliente.getEstatus() %></td>
                <td>
                    <a href="cliente?action=editar&id=<%= cliente.getClienteID() %>" class="btn btn-warning btn-sm" title="Editar">
                        <i class="bi bi-pencil-square"></i>
                    </a>
                    <a href="cliente?action=eliminar&id=<%= cliente.getClienteID() %>" class="btn btn-danger btn-sm" title="Eliminar">
                        <i class="bi bi-trash"></i>
                    </a>
                    <a href="cliente?action=restaurar&id=<%= cliente.getClienteID() %>" class="btn btn-info btn-sm" title="Restaurar">
                        <i class="bi bi-arrow-clockwise"></i>
                    </a>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script>
    // Exportar tabla a Excel (.xls)
    function exportTableToExcel(tableID, fileName) {
        const table = document.getElementById(tableID);
        let tableHTML = table.outerHTML.replace(/ /g, '%20');

        // Crear un enlace invisible para descargar el archivo
        const link = document.createElement('a');
        link.href = 'data:application/vnd.ms-excel,' + tableHTML;
        link.download = `${fileName}.excel`;

        // Simular clic en el enlace
        link.click();
    }

    // Exportar tabla a PDF
    function exportTableToPDF() {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        // Obtener la tabla
        const table = document.querySelector("table");
        const data = [...table.rows].map(row =>
            [...row.cells].map(cell => cell.innerText)
        );

        // Configurar encabezados y contenido
        const headers = data[0];
        const body = data.slice(1);

        // Crear tabla en el PDF
        doc.autoTable({
            head: [headers],
            body: body,
        });

        // Guardar PDF
        doc.save("clientes.pdf");
    }
</script>


<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.23/jspdf.plugin.autotable.min.js"></script>







