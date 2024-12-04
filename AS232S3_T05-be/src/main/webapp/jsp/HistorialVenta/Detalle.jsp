<%@ page import="pe.edu.vallegrande.demo1.service.HistorialSERVICE" %>
<%@ page import="java.util.List" %>
<%@ page import="pe.edu.vallegrande.demo1.dto.DetalleVentaDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detalle de Venta - Boleta de Venta</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7fb;
        }

        .boleta {
            width: 80%;
            max-width: 900px;
            margin: 50px auto;
            padding: 30px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            border-top: 5px solid #007BFF;
        }

        .boleta-header, .boleta-footer {
            text-align: center;
        }

        .boleta-header h1 {
            margin-bottom: 20px;
            font-size: 35px;
            color: #007BFF;
            font-weight: bold;
        }

        .boleta-header p {
            font-size: 16px;
            color: #555;
        }

        .boleta-footer {
            font-size: 14px;
            color: #555;
            margin-top: 40px;
        }

        .tabla-detalle {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }

        .tabla-detalle th, .tabla-detalle td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: left;
        }

        .tabla-detalle th {
            background-color: #f8f9fa;
            color: #007BFF;
            font-weight: bold;
        }

        .tabla-detalle tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        .tabla-detalle td {
            font-size: 16px;
            color: #333;
        }

        .tabla-detalle .total {
            font-weight: bold;
            color: #28a745;
        }

        .detalle-venta {
            margin-bottom: 20px;
        }

        .detalle-venta span {
            font-weight: bold;
            color: #333;
        }

        .detalle-venta .producto {
            margin-bottom: 12px;
            font-size: 16px;
        }

        .boleta-footer p {
            margin: 5px 0;
        }

        .boleta-footer small {
            color: #777;
        }

        /* Estilos para la imagen */
        .imagen-boleta {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .imagen-boleta div {
            text-align: center;
            width: 48%;
        }

        .imagen-boleta img {
            max-width: 100%;
            height: auto;
            border-radius: 8px;
        }

        .Tota{
            margin-left: 180px;
        }

    </style>
</head>
<body>

        <c:forEach var="venta" items="${venta}">
            <div class="boleta">
                <!-- Encabezado de la boleta -->
                 <div class="boleta-header">
                    <h1>Boleta de Venta</h1>
                    <p><strong>Fecha:</strong> ${venta.fechaVenta}</p>
                    <p><strong>Cliente:</strong> ${venta.nombre}</p>
            </div>
        </c:forEach>
        <!-- Detalles de la venta -->
        <div class="detalle-venta">
            <table class="tabla-detalle">
                <thead>
                    <tr>
                        <th>Producto</th>
                        <th>Cantidad</th>
                        <th>Precio Unitario</th>
                        <th>Total</th>
                    </tr>
                </thead>
            <tbody>


    <%
    int id = Integer.parseInt(request.getParameter("id"));
        HistorialSERVICE histo = new HistorialSERVICE();
        List<DetalleVentaDTO> pepe = histo.VerDetalleVenta(id);
        for (DetalleVentaDTO item : pepe) {
    %>
        <tr>
            <td><%=item.getNombreProducto()%></td>
            <td><%=item.getCantidad()%></td>
            <td><%=item.getPrecioUnitario()%></td>
            <td><%=item.getTotalDetalle()%></td>
        </tr>
        <%
            }
        %>

    </tbody>
    </table>
    </div>
<c:forEach var="venta" items="${venta}">

    <!-- Precios debajo de las columnas de "Precio Unitario" y "Total" -->
    <div class="imagen-boleta">
        <div>
        </div>
        <div>
            <p><strong class="Tota">Total a Pagar:</strong> ${venta.precioTotal}</p>
        </div>
    </div>
    </c:forEach>
    <!-- Imagen debajo de la tabla -->
        <div class="imagen-boleta">
            <div>
                <img src="img/correo.png" alt="Imagen de Boleta">
            </div>
        </div>
    <c:forEach var="venta" items="${venta}">
        <!-- Resumen de la venta -->
                <div class="boleta-footer">
                    <p><strong>Pago Realizado:</strong> </p>
                    <p><strong>Vuelto:</strong></p>
                    <p><small>Gracias por su compra.</small></p>
                </c:forEach>
                </div>
            </div>
        </body>
    </html>
