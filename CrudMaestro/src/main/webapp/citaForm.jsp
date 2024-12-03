<%@ page import="pe.edu.vallegrande.service.CitaService" %>
<%@ page import="pe.edu.vallegrande.Dto.ClienteDto" %>
<%@ page import="java.util.List" %>
<%@ page import="pe.edu.vallegrande.Dto.WorkerDto" %>
<%@ page import="pe.edu.vallegrande.Dto.ServicioDto" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro de Cita</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
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

    </style>
</head>
<body class="d-flex">
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

<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-md-10">
            <div class="card card-custom">
                <div class="card-header bg-primary text-white">
                    <h2 class="text-center mb-0">Formulario para Registrar Cita</h2>
                </div>
                <div class="card-body">
                    <!-- Rest of the existing form code remains the same -->
                    <form action="cita" method="post" id="appointmentForm">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="cliente" class="form-label">Seleccionar Cliente</label>
                                <div class="input-group">
                                    <input type="text" class="form-control" id="searchClient"
                                           placeholder="Buscar cliente..."
                                           onkeyup="filterClients()">
                                    <select name="cliente" id="cliente" class="form-select"
                                            onchange="setClientId(this.value, this.options[this.selectedIndex].text)">
                                        <option value="">-- Selecciona un cliente --</option>
                                        <%
                                            CitaService citaService = new CitaService();
                                            List<ClienteDto> clientes = citaService.obtenerClientes();
                                            for (ClienteDto cliente : clientes) {
                                                String nombreCompleto = "Natural".equals(cliente.getTypePerson())
                                                        ? cliente.getName() + " " + cliente.getLastName()
                                                        : cliente.getCompanyName();
                                        %>
                                        <option value="<%= cliente.getId() %>"><%= nombreCompleto %></option>
                                        <% } %>
                                    </select>
                                </div>
                                <div class="mt-2">
                                    <strong>Cliente seleccionado:</strong>
                                    <span id="clientName" class="text-muted">Ninguno</span>
                                </div>
                                <input type="hidden" name="customerId" id="customerId" />
                                <input type="hidden" name="action" value="create" />
                            </div>


                            <div class="col-md-6 mb-3">
                                <label for="vehicleId" class="form-label">Vehículo</label>
                                <select name="vehicleId" id="vehicleId" class="form-select" required>
                                    <option value="">-- Selecciona un vehículo --</option>
                                </select>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="date" class="form-label">Fecha</label>
                                <input type="date" name="date" id="date" class="form-control" required
                                       min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>" />

                                <div id="dateError" class="text-danger"></div>
                            </div>

                            <div class="col-md-6 mb-3">
                                <label for="hour" class="form-label">Hora (8:00 AM - 7:00 PM)</label>
                                <input type="time" name="hour" id="hour" class="form-control" required
                                       min="08:00" max="19:00" onchange="validateTime()" />
                                <div id="timeError" class="text-danger"></div>
                            </div>
                        </div>


                        <div class="mb-3">
                            <label for="description" class="form-label">Descripción General de la Cita</label>
                            <textarea name="description" rows="3" id="description" class="form-control" required></textarea>
                        </div>


                        <div class="mb-3">
                            <label class="form-label">Trabajador</label>
                            <select name="workerId" id="workerId" class="form-select" required>
                                <option value="">-- Selecciona un trabajador --</option>
                                <%
                                    List<WorkerDto> empleados = citaService.obtenerEmpleados();
                                    for (WorkerDto empleado : empleados) {
                                %>
                                <option value="<%= empleado.getId() %>"><%= empleado.getName() %> </option>
                                <% } %>
                            </select>
                        </div>


                        <div class="card mb-3">
                            <div class="card-header bg-secondary text-white">
                                Detalles de Servicios
                                <button type="button" class="btn btn-sm btn-success float-end"
                                        onclick="addServiceDetail()">
                                    <i class="bi bi-plus"></i> Agregar Servicio
                                </button>
                            </div>
                            <div class="card-body" id="serviceDetailsContainer">
                                <!-- Initial service detail row -->
                                <div class="service-detail-row">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Servicio</label>
                                            <select name="details[][serviceId]" class="form-select serviceSelect"
                                                    onchange="updateServiceCost(this)" required>
                                                <option value="">-- Selecciona un servicio --</option>
                                                <%
                                                    List<ServicioDto> servicios = citaService.obtenerServicios();
                                                    for (ServicioDto servicio : servicios) {
                                                %>
                                                <option value="<%= servicio.getId() %>"
                                                        data-cost="<%= servicio.getCost() %>">
                                                    <%= servicio.getName() %> - $<%= String.format("%.2f", servicio.getCost()) %>
                                                </option>
                                                <% } %>
                                            </select>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Costo</label>
                                            <input type="number" step="0.01" name="details[][cost]"
                                                   class="form-control costInput" required />
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Descripción</label>
                                            <textarea name="details[][description]" class="form-control" rows="3" required></textarea>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Resultado</label>
                                            <textarea name="details[][result]" class="form-control" rows="3" required></textarea>
                                        </div>
                                    </div>
                                    <button type="button" class="btn btn-sm btn-danger float-end mb-2" onclick="removeServiceDetail(this)">
                                        Eliminar
                                    </button>


                                </div>
                            </div>
                        </div>


                        <div class="text-center">
                            <button type="submit" class="btn btn-primary btn-lg">
                                Registrar Cita
                            </button>

                            <button type="button" class="btn btn-danger btn-lg" onclick="resetForm()">
                                Cancelar
                            </button>

                            <button type="button" class="btn btn-primary btn-lg" onclick="location.href='cita?action=view'">
                                VOLVER A CITAS 📅
                            </button>



                        </div>




                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function resetForm() {
        document.getElementById('appointmentForm').reset();
    }

    function filterClients() {
        const input = document.getElementById("searchClient").value.toLowerCase();
        const options = document.getElementById("cliente").options;
        for (let i = 1; i < options.length; i++) {
            const text = options[i].text.toLowerCase();
            options[i].style.display = text.includes(input) ? "" : "none";
        }
    }


    function setClientId(id, name) {
        document.getElementById("customerId").value = id;
        document.getElementById("clientName").innerText = name;
        loadVehicles(id);
    }


    function loadVehicles(customerId) {
        const xhr = new XMLHttpRequest();
        xhr.open('GET', 'cita?action=getVehicles&clienteId=' + customerId, true);
        xhr.onload = function () {
            if (xhr.status == 200) {
                try {
                    const vehicles = JSON.parse(xhr.responseText);
                    const vehicleSelect = document.getElementById("vehicleId");
                    vehicleSelect.innerHTML = '<option value="">-- Selecciona un vehículo --</option>';
                    vehicles.forEach(function (vehicle) {
                        const option = document.createElement('option');
                        option.value = vehicle.id;
                        option.textContent = vehicle.plate;
                        vehicleSelect.appendChild(option);
                    });
                } catch (e) {
                    console.error("Error al procesar la respuesta JSON:", e);
                }
            } else {
                console.error("Error al obtener los vehículos:", xhr.status);
            }
        };
        xhr.send();
    }


    function addServiceDetail() {
        const container = document.getElementById('serviceDetailsContainer');
        const newRow = document.createElement('div');
        newRow.classList.add('service-detail-row');
        newRow.innerHTML = `
       <div class="row">
           <div class="col-md-6 mb-3">
               <label class="form-label">Servicio</label>
               <select name="details[][serviceId]" class="form-select serviceSelect" onchange="updateServiceCost(this)" required>
                   <option value="">-- Selecciona un servicio --</option>
                   <%
                       for (ServicioDto servicio : servicios) {
                   %>
                   <option value="<%= servicio.getId() %>" data-cost="<%= servicio.getCost() %>">
                       <%= servicio.getName() %> - $<%= String.format("%.2f", servicio.getCost()) %>
                   </option>
                   <% } %>
               </select>
           </div>
           <div class="col-md-6 mb-3">
               <label class="form-label">Costo</label>
               <input type="number" step="0.01" name="details[][cost]" class="form-control costInput" required />
           </div>
       </div>
       <div class="row">
           <div class="col-md-6 mb-3">
               <label class="form-label">Descripción</label>
               <textarea name="details[][description]" class="form-control" rows="3" required></textarea>
           </div>
           <div class="col-md-6 mb-3">
               <label class="form-label">Resultado</label>
               <textarea name="details[][result]" class="form-control" rows="3" required></textarea>
           </div>
       </div>
       <button type="button" class="btn btn-sm btn-danger float-end mb-2" onclick="removeServiceDetail(this)">Eliminar</button>
   `;
        container.appendChild(newRow);
    }


    function removeServiceDetail(button) {
        const row = button.closest('.service-detail-row');
        row.remove();
    }


    function updateServiceCost(selectElement) {
        const costInput = selectElement.closest('.service-detail-row').querySelector('.costInput');
        const selectedOption = selectElement.options[selectElement.selectedIndex];
        costInput.value = selectedOption ? selectedOption.getAttribute('data-cost') : '';
    }


    // Variables for validation
    let today, selectedDate, selectedTime;

    // Initialize validation on page load
    document.addEventListener('DOMContentLoaded', function() {
        // Set the min attribute to today's date
        today = new Date();
        const formattedToday = today.toISOString().split('T')[0];
        document.getElementById('date').setAttribute('min', formattedToday);
    });

    function validateDate() {
        const dateInput = document.getElementById('date');
        const dateError = document.getElementById('dateError');

        // Reset time validation
        document.getElementById('hour').min = '08:00';
        document.getElementById('hour').max = '19:00';

        selectedDate = new Date(dateInput.value);
        today = new Date();

        // Remove time component for accurate comparison
        today.setHours(0, 0, 0, 0);
        selectedDate.setHours(0, 0, 0, 0);

        if (selectedDate < today) {
            dateError.textContent = 'No puedes seleccionar una fecha anterior a hoy.';
            dateInput.value = ''; // Clear the input
            return false;
        } else {
            dateError.textContent = '';

            // If selected date is today, set time restrictions
            if (selectedDate.getTime() === today.getTime()) {
                const currentHour = new Date().getHours();
                const currentMinute = new Date().getMinutes();

                // Set minimum time to current time + 30 minutes
                const minTime = currentHour < 8
                    ? '08:00'
                    : (currentHour < 19
                        ? formatTime(currentHour, currentMinute + 30)
                        : '19:00');

                document.getElementById('hour').min = minTime;
            }

            return true;
        }
    }

    function validateTime() {
        const hourInput = document.getElementById('hour');
        const timeError = document.getElementById('timeError');
        const dateInput = document.getElementById('date');

        // Check if date is selected
        if (!dateInput.value) {
            timeError.textContent = 'Primero selecciona una fecha.';
            hourInput.value = '';
            return false;
        }

        selectedDate = new Date(dateInput.value);
        today = new Date();
        selectedTime = hourInput.value;

        // Remove time component for accurate comparison
        today.setHours(0, 0, 0, 0);
        selectedDate.setHours(0, 0, 0, 0);

        // Validate time range (8 AM to 7 PM)
        const [hours, minutes] = selectedTime.split(':').map(Number);
        if (hours < 8 || hours >= 20) {
            timeError.textContent = 'La hora debe estar entre 8:00 AM y 7:00 PM.';
            hourInput.value = '';
            return false;
        }

        // Additional validation for today's date
        if (selectedDate.getTime() === today.getTime()) {
            const currentHour = new Date().getHours();
            const currentMinute = new Date().getMinutes();

            // Convert selected time to minutes
            const selectedTimeInMinutes = hours * 60 + minutes;
            const currentTimeInMinutes = currentHour * 60 + currentMinute;

            if (selectedTimeInMinutes <= currentTimeInMinutes) {
                timeError.textContent = 'No puedes seleccionar una hora anterior a la actual.';
                hourInput.value = '';
                return false;
            }
        }

        timeError.textContent = '';
        return true;
    }

    function formatTime(hours, minutes) {
        // Adjust hours and minutes if minutes exceed 59
        if (minutes >= 60) {
            hours += Math.floor(minutes / 60);
            minutes %= 60;
        }

        // Ensure two-digit format
        const formattedHours = hours.toString().padStart(2, '0');
        const formattedMinutes = minutes.toString().padStart(2, '0');

        return `${formattedHours}:${formattedMinutes}`;
    }

    function validateForm() {
        return validateDate() && validateTime();
    }



</script>
</body>
</html>