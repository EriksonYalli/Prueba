<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<div class="container mt-5 d-flex justify-content-center"> <!-- Modificación para centrar la tabla -->
    <div class="col-md-10"> <!-- Ajuste del ancho de la tabla -->

        <c:choose>
        <c:when test="${param.page == 'productos'}">
        <h1 class="text-center">Listado de Productos</h1>
        <div class="text-end mb-3">
            <!-- Botón que abre el modal -->
            <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#modalAgregarProducto">
                Agregar Nuevo Producto
            </button>
        </div>

        <!-- Contador de productos -->
        <%
            ProductoSERVICE productoService = new ProductoSERVICE();
            int totalProductos = productoService.contarProductos();
        %>
        <div class="alert alert-info text-center mt-3">
            Tipos de productos: <strong><%= totalProductos %></strong>
        </div>


            <!-- OPCION DE BUSCA POR MARCA -->
            <form action="producto" method="GET" class="d-flex mb-3">
                <select name="marca" class="form-select" required>
                    <option value="">Seleccione una marca</option>
                    <option value="Delicia Dulce">Delicia Dulce</option>
                    <option value="Oreo">Oreo</option>
                    <option value="Magnolia Bakery">Magnolia Bakery</option>
                    <!-- Agrega más opciones de marca según tus necesidades -->
                </select>
                <button type="submit" class="btn btn-primary ms-2">Buscar</button>
            </form>



        <!-- Modal de Bootstrap para agregar producto -->
        <div class="modal fade" id="modalAgregarProducto" tabindex="-1" aria-labelledby="modalAgregarProductoLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header bg-dark text-white">
                        <h5 class="modal-title" id="modalAgregarProductoLabel">Agregar Producto</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <!-- Formulario para agregar un producto -->
                        <form id="formAgregarProducto" action="producto?action=agregar" method="POST">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="nombre" class="form-label">Nombre</label>
                                        <input type="text" class="form-control" id="nombre" name="nombre" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="descripcion" class="form-label">Descripción</label>
                                        <textarea class="form-control" id="descripcion" name="descripcion" required></textarea>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="categoria" class="form-label">Categoría</label>
                                        <div>
                                            <input type="radio" id="tortas" name="categoria" value="Tortas y Pasteles" required>
                                            <label for="tortas">Tortas y Pasteles</label>
                                        </div>
                                        <div>
                                            <input type="radio" id="galletas" name="categoria" value="Galletas" required>
                                            <label for="galletas">Galletas</label>
                                        </div>
                                        <div>
                                            <input type="radio" id="cupcakes" name="categoria" value="Cupcakes y Muffins" required>
                                            <label for="cupcakes">Cupcakes y Muffins</label>
                                        </div>
                                        <div>
                                            <input type="radio" id="brownies" name="categoria" value="Brownies y Barras" required>
                                            <label for="brownies">Brownies y Barras</label>
                                        </div>
                                        <div>
                                            <input type="radio" id="macarons" name="categoria" value="Macarons y Delicias Francesas" required>
                                            <label for="macarons">Macarons y Delicias Francesas</label>
                                        </div>
                                        <div>
                                            <input type="radio" id="postres" name="categoria" value="Postres y Dulces" required>
                                            <label for="postres">Postres y Dulces</label>
                                        </div>
                                        <div>
                                            <input type="radio" id="panaderia" name="categoria" value="Panadería Dulce" required>
                                            <label for="panaderia">Panadería Dulce</label>
                                        </div>
                                        <div>
                                            <input type="radio" id="tartas" name="categoria" value="Tartas y Pies" required>
                                            <label for="tartas">Tartas y Pies</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-4">
                                        <label for="marca" class="form-label">Marca</label>
                                        <select class="form-select" id="marca" name="marca" required>
                                            <option value="" selected disabled>Selecciona una marca</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="precioVenta" class="form-label">Precio Venta</label>
                                        <input type="number" step="0.01" class="form-control" id="precioVenta" name="precioVenta" required>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="descuento" class="form-label">Descuento</label>
                                        <input type="number" step="0.01" class="form-control" id="descuento" name="descuento" required>
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="stock" class="form-label">Stock</label>
                                        <input type="number" class="form-control" id="stock" name="stock" required>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="estatus" class="form-label">Estatus</label>
                                        <input type="text" class="form-control" id="estatus" name="estatus" value="A" readonly> <!-- Campo prellenado con "A" y no editable -->
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label for="fechaIngreso" class="form-label">Fecha Ingreso</label>
                                        <input type="date" class="form-control" id="fechaIngreso" name="fechaIngreso" required>
                                    </div>
                                </div>
                            </div>

                            <div class="text-center">
                                <button type="submit" class="btn btn-primary">Guardar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>


            <!-- JavaScript para filtrar marcas según la categoría seleccionada -->
            <script>
                // Asociar las marcas con las categorías
                const marcasPorCategoria = {
                    "Tortas y Pasteles": ["Delicia Dulce", "Dulce de Leche Granulado", "Cake Boss"],
                    "Galletas": ["Oreo", "Pepperidge Farm", "Chips Ahoy!"],
                    "Cupcakes y Muffins": ["Hostess", "Magnolia Bakery", "Betty Crocker"],
                    "Brownies y Barras": ["Ghirardelli", "Little Debbie", "Fudge Kitchen"],
                    "Macarons y Delicias Francesas": ["Ladurée", "Pierre Hermé", "La Maison du Chocolat"],
                    "Postres y Dulces": ["Ferrero Rocher", "Hershey's", "Godiva"],
                    "Panadería Dulce": ["Cinnabon", "Krispy Kreme", "Panera Bread"],
                    "Tartas y Pies": ["Marie Callender's", "Sara Lee", "Edwards"]
                };

                // Detectar el cambio en la categoría
                document.querySelectorAll('input[name="categoria"]').forEach((element) => {
                    element.addEventListener('change', function() {
                        const categoriaSeleccionada = this.value;
                        const selectMarcas = document.getElementById('marca');

                        // Limpiar el menú de marcas
                        selectMarcas.innerHTML = '<option value="" selected disabled>Selecciona una marca</option>';

                        // Llenar el menú de marcas según la categoría seleccionada
                        marcasPorCategoria[categoriaSeleccionada].forEach(function(marca) {
                            const option = document.createElement('option');
                            option.value = marca;
                            option.text = marca;
                            selectMarcas.appendChild(option);
                        });
                    });
                });
            </script>

        <!-- Tabla de productos centrada -->
            <table class="table table-bordered table-striped text-center">
                <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Descripción</th>
                    <th>Marca</th>
                    <th>Categoría</th>
                    <th>Precio Venta</th>
                    <th>Descuento</th>
                    <th>Stock</th>
                    <th>Estatus</th>
                    <th>Fecha Ingreso</th>
                    <th>Accion</th>
                </tr>
                </thead>
                <tbody>
                <%
                    String marca = request.getParameter("marca");
                    List<ProductoDTO> productos;

                    if (marca != null && !marca.isEmpty()) {
                        // Búsqueda por marca
                        productos = productoService.listarProductosPorMarca(marca);
                    } else {
                        // Listar todos los productos si no hay búsqueda
                        productos = productoService.listarProductos();
                    }

                    for (ProductoDTO product : productos) {
                %>
                <tr>
                    <td><%= product.getProductoID() %></td>
                    <td><%= product.getNombre() %></td>
                    <td><%= product.getDescripcion() %></td>
                    <td><%= product.getMarca() %></td>
                    <td><%= product.getCategoria() %></td>
                    <td><%= product.getPrecioVenta() %></td>
                    <td><%= product.getDescuento() %></td>
                    <td><%= product.getStock() %></td>
                    <td><%= product.getEstatus() %></td>
                    <td><%= product.getFechaIngreso() %></td>
                    <td>
                        <a href="producto?action=editar&id=<%= product.getProductoID() %>" class="btn btn-warning btn-sm">
                            <i class="bi bi-pencil-square"></i>
                        </a>
                        <a href="producto?action=eliminar&id=<%= product.getProductoID() %>" class="btn btn-danger btn-sm">
                            <i class="bi bi-trash"></i>
                        </a>
                        <a href="producto?action=restaurar&id=<%= product.getProductoID() %>" class="btn btn-info btn-sm">
                            <i class="bi bi-arrow-clockwise"></i>
                        </a>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
            </c:when>
            <c:when test = "${param.page == 'editar'}">

                <h1 class="text-center">Editar Producto</h1>
                <!-- Formulario para editar un producto -->
                <form id="formEditarProducto" action="producto" method="POST">
                    <div class="row">
                        <!-- Campo de Nombre -->
                        <div class="col-md-6">
                            <input type="hidden" name="id" value="${pepito123.productoID}">
                            <div class="mb-3">
                                <label for="nombre" class="form-label">Nombre</label>
                                <input value="${pepito123.nombre}" type="text" class="form-control" name="nombre" required>
                            </div>
                        </div>

                        <!-- Campo de Descripción -->
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="descripcion" class="form-label">Descripción</label>
                                <textarea class="form-control" name="descripcion" required>${pepito123.descripcion}</textarea>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Campo de Categoría (con radio buttons) -->
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="categoria" class="form-label">Categoría</label>
                                <div>
                                    <input type="radio" id="tortas" name="categoria" value="Tortas y Pasteles"
                                        ${pepito123.categoria == 'Tortas y Pasteles' ? 'checked' : ''} required>
                                    <label for="tortas">Tortas y Pasteles</label>
                                </div>
                                <div>
                                    <input type="radio" id="galletas" name="categoria" value="Galletas"
                                        ${pepito123.categoria == 'Galletas' ? 'checked' : ''} required>
                                    <label for="galletas">Galletas</label>
                                </div>
                                <div>
                                    <input type="radio" id="cupcakes" name="categoria" value="Cupcakes y Muffins"
                                        ${pepito123.categoria == 'Cupcakes y Muffins' ? 'checked' : ''} required>
                                    <label for="cupcakes">Cupcakes y Muffins</label>
                                </div>
                                <div>
                                    <input type="radio" id="brownies" name="categoria" value="Brownies y Barras"
                                        ${pepito123.categoria == 'Brownies y Barras' ? 'checked' : ''} required>
                                    <label for="brownies">Brownies y Barras</label>
                                </div>
                                <div>
                                    <input type="radio" id="macarons" name="categoria" value="Macarons y Delicias Francesas"
                                        ${pepito123.categoria == 'Macarons y Delicias Francesas' ? 'checked' : ''} required>
                                    <label for="macarons">Macarons y Delicias Francesas</label>
                                </div>
                                <div>
                                    <input type="radio" id="postres" name="categoria" value="Postres y Dulces"
                                        ${pepito123.categoria == 'Postres y Dulces' ? 'checked' : ''} required>
                                    <label for="postres">Postres y Dulces</label>
                                </div>
                                <div>
                                    <input type="radio" id="panaderia" name="categoria" value="Panadería Dulce"
                                        ${pepito123.categoria == 'Panadería Dulce' ? 'checked' : ''} required>
                                    <label for="panaderia">Panadería Dulce</label>
                                </div>
                                <div>
                                    <input type="radio" id="tartas" name="categoria" value="Tartas y Pies"
                                        ${pepito123.categoria == 'Tartas y Pies' ? 'checked' : ''} required>
                                    <label for="tartas">Tartas y Pies</label>
                                </div>
                            </div>
                        </div>

                        <!-- Campo de Marca (con select dropdown) -->
                        <div class="col-md-6">
                            <div class="mb-4">
                                <label for="marca" class="form-label">Marca</label>
                                <select class="form-select" id="marca" name="marca" required>
                                    <option value="" disabled>Selecciona una marca</option>
                                    <!-- Las opciones de marca se llenarán mediante JavaScript según la categoría seleccionada -->
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Campo de Precio Venta -->
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="precioVenta" class="form-label">Precio Venta</label>
                                <input type="number" step="0.01" class="form-control" id="precioVenta" name="precioVenta"
                                       value="${pepito123.precioVenta}" required>
                            </div>
                        </div>

                        <!-- Campo de Descuento -->
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="descuento" class="form-label">Descuento</label>
                                <input type="number" step="0.01" class="form-control" id="descuento" name="descuento"
                                       value="${pepito123.descuento}" required>
                            </div>
                        </div>

                        <!-- Campo de Stock -->
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="stock" class="form-label">Stock</label>
                                <input type="number" class="form-control" id="stock" name="stock" value="${pepito123.stock}" required>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Campo de Estatus (solo lectura) -->
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="estatus" class="form-label">Estatus</label>
                                <input type="text" class="form-control" id="estatus" name="estatus" value="${pepito123.estatus}" readonly>
                            </div>
                        </div>

                        <!-- Campo de Fecha de Ingreso -->
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label for="fechaIngreso" class="form-label">Fecha Ingreso</label>
                                <input type="date" class="form-control" id="fechaIngreso" name="fechaIngreso"
                                       value="${pepito123.fechaIngreso}" required>
                            </div>
                        </div>
                    </div>
                    <button type="submit" name="action" value="actualizar" class="btn" style="background-color: #385c42; color: #f9f9f9">Actualizar Producto</button>
                </form>






                <!-- JavaScript para filtrar marcas según la categoría seleccionada y preseleccionar la marca -->
                <script>
                    // Asociar las marcas con las categorías
                    const marcasPorCategoria = {
                        "Tortas y Pasteles": ["Delicia Dulce", "Dulce de Leche Granulado", "Cake Boss"],
                        "Galletas": ["Oreo", "Pepperidge Farm", "Chips Ahoy!"],
                        "Cupcakes y Muffins": ["Hostess", "Magnolia Bakery", "Betty Crocker"],
                        "Brownies y Barras": ["Ghirardelli", "Little Debbie", "Fudge Kitchen"],
                        "Macarons y Delicias Francesas": ["Ladurée", "Pierre Hermé", "La Maison du Chocolat"],
                        "Postres y Dulces": ["Ferrero Rocher", "Hershey's", "Godiva"],
                        "Panadería Dulce": ["Cinnabon", "Krispy Kreme", "Panera Bread"],
                        "Tartas y Pies": ["Marie Callender's", "Sara Lee", "Edwards"]
                    };

                    // Al cargar la página, establecer la categoría y marca preseleccionada
                    document.addEventListener('DOMContentLoaded', function() {
                        const categoriaSeleccionada = "${pepito123.categoria}";
                        const marcaSeleccionada = "${pepito123.marca}";
                        const selectMarcas = document.getElementById('marca');

                        // Marcar la categoría seleccionada
                        document.querySelectorAll('input[name="categoria"]').forEach((element) => {
                            if (element.value === categoriaSeleccionada) {
                                element.checked = true;

                                // Llenar el menú de marcas según la categoría preseleccionada
                                marcasPorCategoria[categoriaSeleccionada].forEach(function(marca) {
                                    const option = document.createElement('option');
                                    option.value = marca;
                                    option.text = marca;

                                    // Seleccionar la marca en el menú si coincide con la marca del producto
                                    if (marca === marcaSeleccionada) {
                                        option.selected = true;
                                    }
                                    selectMarcas.appendChild(option);
                                });
                            }
                        });
                    });

                    // Detectar el cambio en la categoría
                    document.querySelectorAll('input[name="categoria"]').forEach((element) => {
                        element.addEventListener('change', function() {
                            const categoriaSeleccionada = this.value;
                            const selectMarcas = document.getElementById('marca');

                            // Limpiar el menú de marcas
                            selectMarcas.innerHTML = '<option value="" selected disabled>Selecciona una marca</option>';

                            // Llenar el menú de marcas según la categoría seleccionada
                            marcasPorCategoria[categoriaSeleccionada].forEach(function(marca) {
                                const option = document.createElement('option');
                                option.value = marca;
                                option.text = marca;
                                selectMarcas.appendChild(option);
                            });
                        });
                    });
                </script>


            </c:when>
            </c:choose>
        </div>
    </div>
</div>










<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<!-- Bootstrap Icons -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

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