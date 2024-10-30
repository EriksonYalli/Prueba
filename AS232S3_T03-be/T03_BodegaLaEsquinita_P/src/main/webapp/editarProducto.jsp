<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Editar Producto</title>
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
  <h2 class="mb-4">Editar Producto</h2>
  <form action="${pageContext.request.contextPath}/editarProduct" method="post">
    <input type="hidden" name="id" value="${producto.id}"/> <!-- Asegúrate de que estás pasando el ID -->
    <div class="mb-3">
      <label for="name" class="form-label">Nombre</label>
      <input type="text" class="form-control" id="name" name="name" value="${producto.name}" required>
    </div>
    <div class="mb-3">
      <label for="description" class="form-label">Descripción</label>
      <input type="text" class="form-control" id="description" name="description" value="${producto.description}" required>
    </div>
    <div class="mb-3">
      <label for="trade_mark" class="form-label">Marca</label>
      <input type="text" class="form-control" id="trade_mark" name="trade_mark" value="${producto.tradeMark}" required>
    </div>
    <div class="mb-3">
      <label for="stock" class="form-label">Stock</label>
      <input type="number" class="form-control" id="stock" name="stock" value="${producto.stock}" required>
    </div>
    <div class="mb-3">
      <label for="price" class="form-label">Precio</label>
      <input type="text" class="form-control" id="price" name="price" value="${producto.price}" required>
    </div>
    <div class="mb-3">
      <label for="expiry_date" class="form-label">Fecha de Vencimiento</label>
      <input type="text" class="form-control" id="expiry_date" name="expiry_date" value="${formattedDate}" placeholder="yyyy/MM/dd" required>
    </div>
    <button type="submit" class="btn btn-danger">Actualizar Producto</button>
    <a href="listarProductos" class="btn btn-secondary">Cancelar</a>
  </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>