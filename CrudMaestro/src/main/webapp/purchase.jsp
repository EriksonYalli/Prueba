<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Compras</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
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

                /* Estilo del menú */
        .menu {
            min-height: 100vh;
            width: 300px;
            background-color: #2D2F36;
            /* Fondo oscuro */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-right: 1px solid #4A4D57;
            /* Divisor */
        }

        .menu h5 {
            font-size: 1.25rem;
            font-weight: 600;
            color: #FFFFFF;
            /* Texto claro */
            padding: 15px;
        }

        .nav-item {
            margin-bottom: 10px;
        }

        .nav-link {
            display: flex;
            align-items: center;
            font-size: 1.1rem;
            color: #8E9098;
            /* Gris claro */
            padding: 12px 15px;
            border-radius: 5px;
            transition: all 0.3s ease-in-out;
        }

        .nav-link:hover,
        .nav-link.active {
            background-color: #F04E30;
            /* Fondo hover */
            color: #FFFFFF;
            /* Texto en hover */
            font-weight: 500;
            text-decoration: none;
        }

        .nav-link i {
            font-size: 1.5rem;
            margin-right: 10px;
            color: #F7A440;
            /* Icono naranja cálido */
            transition: color 0.3s ease-in-out;
        }

        .nav-link:hover i,
        .nav-link.active i {
            color: #FFFFFF;
            /* Icono blanco en hover */
        }

        /* Estilos para el contenido */
        .content {
            flex-grow: 1;
            padding: 15px;
        }

        .layout {
            display: flex;
        }

        .table {
            font-size: 0.9rem;
        }

        .modal-body {
            font-size: 0.9rem;
        }

        .modal-title {
            font-size: 1.2rem;
        }
    </style>
</head>
 <body>
 <div class="layout">
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

     <!-- Contenido principal -->
     <div class="content">
         <h1 class="text-center mb-4">Compras</h1>
         <!-- Formulario de búsqueda -->
         <form action="/Compras" method="get" class="mb-4">
             <div class="row">
                 <!-- Filtro por proveedor -->
                 <div class="col-md-4">
                     <label for="supplierFilter" class="form-label">Proveedor</label>
                     <select id="supplierFilter" name="supplierId" class="form-select"
                             onchange="toggleSearchButton()">
                         <option value="">Seleccione un Proveedor</option>
                         <c:forEach var="supplier" items="${suppliers}"><option value="${supplier.id}" ${supplier.id==param.supplierId ? 'selected' : '' }>${supplier.company}</option></c:forEach>
                     </select>
                 </div>

                            <!-- Botones de acción -->
                 <div class="col-md-4 d-flex align-items-end">
                     <button type="submit" class="btn btn-primary me-2" id="searchButton" disabled>
                         <i class="fas fa-search"></i>
                     </button>
                 </div>
             </div>
         </form>

         <div class="mb-3">
             <a href="/Registrar_Compras" class="btn btn-primary">
                 <i class="fas fa-plus"></i> Registrar Nueva Compra
             </a>
             <a href="/Compras" class="btn btn-secondary">Restaurar</a>
         </div>

         <table class="table mt-4">
             <thead>
             <tr>
                 <th>Orden de Compra</th>
                 <th>Proveedor</th>
                 <th>Fecha</th>
                 <th>Total</th>
                 <th>Método de Pago</th>
                 <th>Acciones</th>
             </tr>
             </thead>
             <tbody>
             <c:forEach var="purchase" items="${purchases}">
                 <tr>
                     <td>${purchase.id}</td>
                     <td>${purchase.supplierName}</td>
                     <td><fmt:formatDate value="${purchase.date}" pattern="dd-MMM-yyyy"/></td>
                     <td>S/. ${purchase.totalAmount}</td>
                     <td>${purchase.paymentMethod}</td>
                     <td>
                         <button class="btn btn-primary btn-sm" data-bs-toggle="modal"
                                 data-bs-target="#detailModal" onclick="loadPurchaseDetails(${purchase.id})">
                             <i class="fas fa-eye"></i> Ver Detalles
                         </button>
                     </td>
                 </tr>
             </c:forEach>
             </tbody>
         </table>
     </div>
 </div>

 <!-- Modal de Detalles -->
 <div class="modal fade" id="detailModal" tabindex="-1" aria-labelledby="detailModalLabel" aria-hidden="true">
     <div class="modal-dialog modal-lg">
         <div class="modal-content shadow-lg border-0 rounded-3">
             <div class="modal-header border-bottom-0">
                 <h5 class="modal-title text-primary" id="detailModalLabel">Detalles de la Compra</h5>
                 <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
             </div>
             <div class="modal-body">
                 <!-- Información General de la Compra -->
                 <div class="mb-4">
                     <p><strong>ID de la Compra:</strong> <span id="purchaseId" class="text-muted"></span></p>
                     <p><strong>Proveedor:</strong> <span id="supplierName" class="text-muted"></span></p>
                     <p><strong>Fecha:</strong> <span id="purchaseDate" class="text-muted"></span></p>
                     <p><strong>Método de Pago:</strong> <span id="paymentMethod" class="text-muted"></span></p>
                 </div>

                 <!-- Tabla de Detalles de la Compra -->
                 <h5 class="mt-4 mb-3 text-secondary">Compras Realizadas</h5>
                 <div class="table-responsive">
                     <table class="table table-bordered table-striped table-hover">
                         <thead class="table-primary">
                         <tr>
                             <th>Repuesto</th>
                             <th>Cantidad</th>
                             <th>Precio Unitario</th>
                             <th>Subtotal</th>
                         </tr>
                         </thead>
                         <tbody id="purchaseDetails">
                         <!-- Detalles dinámicos cargados aquí -->
                         </tbody>
                         <tfoot class="table-light">
                         <tr>
                             <td colspan="3" class="text-end"><strong>Total:</strong></td>
                             <td id="purchaseTotal" class="text-center text-success"></td>
                         </tr>
                         </tfoot>
                     </table>
                 </div>
             </div>

             <!-- Botones de Acción -->
             <div class="modal-footer">
                 <button id="downloadPDF" class="btn btn-success">Descargar PDF</button>
                 <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
             </div>
         </div>
     </div>
 </div>

 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
 <!-- Incluir jsPDF -->
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
 <!-- Incluir la librería autoTable para jsPDF -->
 <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.18/jspdf.plugin.autotable.min.js"></script>

 <script>
     // Evento para generar el PDF
     document.querySelector('#downloadPDF').addEventListener('click', function () {
         const { jsPDF } = window.jspdf;
         const doc = new jsPDF();

         // Título del PDF - Boleta de Compra
         doc.setFontSize(20);
         doc.setFont("helvetica", "bold");
         doc.text('Boleta de Compra', 105, 20, { align: 'center' });

         // Verificar que los elementos del DOM existen
         const supplierNameElem = document.querySelector('#supplierName');
         const purchaseIdElem = document.querySelector('#purchaseId');
         const purchaseDateElem = document.querySelector('#purchaseDate');
         const purchaseTotalElem = document.querySelector('#purchaseTotal');
         const paymentMethodElem = document.querySelector('#paymentMethod');

         if (!supplierNameElem || !purchaseIdElem || !purchaseDateElem || !purchaseTotalElem || !paymentMethodElem) {
             alert('Algunos elementos del DOM no se encontraron.');
             return;
         }

         const supplierName = supplierNameElem.innerText;
         const purchaseId = purchaseIdElem.innerText;
         const purchaseDate = purchaseDateElem.innerText; // Fecha
         const purchaseTotal = purchaseTotalElem.innerText;
         const paymentMethod = paymentMethodElem.innerText;

         // Detalles generales con etiquetas resaltadas
         const details = [
             { label: 'Proveedor:', value: supplierName, y: 30 },
             { label: 'ID de Compra:', value: purchaseId, y: 40 },
             { label: 'Fecha:', value: purchaseDate, y: 50 },
             { label: 'Método de Pago:', value: paymentMethod, y: 60 }
         ];

         doc.setFontSize(12);

         details.forEach(detail => {
             doc.setFont("helvetica", "bold");
             doc.text(detail.label, 14, detail.y);

             const labelWidth = doc.getTextWidth(detail.label); // Obtener ancho del texto resaltado
             doc.setFont("helvetica", "normal");
             doc.text(detail.value, 14 + labelWidth + 2, detail.y); // Mostrar el valor justo después del texto resaltado
         });

         // Línea separadora para claridad
         doc.setDrawColor(0);
         doc.line(14, 65, 200, 65);

         // Crear tabla de detalles de la compra
         const tableColumn = ["Repuesto", "Cantidad", "Precio Unitario", "Subtotal"];
         const tableRows = [];

         const purchaseDetailsRows = document.querySelectorAll('#purchaseDetails tr');

         if (!purchaseDetailsRows.length) {
             alert('No se encontraron filas en los detalles de la compra.');
             return;
         }

         purchaseDetailsRows.forEach(function (row) {
             const cells = row.querySelectorAll('td');
             if (cells.length >= 4) { // Asegurar que hay al menos 4 celdas
                 const rowData = [
                     cells[0].innerText, // Repuesto
                     cells[1].innerText, // Cantidad
                     cells[2].innerText, // Precio Unitario
                     cells[3].innerText  // Subtotal
                 ];
                 tableRows.push(rowData);
             }
         });

         // Generar tabla en el PDF
         if (tableRows.length > 0) {
             doc.autoTable({
                 head: [tableColumn],
                 body: tableRows,
                 startY: 70,
                 theme: 'grid',
                 headStyles: {
                     fillColor: [41, 128, 185],
                     textColor: 255,
                     fontStyle: 'bold',
                     halign: 'center'
                 },
                 margin: { top: 10, left: 14, right: 14 },
                 styles: { overflow: 'linebreak', fontSize: 10 }
             });

             // Total destacado al final de la tabla
             const finalY = doc.lastAutoTable.finalY + 10;
             doc.setFontSize(12);
             doc.setFont("helvetica", "bold");
             doc.text('Total:', 140, finalY);

             doc.setFont("helvetica", "normal");
             doc.text(purchaseTotal, 180, finalY, { align: 'right' });
         } else {
             doc.text('No hay datos en los detalles de la compra.', 14, 70);
         }

         // Descargar el PDF
         doc.save('boleta-de-compra.pdf');
     });


     // Habilitar o deshabilitar el botón de búsqueda basado en el proveedor seleccionado
     function toggleSearchButton() {
         const supplierId = document.getElementById("supplierFilter").value;
         const searchButton = document.getElementById("searchButton");

         searchButton.disabled = supplierId === "";
     }

     // Asegurarse de que el estado del botón sea correcto al cargar la página
     window.onload = function () {
         toggleSearchButton();
     };

     function loadPurchaseDetails(purchaseId) {
         fetch("/ComprasDetalles", {
             method: "POST",
             headers: { "Content-Type": "application/json" },
             body: JSON.stringify({ id: purchaseId })
         })
             .then(response => {
                 if (!response.ok) throw new Error('Error al obtener los detalles de la compra');
                 return response.json();
             })
             .then(data => {
                 const purchase = data.purchase;
                 const details = data.details;

                 // Llenar datos generales
                 document.getElementById('purchaseId').textContent = purchase.id;
                 document.getElementById('supplierName').textContent = purchase.supplierName;
                 document.getElementById('purchaseDate').textContent = purchase.date;
                 document.getElementById('purchaseTotal').textContent = "S/." + purchase.totalAmount;
                 document.getElementById('paymentMethod').textContent = purchase.paymentMethod;

                 // Llenar tabla de detalles
                 const detailsTable = document.getElementById('purchaseDetails');
                 detailsTable.innerHTML = ''; // Limpiar contenido previo
                 details.forEach(detail => {
                     const row = document.createElement('tr');

                     // Nombre del repuesto
                     const sparePartCell = document.createElement('td');
                     sparePartCell.textContent = detail.sparePartName || "N/A";
                     row.appendChild(sparePartCell);

                     // Cantidad
                     const quantityCell = document.createElement('td');
                     quantityCell.textContent = detail.quantity;
                     row.appendChild(quantityCell);

                     // Precio unitario
                     const priceUnitCell = document.createElement('td');
                     priceUnitCell.textContent = "S/." + detail.priceUnit.toFixed(2); // Formatear a 2 decimales
                     row.appendChild(priceUnitCell);

                     // Subtotal
                     const subtotalCell = document.createElement('td');
                     subtotalCell.textContent = "S/." + detail.subtotal.toFixed(2); // Formatear a 2 decimales
                     row.appendChild(subtotalCell);

                     detailsTable.appendChild(row);
                 });
             })
             .catch(error => {
                 console.error('Error al cargar los detalles:', error);
             });
     }
 </script>
 </body>
</html>