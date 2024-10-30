<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="pe.edu.vallegrande.demo1.dto.ProductoDTO" %>
<%@ page import="pe.edu.vallegrande.demo1.service.ProductoSERVICE" %>
<%@ page import="java.util.List" %>
<%@ page import="pe.edu.vallegrande.demo1.service.ClienteSERVICE" %>
<%@ page import="pe.edu.vallegrande.demo1.dto.ClienteDTO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Productos</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        body {
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
            background-color: #faf3e0; /* Blanco Hueso */
            color: #4b2e2e; /* Marrón Oscuro */
        }
        .sidebar {
            width: 250px;
            background-color: #d2a679; /* Marrón Claro */
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 30px 20px;
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            transition: transform 0.3s ease;
        }
        .sidebar.hidden {
            transform: translateX(-100%);
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
            width: 100%;
            transition: margin-left 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #f5f0e1; /* Fondo Crema */
            border-radius: 8px;
        }
        .main-content.full-width {
            margin-left: 0;
        }
        .menu-toggle {
            position: fixed;
            top: 20px;
            left: 20px;
            z-index: 1000;
            background-color: #d2a679;
            color: white;
            border: none;
            font-size: 24px;
            cursor: pointer;
            padding: 10px;
            border-radius: 5px;
        }
        .sidebar .logo {
            text-align: center;
            margin-bottom: 30px;
        }
        .sidebar .logo img {
            width: 80px;
            height: auto;
            border-radius: 50%;
        }
        .sidebar h2 {
            font-size: 1.5rem;
            margin-top: 15px;
            color: #4b2e2e; /* Marrón Oscuro */
        }
        nav.nav {
            margin-top: 30px;
            width: 100%;
        }
        .nav-link {
            color: #4b2e2e; /* Marrón Oscuro */
            font-size: 1.2rem;
            padding: 10px 20px;
        }
        .nav-link:hover {
            background-color: #a36748; /* Terracota */
            border-radius: 5px;
            color: white;
        }
        h1 {
            color: #4b2e2e; /* Marrón Oscuro */
        }
        .btn-success {
            background-color: #a36748; /* Terracota */
            border: none;
        }
        .btn-success:hover, .btn-primary:hover {
            background-color: #4b2e2e; /* Marrón Oscuro */
        }
        .btn-primary {
            background-color: #a36748; /* Terracota */
            border: none;
        }
        .table-dark {
            background-color: #4b2e2e; /* Marrón Oscuro */
            color: white;
        }
        .modal-header {
            background-color: #4b2e2e; /* Marrón Oscuro */
        }
        .form-label {
            color: #4b2e2e; /* Marrón Oscuro */
        }
    </style>
</head>
<body>

<!-- Botón de menú hamburguesa -->
<button class="menu-toggle" onclick="toggleSidebar()">
    <i class="bi bi-list"></i>
</button>

<!-- Sidebar -->
<div class="sidebar" id="sidebar">
    <div class="logo">
        <img src="img/Logo.webp" alt="Logo del Negocio"> <!-- Reemplaza con tu logo -->
        <h2>Sabor de Casa</h2>
    </div>
    <nav class="nav flex-column w-100">
        <a href="index.jsp" class="nav-link d-flex align-items-center mb-3">
            <i class="bi bi-house me-3"></i> Inicio
        </a>
        <a href="producto?action=listar&page=productos" class="nav-link d-flex align-items-center mb-3">
            <i class="bi bi-box-seam me-3"></i> Producto
        </a>
        <a href="cliente?action=listar&page=cliente" class="nav-link d-flex align-items-center mb-3">
            <i class="bi bi-people me-3"></i> Cliente
        </a>
        <a href="venta?action=listar" class="nav-link d-flex align-items-center mb-3">
            <i class="bi bi-cart-check me-3"></i> Venta
        </a>
        <a href="detalle?action=listar" class="nav-link d-flex align-items-center mb-3">
            <i class="bi bi-clipboard-data me-3"></i> VentaDetalle
        </a>
        <a href="reporte?action=listar" class="nav-link d-flex align-items-center mb-3">
            <i class="bi bi-file-earmark-bar-graph me-3"></i> Reporte
        </a>
    </nav>
</div>



<!-- Contenido Principal -->
<div class="main-content" id="main-content">
    <div class="container mt-5 d-flex justify-content-center"> <!-- Modificación para centrar la tabla -->
        <div class="col-md-10"> <!-- Ajuste del ancho de la tabla -->

        <c:choose>
        <c:when test="${param.page == 'cliente'}">

            <h1 class="text-center">Listado de Clientes</h1>
            <div class="text-end mb-3">
                <!-- Botón que abre el modal -->
                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalAgregarCliente">
                    Agregar Nuevo Producto
                </button>
            </div>

            <!-- Modal de Bootstrap para agregar cliente -->
            <div class="modal fade" id="modalAgregarCliente" tabindex="-1" aria-labelledby="modalAgregarClienteLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header bg-dark text-white">
                            <h5 class="modal-title" id="modalAgregarClienteLabel">Agregar Cliente</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="formAgregarCliente" action="cliente" method="POST">
                                <input type="hidden" name="action" value="agregarCliente">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="nombre" class="form-label">Nombre</label>
                                            <input type="text" class="form-control" id="nombre" name="nombre" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="apellido" class="form-label">Apellido</label>
                                            <input type="text" class="form-control" id="apellido" name="apellido" required>
                                        </div>
                                    </div>
                                </div>

                                <!-- Tipo de Documento y Número de Documento -->
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="tipoDocumento" class="form-label">Tipo de Documento</label>
                                            <select class="form-select" id="tipoDocumento" name="tipoDocumento" required>
                                                <option value="">Seleccione</option>
                                                <option value="DNI">DNI</option>
                                                <option value="Carnet de Extranjería">Carnet de Extranjería</option>
                                                <option value="Pasaporte">Pasaporte</option>
                                                <option value="Permiso Temporal de Permanencia">Permiso Temporal de Permanencia</option>
                                                <option value="Carné de Identidad Diplomático">Carné de Identidad Diplomático</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="numeroDocumento" class="form-label">Número de Documento</label>
                                            <input type="text" class="form-control" id="numeroDocumento" name="numeroDocumento" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="fechaNacimiento" class="form-label">Fecha de Nacimiento</label>
                                            <input type="date" class="form-control" id="fechaNacimiento" name="fechaNacimiento">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="celular" class="form-label">Celular</label>
                                            <input type="text" class="form-control" id="celular" name="celular">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="email" class="form-label">Email</label>
                                            <input type="email" class="form-control" id="email" name="email">
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="direccion" class="form-label">Dirección</label>
                                            <input type="text" class="form-control" id="direccion" name="direccion">
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="fechaRegistro" class="form-label">Fecha de Registro</label>
                                            <input type="datetime-local" class="form-control" id="fechaRegistro" name="fechaRegistro" value="<%= new java.sql.Timestamp(System.currentTimeMillis()).toString().substring(0, 16) %>" readonly>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label for="estatus" class="form-label">Estatus</label>
                                            <input type="text" class="form-control" id="estatus" name="estatus" value="A" readonly>
                                        </div>
                                    </div>
                                </div>

                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary">Guardar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>



            <!-- Tabla de clientes centrada -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped text-center">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Apellido</th>
                        <th>Tipo Documento</th>
                        <th>Número Documento</th>
                        <th>Fecha Nacimiento</th>
                        <th>Celular</th>
                        <th>Email</th>
                        <th>Dirección</th>
                        <th>Fecha Registro</th>
                        <th>Estatus</th>
                        <th>Acción</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        ClienteSERVICE dao = new ClienteSERVICE();
                        List<ClienteDTO> list = dao.listarClientes();
                        for (ClienteDTO cliente : list) {
                    %>
                    <tr>
                        <td><%= cliente.getClienteID() %></td>
                        <td><%= cliente.getNombre() %></td>
                        <td><%= cliente.getApellido() %></td>
                        <td><%= cliente.getTipoDocumento() %></td>
                        <td><%= cliente.getNumeroDocumento() %></td>
                        <td><%= cliente.getFechaNacimiento() %></td>
                        <td><%= cliente.getCelular() %></td>
                        <td><%= cliente.getEmail() %></td>
                        <td><%= cliente.getDireccion() %></td>
                        <td><%= cliente.getFechaRegistro() %></td>
                        <td><%= cliente.getEstatus() %></td>
                        <td>
                            <a href="cliente?action=editar&id=<%= cliente.getClienteID() %>" class="btn btn-warning btn-sm">
                                <i class="bi bi-pencil-square"></i>
                            </a>
                            <a href="cliente?action=eliminar&id=<%= cliente.getClienteID() %>" class="btn btn-danger btn-sm">
                                <i class="bi bi-trash"></i>
                            </a>
                            <a href="cliente?action=restaurar&id=<%= cliente.getClienteID() %>" class="btn btn-info btn-sm">
                                <i class="bi bi-arrow-clockwise"></i>
                            </a>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
                </c:when>
                <c:when test = "${param.page == 'editar'}">

                    <h1 class="text-center">Editar Cliente</h1>
                    <!-- Formulario para editar un Cliente -->


                    <form action="cliente" method="post">
                        <input type="hidden" name="idcliente" value="${pepito123.clienteID}">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="nombre" class="form-label">Nombre</label>
                                    <input value="${pepito123.nombre}" type="text" class="form-control" name="nombre" required>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="apellido" class="form-label">Apellido</label>
                                    <input value="${pepito123.apellido}" type="text" class="form-control"  name="apellido" required>
                                </div>
                            </div>
                        </div>

                        <!-- Tipo de Documento y Número de Documento -->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="tipoDocumento" class="form-label">Tipo de Documento</label>
                                    <select value="${pepito123.tipoDocumento}" class="form-select"  name="tipoDocumento" required>
                                        <option value="">Seleccione</option>
                                        <option value="DNI" ${pepito123.tipoDocumento == 'DNI' ? 'selected' : ''}>DNI</option>
                                        <option value="Carnet de Extranjería" ${pepito123.tipoDocumento == 'Carnet de Extranjería' ? 'selected' : ''}>Carnet de Extranjería</option>
                                        <option value="Pasaporte" ${pepito123.tipoDocumento == 'Pasaporte' ? 'selected' : ''}>Pasaporte</option>
                                        <option value="Permiso Temporal de Permanencia" ${pepito123.tipoDocumento == 'Permiso Temporal de Permanencia' ? 'selected' : ''}>Permiso Temporal de Permanencia</option>
                                        <option value="Carné de Identidad Diplomático" ${pepito123.tipoDocumento == 'Carné de Identidad Diplomático' ? 'selected' : ''}>Carné de Identidad Diplomático</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="numeroDocumento" class="form-label">Número de Documento</label>
                                    <input value="${pepito123.numeroDocumento}" type="text" class="form-control"  name="numeroDocumento" required>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="fechaNacimiento" class="form-label">Fecha de Nacimiento</label>
                                    <input value="${pepito123.fechaNacimiento}" type="date" class="form-control"  name="fechaNacimiento">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="celular" class="form-label">Celular</label>
                                    <input value="${pepito123.celular}" type="text" class="form-control"  name="celular">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input value="${pepito123.email}" type="email" class="form-control" name="email">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="mb-3">
                                    <label for="direccion" class="form-label">Dirección</label>
                                    <input value="${pepito123.direccion}" type="text" class="form-control" name="direccion">
                                </div>
                            </div>
                        </div>

                        <div class="text-center">
                            <button type="submit" name="action" value="modificarCliente" class="btn" style="background-color: #385c42; color: #f9f9f9">Actualizar Producto</button>
                        </div>
                    </form>


                </c:when>
                </c:choose>
            </div>
        </div>
    </div>
</div>







            <!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

<!-- Script para mostrar y ocultar la barra lateral -->
<script>
    function toggleSidebar() {
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('main-content');
        sidebar.classList.toggle('hidden');
        mainContent.classList.toggle('full-width');
    }
</script>
</body>
</html>
