<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="pe.edu.vallegrande.demo1.dto.VentaDTO" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="pe.edu.vallegrande.demo1.service.VentaSERVICE" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lista de Ventas</title>

    <!-- Incluir Bootstrap 5 desde CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEJx3QhqLMpG8r+KnujsKWo5jffpslfXwhng5KYV15LmkQdVg0lh7wki/2K5J" crossorigin="anonymous">

    <!-- Puedes incluir tu archivo CSS adicional aquí -->
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<div class="container my-5">
    <h1 class="text-center mb-4">Lista de Ventas</h1>

    <%
        // Crear una instancia de la clase que contiene el método ListarVenta
        VentaSERVICE ve = new VentaSERVICE();
        List<VentaDTO> ventas = ve.listarVentas();
        // Colocar la lista de ventas como atributo en la solicitud
        request.setAttribute("ventas", ventas);
    %>

    <!-- Tabla de ventas con diseño de Bootstrap -->
    <div class="table-responsive">
        <table class="table table-bordered table-striped table-hover">
            <thead class="table-dark text-center">
            <tr>
                <th>ID Venta</th>
                <th>ID Cliente</th>
                <th>Fecha de Venta</th>
                <th>Total Producto Vendidos</th>
                <th>Precio Total</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody class="text-center">
            <!-- Usamos JSTL para iterar sobre la lista de ventas -->
            <c:forEach var="venta" items="${ventas}">
                <tr>
                    <td>${venta.ventaID}</td>
                    <td>${venta.clienteID}</td>
                    <td>${venta.fechaVenta}</td>
                    <td>${venta.totalProductosVendidos}</td>
                    <td>${venta.precioTotal}</td>
                    <td>
                        <!-- Botón Ver Detalle -->
                        <a href="venta?action=detalleVenta&id=${venta.ventaID}" class="btn btn-info btn-sm">
                            Ver Detalle
                        </a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Incluir los scripts de Bootstrap al final -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-pzjw8f+ua7Kw1TIq0v8FqKXfVtFfaX0enQ1saYp1C/ckzEjc7QWfOX8Y6JecO98z" crossorigin="anonymous"></script>
</body>
</html>
