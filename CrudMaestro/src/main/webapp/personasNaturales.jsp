<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clientes Naturales Activos</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

    <script>
        function confirmarEliminacion(id) {
            Swal.fire({
                title: "¿Está seguro?",
                text: "¡No podrá revertir esto!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Sí, eliminarlo"
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('deleteForm_' + id).submit();
                    Swal.fire(
                        '¡Eliminado!',
                        'El cliente ha sido eliminado.',
                        'success'
                    );
                }
            });
        }

        function confirmarAgregarRegistro(formId) {
            Swal.fire({
                title: "¿Está seguro?",
                text: "¿Desea agregar este cliente?",
                icon: "question",
                showCancelButton: true,
                confirmButtonColor: "#3085d6",
                cancelButtonColor: "#d33",
                confirmButtonText: "Sí, agregar"
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById(formId).submit();
                    Swal.fire(
                        '¡Agregado!',
                        'El cliente ha sido agregado.',
                        'success'
                    );
                }
            });
        }

        function toggleFields() {
            const tipoCliente = document.getElementById("typePerson").value;
            const personaNaturalFields = document.getElementById("personaNaturalFields");
            const personaJuridicaFields = document.getElementById("personaJuridicaFields");

            if (tipoCliente === "NATURAL") {
                personaNaturalFields.style.display = "block";
                personaJuridicaFields.style.display = "none";
            } else if (tipoCliente === "JURIDICA") {
                personaNaturalFields.style.display = "none";
                personaJuridicaFields.style.display = "block";
            } else {
                personaNaturalFields.style.display = "none";
                personaJuridicaFields.style.display = "none";
            }
        }

        // Agregar después de las funciones existentes
        function validateAge() {
            const birthdateInput = document.getElementById("birthdate");
            const birthdate = new Date(birthdateInput.value);
            const today = new Date();
            let age = today.getFullYear() - birthdate.getFullYear();
            const monthDiff = today.getMonth() - birthdate.getMonth();

            // Si la fecha de cumpleaños es mayor que la fecha actual, resta un año
            if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthdate.getDate())) {
                age--;
            }

            // Verificar si la persona tiene menos de 18 años
            if (age < 18) {
                alert("Debes ser mayor de 18 años.");
                birthdateInput.value = ""; // Limpia el campo
            }
        }


    </script>

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

        /* Espaciado en el contenedor principal */
        .content {
            padding: 30px; /* Espaciado interno */
        }
        /* Espaciado entre elementos del menú */
        .nav-item {
            margin-bottom: 15px; /* Espacio entre opciones del menú */
        }
        /* Estilo general para botones */
        button {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            border-radius: 5px;
            transition: background-color 0.3s, transform 0.2s;
        }


    </style>
</head>
<body onload="toggleFields()">
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
        <h1>Clientes Naturales Activos</h1>
        <!-- Botón para agregar nuevo cliente -->
        <!-- Contenedor para los botones -->
        <div class="button-container mb-3">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#agregarClienteModal">Agregar Cliente</button>

            <a href="${pageContext.request.contextPath}/exportarClientesPDF" class="btn btn-danger"> <!-- Botón rojo -->
                <i class="fas fa-file-pdf me-2"></i> Exportar PDF
            </a>

            <div class="btn-group">
                <a href="/exportarClientesCSV" class="btn btn-primary btn-icon">
                    <i class="fas fa-file-csv"></i> Exportar CSV
                </a>
                <a href="/exportarClientesXLS" class="btn btn-success btn-icon" style="margin-left: 10px;"> <!-- Margen para separación -->
                    <i class="fas fa-file-excel"></i> Exportar XLS
                </a>
            </div>
        </div>

        <!-- Campos de búsqueda y botón "Limpiar Filtros" -->
        <div class="row mb-3">
            <div class="col-md-4">
                <input id="searchClient" type="text" class="form-control" placeholder="Buscar por nombre 🙇‍♂️">
            </div>
            <div class="col-md-4">
                <input id="searchClientDNI" type="text" class="form-control" placeholder="Buscar por DNI 📃">
            </div>
            <div class="col-md-4 d-flex justify-content-end">
                <!-- Botón para limpiar los filtros -->
                <button id="clearFilters" class="btn btn-secondary">
                    Limpiar Filtros
                </button>
            </div>
        </div>


        <table class="table table-bordered" id="appointmentsTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>Tipo de persona</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Tipo de Documento</th>
                <th>N° Documento</th>
                <th>F. Nacimiento</th>
                <th>Teléfono</th>
                <th>Dirección</th>
                <th>Email</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <c:if test="${empty personasNaturales}">
                <tr>
                    <td colspan="12">No hay clientes naturales activos disponibles.</td>
                </tr>
            </c:if>
            <c:forEach var="cliente" items="${personasNaturales}">
                <tr>
                    <td>${cliente.id}</td>
                    <td>${cliente.typePerson}</td>
                    <td>${cliente.name}</td>
                    <td>${cliente.lastName}</td>
                    <td>${cliente.documentType}</td>
                    <td>${cliente.documentNumber}</td>
                    <td>${cliente.birthdate}</td>
                    <td>${cliente.phone}</td>
                    <td>${cliente.address}</td>
                    <td>${cliente.email}</td>
                    <td>${cliente.status}</td>
                    <td>
                        <a href="${pageContext.request.contextPath}/editarCliente?id=${cliente.id}" class="btn btn-warning btn-sm">Editar</a>
                        <form id="deleteForm_${cliente.id}" action="${pageContext.request.contextPath}/eliminarCliente"
                              method="post" style="display: inline;">
                            <input type="hidden" name="id" value="${cliente.id}">
                            <input type="hidden" name="tipo" value="natural">
                            <a href="javascript:void(0);" onclick="confirmarEliminacion(${cliente.id})" class="btn btn-danger btn-sm">Eliminar</a>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Modal para agregar cliente -->
<div class="modal fade" id="agregarClienteModal" tabindex="-1" role="dialog" aria-labelledby="agregarClienteModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="agregarClienteModalLabel">Agregar Cliente</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="clienteForm" action="${pageContext.request.contextPath}/agregarCliente" method="post">
                    <div class="mb-3">
                        <label for="typePerson" class="form-label">Tipo de Persona</label>
                        <select id="typePerson" name="typePerson" class="form-select" onchange="toggleFields()">
                            <option value="">Seleccione</option>
                            <option value="NATURAL">Natural</option>
                            <option value="JURIDICA">Jurídica</option>
                        </select>
                    </div>

                    <div id="personaNaturalFields" style="display:none;">
                        <h5>Datos de Cliente Natural</h5>
                        <div class="mb-3">
                            <label for="name" class="form-label">Nombre</label>
                            <input type="text" class="form-control" name="name" id="name"
                                   pattern="[A-Za-z\s]+"
                                   title="Solo se permiten letras y espacios"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label for="lastName" class="form-label">Apellido</label>
                            <input type="text" class="form-control" name="lastName" id="lastName"
                                   pattern="[A-Za-z\s]+"
                                   title="Solo se permiten letras y espacios"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label for="documentType" class="form-label">Tipo de Documento</label>
                            <select name="documentType" class="form-select" id="documentType" required>
                                <option value="">Seleccione</option>
                                <option value="DNI">DNI</option>
                                <option value="CNE">CE</option>
                                <option value="Pasaporte">Pasaporte</option>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="documentNumber" class="form-label">N° Documento</label>
                            <input type="text" class="form-control" name="documentNumber" id="documentNumber"
                                   pattern="\d+"
                                   title="Solo se permiten números"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label for="birthdate" class="form-label">F. Nacimiento</label>
                            <input type="date" class="form-control" name="birthdate" id="birthdate"
                                   onchange="validateAge()"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label for="persona_phone" class="form-label">Teléfono</label>
                            <input type="text" class="form-control" name="persona_phone" id="persona_phone"
                                   pattern="\d+"
                                   title="Solo se permiten números"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label for="persona_address" class="form-label">Dirección</label>
                            <input type="text" class="form-control" name="persona_address" id="persona_address"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label for="persona_email" class="form-label">Email</label>
                            <input type="email" class="form-control" name="persona_email" id="persona_email"
                                   pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"
                                   title="Formato de correo inválido. Ejemplo: usuario@dominio.com"
                                   required>
                        </div>
                    </div>

                    <div id="personaJuridicaFields" style="display:none;">
                        <h5>Datos de Cliente Jurídico</h5>
                        <div class="mb-3">
                            <label for="companyName" class="form-label">Razón Social</label>
                            <input type="text" class="form-control" name="companyName" id="companyName"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label for="ruc" class="form-label">RUC</label>
                            <input type="text" class="form-control" name="ruc" id="ruc"
                                   pattern="\d{11}"
                                   title="Debe tener 11 dígitos"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label for="juridica_phone" class="form-label">Teléfono</label>
                            <input type="text" class="form-control" name="juridica_phone" id="juridica_phone"
                                   pattern="\d{9}"
                                   title="Solo se permiten 9 números"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label for="juridica_address" class="form-label">Dirección</label>
                            <input type="text" class="form-control" name="juridica_address" id="juridica_address"
                                   required>
                        </div>
                        <div class="mb-3">
                            <label for="juridica_email" class="form-label">Email</label>
                            <input type="email" class="form-control" name="juridica_email" id="juridica_email"
                                   pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}"
                                   title="Formato de correo inválido. Ejemplo: usuario@dominio.com"
                                   required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" onclick="confirmarAgregarRegistro('clienteForm')">Agregar Cliente</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>

    // Función para filtrar por cliente o empresa
    document.getElementById("searchClient").addEventListener("input", function () {
        let filter = this.value.toLowerCase();
        let rows = document.querySelectorAll("#appointmentsTable tbody tr");

        rows.forEach(row => {
            let clientCell = row.cells[2].textContent.toLowerCase();
            row.style.display = clientCell.includes(filter) ? "" : "none";
        });
    });

    // Función para filtrar por trabajador
    document.getElementById("searchClientDNI").addEventListener("input", function () {
        let filter = this.value.toLowerCase();
        let rows = document.querySelectorAll("#appointmentsTable tbody tr");

        rows.forEach(row => {
            let workerCell = row.cells[5].textContent.toLowerCase();
            row.style.display = workerCell.includes(filter) ? "" : "none";
        });
    });

    // Función para limpiar filtros y restaurar la tabla completa
    document.getElementById("clearFilters").addEventListener("click", function () {
        // Limpiar los campos de búsqueda
        document.getElementById("searchClient").value = "";
        document.getElementById("searchClientEmail").value = "";

        // Mostrar todas las filas de la tabla
        let rows = document.querySelectorAll("#appointmentsTable tbody tr");
        rows.forEach(row => {
            row.style.display = ""; // Restaura la visibilidad
        });
    });

</script>

</body>
</html>