<%@ page import="pe.edu.vallegrande.demo1.service.ClienteSERVICE" %>
<%@ page import="pe.edu.vallegrande.demo1.service.ProductoSERVICE" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio - Sabor de Casa</title>
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
        /* Estilos de las tarjetas */
        .card-container {
            display: flex;
            justify-content: center;
            gap: 20px;
            flex-wrap: wrap;
            margin-top: 30px;
        }
        .card {
            width: 200px;
            background-color: #d2a679; /* Marrón Claro */
            color: white;
            border: none;
            border-radius: 8px;
            text-align: center;
            padding: 20px;
            transition: transform 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .card:hover {
            transform: scale(1.05);
        }
        .card-icon {
            font-size: 40px;
            margin-bottom: 10px;
            color: #faf3e0; /* Blanco Hueso */
        }
        .card-title {
            font-size: 1.2rem;
            margin-top: 10px;
            font-weight: bold;
        }
        /* Estilos para las estadísticas */
        .statistics-container {
            margin-top: 40px;
            display: flex;
            gap: 20px;
            justify-content: center;
        }
        .statistics-card {
            width: 180px;
            background-color: #f0e6d6;
            color: #4b2e2e;
            border-radius: 8px;
            padding: 20px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .statistics-card h5 {
            margin-bottom: 10px;
        }
        .statistics-card .value {
            font-size: 2rem;
            font-weight: bold;
        }
        /* Estilos para la tabla de últimas ventas */
        .sales-table {
            margin-top: 40px;
            width: 80%;
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
    <h1 class="text-center">SABOR DE CASA</h1>
    <h5 class="text-center">Bienvenido al sistema. Desde aquí puedes gestionar tus productos, clientes y ventas.</h5>

    <!-- Contenedor de tarjetas -->
    <div class="card-container">
        <a href="producto?action=listar&page=productos" class="card">
            <i class="bi bi-box-seam card-icon"></i>
            <div class="card-title">Gestionar Productos</div>
        </a>
        <a href="cliente?action=listar&page=cliente" class="card">
            <i class="bi bi-people card-icon"></i>
            <div class="card-title">Gestionar Clientes</div>
        </a>
        <a href="venta?action=listar" class="card">
            <i class="bi bi-cart-check card-icon"></i>
            <div class="card-title">Gestionar Ventas</div>
        </a>
        <a href="ventadetalle?action=listar" class="card">
            <i class="bi bi-clipboard-data card-icon"></i>
            <div class="card-title">Detalle de Ventas</div>
        </a>
    </div>

    <!-- Sección de estadísticas -->
    <%
        // Llamada al servicio para contar productos disponibles
        ProductoSERVICE productoService = new ProductoSERVICE();
        int totalProductosDisponibles = productoService.contarProductos(); // Obtiene el número real de productos disponibles

        // Llamada al servicio para contar clientes activos
        ClienteSERVICE clienteService = new ClienteSERVICE();
        int totalClientesActivos = clienteService.contarClientesActivos(); // Obtiene el número real de clientes activos
    %>
    <div class="statistics-container">
        <div class="statistics-card">
            <h5>Producto Disponible</h5>
            <div class="value"><%= totalProductosDisponibles %></div> <!-- Aquí se muestra la cantidad real de productos disponibles -->
        </div>
        <div class="statistics-card">
            <h5>Clientes Activos</h5>
            <div class="value"><%= totalClientesActivos %></div> <!-- Aquí se muestra la cantidad real de clientes activos -->
        </div>
        <div class="statistics-card">
            <h5>Ventas Hoy</h5>
            <div class="value">35</div> <!-- Puedes conectar este valor a la base de datos si lo necesitas -->
        </div>
    </div>

    <!-- Tabla de últimas ventas -->
    <div class="sales-table">
        <h3 class="text-center mt-5">Últimas Ventas Realizadas</h3>
        <table class="table table-striped table-hover mt-3">
            <thead class="table-dark">
            <tr>
                <th>Cliente</th>
                <th>Producto</th>
                <th>Fecha</th>
                <th>Total</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>Juan Pérez</td>
                <td>Torta de Chocolate</td>
                <td>25/10/2024</td>
                <td>$35.00</td>
            </tr>
            <tr>
                <td>María González</td>
                <td>Galletas de Mantequilla</td>
                <td>25/10/2024</td>
                <td>$10.00</td>
            </tr>
            <!-- Agrega más filas aquí si es necesario -->
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
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
