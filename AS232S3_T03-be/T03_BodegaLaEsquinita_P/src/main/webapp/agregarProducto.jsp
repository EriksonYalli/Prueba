<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agregar Producto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f5f5f5;
        }
        .container {
            margin-top: 50px;
        }
    </style>
</head>
<body>
<div class="container">
    <h2 class="mb-4">Agregar Producto</h2>
    <form action="${pageContext.request.contextPath}/agregarProduct" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Nombre</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>
        <div class="mb-3">
            <label for="description" class="form-label">Descripción</label>
            <input type="text" class="form-control" id="description" name="description" required>
        </div>
        <div class="mb-3">
            <label for="trade_mark" class="form-label">Marca</label>
            <input type="text" class="form-control" id="trade_mark" name="trade_mark" required>
        </div>
        <div class="mb-3">
            <label for="stock" class="form-label">Cantidad</label>
            <input type="number" class="form-control" id="stock" name="stock" required>
        </div>
        <div class="mb-3">
            <label for="price" class="form-label">Precio</label>
            <input type="number" class="form-control" id="price" name="price" required step="0.01">
        </div>
        <div class="mb-3">
            <label for="expiry_date" class="form-label">Fecha de Vencimiento</label>
            <input type="text" class="form-control" id="expiry_date" name="expiry_date" required placeholder="yyyy/MM/dd" pattern="\d{4}/\d{2}/\d{2}">
        </div>
        <div class="mb-3">
            <label for="id_supplier" class="form-label">ID Proveedor</label>
            <input type="number" class="form-control" id="id_supplier" name="id_supplier" required>
        </div>
        <button type="submit" class="btn btn-danger">Añadir Producto</button>
        <a href="listarProductos" class="btn btn-secondary">Cancelar</a>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
