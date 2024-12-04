<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="pe.edu.vallegrande.demo1.dto.ProductoDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="pe.edu.vallegrande.demo1.service.ProductoSERVICE" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    String marca = request.getParameter("marca");
    ProductoSERVICE pro = new ProductoSERVICE();
    List<ProductoDTO> productos;

    if (marca != null && !marca.isEmpty() && !"Todas".equals(marca)) {
        productos = pro.listarProductosPorMarca(marca);
    } else {
        productos = pro.listarProductos();
    }

    // Filtrar solo productos con estatus 'A'
    productos.removeIf(producto -> !"A".equals(producto.getEstatus()));
%>

<div class="container-fluid" id="container">
    <!-- Título de la página -->
    <h1 class="text-center my-4">Listado de Productos</h1>

    <!-- BOTONES DE EXCEL Y PDF -->
    <div class="07">
        <!-- Botón de exportación a Excel con color verde personalizado y tamaño más grande -->
        <button type="button" class="btn btn-success px-4 py-2 me-2" style="background-color: #28a745; border-color: #28a745;" onclick="exportTableToExcel('productTable', 'productos_activos')">
            <i class="bi bi-file-earmark-spreadsheet-fill"></i> Exportar a Excel
        </button>

        <!-- Botón de exportación a PDF con color rojo personalizado y tamaño más grande -->
        <button type="button" class="btn btn-danger px-4 py-2" style="background-color: #dc3545; border-color: #dc3545;" onclick="exportTableToPDF()">
            <i class="bi bi-file-earmark-pdf-fill"></i> Exportar a PDF
        </button>
    </div>

    <!-- Botón para agregar un nuevo producto -->
    <div class="text-end mb-3">
        <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalAgregarProducto">
            Agregar Nuevo Producto
        </button>

        <a href="producto?action=Inactivos" class="btn btn-danger ms-2">
            Inactivos <i class="bi bi-person-x"></i>
        </a>
    </div>

    <!-- OPCION DE BUSCA POR MARCA -->
    <form action="producto" method="GET" class="d-flex mb-3">
        <select name="marca" class="form-select">
            <option value="Todas" <%= (marca == null || "Todas".equals(marca)) ? "selected" : "" %>>Todas</option>
            <option value="Delicia Dulce" <%= "Delicia Dulce".equals(marca) ? "selected" : "" %>>Delicia Dulce</option>
            <option value="Oreo" <%= "Oreo".equals(marca) ? "selected" : "" %>>Oreo</option>
            <option value="Magnolia Bakery" <%= "Magnolia Bakery".equals(marca) ? "selected" : "" %>>Magnolia Bakery</option>
            <!-- Agrega más opciones de marca según tus necesidades -->
        </select>
        <button type="submit" class="btn btn-primary ms-2">Buscar</button>
    </form>

    <!-- Inclusión del formulario para agregar producto -->
    <jsp:include page="agregar.jsp"></jsp:include>

    <!-- Tabla de productos -->
    <table id="productTable" class="table table-bordered table-striped text-center">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Marca</th>
            <th>Categoría</th>
            <th>Precio Venta</th>
            <th>Descuento</th>
            <th>Stock</th>
            <th>Estatus</th>
            <th>Fecha Ingreso</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (ProductoDTO product : productos) {
        %>
        <tr>
            <td><%= product.getProductoID() %></td>
            <td><%= product.getNombre() %></td>
            <td><%= product.getDescripcion() %></td>
            <td><%= product.getMarca() %></td>
            <td><%= product.getCategoria() %></td>
            <td><%= product.getPrecioVenta() %></td>
            <td><%= product.getDescuento() %></td>
            <td><%= product.getStock() %></td>
            <td><%= product.getEstatus() %></td>
            <td><%= product.getFechaIngreso() %></td>
            <td>
                <a href="producto?action=editar&id=<%= product.getProductoID() %>" class="btn btn-warning btn-sm">
                    <i class="bi bi-pencil-square"></i>
                </a>
                <a href="producto?action=eliminar&id=<%= product.getProductoID() %>" class="btn btn-danger btn-sm">
                    <i class="bi bi-trash"></i>
                </a>
            </td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>

<!-- JavaScript -->
<script>
    // Exportar tabla a Excel con SheetJS
    function exportTableToExcel(tableID, filename = 'excel_data') {
        var wb = XLSX.utils.book_new();
        var ws = XLSX.utils.table_to_sheet(document.getElementById(tableID));

        // Añadir la hoja al libro de trabajo
        XLSX.utils.book_append_sheet(wb, ws, "Clientes");

        // Descargar el archivo Excel
        XLSX.writeFile(wb, filename + ".xlsx");
    }

    // Exportar tabla a PDF con jsPDF y AutoTable
    function exportTableToPDF() {
        const { jsPDF } = window.jspdf;

        // Crear una instancia de jsPDF
        var doc = new jsPDF();

        // Obtener la tabla de HTML y convertirla en PDF
        var element = document.getElementById("productTable");
        doc.autoTable({ html: element });

        // Guardar el PDF con un nombre específico
        doc.save("clientes_activos.pdf");
    }
</script>

<!-- jsPDF and SheetJS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.3.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.14/jspdf.plugin.autotable.min.js"></script>
</head>
