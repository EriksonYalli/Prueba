<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        /* Estilos generales */
        body {
            min-height: 100vh;
            overflow-x: hidden;
            background-color: #faf3e0; /* Blanco Hueso */
            color: #4b2e2e; /* Marrón Oscuro */
        }

        /* Estilos de la barra lateral */
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

        /* Estilos del contenido principal */
        .main-content {
            margin-left: 250px;
            padding: 0; /* Eliminamos padding para maximizar el uso del espacio */
            width: calc(100% - 250px); /* Ajusta el ancho en función de la barra lateral */
            transition: margin-left 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
            background-color: #f5f0e1; /* Fondo Crema */
            border-radius: 8px;
        }
        .main-content.full-width {
            margin-left: 0;
            width: 100%;
        }

        /* Estilos del botón de menú */
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

        /* Estilos adicionales */
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
        .container {
            width: 100%;
        }
    </style>
</head>

<body>


<div class="d-flex">
    <!-- Botón de menú hamburguesa -->
    <button class="menu-toggle" onclick="toggleSidebar()">
        <i class="bi bi-list"></i>
    </button>

    <!-- Sidebar -->
    <div class="sidebar" id="sidebar">
        <div class="logo">
            <img src="img/Logo.png" alt="Logo del Negocio"> <!-- Reemplaza con tu logo -->
            <h2>Sabor de Casa</h2>
        </div>
        <nav class="nav flex-column w-100">
            <a href="index.jsp" class="nav-link d-flex align-items-center mb-3">
                <i class="bi bi-house me-3"></i> Inicio
            </a>
            <a href="producto?action=listar" class="nav-link d-flex align-items-center mb-3">
                <i class="bi bi-box-seam me-3"></i> Producto
            </a>
            <a href="cliente?action=listarCliente" class="nav-link d-flex align-items-center mb-3">
                <i class="bi bi-people me-3"></i> Cliente
            </a>
            <a href="venta?action=venta_detalle" class="nav-link d-flex align-items-center mb-3">
                <i class="bi bi-cart-check me-3"></i> Venta
            </a>
        </nav>
    </div>

    <!-- Contenido principal -->
    <div class="main-content" id="main-content">
        <main>
            <div class="container-fluid">
                <div id="content" class="container-fluid mt-4"> <!-- Cambiado a container-fluid -->
                    <c:choose>
                        <c:when test="${param.page == 'principal' || param.page == null}">
                            <jsp:include page="jsp/principal/principal.jsp"></jsp:include>
                        </c:when>
                        <c:when test="${param.page == 'listarCliente' || param.page == null}">
                            <jsp:include page="jsp/cliente/listar.jsp"></jsp:include>
                        </c:when>
                        <c:when test="${param.page == 'editarCliente' || param.page == null}">
                            <jsp:include page="jsp/cliente/editar.jsp"></jsp:include>
                        </c:when>
                        <c:when test="${param.page == 'listarInactivos' || param.page == null}">
                            <jsp:include page="jsp/cliente/listarInactivos.jsp"></jsp:include>
                        </c:when>
                        <c:when test="${param.page == 'listarProducto' || param.page == null}">
                            <jsp:include page="jsp/producto/listar.jsp"></jsp:include>
                        </c:when>
                        <c:when test="${param.page == 'editarProducto' || param.page == null}">
                            <jsp:include page="jsp/producto/editar.jsp"></jsp:include>
                        </c:when>
                        <c:when test="${param.page == 'listarProductoInactivos' || param.page == null}">
                            <jsp:include page="jsp/producto/listarInactivos.jsp"></jsp:include>
                        </c:when>
                        <c:when test="${param.page == 'venta_detalle' || param.page == null}">
                            <jsp:include page="jsp/venta/venta.jsp"></jsp:include>
                        </c:when>
                    </c:choose>
                </div>
            </div>
        </main>
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
