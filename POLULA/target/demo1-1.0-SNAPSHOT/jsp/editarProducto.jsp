<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Producto</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h1 class="text-center">Editar Producto</h1>
    <form action="producto" method="post" class="mt-4">
        <input type="hidden" name="action" value="editar">
        <input type="hidden" name="productoID" value="${producto.productoID}">

        <div class="mb-3">
            <label for="nombre" class="form-label">Nombre del Producto</label>
            <input type="text" name="nombre" value="${producto.nombre}" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="descripcion" class="form-label">Descripción</label>
            <textarea name="descripcion" class="form-control">${producto.descripcion}</textarea>
        </div>
        <div class="mb-3">
            <label for="precioCompra" class="form-label">Precio de Compra</label>
            <input type="number" step="0.01" name="precioCompra" value="${producto.precioCompra}" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="precioVenta" class="form-label">Precio de Venta</label>
            <input type="number" step="0.01" name="precioVenta" value="${producto.precioVenta}" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="stock" class="form-label">Stock</label>
            <input type="number" name="stock" value="${producto.stock}" class="form-control" required>
        </div>
        <div class="text-center">
            <button type="submit" class="btn btn-primary">Guardar Cambios</button>
            <a href="producto?action=listar" class="btn btn-secondary">Cancelar</a>
        </div>
    </form>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
