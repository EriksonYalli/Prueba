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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Montserrat', sans-serif;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
            font-family: Arial, sans-serif;
        }
        .table thead {
            background-color: #f5f5f5;
            color: #333;
            font-weight: bold;
            text-align: left;
        }
        .table th, .table td {
            padding: 12px 15px;
            border-bottom: 1px solid #ddd;
        }
        .table tbody tr:hover {
            background-color: #f9f9f9;
        }
        .table .btn {
            padding: 6px 10px;
            font-size: 0.875rem;
            border-radius: 4px;
        }
        .btn-primary {
            color: #fff;
            background-color: #007bff;
            border: none;
        }
        .btn-danger {
            color: #fff;
            background-color: #dc3545;
            border: none;
        }
        .badge {
            font-size: 0.75rem;
            padding: 5px 10px;
            border-radius: 4px;
        }
        .bg-secondary {
            --bs-bg-opacity: 1;
            background-color: #28a745 !important;
        }
        th, td {
            text-align: center;
            vertical-align: middle;
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
        .description-field {
            height: 150px;
            resize: none;
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
            background-color: #ff5722; /* Color de fondo */
            color: white; /* Color del texto */
        }

        .btn-custom:hover {
            border: 2px solid black;
            background-color: white;
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
        }

    </style>
</head>
<body class="container">

<h1 class="text-center my-4">Lista de Repuestos</h1>

<div class="Busqueda mb-1">
    <form action="${pageContext.request.contextPath}/listar" method="get" class="d-flex" onsubmit="return validateForm()">
        <input type="text" id="nombre" name="nombre" class="form-control me-2" placeholder="Nombre del repuesto" aria-label="Nombre del repuesto" oninput="toggleButton()"/>

        <label for="brand" class="form-label me-2">Marca:</label>
        <select id="marca" name="marca" class="form-select me-2" onchange="toggleButton()">
            <option value="">Seleccione una marca</option>
            <option value="Toyota">Toyota</option>
            <option value="Honda">Honda</option>
            <option value="Ford">Ford</option>
            <option value="Chevrolet">Chevrolet</option>
            <option value="Nissan">Nissan</option>
            <option value="BMW">BMW</option>
            <option value="Audi">Audi</option>
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

<!-- Botón para exportar la tabla a Excel -->
<button class="btn btn-success float-end me-2" onclick="exportTableToExcel('partsTable', 'Repuestos')">
    <i class="bi bi-file-earmark-spreadsheet"></i> Exportar a Excel
</button>

<!-- Botón para imprimir o descargar como PDF -->
<button id="browserPrint" class="btn btn-custom float-end me-2">
    <i class="bi bi-file-earmark-pdf"></i> Descargar PDF
</button>

<!-- Modal para agregar repuesto -->
<div class="modal fade" id="addRepuestoModal" tabindex="-1" aria-labelledby="addRepuestoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addRepuestoModalLabel">Agregar Nuevo Repuesto</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="addRepuestoForm" action="/create" method="post" novalidate>
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="name" class="form-label">Nombre:</label>
                        <input type="text" id="name" name="name" class="form-control" required>
                        <div class="invalid-feedback">El nombre es obligatorio.</div>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Descripción:</label>
                        <textarea id="description" name="description" class="form-control" required></textarea>
                        <div class="invalid-feedback">La descripción es obligatoria.</div>
                    </div>
                    <div class="mb-3">
                        <label for="priceUnit" class="form-label">Precio:</label>
                        <input type="number" step="0.10" id="priceUnit" name="priceUnit" class="form-control" required>
                        <div class="invalid-feedback">El precio es obligatorio y debe ser un número positivo.</div>
                    </div>
                    <div class="mb-3">
                        <label for="brand" class="form-label">Marca:</label>
                        <select id="brand" name="brand" class="form-control" required>
                            <option value="">Seleccione una marca</option>
                            <option value="Toyota">Toyota</option>
                            <option value="Honda">Honda</option>
                            <option value="Ford">Ford</option>
                            <option value="Chevrolet">Chevrolet</option>
                            <option value="Nissan">Nissan</option>
                            <option value="BMW">BMW</option>
                            <option value="Audi">Audi</option>
                        </select>
                        <div class="invalid-feedback">Seleccione una marca.</div>
                    </div>
                    <div class="mb-3">
                        <label for="stock" class="form-label">Stock:</label>
                        <input type="number" id="stock" name="stock" class="form-control" required min="1">
                        <div class="invalid-feedback">El stock debe ser un número entero.</div>
                    </div>
                    <div class="mb-3">
                        <label for="compatibleModel" class="form-label">Modelo Compatible:</label>
                        <select id="compatibleModel" name="compatibleModel" class="form-control" required>
                            <option value="">Seleccione un modelo</option>
                            <option value="Original">Original</option>
                            <option value="Compatible">Compatible</option>
                        </select>
                        <div class="invalid-feedback">Seleccione un modelo compatible.</div>
                    </div>
                    <div class="mb-3">
                        <label for="entryDate" class="form-label">Fecha de Entrada:</label>
                        <input type="date" id="entryDate" name="entryDate" class="form-control" required>
                        <div class="invalid-feedback">La fecha de entrada es obligatoria.</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary">Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<div id="printableArea">
    <!-- Lista de Repuestos -->
    <table class="table mt-4" id="partsTable">
        <thead>
        <tr>
            <th>ID</th>
            <th>NOMBRE</th>
            <th>DESCRIPCIÓN</th>
            <th>PRECIO</th>
            <th>MARCA</th>
            <th>STOCK</th>
            <th>MODELO COMPATIBLE</th>
            <th>FECHA DE ENTRADA</th>
            <th>ESTADO</th>
            <th>ACCIONES</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="repuesto" items="${parts}">
            <tr>
                <td>${repuesto.id}</td>
                <td>${repuesto.name}</td>
                <td>${repuesto.description}</td>
                <td>S/. <fmt:formatNumber value="${repuesto.priceUnit}" pattern="#,##0.00"/></td>
                <td>${repuesto.brand}</td>
                <td>${repuesto.stock}</td>
                <td>${repuesto.compatibleModel}</td>
                <td><fmt:formatDate value="${repuesto.entryDate}" pattern="dd-MMM-yyyy"/></td>
                <td>
                    <span class="badge bg-secondary">${repuesto.state}</span>
                </td>
                <td>
                    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#editModal"
                            data-id="${repuesto.id}" data-name="${repuesto.name}" data-description="${repuesto.description}"
                            data-price="${repuesto.priceUnit}" data-brand="${repuesto.brand}" data-stock="${repuesto.stock}"
                            data-model="${repuesto.compatibleModel}" data-date="${repuesto.entryDate}">
                        <i class="bi bi-pencil"></i> <!-- Ícono de lápiz de Bootstrap -->
                    </button>
                    <form action="/eliminar" method="post" style="display: inline;" onsubmit="return confirm('¿Estás seguro de que quieres eliminar este repuesto?');">
                        <input type="hidden" name="id" value="${repuesto.id}">
                        <button type="submit" class="btn btn-danger">
                            <i class="bi bi-trash"></i> <!-- Ícono de papelera de Bootstrap -->
                        </button>
                    </form>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- Modal para editar repuesto -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">Editar Repuesto</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form id="editRepuestoForm" action="/editar" method="post" novalidate>
                <div class="modal-body">
                    <input type="hidden" id="edit-id" name="id">
                    <div class="mb-3">
                        <label for="edit-name" class="form-label">Nombre:</label>
                        <input type="text" id="edit-name" name="name" class="form-control" required>
                        <div class="invalid-feedback">El nombre es obligatorio.</div>
                    </div>
                    <div class="mb-3">
                        <label for="edit-description" class="form-label">Descripción:</label>
                        <textarea id="edit-description" name="description" class="form-control" required></textarea>
                        <div class="invalid-feedback">La descripción es obligatoria.</div>
                    </div>
                    <div class="mb-3">
                        <label for="edit-priceUnit" class="form-label">Precio:</label>
                        <input type="number" step="0.10" id="edit-priceUnit" name="priceUnit" class="form-control" required>
                        <div class="invalid-feedback">El precio es obligatorio y debe ser un número positivo.</div>
                    </div>
                    <div class="mb-3">
                        <label for="edit-brand" class="form-label">Marca:</label>
                        <select id="edit-brand" name="brand" class="form-control" required>
                            <option value="">Seleccione una marca</option>
                            <option value="Toyota">Toyota</option>
                            <option value="Honda">Honda</option>
                            <option value="Ford">Ford</option>
                            <option value="Chevrolet">Chevrolet</option>
                            <option value="Nissan">Nissan</option>
                            <option value="BMW">BMW</option>
                            <option value="Audi">Audi</option>
                        </select>
                        <div class="invalid-feedback">Seleccione una marca.</div>
                    </div>
                    <div class="mb-3">
                        <label for="edit-stock" class="form-label">Stock:</label>
                        <input type="number" id="edit-stock" name="stock" class="form-control" required min="1">
                        <div class="invalid-feedback">El stock debe ser un número entero y mayor que cero.</div>
                    </div>
                    <div class="mb-3">
                        <label for="edit-compatibleModel" class="form-label">Modelo Compatible:</label>
                        <select id="edit-compatibleModel" name="compatibleModel" class="form-control" required>
                            <option value="">Seleccione un modelo</option>
                            <option value="Original">Original</option>
                            <option value="Compatible">Compatible</option>
                        </select>
                        <div class="invalid-feedback">Seleccione un modelo compatible.</div>
                    </div>
                    <div class="mb-3">
                        <label for="edit-entryDate" class="form-label">Fecha de Entrada:</label>
                        <input type="date" id="edit-entryDate" name="entryDate" class="form-control" required>
                        <div class="invalid-feedback">La fecha de entrada es obligatoria.</div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" class="btn btn-primary">Actualizar</button>
                </div>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Validación para agregar repuesto
        const addForm = document.getElementById("addRepuestoForm");
        const addFields = {
            priceUnit: {
                element: document.getElementById("priceUnit"),
                validate: function() {
                    const value = this.element.value;
                    const isValid = value > 0 && /^\d+(\.\d{1,2})?$/.test(value);
                    toggleValidity(this.element, isValid, "Debe ser un número mayor a cero con hasta dos decimales.");
                    return isValid;
                }
            },
            stock: {
                element: document.getElementById("stock"),
                validate: function() {
                    const value = this.element.value;
                    const isValid = /^[1-9]\d*$/.test(value);
                    toggleValidity(this.element, isValid, "Debe ser un número entero mayor a cero.");
                    return isValid;
                }
            },
            name: {
                element: document.getElementById("name"),
                validate: function() {
                    return checkRequired(this.element, "Por favor, complete este campo.");
                }
            },
            description: {
                element: document.getElementById("description"),
                validate: function() {
                    return checkRequired(this.element, "Por favor, complete este campo.");
                }
            },
            brand: {
                element: document.getElementById("brand"),
                validate: function() {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione una marca.");
                    return isValid;
                }
            },
            compatibleModel: {
                element: document.getElementById("compatibleModel"),
                validate: function() {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione un modelo compatible.");
                    return isValid;
                }
            },
            entryDate: {
                element: document.getElementById("entryDate"),
                validate: function() {
                    return checkRequired(this.element, "Ingrese una fecha válida.");
                }
            }
        };

        // Agrega eventos de entrada para validación en tiempo real
        Object.values(addFields).forEach(field => field.element.addEventListener("input", field.validate.bind(field)));
        Object.values(addFields).forEach(field => {
            if (field.element.tagName === "SELECT") {
                field.element.addEventListener("change", field.validate.bind(field));
            }
        });

        // Validación general en el envío del formulario de agregar
        addForm.addEventListener("submit", function(event) {
            const isFormValid = Object.values(addFields).every(field => field.validate());
            if (!isFormValid) {
                event.preventDefault();
            }
        });

        // Validación para editar repuesto
        const editForm = document.getElementById("editModal").querySelector("form");
        const editFields = {
            priceUnit: {
                element: document.getElementById("edit-priceUnit"),
                validate: function() {
                    const value = this.element.value;
                    const isValid = value > 0 && /^\d+(\.\d{1,2})?$/.test(value);
                    toggleValidity(this.element, isValid, "Debe ser un número mayor a cero con hasta dos decimales.");
                    return isValid;
                }
            },
            stock: {
                element: document.getElementById("edit-stock"),
                validate: function() {
                    const value = this.element.value;
                    const isValid = /^[1-9]\d*$/.test(value);
                    toggleValidity(this.element, isValid, "Debe ser un número entero mayor a cero.");
                    return isValid;
                }
            },
            name: {
                element: document.getElementById("edit-name"),
                validate: function() {
                    return checkRequired(this.element, "Por favor, complete este campo.");
                }
            },
            description: {
                element: document.getElementById("edit-description"),
                validate: function() {
                    return checkRequired(this.element, "Por favor, complete este campo.");
                }
            },
            brand: {
                element: document.getElementById("edit-brand"),
                validate: function() {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione una marca.");
                    return isValid;
                }
            },
            compatibleModel: {
                element: document.getElementById("edit-compatibleModel"),
                validate: function() {
                    const isValid = this.element.value !== "";
                    toggleValidity(this.element, isValid, "Seleccione un modelo compatible.");
                    return isValid;
                }
            },
            entryDate: {
                element: document.getElementById("edit-entryDate"),
                validate: function() {
                    return checkRequired(this.element, "Ingrese una fecha válida.");
                }
            }
        };

        // Agrega eventos de entrada para validación en tiempo real en el formulario de edición
        Object.values(editFields).forEach(field => field.element.addEventListener("input", field.validate.bind(field)));
        Object.values(editFields).forEach(field => {
            if (field.element.tagName === "SELECT") {
                field.element.addEventListener("change", field.validate.bind(field));
            }
        });

        // Validación general en el envío del formulario de editar
        editForm.addEventListener("submit", function(event) {
            const isFormValid = Object.values(editFields).every(field => field.validate());
            if (!isFormValid) {
                event.preventDefault();
            }
        });

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

        function checkRequired(element, message) {
            const isValid = element.value.trim() !== "";
            toggleValidity(element, isValid, message);
            return isValid;
        }
    });

    // Código para permitir que la búsqueda funcione, poniendo al menos un campo seleccionado
    function toggleButton() {
        const nombre = document.getElementById("nombre").value.trim();
        const marca = document.getElementById("marca").value;
        const searchButton = document.getElementById("searchButton");

        // Habilita el botón si al menos uno de los campos tiene un valor
        searchButton.disabled = !(nombre || marca);
    }

    function validateForm() {
        return !document.getElementById("searchButton").disabled;
    }
    // Fin del código para habilitar la búsqueda con al menos un campo seleccionado

    // Llenar el modal de edición con los datos del repuesto seleccionado
    const editModal = document.getElementById('editModal');
    editModal.addEventListener('show.bs.modal', event => {
        const button = event.relatedTarget; // Botón que abrió el modal
        const id = button.getAttribute('data-id');
        const name = button.getAttribute('data-name');
        const description = button.getAttribute('data-description');
        const price = button.getAttribute('data-price');
        const brand = button.getAttribute('data-brand');
        const stock = button.getAttribute('data-stock');
        const model = button.getAttribute('data-model');
        const date = button.getAttribute('data-date');

        // Actualizar los campos del modal
        document.getElementById('edit-id').value = id;
        document.getElementById('edit-name').value = name;
        document.getElementById('edit-description').value = description;
        document.getElementById('edit-priceUnit').value = price;
        document.getElementById('edit-brand').value = brand;
        document.getElementById('edit-stock').value = stock;
        document.getElementById('edit-compatibleModel').value = model;
        document.getElementById('edit-entryDate').value = date;
    });

    function downloadPDFWithBrowserPrint() {
        window.print();
    }
    document.querySelector('#browserPrint').addEventListener('click', downloadPDFWithBrowserPrint);

    function exportTableToExcel(tableID, filename = '') {
        let table = document.getElementById(tableID);
        let wb = XLSX.utils.table_to_book(table, { sheet: "Sheet1" });
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
