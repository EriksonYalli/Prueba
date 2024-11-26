<%@ page import="pe.edu.vallegrande.demo1.dto.ProductoDTO" %>
<%@ page import="pe.edu.vallegrande.demo1.service.ProductoSERVICE" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Listado de Productos</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Listado de Productos</h1>
    <div class="text-end mb-3">
        <!-- Cambiamos la ruta a la carpeta jsp -->
        <a href="jsp/agregarProducto.jsp" class="btn btn-success">Agregar Nuevo Producto</a>
    </div>
    <table class="table table-bordered table-striped">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Precio Compra</th>
            <th>Precio Venta</th>
            <th>Stock</th>
            <th>Estatus</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="producto" items="${productos}">
            <tr>
                <td>${producto.productoID}</td>
                <td>${producto.nombre}</td>
                <td>${producto.descripcion}</td>
                <td>S/. ${producto.precioCompra}</td>
                <td>S/. ${producto.precioVenta}</td>
                <td>${producto.stock}</td>
                <td>
                    <span class="badge ${producto.estatus == 'A' ? 'bg-success' : 'bg-danger'}">
                            ${producto.estatus == 'A' ? 'Activo' : 'Inactivo'}
                    </span>
                </td>
                <td>
                    <a href="producto?action=editar&id=${producto.productoID}" class="btn btn-warning btn-sm">Editar</a>
                    <a href="producto?action=eliminar&id=${producto.productoID}" class="btn btn-danger btn-sm">
                            ${producto.estatus == 'A' ? 'Eliminar' : 'Restaurar'}
                    </a>
                </td>
            </tr>
        </c:forEach>
        </tbody>

        <%
            ProductoSERVICE dao = new ProductoSERVICE();
            List<ProductoDTO> list;
            if("true".equals(request.getParameter("showInactive"))){
                list = dao.inactivos();
            }else {
                list = dao.listarProductos();
            }
            for (ProductoDTO product : list) {
            %>

    </table>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
