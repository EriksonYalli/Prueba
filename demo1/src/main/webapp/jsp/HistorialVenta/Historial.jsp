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
    <link rel="stylesheet" href="styles.css"> <!-- Incluye tu archivo CSS aquí -->
</head>
<body>
<h1>Lista de Ventas</h1>

<%
    // Crear una instancia de la clase que contiene el método ListarVenta
    VentaSERVICE ve = new VentaSERVICE();
    List<VentaDTO> ventas = ve.listarVentas();
    // Colocar la lista de ventas como atributo en la solicitud
    request.setAttribute("ventas", ventas);
%>

<!-- Mostrar las ventas en una tabla -->
<table border="1" cellpadding="10" cellspacing="0">
    <thead>
    <tr>
        <th>ID Venta</th>
        <th>ID Cliente</th>
        <th>Fecha de Venta</th>
        <th>Total Producto Vendidos</th>
        <th>Precio Total</th>
    </tr>
    </thead>
    <tbody>
    <!-- Usamos JSTL para iterar sobre la lista de ventas -->
    <c:forEach var="venta" items="${ventas}">
        <tr>
            <td>${venta.ventaID}</td>
            <td>${venta.clienteID}</td>
            <td>${venta.fechaVenta}</td>
            <td>${venta.totalProductosVendidos}</td>
            <td>${venta.precioTotal}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

</body>
</html>
