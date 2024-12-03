<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Repuestos</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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
            background-color: #34495e; /* Color oscuro elegante */
            color: #ecf0f1; /* Texto claro */
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

        .btn-danger {
            color: #fff;
            background-color: #FF0000; /* Rojo vivo */
            border: none;
        }

        .btn-danger:hover {
            background-color: #c0392b; /* Rojo más oscuro */
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

        .modal-content {
            border-radius: 10px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.2);
        }
        .modal-header {
            background-color: #007bff;
            color: white;
        }
        .modal-body {
            background-color: #f8f9fa;
        }
        .form-label {
            margin-top: .5rem;
            font-weight: 500;
        }

        .mb-3 {
            margin-bottom: 0 !important;
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
            #partsTable th:last-child,
            #partsTable td:last-child {
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

    <!-- Contenido principal -->
    <div class="p-4 flex-grow-1 content">
        <h1 class="text-center mb-4">Lista de Repuestos</h1>

        <div class="Busqueda mb-1">
            <form action="${pageContext.request.contextPath}/listar" method="get" class="d-flex" onsubmit="return validateForm()">
                <input type="text" id="nombre" name="nombre" class="form-control me-2" placeholder="Nombre del repuesto" aria-label="Nombre del repuesto" oninput="toggleButton()"/>

                <label for="brandId-B" class="form-label me-2">Marca:</label>
                <select id="brandId-B" name="brandId" class="form-select me-2" onchange="toggleButton()">
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

        <!-- Botón para abrir el modal de agregar repuesto -->
        <button type="button" class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#addRepuestoModal">
            <i class="bi bi-plus-circle"></i> Agregar Nuevo Repuesto
        </button>

        <a href="/listarInactivo" class="btn btn-dark">
            <i class="bi bi-eye-slash"></i> Inactivos
        </a>

        <a href="${pageContext.request.contextPath}/listar" class="btn btn-primary custom-btn">Restaurar tabla</a>

        <button type="button" class="btn btn-excel float-end me-2" onclick="exportToCSV()">
            <i class="bi bi-file-earmark-spreadsheet"></i> Exportar a CSV
        </button>

        <!-- Botón para exportar la tabla a Excel -->
        <button class="btn btn-excel float-end me-2" onclick="exportTableToExcel('partsTable', 'Repuestos')">
            <i class="bi bi-file-earmark-spreadsheet"></i> Exportar a Excel
        </button>

        <!-- Botón para imprimir o descargar como PDF -->
        <button id="browserPrint" class="btn btn-custom float-end me-2">
            <i class="bi bi-file-earmark-pdf"></i> Descargar PDF
        </button>

        <!-- Modal agregar -->
        <div class="modal fade" id="addRepuestoModal" tabindex="-1" aria-labelledby="addRepuestoModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <form action="/create" method="post" id="addRepuestoForm">
                        <!-- Header -->
                        <div class="modal-header bg-primary text-white">
                            <h5 class="modal-title" id="addRepuestoModalLabel">Agregar Repuesto</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <!-- Body -->
                        <div class="modal-body">
                            <div class="row g-3">
                                <!-- Nombre -->
                                <div class="col-md-6">
                                    <label for="name" class="form-label">Nombre:</label>
                                    <input type="text" id="name" name="name" class="form-control" placeholder="Ingrese el nombre del repuesto" required>
                                </div>
                                <!-- Descripción -->
                                <div class="col-md-6">
                                    <label for="description" class="form-label">Descripción:</label>
                                    <textarea id="description" name="description" class="form-control" placeholder="Ingrese una breve descripción" rows="3" required></textarea>
                                </div>
                            </div>
                            <div class="row g-3 mt-3">
                                <!-- Tipo de Compatibilidad -->
                                <div class="col-md-6">
                                    <label for="compatibilityType" class="form-label">Tipo de Calidad:</label>
                                    <select id="compatibilityType" name="compatibilityType" class="form-select" required>
                                        <option value="">Seleccione una opción</option>
                                        <option value="Original">Original</option>
                                        <option value="Generico">Generico</option>
                                    </select>
                                </div>
                                <!-- Categoría -->
                                <div class="col-md-6">
                                    <label for="categoryId" class="form-label">Categoría:</label>
                                    <select id="categoryId" name="categoryId" class="form-select" required>
                                        <option value="">Seleccione una categoría</option>
                                        <c:forEach var="category" items="${categories}">
                                            <option value="${category.id}">${category.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="row g-3 mt-3">
                                <!-- Marca -->
                                <div class="col-md-6">
                                    <label for="brandId" class="form-label">Marca:</label>
                                    <select id="brandId" name="brandId" class="form-select" required>
                                        <option value="">Seleccione una marca</option>
                                        <c:forEach var="brand" items="${brands}">
                                            <option value="${brand.id}">${brand.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <!-- Fecha de Entrada -->
                                <div class="col-md-6">
                                    <label for="entryDate" class="form-label">Fecha de Entrada:</label>
                                    <input type="date" id="entryDate" name="entryDate" class="form-control" required>
                                </div>
                            </div>
                        </div>
                        <!-- Footer -->
                        <div class="modal-footer bg-light">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            <button type="button" class="btn btn-primary" onclick="submitWithConfirmation()">Guardar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Tabla -->
        <div id="printableArea">
            <table class="table mt-4" id="partsTable">
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
                <c:forEach var="repuesto" items="${parts}">
                    <tr>
                        <td>${repuesto.name}</td>
                        <td>${repuesto.description}</td>
                        <td>${repuesto.compatibilityType}</td>
                        <td>${repuesto.categoryName}</td> <!-- Mostrar nombre de la categoría -->
                        <td>${repuesto.brandName}</td>    <!-- Mostrar nombre de la marca -->
                        <td>${repuesto.stock}</td>
                        <td><fmt:formatDate value="${repuesto.entryDate}" pattern="dd-MMM-yyyy"/></td>
                        <td>
                            <button
                                    type="button"
                                    class="btn btn-primary"
                                    data-bs-toggle="modal"
                                    data-bs-target="#editRepuestoModal"
                                    data-id="${repuesto.id}"
                                    data-name="${repuesto.name}"
                                    data-description="${repuesto.description}"
                                    data-compatibilityType="${repuesto.compatibilityType}"
                                    data-categoryId="${repuesto.categoryId}"
                                    data-brandId="${repuesto.brandId}"
                                    data-entryDate="${repuesto.entryDate}"
                                    onclick="loadEditModal(event)">
                                <i class="bi bi-pencil"></i>
                            </button>
                            <form action="/eliminar" method="post" style="display:inline;" onsubmit="return confirmDelete(event, this);">
                                <input type="hidden" name="id" value="${repuesto.id}">
                                <button type="button" class="btn btn-danger" onclick="triggerDeleteConfirmation(this.form)">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <!-- Modal editar -->
        <div class="modal fade" id="editRepuestoModal" tabindex="-1" aria-labelledby="editRepuestoModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <form action="/editar" method="post" id="editRepuestoForm">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editRepuestoModalLabel">Editar Repuesto</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <input type="hidden" id="edit-id" name="id">
                            <div class="mb-3">
                                <label for="edit-name" class="form-label">Nombre:</label>
                                <input type="text" id="edit-name" name="name" class="form-control" required>
                            </div>
                            <div class="mb-3">
                                <label for="edit-description" class="form-label">Descripción:</label>
                                <textarea id="edit-description" name="description" class="form-control" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="edit-compatibilityType" class="form-label">Tipo de Calidad:</label>
                                <select id="edit-compatibilityType" name="compatibilityType" class="form-select" required>
                                    <option value="">Seleccione una opción</option>
                                    <option value="Original">Original</option>
                                    <option value="Generico">Generico</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="editCategoryId" class="form-label">Categoría:</label>
                                <select id="editCategoryId" name="categoryId" class="form-select" required>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.id}" ${category.id == sparePart.categoryId ? 'selected' : ''}>${category.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="editBrandId" class="form-label">Marca:</label>
                                <select id="editBrandId" name="brandId" class="form-select" required>
                                    <c:forEach var="brand" items="${brands}">
                                        <option value="${brand.id}" ${brand.id == sparePart.brandId ? 'selected' : ''}>${brand.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="edit-entryDate" class="form-label">Fecha de Entrada:</label>
                                <input type="date" id="edit-entryDate" name="entryDate" class="form-control" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            <button type="button" class="btn btn-primary" onclick="submitEditForm()">Actualizar</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Scripts -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>

    function exportToCSV() {
        // Obtener la tabla
        var table = document.getElementById("partsTable");
        var rows = table.rows;
        var csvContent = "";

        // Iterar sobre las filas de la tabla
        for (var i = 0; i < rows.length; i++) {
            var row = rows[i];
            var cells = row.getElementsByTagName("td");
            var rowData = [];

            // Si no es la primera fila (encabezado), procesar los datos
            if (cells.length > 0) {
                for (var j = 0; j < cells.length; j++) {
                    rowData.push(cells[j].innerText.trim());
                }

                // Unir los valores con un gran espacio (puedes ajustar la cantidad de espacios)
                csvContent += rowData.join("      ") + "\n"; // 6 espacios
            }
        }

        // Crear un enlace temporal para descargar el CSV
        var blob = new Blob([csvContent], { type: 'text/csv' });
        var link = document.createElement("a");
        link.href = URL.createObjectURL(blob);
        link.download = "repuestos.csv"; // Nombre del archivo CSV
        link.click();
    }

    function submitEditForm() {
        // Verificar si todos los campos requeridos están llenos
        const isFormValid = validateEditForm();

        if (!isFormValid) {
            // Mostrar alerta si el formulario no es válido
            Swal.fire({
                title: "Error",
                text: "Por favor, complete todos los campos requeridos.",
                icon: "error",
                confirmButtonText: "Entendido"
            });
            return; // Detener el envío del formulario
        }

        // Si los campos son válidos, mostrar confirmación
        Swal.fire({
            title: "¿Está seguro de actualizar este repuesto?",
            text: "Confirme que desea realizar los cambios.",
            icon: "question",
            showCancelButton: true,
            confirmButtonText: "Sí, actualizar",
            cancelButtonText: "Cancelar",
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById("editRepuestoForm").submit(); // Enviar el formulario
            } else {
                Swal.fire("Cancelado", "Los cambios no fueron aplicados.", "info");
            }
        });
    }

    // Función para validar si todos los campos requeridos están completos en el formulario de edición
    function validateEditForm() {
        const editFields = {
            name: document.getElementById("edit-name"),
            description: document.getElementById("edit-description"),
            compatibilityType: document.getElementById("edit-compatibilityType"),
            categoryId: document.getElementById("editCategoryId"),
            brandId: document.getElementById("editBrandId"),
            entryDate: document.getElementById("edit-entryDate")
        };

        let isValid = true;

        // Verificar cada campo
        for (let field in editFields) {
            if (editFields[field].value.trim() === "") {
                isValid = false;
                editFields[field].classList.add("is-invalid"); // Resaltar campos vacíos
            } else {
                editFields[field].classList.remove("is-invalid"); // Remover resalte de campos válidos
            }
        }

        return isValid;
    }

    function submitWithConfirmation() {
        // Verificar si todos los campos requeridos están llenos
        const isFormValid = validateForm();

        if (!isFormValid) {
            // Mostrar alerta si el formulario no es válido
            Swal.fire({
                title: "Error",
                text: "Por favor, complete todos los campos requeridos.",
                icon: "error",
                confirmButtonText: "Entendido"
            });
            return; // Detener el envío del formulario
        }

        // Si los campos son válidos, mostrar confirmación
        Swal.fire({
            title: "¿Está seguro de agregar este repuesto?",
            icon: "question",
            showCancelButton: true,
            confirmButtonText: "Sí, guardar",
            cancelButtonText: "Cancelar",
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById("addRepuestoForm").submit(); // Enviar el formulario
            } else {
                Swal.fire("Cancelado", "El repuesto no fue agregado.", "info");
            }
        });
    }

    // Función para validar si todos los campos requeridos están completos
    function validateForm() {
        const addFields = {
            name: document.getElementById("name"),
            description: document.getElementById("description"),
            compatibilityType: document.getElementById("compatibilityType"),
            categoryId: document.getElementById("categoryId"),
            brandId: document.getElementById("brandId"),
            entryDate: document.getElementById("entryDate")
        };

        let isValid = true;

        // Verificar cada campo
        for (let field in addFields) {
            if (addFields[field].value.trim() === "") {
                isValid = false;
                addFields[field].classList.add("is-invalid"); // Resaltar campos vacíos
            } else {
                addFields[field].classList.remove("is-invalid"); // Remover resalte de campos válidos
            }
        }

        return isValid;
    }

    function triggerDeleteConfirmation(form) {
        Swal.fire({
            title: "¿Está seguro de eliminar este repuesto?",
            text: "Esta acción se podra deshacer al entrar en inactivo.",
            icon: "warning",
            showCancelButton: true,
            confirmButtonText: "Sí, eliminar",
            cancelButtonText: "Cancelar",
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                form.submit(); // Envía el formulario si se confirma la eliminación
            }
        });
    }


    document.addEventListener("DOMContentLoaded", function () {
        // Validaciones para el formulario de agregar repuesto
        const addForm = document.getElementById("addRepuestoForm");
        const addFields = {
            name: {
                element: document.getElementById("name"),
                validate: function () {
                    return checkRequired(this.element, "Por favor, complete este campo.");
                }
            },
            description: {
                element: document.getElementById("description"),
                validate: function () {
                    return checkRequired(this.element, "Por favor, complete este campo.");
                }
            },
            compatibilityType: {
                element: document.getElementById("compatibilityType"),
                validate: function () {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione un tipo de compatibilidad.");
                    return isValid;
                }
            },
            categoryId: {
                element: document.getElementById("categoryId"),
                validate: function () {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione una categoría.");
                    return isValid;
                }
            },
            brandId: {
                element: document.getElementById("brandId"),
                validate: function () {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione una marca.");
                    return isValid;
                }
            },
            entryDate: {
                element: document.getElementById("entryDate"),
                validate: function () {
                    return checkRequired(this.element, "Ingrese una fecha válida.");
                }
            }
        };

        // Validaciones para el formulario de editar repuesto
        const editForm = document.getElementById("editRepuestoForm");
        const editFields = {
            name: {
                element: document.getElementById("edit-name"),
                validate: function () {
                    return checkRequired(this.element, "Por favor, complete este campo.");
                }
            },
            description: {
                element: document.getElementById("edit-description"),
                validate: function () {
                    return checkRequired(this.element, "Por favor, complete este campo.");
                }
            },
            compatibilityType: {
                element: document.getElementById("edit-compatibilityType"),
                validate: function () {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione un tipo de compatibilidad.");
                    return isValid;
                }
            },
            categoryId: {
                element: document.getElementById("editCategoryId"),
                validate: function () {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione una categoría.");
                    return isValid;
                }
            },
            brandId: {
                element: document.getElementById("editBrandId"),
                validate: function () {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione una marca.");
                    return isValid;
                }
            },
            entryDate: {
                element: document.getElementById("edit-entryDate"),
                validate: function () {
                    return checkRequired(this.element, "Ingrese una fecha válida.");
                }
            }
        };

        // Eventos de validación en tiempo real para agregar
        Object.values(addFields).forEach(field => {
            field.element.addEventListener("input", field.validate.bind(field));
            if (field.element.tagName === "SELECT") {
                field.element.addEventListener("change", field.validate.bind(field));
            }
        });

        // Validación general al enviar el formulario de agregar
        addForm.addEventListener("submit", function (event) {
            const isFormValid = Object.values(addFields).every(field => field.validate());
            if (!isFormValid) {
                event.preventDefault();
            }
        });

        // Eventos de validación en tiempo real para editar
        Object.values(editFields).forEach(field => {
            field.element.addEventListener("input", field.validate.bind(field));
            if (field.element.tagName === "SELECT") {
                field.element.addEventListener("change", field.validate.bind(field));
            }
        });

        // Validación general al enviar el formulario de editar
        editForm.addEventListener("submit", function (event) {
            const isFormValid = Object.values(editFields).every(field => field.validate());
            if (!isFormValid) {
                event.preventDefault();
            }
        });

        // Función para alternar clases de validación y mensajes de error
        function toggleValidity(element, isValid, message) {
            if (isValid) {
                element.setCustomValidity("");
                element.classList.add("is-valid");
                element.classList.remove("is-invalid");
            } else {
                element.setCustomValidity(message);
                element.classList.add("is-invalid");
                element.classList.remove("is-valid");
            }
        }

        // Función para campos requeridos
        function checkRequired(element, message) {
            const isValid = element.value.trim() !== "";
            toggleValidity(element, isValid, message);
            return isValid;
        }
    });

    // Código para permitir que la búsqueda funcione, poniendo al menos un campo seleccionado
    function toggleButton() {
        const nombre = document.getElementById("nombre").value.trim();
        const marca = document.getElementById("brandId-B").value; // Cambiado a brandId
        const searchButton = document.getElementById("searchButton");

        // Habilita el botón si al menos uno de los campos tiene un valor
        searchButton.disabled = !(nombre || marca);
    }

    document.getElementById('editRepuestoModal').addEventListener('hidden.bs.modal', function () {
        const backdrop = document.querySelector('.modal-backdrop');
        if (backdrop) {
            backdrop.remove();
        }
    });

    // Llenar el modal de edición con los datos del repuesto seleccionado
    function loadEditModal(event) {
        const button = event.currentTarget; // Botón que activó el modal

        // Extraer los valores de los atributos data-*
        const id = button.getAttribute('data-id');
        const name = button.getAttribute('data-name');
        const description = button.getAttribute('data-description');
        const compatibilityType = button.getAttribute('data-compatibilityType');
        const categoryId = button.getAttribute('data-categoryId');
        const brandId = button.getAttribute('data-brandId');
        const entryDate = button.getAttribute('data-entryDate');

        // Asignar los valores a los campos del modal
        document.getElementById('edit-id').value = id;
        document.getElementById('edit-name').value = name;
        document.getElementById('edit-description').value = description;
        document.getElementById('edit-compatibilityType').value = compatibilityType;
        document.getElementById('editCategoryId').value = categoryId;
        document.getElementById('editBrandId').value = brandId;
        document.getElementById('edit-entryDate').value = entryDate;

        // Mostrar el modal
        new bootstrap.Modal(document.getElementById('editRepuestoModal')).show();
    }

    function downloadPDFWithBrowserPrint() {
        window.print();
    }
    document.querySelector('#browserPrint').addEventListener('click', downloadPDFWithBrowserPrint);

    function exportTableToExcel(tableID, filename = '') {
        // Obtener la tabla original
        let table = document.getElementById(tableID);
        // Clonar la tabla para modificarla sin afectar el DOM
        let clonedTable = table.cloneNode(true);
        // Eliminar la última columna (Acciones) de la tabla clonada
        Array.from(clonedTable.rows).forEach(row => {
            if (row.cells.length > 0) {
                row.deleteCell(row.cells.length - 1); // Eliminar última celda
            }
        });
        // Crear el libro de Excel a partir de la tabla modificada
        let wb = XLSX.utils.table_to_book(clonedTable, { sheet: "Sheet1" });
        // Guardar el archivo Excel
        XLSX.writeFile(wb, filename ? filename + '.xlsx' : 'Repuestos.xlsx');
    }


    // Establecer la fecha máxima al cargar la página
    document.addEventListener('DOMContentLoaded', function() {
        const today = new Date().toISOString().split('T')[0];
        // Establecer max para ambos elementos por separado
        document.getElementById('entryDate').setAttribute('max', today);
        document.getElementById('edit-entryDate').setAttribute('max', today);
    });
</script>
</body>
</html>