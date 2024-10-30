<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Proveedores Inactivos - La Esquinita</title>
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
      height: 100vh;
      padding: 20px;
      font-weight: bold;
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
    .btn-restore {
      background-color: #4caf50;
      color: white;
      width: 100px;
    }
    .btn-container {
      display: flex;
      gap: 10px;
      align-items: center;
      margin-bottom: 20px;
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
      <h3 class="text-center">Lista de Proveedores Inactivos</h3>
      <p class="text-center">Información sobre proveedores inactivos y opciones para restaurar su estado.</p>

      <div class="d-flex justify-content-between mb-3">
        <form action="listarSupplierInactivos" method="get">
          <select name="searchType" >
            <option value="name">Buscar por Razón Social</option>
            <option value="ruc">Buscar por RUC</option>
          </select>
          <input type="text" name="query" placeholder="Ingrese su búsqueda..." required>
          <button type="submit">Buscar</button>
        </form>


        <div class="btn-container">
          <button onclick="exportTableToExcel('tblData')" class="btn btn-success">Exportar a Excel</button>
          <button onclick="exportTableToPDF()" class="btn btn-secondary">Descargar PDF</button>
        </div>
      </div>

      <table class="table table-striped" id="tblData">
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
        <c:forEach var="supplier" items="${supplierInactivos}">
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
              <a href="restaurarSupplier?id=${supplier.id}" class="btn btn-success btn-restore">Restaurar</a>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

<script>
  // Exporta la tabla a un archivo Excel
  function exportTableToExcel(tableID, filename = '') {
    let table = document.getElementById(tableID);
    let wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });
    XLSX.writeFile(wb, filename ? filename + '.xlsx' : 'Proveedores_Inactivos.xlsx');
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

    doc.save('Proveedores_Inactivos.pdf');
  }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
