<%@ page import="pe.edu.vallegrande.demo1.service.ClienteSERVICE" %>
<%@ page import="pe.edu.vallegrande.demo1.service.ProductoSERVICE" %>
<%@ page import="pe.edu.vallegrande.demo1.service.DetalleSERVICE" %>
<%@ page import="pe.edu.vallegrande.demo1.dto.DetalleDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="pe.edu.vallegrande.demo1.service.DetalleSERVICE" %>
<%@ page import="pe.edu.vallegrande.demo1.dto.DetalleDTO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalles de Venta - Sabor de Casa</title>
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
        <a href="producto?action=listar" class="nav-link d-flex align-items-center mb-3">
            <i class="bi bi-box-seam me-3"></i> Producto
        </a>
        <a href="cliente?action=listar" class="nav-link d-flex align-items-center mb-3">
            <i class="bi bi-people me-3"></i> Cliente
        </a>
        <a href="venta?action=listar" class="nav-link d-flex align-items-center mb-3">
            <i class="bi bi-cart-check me-3"></i> Venta
        </a>
        <a href="ventadetalle?action=listar" class="nav-link d-flex align-items-center mb-3">
            <i class="bi bi-clipboard-data me-3"></i> VentaDetalle
        </a>
        <a href="reporte?action=listar" class="nav-link d-flex align-items-center mb-3">
            <i class="bi bi-file-earmark-bar-graph me-3"></i> Reporte
        </a>
    </nav>
</div>

<!-- Contenido Principal -->
<div class="main-content" id="main-content">
    <div class="container mt-5 d-flex justify-content-center">
        <div class="col-md-10">
            <h1 class="text-center">Listado de Detalles de Venta</h1>
            <div class="text-end mb-3">
                <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalAgregarDetalleVenta">
                    Agregar Detalle de Venta
                </button>
            </div>

            <!-- Modal de Bootstrap para agregar detalle de venta -->
            <div class="modal fade" id="modalAgregarDetalleVenta" tabindex="-1" aria-labelledby="modalAgregarDetalleVentaLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header bg-dark text-white">
                            <h5 class="modal-title" id="modalAgregarDetalleVentaLabel">Agregar Detalle de Venta</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="formAgregarDetalleVenta" action="detalleVenta?action=agregar" method="POST">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="ventaID" class="form-label">Venta ID</label>
                                        <input type="number" class="form-control" id="ventaID" name="ventaID" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="productoID" class="form-label">Producto ID</label>
                                        <input type="number" class="form-control" id="productoID" name="productoID" required onblur="obtenerProducto()">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="nombreProducto" class="form-label">Nombre del Producto</label>
                                    <input type="text" class="form-control" id="nombreProducto" name="nombreProducto" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="cantidad" class="form-label">Cantidad</label>
                                    <input type="number" class="form-control" id="cantidad" name="cantidad" required min="1" oninput="calcularSubtotalYVuelto()">
                                </div>
                                <div class="mb-3">
                                    <label for="precioVenta" class="form-label">Precio Venta (por unidad)</label>
                                    <input type="number" step="0.01" class="form-control" id="precioVenta" name="precioVenta" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="descuento" class="form-label">Descuento</label>
                                    <input type="number" step="0.01" class="form-control" id="descuento" name="descuento" value="0.00" oninput="calcularSubtotalYVuelto()">
                                </div>
                                <div class="mb-3">
                                    <label for="subtotal" class="form-label">Subtotal</label>
                                    <input type="number" step="0.01" class="form-control" id="subtotal" name="subtotal" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="montoRecibido" class="form-label">Monto Recibido</label>
                                    <input type="number" step="0.01" class="form-control" id="montoRecibido" name="montoRecibido" required oninput="calcularSubtotalYVuelto()">
                                </div>
                                <div class="mb-3">
                                    <label for="vuelto" class="form-label">Vuelto</label>
                                    <input type="number" step="0.01" class="form-control" id="vuelto" name="vuelto" readonly>
                                </div>
                                <div class="mb-3">
                                    <label for="estadoDetalle" class="form-label">Estado Detalle</label>
                                    <select class="form-select" id="estadoDetalle" name="estadoDetalle">
                                        <option value="Activo" selected>Activo</option>
                                        <option value="Cancelado">Cancelado</option>
                                    </select>
                                </div>

                                <div class="text-center">
                                    <button type="submit" class="btn btn-primary">Guardar</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Tabla de detalles de ventas -->
            <div class="table-responsive">
                <table class="table table-bordered table-striped text-center">
                    <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Venta ID</th>
                        <th>Producto ID</th>
                        <th>Nombre Producto</th>
                        <th>Cantidad</th>
                        <th>Precio Venta</th>
                        <th>Descuento</th>
                        <th>Subtotal</th>
                        <th>Monto Recibido</th>
                        <th>Vuelto</th>
                        <th>Fecha Venta</th>
                        <th>Estado</th>
                        <th>Acción</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%-- Código JSP para listar los detalles de venta --%>
                    <%
                        DetalleSERVICE dao = new DetalleSERVICE();
                        List<DetalleDTO> list = dao.listarDetallesVenta();
                        for (DetalleDTO detalle : list) {
                    %>
                    <tr>
                        <td><%= detalle.getDetalleVentaID() %></td>
                        <td><%= detalle.getFkVentaID() %></td>
                        <td><%= detalle.getFkProductoID() %></td>
                        <td><%= detalle.getNombreProducto() %></td>
                        <td><%= detalle.getCantidad() %></td>
                        <td><%= detalle.getPrecioVenta() %></td>
                        <td><%= detalle.getDescuento() %></td>
                        <td><%= detalle.getSubtotal() %></td>
                        <td><%= detalle.getMontoRecibido() %></td>
                        <td><%= detalle.getVuelto() %></td>
                        <td><%= detalle.getFechaVenta() %></td>
                        <td><%= detalle.getEstadoDetalle() %></td>
                        <td>
                            <button class="btn btn-warning btn-sm">Editar</button>
                            <button class="btn btn-danger btn-sm">Eliminar</button>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

<!-- Scripts -->
<script>
    function obtenerProducto() {
        // Implementación AJAX para obtener datos del producto
    }

    function calcularSubtotalYVuelto() {
        const cantidad = parseFloat(document.getElementById("cantidad").value) || 0;
        const precioVenta = parseFloat(document.getElementById("precioVenta").value) || 0;
        const descuento = parseFloat(document.getElementById("descuento").value) || 0;
        const montoRecibido = parseFloat(document.getElementById("montoRecibido").value) || 0;

        const subtotal = (cantidad * precioVenta) - descuento;
        document.getElementById("subtotal").value = subtotal.toFixed(2);

        const vuelto = montoRecibido >= subtotal ? montoRecibido - subtotal : 0;
        document.getElementById("vuelto").value = vuelto.toFixed(2);
    }
</script>

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
