<%@ page import="pe.edu.vallegrande.demo1.service.ProductoSERVICE" %>
<%@ page import="pe.edu.vallegrande.demo1.service.ClienteSERVICE" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
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
        width: 100%; /* Cambiado a 100% para ocupar todo el contenedor */
    }
</style>

<!-- Contenido Principal -->
<div class="container-fluid" id="container"> <!-- Cambiado a container-fluid para ocupar todo el ancho -->
    <h1 class="text-center">SABOR DE CASA</h1>
    <h5 class="text-center">Bienvenido al sistema. Desde aquí puedes gestionar tus productos, clientes y ventas.</h5>

    <!-- Contenedor de tarjetas -->
    <div class="card-container">
        <a href="producto?action=listar" class="card">
            <i class="bi bi-box-seam card-icon"></i>
            <div class="card-title">Gestionar Productos</div>
        </a>
        <a href="cliente?action=listarCliente" class="card">
            <i class="bi bi-people card-icon"></i>
            <div class="card-title">Gestionar Clientes</div>
        </a>
        <a href="venta?action=listar&page=venta" class="card">
            <i class="bi bi-cart-check card-icon"></i>
            <div class="card-title">Gestionar Ventas</div>
        </a>
    </div>

    <!-- Sección de estadísticas -->
    <%
        ProductoSERVICE productoService = new ProductoSERVICE();
        int totalProductosDisponibles = productoService.contarProductos();

        ClienteSERVICE clienteService = new ClienteSERVICE();
        int totalClientesActivos = clienteService.contarClientesActivos();
    %>
    <div class="statistics-container">
        <div class="statistics-card">
            <h5>Producto Disponible</h5>
            <div class="value"><%= totalProductosDisponibles %></div>
        </div>
        <div class="statistics-card">
            <h5>Clientes Activos</h5>
            <div class="value"><%= totalClientesActivos %></div>
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
            <!-- Más filas aquí si es necesario -->
            </tbody>
        </table>
    </div>
</div>
