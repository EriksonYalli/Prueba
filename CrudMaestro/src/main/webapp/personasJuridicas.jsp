<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="es">
<head>
    <title>Clientes Jurídicos Activos</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function confirmarEliminacion(id) {
            const swalWithBootstrapButtons = Swal.mixin({
                customClass: {
                    confirmButton: 'btn btn-success',
                    cancelButton: 'btn btn-danger'
                },
                buttonsStyling: false
            });
            swalWithBootstrapButtons.fire({
                title: "¿Está seguro?",
                text: "¡Esta acción no se puede revertir!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Sí, eliminar",
                cancelButtonText: "No, cancelar",
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById('deleteForm_' + id).submit();
                    swalWithBootstrapButtons.fire(
                        "¡Eliminado!",
                        "El cliente ha sido eliminado.",
                        "success"
                    );
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    swalWithBootstrapButtons.fire(
                        "Cancelado",
                        "La acción ha sido cancelada.",
                        "error"
                    );
                }
            });
        }

        function confirmarAgregarCliente(formId) {
            Swal.fire({
                title: "¿Está seguro?",
                text: "¿Desea agregar este cliente?",
                icon: "question",
                showCancelButton: true,
                confirmButtonText: "Sí, agregar",
                cancelButtonText: "No, cancelar",
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    document.getElementById(formId).submit();
                    Swal.fire(
                        "¡Agregado!",
                        "El cliente ha sido agregado exitosamente.",
                        "success"
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

        function toggleEditForm(clientId) {
            // Toggle display of the edit form modal
            const editModal = document.getElementById('editClientModal_' + clientId);
            editModal.style.display = editModal.style.display === 'none' ? 'block' : 'none';
        }

        function submitEditForm(formId) {
            document.getElementById(formId).submit();
        }
    </script>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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

        .button-container {
            display: flex;
            justify-content: flex-start; /* Alinea los botones a la izquierda */
            gap: 10px; /* Espacio entre los botones */
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
        <h1>Clientes Jurídicos Activos</h1>
        <!-- Contenedor para los botones -->
        <div class="button-container mb-3">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addClientModal">Agregar Cliente</button>
            <a href="${pageContext.request.contextPath}/exportarPersonasJuridicasPDF" class="btn btn-danger">
                <i class="fas fa-file-pdf me-2"></i> Exportar PDF
            </a>
            <div class="btn-group">
                <a href="/exportarPersonasJuridicasCSV" class="btn btn-primary btn-icon">
                    <i class="fas fa-file-csv"></i> Exportar CSV
                </a>
                <a href="/exportarPersonasJuridicasXLS" class="btn btn-success btn-icon" style="margin-left: 10px;">
                    <i class="fas fa-file-excel"></i> Exportar XLS
                </a>
            </div>
        </div>


        <table class="table table-bordered">
            <!-- Modal para agregar cliente -->
            <div class="modal fade" id="addClientModal" tabindex="-1" role="dialog" aria-labelledby="addClientModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addClientModalLabel">Agregar Cliente</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>


                        </div>
                        <div class="modal-body">
                            <form id="clientForm" onsubmit="event.preventDefault(); confirmarAgregarCliente('clientForm');" method="post" action="${pageContext.request.contextPath}/agregarCliente">
                                <div class="form-group">
                                    <label for="typePerson">Tipo de Persona</label>
                                    <select id="typePerson" name="typePerson" class="form-control" onchange="toggleFields()" required>
                                        <option value="">Seleccione</option>
                                        <option value="NATURAL">Natural</option>
                                        <option value="JURIDICA">Jurídica</option>
                                    </select>
                                </div>

                                <!-- Sección de campos para Cliente Natural -->
                                <div id="personaNaturalFields" style="display:none;">
                                    <h5>Datos de Cliente Natural</h5>
                                    <div class="form-group">
                                        <label for="name">Nombre:</label>
                                        <input type="text" name="name" id="name" class="form-control"  pattern="[A-Za-z\s]+" title="Solo se permiten letras y espacios">
                                    </div>
                                    <div class="form-group">
                                        <label for="lastName">Apellido:</label>
                                        <input type="text" name="lastName" id="lastName" class="form-control"  pattern="[A-Za-z\s]+" title="Solo se permiten letras y espacios">
                                    </div>
                                    <div class="form-group">
                                        <label for="documentType">Tipo de Documento:</label>
                                        <select name="documentType" class="form-control" id="documentType" >
                                            <option value="">Seleccione</option>
                                            <option value="DNI">DNI</option>
                                            <option value="CNE">CE</option>
                                            <option value="Pasaporte">Pasaporte</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="documentNumber">N° Documento:</label>
                                        <input type="text" name="documentNumber" id="documentNumber" class="form-control"  pattern="\d+" title="Solo se permiten números">
                                    </div>
                                    <div class="form-group">
                                        <label for="birthdate">F. Nacimiento:</label>
                                        <input type="date" name="birthdate" id="birthdate" class="form-control" >
                                    </div>
                                    <div class="form-group">
                                        <label for="persona_email">Email:</label>
                                        <input type="email" name="persona_email" id="persona_email" class="form-control"  pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" title="Formato de correo inválido. Ejemplo: usuario@dominio.com">
                                    </div>
                                    <div class="form-group">
                                        <label for="persona_phone">Teléfono:</label>
                                        <input type="text" name="persona_phone" id="persona_phone" class="form-control"  pattern="\d+" title="Solo se permiten números">
                                    </div>
                                    <!-- Nuevos campos para la dirección -->
                                    <div class="form-group">
                                        <label for="persona_address">Dirección:</label>
                                        <input type="text" name="persona_address" id="persona_address" class="form-control" >
                                    </div>
                                </div>

                                <!-- Sección de campos para Cliente Jurídico -->
                                <div id="personaJuridicaFields" style="display:none;">
                                    <h5>Datos de Cliente Jurídico</h5>
                                    <div class="form-group">
                                        <label for="companyName">Razón Social:</label>
                                        <input type="text" name="companyName" id="companyName" class="form-control" >
                                    </div>
                                    <div class="form-group">
                                        <label for="ruc">RUC:</label>
                                        <input type="text" name="ruc" id="ruc" class="form-control"  pattern="\d{11}" title="Debe tener 11 dígitos">
                                    </div>

                                    <div class="form-group">
                                        <label for="juridica_email">Email:</label>
                                        <input type="email" name="juridica_email" id="juridica_email" class="form-control"  pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" title="Formato de correo inválido. Ejemplo: usuario@dominio.com">
                                    </div>
                                    <div class="form-group">
                                        <label for="juridica_phone">Teléfono:</label>
                                        <input type="text" name="juridica_phone" id="juridica_phone" class="form-control"  pattern="\d+" title="Solo se permiten números">
                                    </div>
                                    <!-- Nuevos campos para la dirección -->
                                    <div class="form-group">
                                        <label for="juridica_address">Dirección:</label>
                                        <input type="text" name="juridica_address" id="juridica_address" class="form-control" >
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary">Agregar Cliente</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row mb-3">
                <div class="col-md-4">
                    <input id="searchClient" type="text" class="form-control" placeholder="Buscar por nombre de empresa 🏤">
                </div>
                <div class="col-md-4">
                    <input id="searchClientEmail" type="text" class="form-control" placeholder="Buscar por Email 📧">
                </div>
                <div class="col-md-4 d-flex justify-content-end">
                    <!-- Botón para limpiar los filtros -->
                    <button id="clearFilters" class="btn btn-secondary">
                        Limpiar Filtros
                    </button>
                </div>
            </div>

            <table class="table table-striped" id="appointmentsTable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>T. Persona</th>
                    <th>Razón Social</th>
                    <th>RUC</th>
                    <th>Dirección</th>
                    <th>Teléfono</th>
                    <th>Email</th>
                    <th>Estado</th>
                    <th>Acciones</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="cliente" items="${personasJuridicas}">
                    <tr>
                        <td>${cliente.id}</td>
                        <td>${cliente.typePerson}</td>
                        <td>${cliente.companyName}</td>
                        <td>${cliente.ruc}</td>
                        <td>${cliente.address}</td>
                        <td>${cliente.phone}</td>
                        <td>${cliente.email}</td>
                        <td>${cliente.status}</td>
                        <td>
                            <button type="button" class="btn btn-primary" onclick="toggleEditForm(${cliente.id})">Editar</button>

                            <form id="deleteForm_${cliente.id}" action="${pageContext.request.contextPath}/eliminarCliente" method="post" style="display:inline;">
                                <input type="hidden" name="id" value="${cliente.id}">
                                <button type="button" class="btn btn-danger" onclick="confirmarEliminacion(${cliente.id})">Eliminar</button>
                            </form>


                            <!-- Edit client modal -->
                            <div id="editClientModal_${cliente.id}" class="modal" style="display:none;">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Editar Cliente Jurídico</h5>
                                            <button type="button" class="btn-close" onclick="toggleEditForm(${cliente.id})"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form id="clientForm" onsubmit="event.preventDefault(); confirmarAgregarCliente('clientForm');" method="post" action="${pageContext.request.contextPath}/agregarCliente">
                                                <div class="form-group">
                                                    <label for="typePerson">Tipo de Persona</label>
                                                    <select id="typePerson" name="typePerson" class="form-control" onchange="toggleFields()" required>
                                                        <option value="">Seleccione</option>
                                                        <option value="NATURAL">Natural</option>
                                                        <option value="JURIDICA">Jurídica</option>
                                                    </select>
                                                </div>

                                                <!-- Sección de campos para Cliente Natural -->
                                                <div id="personaNaturalFields" style="display:none;">
                                                    <h5>Datos de Cliente Natural</h5>
                                                    <div class="form-group">
                                                        <label for="name">Nombre:</label>
                                                        <input type="text" name="name" id="name" class="form-control"  pattern="[A-Za-z\s]+" title="Solo se permiten letras y espacios">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="lastName">Apellido:</label>
                                                        <input type="text" name="lastName" id="lastName" class="form-control"  pattern="[A-Za-z\s]+" title="Solo se permiten letras y espacios">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="documentType">Tipo de Documento:</label>
                                                        <select name="documentType" class="form-control" id="documentType" >
                                                            <option value="">Seleccione</option>
                                                            <option value="DNI">DNI</option>
                                                            <option value="CNE">CE</option>
                                                            <option value="Pasaporte">Pasaporte</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="documentNumber">N° Documento:</label>
                                                        <input type="text" name="documentNumber" id="documentNumber" class="form-control"  pattern="\d+" title="Solo se permiten números">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="birthdate">F. Nacimiento:</label>
                                                        <input type="date" name="birthdate" id="birthdate" class="form-control"  onchange="validateAge()">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="persona_email">Email:</label>
                                                        <input type="email" name="persona_email" id="persona_email" class="form-control"  pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" title="Formato de correo inválido. Ejemplo: usuario@dominio.com">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="persona_phone">Teléfono:</label>
                                                        <input type="text" name="persona_phone" id="persona_phone" class="form-control"  pattern="\d+" title="Solo se permiten números">
                                                    </div>
                                                    <!-- Nuevos campos para la dirección -->
                                                    <div class="form-group">
                                                        <label for="persona_address">Dirección:</label>
                                                        <input type="text" name="persona_address" id="persona_address" class="form-control" >
                                                    </div>
                                                </div>

                                                <!-- Sección de campos para Cliente Jurídico -->
                                                <div id="personaJuridicaFields" style="display:none;">
                                                    <h5>Datos de Cliente Jurídico</h5>
                                                    <div class="form-group">
                                                        <label for="companyName">Razón Social:</label>
                                                        <input type="text" name="companyName" id="companyName" class="form-control" >
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="ruc">RUC:</label>
                                                        <input type="text" name="ruc" id="ruc" class="form-control"  pattern="\d{11}" title="Debe tener 11 dígitos">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="juridica_contact">Persona de Contacto:</label>
                                                        <input type="text" name="juridica_contact" id="juridica_contact" class="form-control"  pattern="[A-Za-z\s]+" title="Solo se permiten letras y espacios">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="juridica_email">Email:</label>
                                                        <input type="email" name="juridica_email" id="juridica_email" class="form-control"  pattern="[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}" title="Formato de correo inválido. Ejemplo: usuario@dominio.com">
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="juridica_phone">Teléfono:</label>
                                                        <input type="text" name="juridica_phone" id="juridica_phone" class="form-control"  pattern="\d+" title="Solo se permiten números">
                                                    </div>
                                                    <!-- Nuevos campos para la dirección -->
                                                    <div class="form-group">
                                                        <label for="juridica_address">Dirección:</label>
                                                        <input type="text" name="juridica_address" id="juridica_address" class="form-control" >
                                                    </div>
                                                </div>

                                                <button type="submit" class="btn btn-primary">Agregar Cliente</button>
                                            </form>
                                        </div>


                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-secondary" onclick="toggleEditForm(${cliente.id})">Cancelar</button>
                                            <button type="button" class="btn btn-primary" onclick="submitEditForm('editForm_${cliente.id}')">Guardar</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>

            </table>
        </table>
    </div>
</div>

<!-- Bootstrap JS -->
<script>
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
    document.getElementById("searchClientEmail").addEventListener("input", function () {
        let filter = this.value.toLowerCase();
        let rows = document.querySelectorAll("#appointmentsTable tbody tr");

        rows.forEach(row => {
            let workerCell = row.cells[6].textContent.toLowerCase();
            row.style.display = workerCell.includes(filter) ? "" : "none";
        });
    });

    // Función para limpiar filtros y restaurar la tabla completa
    document.getElementById("clearFilters").addEventListener("click", function () {
        // Limpiar los campos de búsqueda
        document.getElementById("searchClient").value = "";
        document.getElementById("searchWorker").value = "";

        // Mostrar todas las filas de la tabla
        let rows = document.querySelectorAll("#appointmentsTable tbody tr");
        rows.forEach(row => {
            row.style.display = ""; // Restaura la visibilidad
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>