<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Lista de Repuestos Inactivos</title>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <style>
    /* Estilo del menú */
    .menu {
      min-height: 100vh;
      width: 300px;
      background-color: #2D2F36; /* Fondo oscuro */
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      border-right: 1px solid #4A4D57; /* Divisor */
    }

    .menu h5 {
      font-size: 1.25rem;
      font-weight: 600;
      color: #FFFFFF; /* Texto claro */
      padding: 15px;
    }

    .nav-item {
      margin-bottom: 10px;
    }

    .nav-link {
      display: flex;
      align-items: center;
      font-size: 1.1rem;
      color: #8E9098; /* Gris claro */
      padding: 12px 15px;
      border-radius: 5px;
      transition: all 0.3s ease-in-out;
    }

    .nav-link:hover,
    .nav-link.active {
      background-color: #F04E30; /* Fondo hover */
      color: #FFFFFF; /* Texto en hover */
      font-weight: 500;
      text-decoration: none;
    }

    .nav-link i {
      font-size: 1.5rem;
      margin-right: 10px;
      color: #F7A440; /* Icono naranja cálido */
      transition: color 0.3s ease-in-out;
    }

    .nav-link:hover i,
    .nav-link.active i {
      color: #FFFFFF; /* Icono blanco en hover */
    }

    .table {
      width: 100%;
      border-collapse: collapse;
      font-family: 'Segoe UI', Arial, sans-serif;
      font-size: 14px; /* Compacto pero legible */
      color: #333; /* Texto oscuro y limpio */
      margin: 20px 0;
    }

    .table thead {
      text-transform: uppercase;
      font-size: 14px;
    }

    .table th, .table td {
      padding: 10px 12px; /* Espaciado pequeño pero suficiente */
      border: 1px solid #ddd; /* Bordes suaves */
    }

    .table tbody tr {
      transition: background-color 0.3s ease;
    }

    .table tbody tr:nth-child(even) {
      background-color: #f8f9fa; /* Alternancia de filas */
    }

    .table tbody tr:hover {
      background-color: #e8ecef; /* Efecto hover suave */
    }

    .table .btn {
      padding: 6px 10px;
      font-size: 13px; /* Compacto pero funcional */
      border-radius: 4px;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    .btn-primary {
      color: #fff;
      background-color: #3498db; /* Azul vivo */
      border: none;
    }

    .btn-primary:hover {
      background-color: #2980b9; /* Azul más oscuro */
      transform: scale(1.05); /* Pequeña animación */
    }

    th, td {
      text-align: center;
      vertical-align: middle;
    }

    .table caption {
      caption-side: top;
      font-size: 16px;
      font-weight: bold;
      margin-bottom: 10px;
      color: #2c3e50;
    }

    .form-label {
      margin-top: .5rem;
      font-weight: 500;
    }

    .mb-1 {
      margin-bottom: 1rem !important;
    }

    .custom-btn {
      background-color: #495057; /* Gris azulado oscuro */
      border: none;
      color: white;
    }

    .custom-btn:hover {
      background-color: #343a40; /* Gris más oscuro para el hover */
    }

    .btn-custom {
      background-color: #FF0000; /* Rojo vivo */
      color: white; /* Texto blanco */
      border: none; /* Sin borde inicial */
      transition: all 0.3s ease-in-out; /* Transición suave para el hover */
    }

    .btn-custom:hover {
      background-color: white; /* Fondo blanco al pasar el cursor */
      color: #FF0000; /* Texto rojo */
      border: 2px solid #FF0000; /* Borde rojo al pasar el cursor */
    }

    .btn-excel {
      background-color: #28a745; /* Verde vibrante */
      color: white; /* Texto blanco */
      border: none; /* Sin borde inicial */
      transition: all 0.3s ease-in-out; /* Transición suave */
    }

    .btn-excel:hover {
      background-color: white; /* Fondo blanco al pasar el cursor */
      color: #28a745; /* Texto verde vibrante */
      border: 2px solid #28a745; /* Borde verde */
    }

    @media print {
      body * {
        visibility: hidden;
      }
      #printableArea, #printableArea * {
        visibility: visible;
      }
      #printableArea {
        position: absolute;
        left: 0;
        top: 0;
        width: 100%;
      }
      #inactivePartsTable th:last-child,
      #inactivePartsTable td:last-child {
        display: none; /* Ocultar la columna de acciones */
      }
    }
  </style>
</head>
<body>
<div class="d-flex">
  <!-- Menú vertical -->
  <div class="menu p-3">
    <h5 class="pb-3 border-bottom">K&G Electronic</h5>
    <ul class="nav flex-column">
      <li class="nav-item">
        <a class="nav-link d-flex align-items-center" href="/WelcomeAdmin.jsp">
          <i class="fas fa-home me-2"></i> Inicio
        </a>
      </li>
      <li class="nav-item dropdown">
        <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
          <i class="fas fa-users me-2"></i> Clientes
        </a>
        <ul class="dropdown-menu">
          <li>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/clientes">
              <i class="fas fa-user me-2"></i> Cliente Natural
            </a>
          </li>
          <li>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/clientesjuridicos">
              <i class="fas fa-building me-2"></i> Cliente Jurídico
            </a>
          </li>
          <li>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/clientesjuridicosinactivos">
              <i class="fas fa-building me-2"></i> Cliente Jurídico Inactivos
            </a>
          </li>
          <li>
            <a class="dropdown-item" href="${pageContext.request.contextPath}/clientesinactivos">
              <i class="fas fa-user me-2"></i> Cliente Natural Inactivos
            </a>
          </li>
        </ul>
      </li>
      <li class="nav-item">
        <a class="nav-link d-flex align-items-center" href="cita?action=view">
          <i class="fas fa-calendar-check me-2"></i> Citas
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link d-flex align-items-center" href="/listar">
          <i class="fas fa-cog me-2"></i> Repuestos
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link d-flex align-items-center" href="/Compras">
          <i class="fas fa-shopping-cart me-2"></i> Compra
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link d-flex align-items-center" href="/logout">
          <i class="fas fa-sign-out-alt me-2"></i> Cerrar sesión
        </a>
      </li>
    </ul>
  </div>

  <div class="p-4 flex-grow-1 content">
    <h1 class="text-center mb-4">Lista de Repuestos Inactivos</h1>

    <div class="Busqueda mb-1">
      <form action="${pageContext.request.contextPath}/listarInactivo" method="get" class="d-flex" onsubmit="return validateForm()">
        <input type="text" id="nombre" name="nombre" class="form-control me-2" placeholder="Nombre del repuesto" aria-label="Nombre del repuesto" oninput="toggleButton()"/>

        <label for="brandId" class="form-label me-2">Marca:</label>
        <select id="brandId" name="brandId" class="form-select me-2" onchange="toggleButton()">
          <option value="">Seleccione una marca</option>
          <c:forEach var="brand" items="${brands}">
            <option value="${brand.id}">${brand.name}</option>
          </c:forEach>
        </select>

        <button type="submit" id="searchButton" class="btn btn-primary" disabled>
          <i class="bi bi-search"></i>
        </button>
      </form>
    </div>

    <a href="/listar" class="btn btn-primary">
      <i class="bi bi-tools"></i> Activos
    </a>

    <a href="${pageContext.request.contextPath}/listarInactivo" class="btn btn-primary custom-btn">Restaurar tabla</a>

    <button type="button" class="btn btn-excel float-end me-2" onclick="exportInactivePartsToCSV()">
      <i class="bi bi-file-earmark-spreadsheet"></i> Exportar Repuestos Inactivos a CSV
    </button>

    <!-- Botón para exportar la tabla a Excel -->
    <button class="btn btn-excel float-end me-2" onclick="exportTableToExcel('inactivePartsTable', 'Repuestos')">
      <i class="bi bi-file-earmark-spreadsheet"></i> Exportar a Excel
    </button>

    <!-- Botón para imprimir o descargar como PDF -->
    <button id="browserPrint" class="btn btn-custom float-end me-2">
      <i class="bi bi-file-earmark-pdf"></i> Descargar PDF
    </button>

    <!-- Tabla de Repuestos Inactivos -->
    <div id="printableArea">
      <table class="table mt-4" id="inactivePartsTable">
        <thead>
        <tr>
          <th>Nombre</th>
          <th>Descripción</th>
          <th>Tipo de Compatibilidad</th>
          <th>Categoría</th>
          <th>Marca</th>
          <th>Stock</th>
          <th>Fecha de Entrada</th>
          <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="repuestoI" items="${partsI}">
          <tr>
            <td>${repuestoI.name}</td>
            <td>${repuestoI.description}</td>
            <td>${repuestoI.compatibilityType}</td>
            <td>${repuestoI.categoryName}</td> <!-- Mostrar nombre de la categoría -->
            <td>${repuestoI.brandName}</td>    <!-- Mostrar nombre de la marca -->
            <td>${repuestoI.stock}</td>
            <td><fmt:formatDate value="${repuestoI.entryDate}" pattern="dd-MMM-yyyy"/></td>
            <td>
              <form action="/restaurar" method="post" style="display:inline;" id="restoreForm-${repuestoI.id}">
                <input type="hidden" name="id" value="${repuestoI.id}">
                <button type="button" class="btn btn-outline-success" onclick="triggerRestoreConfirmation(this.form)">
                  <i class="bi bi-arrow-clockwise"></i>
                </button>
              </form>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>

      function exportInactivePartsToCSV() {
        // Obtener la tabla de repuestos inactivos
        var table = document.getElementById("inactivePartsTable");
        var rows = table.rows;
        var csvContent = "Nombre,Descripción,Tipo de Compatibilidad,Categoría,Marca,Stock,Fecha de Entrada\n"; // Encabezados de la tabla

        // Iterar sobre las filas de la tabla (saltar la fila de encabezado)
        for (var i = 1; i < rows.length; i++) {
          var row = rows[i];
          var cells = row.getElementsByTagName("td");
          var rowData = [];

          // Extraer los datos de cada celda en la fila
          for (var j = 0; j < cells.length - 1; j++) {  // -1 para no incluir la columna de "Acciones"
            rowData.push(cells[j].innerText.trim());
          }

          // Unir los valores de la fila con comas y agregarla al contenido CSV
          csvContent += rowData.join(",") + "\n";
        }

        // Crear un enlace temporal para descargar el CSV
        var blob = new Blob([csvContent], { type: 'text/csv' });
        var link = document.createElement("a");
        link.href = URL.createObjectURL(blob);
        link.download = "repuestos_inactivos.csv"; // Nombre del archivo CSV
        link.click();
      }

      function triggerRestoreConfirmation(form) {
        Swal.fire({
          title: "¿Está seguro de restaurar este repuesto?",
          text: "El repuesto volverá a estar activo en el sistema.",
          icon: "question",
          showCancelButton: true,
          confirmButtonText: "Sí, restaurar",
          cancelButtonText: "Cancelar",
          reverseButtons: true
        }).then((result) => {
          if (result.isConfirmed) {
            form.submit(); // Envía el formulario si se confirma la restauración
          }
        });
      }

      // Código para permitir que la búsqueda funcione, poniendo al menos un campo seleccionado
      function toggleButton() {
        const nombre = document.getElementById("nombre").value.trim();
        const marca = document.getElementById("brandId").value; // Cambiado a brandId
        const searchButton = document.getElementById("searchButton");

        // Habilita el botón si al menos uno de los campos tiene un valor
        searchButton.disabled = !(nombre || marca);
      }

      function validateForm() {
        return !document.getElementById("searchButton").disabled;
      }

      function downloadPDFWithBrowserPrint() {
        window.print();
      }
      document.querySelector('#browserPrint').addEventListener('click', downloadPDFWithBrowserPrint);

      function exportTableToExcel(tableID, filename = '') {
        let table = document.getElementById(tableID);

        // Crear una copia de la tabla para excluir la columna "Acciones"
        let clonedTable = table.cloneNode(true);

        // Eliminar la última columna en cada fila (Acciones)
        Array.from(clonedTable.rows).forEach(row => {
          if (row.cells.length > 0) {
            row.deleteCell(row.cells.length - 1); // Elimina la última celda
          }
        });

        // Convertir la tabla modificada en libro de Excel
        let wb = XLSX.utils.table_to_book(clonedTable, { sheet: "Sheet1" });

        // Exportar el archivo
        XLSX.writeFile(wb, filename ? filename + '.xlsx' : 'Repuestos-Inactivo.xlsx');
      }

    </script>
  </div>
</div>
</body>
</html>


