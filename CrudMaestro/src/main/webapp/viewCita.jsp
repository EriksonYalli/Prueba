<%@ page import="java.util.List" %>
<%@ page import="pe.edu.vallegrande.Dto.CitasDto" %>
<%@ page import="pe.edu.vallegrande.Dto.CitasDetalleDto" %>
<%@ page import="pe.edu.vallegrande.Dto.ClienteDto" %>
<%@ page import="pe.edu.vallegrande.Dto.VehicleDto" %>
<%@ page import="pe.edu.vallegrande.Dto.WorkerDto" %>
<%@ page import="pe.edu.vallegrande.Dto.ServicioDto" %>
<%@ page import="pe.edu.vallegrande.service.CitaService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Citas</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
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

        .dropdown-menu {
            background-color: #f8f9fa;
            border-radius: 5px;
            border: 1px solid #dee2e6;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .dropdown-item {
            font-size: 1rem;
            color: #495057;
            padding: 8px 15px;
            transition: all 0.3s ease-in-out;
        }

        .dropdown-item:hover {
            background-color: #e9ecef;
            color: #0d6efd;
        }

        /* Ajuste para el layout con menú */
        .page-container {
            display: flex;
        }

        .content-container {
            flex-grow: 1;
            padding: 20px;
        }

        .card {
            background-color: rgba(255, 255, 255, 0.1); /* Fondo blanco semitransparente */
            backdrop-filter: blur(10px); /* Desenfoque de fondo */
            border: 1px solid rgba(255, 255, 255, 0.3); /* Borde sutil */
            box-shadow: 0 4px 6px rgba(0, 123, 255, 0.5); /* Sombra ligera */
            border-radius: 10px; /* Bordes redondeados */
            transition: transform 0.3s, box-shadow 0.3s; /* Transiciones para hover */
        }

        .card:hover {
            transform: translateY(-5px); /* Efecto de elevación */
            box-shadow: 0 8px 15px rgba(0, 123, 255, 0.7); /* Aumentar sombra */
        }

        .modal-content {
            background-color: rgba(255, 255, 255, 0.8); /* Fondo blanco semitransparente */
            backdrop-filter: blur(15px); /* Desenfoque */
            border-radius: 15px; /* Bordes redondeados */
            border: 1px solid rgba(255, 255, 255, 0.3); /* Borde sutil */
            box-shadow: 0 8px 15px rgba(0, 0, 0, 0.2); /* Sombra */
            transition: all 0.3s ease-in-out; /* Transiciones suaves */
        }

        .modal-body {
            background-color: rgba(255, 255, 255, 0.6); /* Más transparencia para el área del cuerpo */
            padding: 20px; /* Espaciado interno */
            border-radius: 10px; /* Bordes redondeados */
            backdrop-filter: blur(10px); /* Desenfoque adicional */
            border: 1px solid rgba(255, 255, 255, 0.2); /* Borde tenue */
            box-shadow: inset 0 4px 6px rgba(0, 0, 0, 0.1); /* Sombra interior */
        }

        .modal-body .row {
            margin: 10px 0; /* Espaciado entre las filas */
        }

        /* Estilo específico para el contenedor de detalles dentro del modal */
        .details-section {
            background-color: rgba(255, 255, 255, 0.7); /* Fondo blanco semitransparente */
            backdrop-filter: blur(10px); /* Efecto borroso */
            border-radius: 10px; /* Bordes redondeados */
            padding: 15px; /* Espaciado interno */
            border: 1px solid rgba(255, 255, 255, 0.3); /* Borde sutil */
            box-shadow: inset 0 4px 6px rgba(0, 0, 0, 0.1); /* Sombra interna */
            margin-bottom: 20px; /* Separación inferior para las cartas */
        }

        /* Estilo adicional para los títulos y textos */
        .details-section strong {
            font-weight: bold;
            color: #495057;
        }
        .modal-header {
            background-color: rgba(0, 123, 255, 0.5); /* Celeste semitransparente */
            backdrop-filter: blur(5px); /* Efecto borroso */
            border-bottom: 1px solid rgba(255, 255, 255, 0.3); /* Borde sutil */
            border-radius: 15px 15px 0 0; /* Bordes redondeados en la parte superior */
            padding: 15px; /* Espaciado interno */
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1); /* Sombra ligera */
        }

        .export-buttons {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .export-btn {
            display: flex;
            align-items: center;
            gap: 5px;
            transition: all 0.3s ease;
        }

        .export-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
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
<body>
<div class="page-container">
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
    <div class="content-container">
        <div class="container-fluid">
            <div class="container-fluid d-flex justify-content-between align-items-center my-4">
                <h1>Listado de Citas</h1>

                <!-- Contenedor para los botones -->
                <div class="button-container mb-3">

                    <a href="citaForm.jsp" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Agregar Cita
                    </a>
                    <a href="${pageContext.request.contextPath}/exportarCitasPDF" class="btn btn-danger"> <!-- Botón rojo -->
                        <i class="fas fa-file-pdf me-2"></i> Exportar PDF
                    </a>

                    <div class="btn-group">
                        <a href="/exportarCitasCSV" class="btn btn-primary btn-icon">
                            <i class="fas fa-file-csv"></i> Exportar CSV
                        </a>
                        <a href="/exportarCitasXLS" class="btn btn-success btn-icon" style="margin-left: 10px;"> <!-- Margen para separación -->
                            <i class="fas fa-file-excel"></i> Exportar XLS
                        </a>
                    </div>
                </div>

                </div>
            </div>


            <!-- Campos de búsqueda y botón "Limpiar Filtros" -->
            <div class="row mb-3">
                <div class="col-md-4">
                    <input id="searchClient" type="text" class="form-control" placeholder="Buscar por cliente o empresa">
                </div>
                <div class="col-md-4">
                    <input id="searchWorker" type="text" class="form-control" placeholder="Buscar por trabajador">
                </div>
                <div class="col-md-4 d-flex justify-content-end">
                    <!-- Botón para limpiar los filtros -->
                    <button id="clearFilters" class="btn btn-secondary">
                        Limpiar Filtros
                    </button>
                </div>
            </div>

            <!-- Tabla de citas -->
            <table class="table table-bordered" id="appointmentsTable">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Fecha / Hora</th>
                    <th>Cliente</th>
                    <th>Vehículo</th>
                    <th>Trabajador</th>
                    <th>Estado</th>
                    <th>Detalles</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<CitasDto> citas = (List<CitasDto>) request.getAttribute("citas");
                    for (CitasDto cita : citas) {
                        ClienteDto cliente = cita.getCustomer();  // Cliente de la cita
                        WorkerDto trabajador = cita.getWorker();  // Trabajador de la cita
                        VehicleDto vehiculo = cita.getVehicle();  // Vehículo de la cita
                %>
                <tr>
                    <td><%= cita.getId() %></td>
                    <td><%= cita.getDate() %> / <%= cita.getHour() %></td>
                    <td>
                        <%
                            if (cliente != null) {
                                if (cliente.getTypePerson() != null && cliente.getTypePerson().equalsIgnoreCase("Jurídica")) {
                                    // Mostrar el nombre de la empresa si el cliente es una persona jurídica
                                    out.print(cliente.getCompanyName() != null ? cliente.getCompanyName() : "Sin nombre de empresa");
                                } else {
                                    // Mostrar nombre y apellido si el cliente es una persona natural
                                    out.print(cliente.getName() + " " + cliente.getLastName());
                                }
                            } else {
                                out.print("No disponible");
                            }
                        %>
                    </td>
                    <td><%= vehiculo != null ? vehiculo.getPlate() : "No disponible" %></td>
                    <td><%= trabajador != null ? trabajador.getName() : "No disponible" %></td>
                    <td><%= cita.getStatus() %></td>
                    <td>
                        <!-- Botón para abrir el modal con los detalles de la cita -->
                        <button type="button" class="btn btn-info" data-bs-toggle="modal" data-bs-target="#modalDetalles<%= cita.getId() %>">
                            Ver Detalles
                        </button>

                        <!-- Modal con detalles de la cita -->
                        <div class="modal fade" id="modalDetalles<%= cita.getId() %>" tabindex="-1" aria-labelledby="modalDetallesLabel" aria-hidden="true">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modalDetallesLabel">Detalles de la Cita</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <!-- Contenedor de detalles con estilo de fondo borroso y transparente -->
                                        <div class="details-section">
                                            <strong>Descripción:</strong> <%= cita.getDescription() %><br>
                                            <strong>Estado:</strong> <%= cita.getStatus() %><br>
                                            <strong>Diagnóstico:</strong> <%= cita.getDiagnosticResult() %><br>
                                            <strong>Tipo de Diagnóstico:</strong> <%= cita.getDiagnosisType() %><br>
                                        </div>

                                        <h6 class="mt-3">Detalles de los Servicios:</h6>
                                        <div class="row">
                                            <%
                                                List<CitasDetalleDto> detalles = cita.getDetalles();
                                                for (CitasDetalleDto detalle : detalles) {
                                                    // Obtener el servicio asociado al detalle usando el serviceId
                                                    ServicioDto servicio = CitaService.obtenerServicioPorId(detalle.getServiceId());
                                            %>
                                            <!-- Cada detalle en una tarjeta (card) -->
                                            <div class="col-md-4 mb-3">
                                                <div class="card">
                                                    <div class="card-body">
                                                        <h5 class="card-title">Servicio: <%= servicio != null ? servicio.getName() : "Desconocido" %></h5>
                                                        <p class="card-text">
                                                            <strong>Descripción:</strong> <%= detalle.getDescription() %><br>
                                                            <strong>Resultado:</strong> <%= detalle.getResult() %><br>
                                                            <strong>Costo:</strong> $<%= detalle.getCost() %><br>
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
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
        document.getElementById("searchWorker").addEventListener("input", function () {
        let filter = this.value.toLowerCase();
        let rows = document.querySelectorAll("#appointmentsTable tbody tr");

        rows.forEach(row => {
        let workerCell = row.cells[4].textContent.toLowerCase();
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

</div>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
</body>
</html>