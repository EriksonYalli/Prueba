<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Proveedores - La Esquinita</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.4.0/jspdf.umd.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.17/jspdf.plugin.autotable.min.js"></script>
    <style>
        body {
            background-color: #f5f5f5;
        }
        .sidebar {
            background-color: #d32f2f;
            color: white;
            padding: 20px;
            font-weight: bold;
            height: 100vh;
            position: sticky;
            top: 0;
        }
        .row {
            min-height: 100vh;
        }
        .container-fluid {
            display: flex;
            min-height: 100vh;
        }
        .sidebar a {
            color: white;
            text-decoration: none;
            display: block;
            margin: 15px 0;
            font-size: 18px;
        }
        .sidebar a:hover {
            text-decoration: underline;
        }
        .main-content {
            padding: 40px;
            background-color: #f5f5f5;
        }
        .table th, .table td {
            vertical-align: middle;
            text-align: center;
            border: 1px solid #dee2e6;
        }
        .btn-edit, .btn-delete {
            width: 100px;
            display: inline-block;
        }
        .btn-edit {
            background-color: #4a90e2;
            color: white;
        }
        .btn-delete {
            background-color: #d32f2f;
            color: white;
        }
        .btn-inactive {
            background-color: #3c5c6e;
            color: #ffffff;
        }
        .btn-container .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-container {
            display: flex;
            gap: 10px;
            align-items: center;
        }
    </style>
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-2 sidebar">
            <h2>BODEGA LA ESQUINITA</h2>
            <a href="home.jsp">Inicio</a>
            <a href="listarSupplier">Proveedores</a>
            <a href="listarProductos">Productos</a>
            <a href="#">Gestión de productos</a>
            <a href="#">Cerrar Sesión</a>
        </div>

        <div class="col-md-10 main-content">
            <h3>Lista de Proveedores</h3>
            <p>Información sobre proveedores, contacto, dirección y más.</p>

            <div class="d-flex justify-content-between mb-3">
                <form action="listarSupplier" method="get">
                    <select name="searchType">
                        <option value="name">Buscar por Razón Social</option>
                        <option value="ruc">Buscar por RUC</option>
                    </select>
                    <input type="text" name="query" placeholder="Ingrese su búsqueda..." required>
                    <button type="submit">Buscar</button>
                </form>

                <div class="btn-container">
                    <a href="agregarProveedor.jsp" class="btn btn-danger">Añadir Proveedor</a>
                    <button onclick="exportTableToExcel('tblData')" class="btn btn-success">Exportar a Excel</button>
                    <a href="listarSupplierInactivos" class="btn btn-inactive">Proveedores Inactivos</a>
                    <button onclick="exportTableToPDF()" class="btn btn-secondary">Descargar PDF</button>
                </div>
            </div>

            <div id="printableArea">
                <table id="tblData" class="table table-striped">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Razón Social</th>
                        <th>Dirección</th>
                        <th>Correo Electrónico</th>
                        <th>RUC</th>
                        <th>Representante</th>
                        <th>Email Representante</th>
                        <th>Teléfono Representante</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="supplier" items="${supplierList}">
                        <tr>
                            <td>${supplier.id}</td>
                            <td>${supplier.name}</td>
                            <td>${supplier.direction}</td>
                            <td>${supplier.email}</td>
                            <td>${supplier.ruc}</td>
                            <td>${supplier.representative}</td>
                            <td>${supplier.emailRepresentative}</td>
                            <td>${supplier.phoneRepresentative}</td>
                            <td>${supplier.status}</td>
                            <td>
                                <a href="editarSupplier?id=${supplier.id}" class="btn btn-primary btn-edit">Editar</a>
                                <a href="eliminarSupplier?id=${supplier.id}" class="btn btn-danger btn-delete">Eliminar</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    // Exporta la tabla a un archivo Excel
    function exportTableToExcel(tableID, filename = '') {
        let table = document.getElementById(tableID);
        let wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });
        XLSX.writeFile(wb, filename ? filename + '.xlsx' : 'Proveedores.xlsx');
    }

    // Exporta la tabla a un archivo PDF
    function exportTableToPDF() {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        doc.autoTable({
            html: '#tblData',
            startY: 20,
            headStyles: { fillColor: [0, 0, 0] },
            margin: { top: 10 },
            styles: { fontSize: 6 }
        });

        doc.save('Proveedores.pdf');
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
