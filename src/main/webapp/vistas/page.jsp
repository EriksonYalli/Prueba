<%@ page import="java.util.List" %>
<%@ page import="java.util.Collections" %>
<%@ page import="pe.edu.vallegrande.service.*" %>
<%@ page import="pe.edu.vallegrande.dto.*" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.lineicons.com/5.0/lineicons.css" />
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="https://cdn.lineicons.com/3.0.0/lineicons.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">



    <title>SIDEBAR TEST</title>
</head>
<body >


<div class="d-flex">
    <!-- Sidebar -->
    <aside id="sidebar" class="sidebar-toggle">
        <div class="sidebar-logo">
            <a href="controlador?accion=INICIO">NUEVOAGRO ZAM</a>
        </div>
        <!-- Sidebar Navigation -->
        <ul class="sidebar-nav p-0">

            <li class="sidebar-item">
                <a href="controlador?accion=INICIO" class="sidebar-link">
                    <i class="lni lni-home"></i>
                    <span>Tabla principal</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="#" class="sidebar-link">
                    <i class="lni lni-calendar"></i>
                    <span>Agenda</span>
                </a>
            </li>
            <li class="sidebar-header">
                Pages
            </li>
            <li class="sidebar-item">
                <a href="#" class="sidebar-link collapsed has-dropdown" data-bs-toggle="collapse"
                   data-bs-target="#auth" aria-expanded="true" aria-controls="auth">
                    <i class="lni lni-folder"></i>  <!-- Cambié a un ícono de carpeta -->
                    <span>Lista de Productos</span>
                </a>
                <ul id="auth" class="sidebar-dropdown list-unstyled collapse" data-bs-parent="#sidebar">
                    <li class="sidebar-item">
                        <a href="controlador?accion=listar&page=productos" class="sidebar-link">Productos</a>
                    </li>
                    <li class="sidebar-item">
                        <a href="#" class="sidebar-link">Inventario</a>
                    </li>
                </ul>
            </li>
            <li class="sidebar-item">
                <a href="controlador?accion=ventas" class="sidebar-link">
                    <i class="lni lni-cart"></i>
                    <span>Ventas</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="controlador?accion=listar&page=compras" class="sidebar-link">
                    <i class="lni lni-shopping-basket"></i>
                    <span>Compras</span>
                </a>
            </li>
            <li class="sidebar-item">
                <a href="#" class="sidebar-link">
                    <i class="lni lni-cog"></i>
                    <span>Proveedores</span>
                </a>
            </li>
        </ul>
        <!-- Sidebar Navigation Ends -->
        <div class="sidebar-footer">
            <a href="#" class="sidebar-link">
                <i class="lni lni-exit"></i>
                <span>Cerrar sesión</span>
            </a>
        </div>
    </aside>
    <!-- Sidebar Ends -->
    <!-- Main Component -->
    <div class="main">
        <nav class="navbar navbar-expand">
            <button class="toggler-btn" type="button">
                <svg width="32" height="32" viewBox="0 0 25 24" fill="#000000" xmlns="http://www.w3.org/2000/svg" transform="rotate(180 0 0) scale(-1, 1) translate(-0, 0) scale(1, -1) translate(0, -0)">
                    <path d="M3.5625 6C3.5625 5.58579 3.89829 5.25 4.3125 5.25H20.3125C20.7267 5.25 21.0625 5.58579 21.0625 6C21.0625 6.41421 20.7267 6.75 20.3125 6.75L4.3125 6.75C3.89829 6.75 3.5625 6.41422 3.5625 6Z" fill="#000000"/>
                    <path d="M3.5625 18C3.5625 17.5858 3.89829 17.25 4.3125 17.25L20.3125 17.25C20.7267 17.25 21.0625 17.5858 21.0625 18C21.0625 18.4142 20.7267 18.75 20.3125 18.75L4.3125 18.75C3.89829 18.75 3.5625 18.4142 3.5625 18Z" fill="#000000"/>
                    <path d="M4.3125 11.25C3.89829 11.25 3.5625 11.5858 3.5625 12C3.5625 12.4142 3.89829 12.75 4.3125 12.75L20.3125 12.75C20.7267 12.75 21.0625 12.4142 21.0625 12C21.0625 11.5858 20.7267 11.25 20.3125 11.25L4.3125 11.25Z" fill="#000000"/>
                </svg>
            </button>
        </nav>
        <main class="p-3">
            <div class="container-fluid">
                <div id="content" class="container mt-4">
                    <c:choose>
                        <c:when test="${param.page == 'dashboard' || param.page == null}">
                        <div class="container mx-auto mt-10">
                            <h2 class="text-center text-4xl font-bold my-6 text-green-700">Tablero Principal</h2>

                            <div class="flex flex-wrap justify-center">
                                <!-- Resumen de Estadísticas -->
                                <div class="w-full sm:w-1/3 p-4">
                                    <div class="bg-white shadow-lg rounded-lg p-6 border-l-8 border-green-700 transition transform hover:scale-105">
                                        <h5 class="text-lg font-semibold text-gray-800">Total de Productos</h5>
                                        <h2 class="text-3xl font-bold text-green-700">150</h2>
                                    </div>
                                </div>

                                <div class="w-full sm:w-1/3 p-4">
                                    <div class="bg-white shadow-lg rounded-lg p-6 border-l-8 border-blue-600 transition transform hover:scale-105">
                                        <h5 class="text-lg font-semibold text-gray-800">Ventas del Mes</h5>
                                        <h2 class="text-3xl font-bold text-blue-600">$10,000</h2>
                                    </div>
                                </div>

                                <div class="w-full sm:w-1/3 p-4">
                                    <div class="bg-white shadow-lg rounded-lg p-6 border-l-8 border-yellow-600 transition transform hover:scale-105">
                                        <h5 class="text-lg font-semibold text-gray-800">Nuevos Productos</h5>
                                        <h2 class="text-3xl font-bold text-yellow-600">5</h2>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <style>
                            body {
                                background-color: #f0f9f4; /* Un verde suave */
                                font-family: 'Arial', sans-serif;
                            }
                        </style>

                    </c:when>
                        <c:when test="${param.page == 'productos'|| param.page == Inactivos}">

                        <div class="container mx-auto mt-10">
                            <h2 class="text-center text-4xl font-bold my-6 text-green-700">Lista de Productos</h2>
                            <div class="flex justify-between items-center mb-4">
                                <a href="" data-toggle="modal" data-target="#addProductModal" data-accion="add" class="inline-block bg-gradient-to-r from-green-700 to-green-700 text-white font-semibold py-2 px-4 rounded-lg shadow-md transform hover:scale-105 hover:shadow-lg transition duration-300">
                                    Agregar
                                </a>

                                <a href="controlador?accion=listar&page=inactivos" class="inline-block bg-gradient-to-r from-green-700 to-green-700 text-white font-semibold py-2 px-6 rounded-lg shadow-lg transform hover:scale-105 hover:shadow-2xl transition duration-300">
                                    Mostrar inactivos
                                </a>
                            </div>
                            <div class="mb-4">
                                <form action="controlador" method="post" class="flex items-center space-x-2 mb-4">
                                    <input type="text" name="searchQuery" placeholder="ID / MARCA / CULTIVO" required
                                           class="w-full max-w-xs p-2 border border-gray-300 rounded-lg shadow-md focus:outline-none focus:ring-2 focus:ring-green-500 transition duration-300">

                                    <button type="submit" name="accion" value="buscarProductos"
                                            class=" text-white font-semibold py-2 px-4 rounded-lg shadow-md transform hover:scale-105 hover:shadow-lg transition duration-300" style="background-color: #2E5B3C">
                                        Search
                                    </button>
                                </form>
                            </div>


                            <div class="overflow-x-auto">
                                <table class="min-w-full bg-white shadow-lg rounded-lg overflow-hidden">
                                    <thead class=" text-white" style="background-color: #2E5B3C">
                                    <tr>
                                        <th class="py-3 px-4 text-left">ID</th>
                                        <th class="py-3 px-4 text-left">Nombre Comercial</th>
                                        <th class="py-3 px-4 text-left">Nombre Genérico</th>
                                        <th class="py-3 px-4 text-left">Formulación</th>
                                        <th class="py-3 px-4 text-left">Marca</th>
                                        <th class="py-3 px-4 text-left">Descripción</th>
                                        <th class="py-3 px-4 text-left">Categoría</th>
                                        <th class="py-3 px-4 text-left">Precio Venta</th>
                                        <th class="py-3 px-4 text-left">Unidad de Medida</th>
                                        <th class="py-3 px-4 text-left">Estado</th>
                                        <th class="py-3 px-4 text-left">Concentración</th>
                                        <th class="py-3 px-4 text-left">Medida de Concentración</th>
                                        <th class="py-3 px-4 text-left">Modo de Uso</th>
                                        <th class="py-3 px-4 text-left">Cultivos</th>
                                        <th class="py-3 px-4 text-left">Enfermedades o Plagas</th>
                                        <th class="py-3 px-4 text-left">Dosis Recomendada</th>
                                        <th class="py-3 px-4 text-left">Precauciones</th>
                                        <th class="py-3 px-4 text-left">Cantidad</th>
                                        <th class="py-3 px-4 text-left">Acciones</th>
                                    </tr>
                                    </thead>
                                    <tbody class="text-gray-700">
                                    <%
                                        ProductsDAO dao = new ProductsDAO();
                                        List<Products> list = dao.listar();
                                        for (Products product : list) {
                                    %>
                                    <tr class="hover:bg-gray-100 transition duration-200">
                                        <td class="py-2 px-4 border-b"><%= product.getProducts_id() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getComercial_name() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getGeneric_name() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getFormulation() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getBrand() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getDescription() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getCategory() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getSales_price() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getUnit() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getStatus() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getConcentration() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getConcentration_unit() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getAction_mode() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getCrops() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getPests_Diseases() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getRecomended_dose() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getPrecautions() %></td>
                                        <td class="py-2 px-4 border-b"><%= product.getQuantity() %></td>
                                        <td class="py-2 px-4 border-b">
                                            <a href="controlador?accion=editar&id=<%=product.getProducts_id()%>&page=EditarProductos" class="btn bg-green-700 text-white py-1 px-3 rounded shadow hover:bg-green-600">
                                                Editar
                                            </a>
                                            <a href="controlador?accion=eliminar&id=<%=product.getProducts_id()%>" class="btn bg-red-600 text-white py-1 px-3 rounded shadow hover:bg-red-500">
                                                Eliminar
                                            </a>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                    %>
                                    </tbody>
                                </table>


                                <div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalLabel" aria-hidden="true">
                                    <div class="modal-dialog modal-lg" role="document">
                                        <div class="modal-content rounded-lg shadow-lg">
                                            <div class="modal-header  text-white rounded-t-lg" style="background-color: #2E5B3C">
                                                <h5 class="modal-title" id="addProductModalLabel">Agregar Producto</h5>
                                                <button type="button" data-dismiss="modal" aria-label="Close" class="text-white hover:text-gray-200">
                                                    <i class="lni lni-exit"></i>
                                                </button>
                                            </div>
                                            <div class="modal-body p-6 bg-white">
                                                <form action="controlador" method="post">
                                                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                                        <div>
                                                            <label class="block text-sm font-medium text-gray-700">Nombre Comercial:</label>
                                                            <input type="text" name="txtComercialName" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                        </div>
                                                        <div>
                                                            <label class="block text-sm font-medium text-gray-700">Nombre Genérico:</label>
                                                            <input type="text" name="txtGenericName" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                        </div>
                                                        <div>
                                                            <label class="block text-sm font-medium text-gray-700">Formulación:</label>
                                                            <select name="txtFormulation" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                <option value="">Seleccione una opción</option>
                                                                <option value="Suspensión Concentrada (SC)">Suspensión Concentrada (SC)</option>
                                                                <option value="Emulsión (EC)">Emulsión (EC)</option>
                                                                <option value="Polvo Mojable (WP)">Polvo Mojable (WP)</option>
                                                                <option value="Granulado (GR)">Granulado (GR)</option>
                                                                <option value="Concentrado Soluble (SL)">Concentrado Soluble (SL)</option>
                                                                <option value="Gel">Gel</option>
                                                                <option value="Tabletas">Tabletas</option>
                                                                <option value="Aerosoles">Aerosoles</option>
                                                            </select>
                                                        </div>
                                                        <div>
                                                            <label class="block text-sm font-medium text-gray-700">Marca:</label>
                                                            <select name="txtBrand" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" id="brandSelect" required>
                                                                <option value="">Seleccione una marca</option>
                                                                <option value="BASF">BASF</option>
                                                                <option value="Bayer">Bayer</option>
                                                                <option value="Syngenta">Syngenta</option>
                                                                <option value="Corteva">Corteva Agriscience</option>
                                                                <option value="FMC Corporation">FMC Corporation</option>
                                                                <option value="Adama">Adama</option>
                                                                <option value="Nufarm">Nufarm</option>
                                                                <option value="Monsanto">Monsanto</option>
                                                                <option value="Sumitomo Chemical">Sumitomo Chemical</option>
                                                                <option value="Zhejiang Yongnong">Zhejiang Yongnong</option>
                                                                <option value="UPL">UPL</option>
                                                                <option value="Arysta LifeScience">Arysta LifeScience</option>
                                                                <option value="Koppert">Koppert</option>
                                                                <option value="Agroquímicos Perú">Agroquímicos Perú</option>
                                                                <option value="Fertiperú">Fertilizantes del Perú</option>
                                                                <option value="Agroindustrias San Miguel">Agroindustrias San Miguel</option>
                                                                <option value="Proquiper">Productos Químicos de Perú</option>
                                                                <option value="Agrícola Mínima">Agrícola Mínima</option>
                                                                <option value="Agro Sostenible">Agro Sostenible</option>
                                                                <option value="Otra marca">Otra marca</option>
                                                            </select>
                                                            <div id="otherBrandInput" style="display: none;">
                                                                <input type="text" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" placeholder="Ingrese otra marca">
                                                            </div>
                                                        </div>
                                                        <div>
                                                            <label class="block text-sm font-medium text-gray-700">Descripción:</label>
                                                            <input type="text" name="txtDescription" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                        </div>
                                                        <div>
                                                            <%
                                                                CategoryDAO catdao = new CategoryDAO();
                                                                List<Category> categories = catdao.listar(); // Llamada al método que retorna la lista
                                                                request.setAttribute("categories", categories); // Guardar en el request
                                                            %>
                                                            <label class="block text-sm font-medium text-gray-700">Categoría:</label>
                                                            <select name="txtCategory" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                <option value="">Seleccione una categoría</option>
                                                                <c:forEach items="${categories}" var="category">
                                                                    <option value="${category.categoryId}">${category.categoryName}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                        <div>
                                                            <label class="block text-sm font-medium text-gray-700">Precio Venta:</label>
                                                            <input type="number" name="txtPsale" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required min="0" step="0.01">
                                                        </div>
                                                        <div>
                                                            <label class="block text-sm font-medium text-gray-700">Unidad:</label>
                                                            <select name="txtUnit" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                <option value="">Seleccione una unidad de medida</option>
                                                                <option value="L">Litros (L)</option>
                                                                <option value="mL">Mililitros (mL)</option>
                                                                <option value="kg">Kilogramos (kg)</option>
                                                                <option value="g">Gramos (g)</option>
                                                            </select>
                                                        </div>
                                                        <div>
                                                            <label class="block text-sm font-medium text-gray-700">Concentración:</label>
                                                            <input type="number" name="txtConcentration" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required min="0" step="0.01">
                                                        </div>
                                                        <div>
                                                            <label class="block text-sm font-medium text-gray-700">Seleccione la medida de concentración:</label>
                                                            <select id="concentration" name="txtConcentrationUnit" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                <option value="">Seleccione una opción</option>
                                                                <option value="% p/p">%p/p</option>
                                                                <option value="% v/v">%v/v</option>
                                                                <option value="g/L">g/L</option>
                                                                <option value="mg/L">mg/L</option>
                                                                <option value="mg/kg">mg/kg</option>
                                                                <option value="ppm">ppm</option>
                                                                <option value="M">M</option>
                                                                <option value="g/ha">g/ha</option>
                                                                <option value="lb/acre">lb/acre</option>
                                                                <option value="kg/ha">kg/ha</option>
                                                            </select>
                                                        </div>
                                                        <div>
                                                            <label class="block text-sm font-medium text-gray-700">Modo de Acción:</label>
                                                            <input type="text" name="txtActionMode" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                        </div>
                                                        <div>
                                                            <%
                                                                CultivosDAO culdao = new CultivosDAO();
                                                                List<Cultivos> cultivos = culdao.listar();
                                                                request.setAttribute("cultivos", cultivos);
                                                            %>
                                                            <label class="block text-sm font-medium text-gray-700">Cultivos:</label>
                                                            <select name="txtCrops" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                <option value="">Seleccione un cultivo</option>
                                                                <c:forEach items="${cultivos}" var="cultivo">
                                                                    <option value="${cultivo.idCultivo}">${cultivo.nombreCultivo}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>
                                                    </div>
                                                    <div class="form-group mb-4">
                                                        <label for="pestsDiseases" class="block text-sm font-medium text-gray-700">Seleccione una enfermedad o plaga:</label>
                                                        <select id="pestsDiseases" name="txtPestsDiseases" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                            <option value="">Seleccione una opción</option>
                                                            <option value="Pulgones">Pulgones</option>
                                                            <option value="Mosca blanca">Mosca blanca</option>
                                                            <option value="Ácaros">Ácaros</option>
                                                            <option value="Gusanos">Gusanos</option>
                                                            <option value="Podredumbre de raíces">Podredumbre de raíces</option>
                                                            <option value="Mildiú polvoriento">Mildiú polvoriento</option>
                                                            <option value="Roya">Roya</option>
                                                            <option value="Tizón">Tizón</option>
                                                            <option value="Nematodos">Nematodos</option>
                                                            <option value="Mildiú hondo">Mildiú hondo</option>
                                                        </select>
                                                    </div>
                                                    <div class="form-group mb-4">
                                                        <label class="block text-sm font-medium text-gray-700">Dosis Recomendadas:</label>
                                                        <input type="text" name="txtRecomendedDose" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                    </div>
                                                    <div class="form-group mb-4">
                                                        <label class="block text-sm font-medium text-gray-700">Precauciones:</label>
                                                        <input type="text" name="txtPrecautions" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                    </div>
                                                    <button type="submit" name="accion" value="agregar" class="w-full py-2 px-4 bg-green-700 text-white rounded-lg hover:bg-green-600 transition">Agregar Producto</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </c:when>

                                <c:when test="${param.page == 'inactivos'}">
                                <h2 class="text-center text-4xl font-bold my-6 text-green-700">Lista de Productos Inactivos</h2>
                                <div class="flex justify-between items-center mb-4">
                                    <a href="controlador?accion=listar&page=productos" class="inline-block bg-gradient-to-r from-green-700 to-green-700 text-white font-semibold py-2 px-6 rounded-lg shadow-lg transform hover:scale-105 hover:shadow-2xl transition duration-300">
                                        Regresar</a>
                                    <a href="controlador?accion=listar&page=productos" class="inline-block bg-gradient-to-r from-green-700 to-green-700 text-white font-semibold py-2 px-6 rounded-lg shadow-lg transform hover:scale-105 hover:shadow-2xl transition duration-300">
                                        Mostrar Activos
                                    </a>
                                </div>
                                <div class="overflow-x-auto">
                                    <table class="min-w-full bg-white shadow-lg rounded-lg overflow-hidden">
                                        <thead class=" text-white" style="background-color: #2E5B3C">
                                        <tr>
                                            <th class="py-3 px-4 text-left">ID</th>
                                            <th class="py-3 px-4 text-left">Nombre Comercial</th>
                                            <th class="py-3 px-4 text-left">Nombre Genérico</th>
                                            <th class="py-3 px-4 text-left">Formulación</th>
                                            <th class="py-3 px-4 text-left">Marca</th>
                                            <th class="py-3 px-4 text-left">Descripción</th>
                                            <th class="py-3 px-4 text-left">Categoría</th>
                                            <th class="py-3 px-4 text-left">Precio Venta</th>
                                            <th class="py-3 px-4 text-left">Unidad de Medida</th>
                                            <th class="py-3 px-4 text-left">Estado</th>
                                            <th class="py-3 px-4 text-left">Concentración</th>
                                            <th class="py-3 px-4 text-left">Medida de Concentración</th>
                                            <th class="py-3 px-4 text-left">Modo de Uso</th>
                                            <th class="py-3 px-4 text-left">Cultivos</th>
                                            <th class="py-3 px-4 text-left">Enfermedades o Plagas</th>
                                            <th class="py-3 px-4 text-left">Dosis Recomendada</th>
                                            <th class="py-3 px-4 text-left">Precauciones</th>
                                            <th class="py-3 px-4 text-left">Cantidad</th>
                                            <th class="py-3 px-4 text-left">Acciones</th>
                                        </tr>
                                        </thead>
                                        <tbody class="text-gray-700">
                                        <%
                                            ProductsDAO dao = new ProductsDAO();
                                            List<Products> list = dao.inactivos();
                                            for (Products product : list) {
                                        %>
                                        <tr class="hover:bg-gray-100 transition duration-200">
                                            <td class="py-2 px-4 border-b"><%= product.getProducts_id() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getComercial_name() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getGeneric_name() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getFormulation() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getBrand() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getDescription() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getCategory() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getSales_price() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getUnit() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getStatus() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getConcentration() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getConcentration_unit() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getAction_mode() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getCrops() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getPests_Diseases() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getRecomended_dose() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getPrecautions() %></td>
                                            <td class="py-2 px-4 border-b"><%= product.getQuantity() %></td>
                                            <td class="py-2 px-4 border-b">
                                                <a href="controlador?accion=Restaurar&id=<%= product.getProducts_id() %>" class="btn btn-warning mb-3" title="Restaurar Producto">
                                                    Restaurar
                                                </a>>
                                            </td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                        </tbody>
                                    </table>
                                </div>
                                <
                                    </c:when>


                        <c:when test="${param.page == 'EditarProductos'}">

                            <div class="container">
                                <h2>Editar Producto</h2>
                                <form action="controlador" method="post">
                                    <input type="hidden" name="id" value="${product.products_id}"> <!-- ID del producto -->

                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group mb-4">
                                                <label>Nombre Comercial:</label>
                                                <input type="text" name="txtComercialName" placeholder="ej: Agro quimico" class="form-control" value="${product.comercial_name}" required>
                                            </div>
                                            <div class="form-group mb-4">
                                                <label>Nombre Genérico:</label>
                                                <input type="text" name="txtGenericName" placeholder="ej: Agro Generic" class="form-control" value="${product.generic_name}" required>
                                            </div>
                                            <div class="form-group mb-4">
                                                <label>Formulación:</label>
                                                <select name="txtFormulation" class="form-control" required>
                                                    <option value="${product.formulation}">${product.formulation}</option>
                                                    <option value="Suspensión Concentrada (SC)">Suspensión Concentrada (SC)</option>
                                                    <option value="Emulsión (EC)">Emulsión (EC)</option>
                                                    <option value="Polvo Mojable (WP)">Polvo Mojable (WP)</option>
                                                    <option value="Granulado (GR)">Granulado (GR)</option>
                                                    <option value="Concentrado Soluble (SL)">Concentrado Soluble (SL)</option>
                                                    <option value="Gel">Gel</option>
                                                    <option value="Tabletas">Tabletas</option>
                                                    <option value="Aerosoles">Aerosoles</option>
                                                </select>
                                            </div>
                                            <div class="form-group mb-4">
                                                <label>Marca:</label>
                                                <select name="txtBrand" class="form-control" id="brandSelect"  required>
                                                    <option value="${product.brand}">${product.brand}</option>
                                                    <option value="BASF">BASF</option>
                                                    <option value="Bayer">Bayer</option>
                                                    <option value="Syngenta">Syngenta</option>
                                                    <option value="Corteva">Corteva Agriscience</option>
                                                    <option value="FMC Corporation">FMC Corporation</option>
                                                    <option value="Adama">Adama</option>
                                                    <option value="Nufarm">Nufarm</option>
                                                    <option value="Monsanto">Monsanto</option>
                                                    <option value="Sumitomo Chemical">Sumitomo Chemical</option>
                                                    <option value="Zhejiang Yongnong">Zhejiang Yongnong</option>
                                                    <option value="UPL">UPL</option>
                                                    <option value="Arysta LifeScience">Arysta LifeScience</option>
                                                    <option value="Koppert">Koppert</option>
                                                    <option value="Agroquímicos Perú">Agroquímicos Perú</option>
                                                    <option value="Fertiperú">Fertilizantes del Perú</option>
                                                    <option value="Agroindustrias San Miguel">Agroindustrias San Miguel</option>
                                                    <option value="Proquiper">Productos Químicos de Perú</option>
                                                    <option value="Agrícola Mínima">Agrícola Mínima</option>
                                                    <option value="Agro Sostenible">Agro Sostenible</option>
                                                    <option value="Otra marca">Otra marca</option>
                                                </select>
                                            </div>
                                            <div class="form-group mb-4">
                                                <label>Descripción:</label>
                                                <input type="text" name="txtDescription" class="form-control" value="${product.description}" required>
                                            </div>
                                            <div class="form-group mb-4">
                                                <label>Precio Venta:</label>
                                                <input type="text" name="txtPsale" class="form-control" value="${product.sales_price}" required>
                                            </div>
                                            <div class="form-group mb-4">
                                                <label>Unidad:</label>
                                                <select name="txtUnit" class="form-control" required>
                                                    <option value="${product.unit}">${product.unit}</option>
                                                    <option value="L">Litros (L)</option>
                                                    <option value="mL">Mililitros (mL)</option>
                                                    <option value="kg">Kilogramos (kg)</option>
                                                    <option value="g">Gramos (g)</option>
                                                </select>
                                            </div>
                                        </div>
                                        <%
                                            CategoryDAO catdao = new CategoryDAO();
                                            List<Category> categories = catdao.listar(); // Llamada al método que retorna la lista
                                            request.setAttribute("categories", categories); // Guardar en el request
                                        %>
                                        <div class="col-md-6">
                                            <div class="form-group mb-4">
                                                <label>Categoría:</label>
                                                <select name="txtCategory" class="form-control" required>
                                                    <option value="" disabled ${product.category == '' ? 'selected' : ''}>Seleccione una categoría</option>
                                                    <c:forEach items="${categories}" var="category">
                                                        <option value="${category.categoryId}" ${category.categoryId == product.category ? 'selected' : ''}>
                                                                ${category.categoryName}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group mb-4">
                                                <label>Concentración:</label>
                                                <input type="number" placeholder="ej: 9.0" name="txtConcentration" class="form-control" value="${product.concentration}" required>
                                            </div>
                                            <div class="form-group mb-4">
                                                <label>Medida de Concentración:</label>
                                                <select id="concentration" name="txtConcentrationUnit" class="form-control" required>
                                                    <option value="${product.concentration_unit}">${product.concentration_unit}</option>
                                                    <option value="% p/p">%p/p</option>
                                                    <option value="% v/v">%v/v</option>
                                                    <option value="g/L">g/L</option>
                                                    <option value="mg/L">mg/L</option>
                                                    <option value="mg/kg">mg/kg</option>
                                                    <option value="ppm">ppm</option>
                                                    <option value="M">M</option>
                                                    <option value="g/ha">g/ha</option>
                                                    <option value="lb/acre">lb/acre</option>
                                                    <option value="kg/ha">kg/ha</option>
                                                </select>
                                            </div>
                                            <div class="form-group mb-4">
                                                <label>Modo de Acción:</label>
                                                <input type="text" name="txtActionMode" class="form-control" value="${product.action_mode}" required>
                                            </div>
                                            <%
                                                CultivosDAO cultivoDao = new CultivosDAO();
                                                List<Cultivos> cultivos = cultivoDao.listar(); // Llamada al método que retorna la lista de cultivos
                                                request.setAttribute("cultivos", cultivos); // Guardar en el request
                                            %>
                                            <div class="form-group mb-4">
                                                <label>Cultivos:</label>
                                                <select name="txtCrops" class="form-control" required>
                                                    <option value="" disabled ${product.crops == '' ? 'selected' : ''}>Seleccione un cultivo</option>
                                                    <c:forEach items="${cultivos}" var="cultivo">
                                                        <option value="${cultivo.idCultivo}" ${cultivo.idCultivo == product.crops ? 'selected' : ''}>
                                                                ${cultivo.nombreCultivo}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                            <div class="form-group mb-4">
                                                <label>Enfermedades / Plagas:</label>
                                                <select name="txtPestsDiseases" class="form-control" required>
                                                    <option value="${product.pests_Diseases}">${product.pests_Diseases}</option>
                                                    <option value="Pulgones">Pulgones</option>
                                                    <option value="Mosca-blanca">Mosca blanca</option>
                                                    <option value="Acaros">Ácaros</option>
                                                    <option value="Gusanos">Gusanos</option>
                                                    <option value="Podredumbre de raíces">Podredumbre de raíces</option>
                                                    <option value="Mildiu polvoriento">Mildiú polvoriento</option>
                                                    <option value="Roya">Roya</option>
                                                    <option value="Tizon">Tizón</option>
                                                    <option value="Nematodos">Nematodos</option>
                                                    <option value="Mildiu hondo">Mildiú hondo</option>
                                                </select>
                                            </div>
                                            <div class="form-group mb-4">
                                                <label>Recomendaciones de uso:</label>
                                                <input type="text" name="txtRecomendedDose" class="form-control" value="${product.recomended_dose}" required>
                                            </div>
                                            <div class="form-group mb-4">
                                                <label>Precauciones:</label>
                                                <input type="text" name="txtPrecautions" class="form-control" value="${product.precautions}" required>
                                            </div>
                                        </div>
                                    </div>

                                    <input type="hidden" name="redirect" value="productos">
                                    <button type="submit" name="accion" value="Actualizar" class="btn" style="background-color: #2E5B3C; color: white ">Actualizar Producto</button>
                                </form>
                            </div>
                        </c:when>



                                    <c:when test="${param.page == 'compras'}">
                                <h2 class="text-center text-4xl font-bold my-6 text-green-700">Lista de Compras</h2>
                                <div class="mb-4">

                                </div>
                                        <div style="display: flex; justify-content: space-between; align-items: center;">
                                            <a href="" data-toggle="modal" data-target="#addCompra" class="inline-block bg-gradient-to-r from-green-700 to-green-700 text-white font-semibold py-2 px-4 rounded-lg shadow-md transform hover:scale-105 hover:shadow-lg transition duration-300" style="background-color: #385c42; color: #ffffff">Agregar Compra</a>
                                        </div>
                                <div class="space-y-4">
                                    <div></div>
                                    <div></div>
                                    <div></div>
                                </div>
                                        <div style="max-height: 400px; overflow-y: auto;">

                                            <table class="min-w-full bg-white shadow-lg rounded-lg overflow-hidden">
                                                <thead class=" text-white" style="background-color: #2E5B3C">
                                                <tr>
                                                    <th class="py-3 px-4 text-left">ID Compra</th>
                                                    <th class="py-3 px-4 text-left">Precio Total</th>
                                                    <th class="py-3 px-4 text-left">Proveedor</th>
                                                    <th class="py-3 px-4 text-left">Cantidad de productos Comprados</th>
                                                    <th class="py-3 px-4 text-left">Fecha Compra</th>
                                                    <th class="py-3 px-4 text-center">Acciones</th>
                                                </tr>
                                                </thead>
                                                <tbody class="bg-white divide-y divide-gray-200">
                                                <%
                                                    BuysDAO buysDAO = new BuysDAO();
                                                    List<Buys> comprasList = buysDAO.listarCompras();
                                                    for (Buys compra : comprasList) {
                                                %>
                                                <tr class="hover:bg-gray-100 transition duration-200">
                                                    <td class="py-2 px-4 border-b"><%= compra.getBuys_Id() %></td>
                                                    <td class="py-2 px-4 border-b"><%= compra.getBuys_price() %></td>
                                                    <td class="py-2 px-4 border-b"><%= compra.getSupplierName() %></td>
                                                    <td class="py-2 px-4 border-b"><%= compra.getTotalQuantity() %></td>
                                                    <td class="py-2 px-4 border-b"><%= compra.getBuys_date() %></td>
                                                    <td class="py-2 px-4 border-b ">
                                                        <div class="flex space-x-2">
                                                            <a href="comprasController?accion=editarcompra&id=<%=compra.getBuys_Id()%>&page=editbuys" class="flex-1 bg-yellow-500 text-white px-4 py-2 rounded hover:bg-yellow-400 text-center">
                                                                Editar
                                                            </a>
                                                            <a href="comprasController?accion=detallesCompra&id=<%= compra.getBuys_Id() %>" class="flex-1 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-400 text-center">
                                                                Ver Detalles
                                                            </a>
                                                            <a href="comprasController?accion=reportes&id=<%= compra.getBuys_Id() %>" class="flex-1 bg-green-500 text-white px-4 py-2 rounded hover:bg-green-400 text-center">
                                                                Ir a reportes
                                                            </a>
                                                        </div>

                                                    </td>
                                                </tr>
                                                <%
                                                    }
                                                %>
                                                </tbody>
                                            </table>




                                        <div class="modal fade" id="addCompra" tabindex="-1" role="dialog" aria-labelledby="addCompraLabel" aria-hidden="true">
                                                <div class="modal-dialog modal-lg" role="document">
                                                    <div class="modal-content">
                                                        <div class="modal-header text-white" style="background:#385c42;">
                                                            <h5 class="modal-title" id="addCompraLabel">Agregar Compra</h5>
                                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                <span aria-hidden="true">&times;</span>
                                                            </button>
                                                        </div>
                                                        <div class="modal-body">
                                                            <form  action="comprasController"   method="post" id="purchaseForm" class="container mt-4">
                                                                <input type="hidden" name="accion" value="agregarCompras">
                                                                <%
                                                                    SuppliersDAO add = new SuppliersDAO();
                                                                    List<Suppliers> list = add.listar();
                                                                    request.setAttribute("proveedor", list);
                                                                %>
                                                                <div class="form-group">
                                                                    <label >Proveedor:</label>
                                                                    <select class="form-control" name="supplier">
                                                                        <option value="">Seleccione un Proveedor</option>
                                                                        <c:forEach items="${proveedor}" var="pro">
                                                                            <option value="${pro.suppliers_id}">${pro.supplers_name}</option>
                                                                        </c:forEach>
                                                                    </select>
                                                                </div>
                                                                <%
                                                                    ProductsDAO pr = new ProductsDAO();
                                                                    List<Products> list1 = pr.listar();
                                                                    request.setAttribute("prod", list1);
                                                                %>
                                                                <div style="max-height: 600px; overflow-y: auto; border: 1px solid #ddd; padding: 10px;">
                                                                <div id="productList">
                                                                    <div class="product-item mb-3">
                                                                        <label>Producto:</label>
                                                                        <select class="form-control" name="productId[]">
                                                                            <option value="">Seleccione el Producto</option>
                                                                            <c:forEach items="${prod}" var="pr">
                                                                                <option value="${pr.products_id}">${pr.comercial_name}</option>
                                                                            </c:forEach>
                                                                        </select>

                                                                        <label>Cantidad:</label>
                                                                        <input type="number" class="form-control quantity" name="quantity[]" min="1"  required oninput="updateTotalPrice()">

                                                                        <label>Precio Unitario:</label>
                                                                        <input type="number" class="form-control unit_price" name="unit_price[]" min="0" step="0.01" required oninput="updateTotalPrice()">
                                                                        <label>Fecha de Compra:</label>
                                                                        <input type="date" class="form-control" name="buys_date" required>

                                                                        <label>Lote:</label>
                                                                        <input type="text" class="form-control" name="batch[]" required>

                                                                        <label>Fecha de Caducidad:</label>
                                                                        <input type="date" class="form-control" name="expire_date[]" required>

                                                                        <label>Presentación:</label>
                                                                        <input type="text" class="form-control" name="presentation[]" required>

                                                                        <label>Registro Sanitario:</label>
                                                                        <input type="text" class="form-control" name="health_record[]" required>

                                                                    </div>
                                                                </div>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label>Precio Total:</label>
                                                                    <input type="text" class="form-control" name="buys_price" id="buys_price" readonly>
                                                                </div>

                                                                <div class="flex justify-between mb-4">
                                                                    <button type="button" id="addProduct" class="bg-gray-600 text-white font-semibold py-2 px-4 rounded hover:bg-gray-500 transition duration-300">
                                                                        Agregar otro producto
                                                                    </button>
                                                                    <button type="submit" class="bg-blue-600 text-white font-semibold py-2 px-4 rounded hover:bg-blue-500 transition duration-300">
                                                                        Registrar Compra
                                                                    </button>
                                                                </div>
                                                            </form>

                                                            <script>
                                                                function updateTotalPrice() {
                                                                    const quantities = document.querySelectorAll('.quantity');
                                                                    console.log(quantities)
                                                                    const unitPrices = document.querySelectorAll('.unit_price');
                                                                    let total = 0;

                                                                    for (let i = 0; i < quantities.length; i++) {
                                                                        const quantity = parseInt(quantities[i].value) || 0;
                                                                        const unitPrice = parseFloat(unitPrices[i].value) || 0;
                                                                        total += quantity * unitPrice;
                                                                    }

                                                                    document.getElementById('buys_price').value = total.toFixed(2); // Actualiza el precio total
                                                                }
                                                                document.getElementById('addProduct').addEventListener('click', function() {
                                                                    const productItem = document.createElement('div');
                                                                    productItem.classList.add('product-item', 'mb-3');
                                                                    productItem.innerHTML = `
                                                                    <label>Producto:</label>
                                                                    <select class="form-control" name="productId[]">
                                                                        <option value="">Seleccione el Producto</option>
                                                                         <c:forEach items="${prod}" var="pr">
                                                                         <option value="${pr.products_id}">${pr.comercial_name}</option>
                                                                         </c:forEach>
                                                                    </select>
                                                                        <label>Cantidad:</label>
                                                                        <input type="number" class="form-control quantity" name="quantity[]" min="1"  required oninput="updateTotalPrice()">

                                                                        <label>Precio Unitario:</label>
                                                                        <input type="number" class="form-control unit_price" name="unit_price[]" min="0" step="0.01" required oninput="updateTotalPrice()">

                                                                        <label>Lote:</label>
                                                                        <input type="text" class="form-control" name="batch[]" required>

                                                                        <label>Fecha de Caducidad:</label>
                                                                        <input type="date" class="form-control" name="expire_date[]" required>

                                                                        <label>Presentación:</label>
                                                                        <input type="text" class="form-control" name="presentation[]" required>

                                                                        <label>Registro Sanitario:</label>
                                                                        <input type="text" class="form-control" name="health_record[]" required>
                        `;
                                                                    document.getElementById('productList').appendChild(productItem);
                                                                });
                                                            </script>

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                        </c:when>

                                    <c:when test="${param.accion == 'detallesCompra'}">
                                            <div class="container mx-auto p-4 bg-white rounded-lg">
                                                <h2 class="text-agrochemical text-2xl font-bold text-center mb-4">Detalles de la Compra</h2>

                                                <%
                                                    int compraId = Integer.parseInt(request.getParameter("id"));
                                                    BuysDetail de = new BuysDetail();
                                                    List<Buys_detail> detalles = de.listarDetallesPorCompra(compraId);
                                                %>

                                                <div class="overflow-x-auto">
                                                    <table class="min-w-full bg-white border border-gray-300 rounded-lg">
                                                        <thead>
                                                        <tr class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
                                                            <th class="py-3 px-4 text-left">ID Detalle</th>
                                                            <th class="py-3 px-4 text-left">Producto</th>
                                                            <th class="py-3 px-4 text-left">Cantidad</th>
                                                            <th class="py-3 px-4 text-left">Precio Unitario</th>
                                                            <th class="py-3 px-4 text-left">Total</th>
                                                            <th class="py-3 px-4 text-left">Lote</th>
                                                            <th class="py-3 px-4 text-left">Fecha de Caducidad</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody class="text-gray-600 text-sm font-light">
                                                        <%
                                                            for (Buys_detail detalle : detalles) {
                                                        %>
                                                        <tr class="border-b hover:bg-gray-100">
                                                            <td class="py-2 px-4 text-left"><%= detalle.getBuyDetailId() %></td>
                                                            <td class="py-2 px-4 text-left"><%= detalle.getComercialName() %></td>
                                                            <td class="py-2 px-4 text-left"><%= detalle.getQuantity() %></td>
                                                            <td class="py-2 px-4 text-left"><%= detalle.getUnitPrice() %></td>
                                                            <td class="py-2 px-4 text-left"><%= detalle.getTotalDetail() %></td>
                                                            <td class="py-2 px-4 text-left"><%= detalle.getBatch() %></td>
                                                            <td class="py-2 px-4 text-left"><%= detalle.getExpireDate() %></td>
                                                        </tr>
                                                        <%
                                                            }
                                                        %>
                                                        </tbody>
                                                    </table>
                                                </div>

                                                <div class="mt-4 text-center">
                                                    <button type="button" class="bg-green-500 text-black font-semibold py-2 px-4 rounded-lg hover:bg-green-600 transition duration-300" onclick="location.href='controlador?accion=listar&page=compras'">Regresar</button>
                                                </div>
                                            </div>


                                            ``
                                    </c:when>
                                            <c:when test="${param.page == 'editbuys'}">
                                                <style>
                                                    h2 {
                                                        font-family: 'Roboto', sans-serif;
                                                        font-weight: 700; /* Negrita */
                                                        font-size: 2rem; /* Ajusta el tamaño */
                                                        color: white; /* Color azul (Bootstrap) */
                                                        text-align: center; /* Centrar el texto */
                                                    }
                                                    .custom-header {
                                                        background-color: #2E5B3C; /* Verde Bosque */
                                                        color: white; /* Blanco */
                                                        font-weight: bold; /* Opcional: hacer el texto más grueso */
                                                    }

                                                    .card-header {
                                                        background-color: #2E5B3C; /* Color personalizado para la cabecera de la tarjeta */
                                                    }

                                                    .card-body {
                                                        background-color: #f9f9f9; /* Color personalizado para el cuerpo de la tarjeta */
                                                    }

                                                    .form-control {
                                                        border-color: #2E5B3C; /* Color personalizado para los bordes de los campos de formulario */
                                                    }

                                                    .btn-primary {
                                                        background-color: #2E5B3C; /* Color personalizado para el botón de envío */
                                                    }
                                                </style>
                                                <div class="container mt-5">
                                                    <div class="row justify-content-center">
                                                        <div class="col-md-8">
                                                            <div class="card shadow-sm border-success">
                                                                <div class="card-header bg-success text-white text-center">
                                                                    <h2 class="mb-0">Editar Compras</h2>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <form action="comprasController" method="post" class="bg-light p-4 rounded shadow mt-4">

                                                        <input type="hidden" name="buy_id" value="${compra.buys_Id}">
                                                        <input type="hidden" name="accion" value="actualizarDetalle">

                                                        <div class="form-group">
                                                            <label for="buys_date" class="font-weight-bold">Fecha de Compra:</label>
                                                            <input type="date" class="form-control" id="buys_date" name="buys_date" value="${compra.buys_date}">
                                                        </div>

                                                        <div class="form-group">
                                                            <%
                                                                SuppliersDAO add = new SuppliersDAO();
                                                                List<Suppliers> list = add.listar();
                                                                request.setAttribute("proveedor", list);
                                                            %>
                                                            <label for="supplier" class="font-weight-bold">Proveedor:</label>
                                                            <select name="supplier" class="form-control" id="supplier">
                                                                <option value="${compra.supplierId}">${compra.supplierName}</option>
                                                                <c:forEach items="${proveedor}" var="pro">
                                                                    <option value="${pro.suppliers_id}">${pro.supplers_name}</option>
                                                                </c:forEach>
                                                            </select>
                                                        </div>

                                                        <h3 class="mt-4 text-secondary">Detalles de la Compra</h3>
                                                        <div style="max-height: 300px; overflow-y: auto; border: 1px solid #ddd; padding: 10px;">
                                                            <div id="detailsList">
                                                                <c:forEach items="${detalles}" var="detalle">
                                                                    <div class="detail-item mb-4 p-3 border rounded bg-white shadow-sm">

                                                                        <input type="hidden" name="detail_id[]" value="${detalle.buyDetailId}">

                                                                        <%

                                                                        %>

                                                                        <div class="form-group">
                                                                            <label for="productId_${detalle.fkproduct_id}" class="font-weight-bold">Producto:</label>
                                                                            <%
                                                                                ProductsDAO pro = new ProductsDAO();
                                                                                List<Products> pr = pro.listar();
                                                                                request.setAttribute("prodd", pr);
                                                                            %>
                                                                            <select name="productId[]" class="form-control" id="productId_${detalle.buyDetailId}">
                                                                                <option value="${detalle.fkproduct_id}">${detalle.comercialName}</option>
                                                                                <c:forEach items="${prodd}" var="producto">
                                                                                    <option value="${producto.products_id}">${producto.comercial_name}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <label for="quantity_${detalle.buyDetailId}" class="font-weight-bold">Cantidad:</label>
                                                                            <input type="number" class="form-control quantity" id="quantity_${detalle.buyDetailId}" name="quantity[]" value="${detalle.quantity}" oninput="updateTotalPrice()">
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <label for="unit_price_${detalle.buyDetailId}" class="font-weight-bold">Precio Unitario:</label>
                                                                            <input type="text" class="form-control unit_price" id="unit_price_${detalle.buyDetailId}" name="unit_price[]" value="${detalle.unitPrice}" oninput="updateTotalPrice()">
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <label for="batch_${detalle.buyDetailId}" class="font-weight-bold">Lote:</label>
                                                                            <input type="text" class="form-control" id="batch_${detalle.buyDetailId}" name="batch[]" value="${detalle.batch}">
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <label for="expire_date_${detalle.buyDetailId}" class="font-weight-bold">Fecha de Caducidad:</label>
                                                                            <input type="date" class="form-control" id="expire_date_${detalle.buyDetailId}" name="expire_date[]" value="${detalle.expireDate}">
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <label for="presentation_${detalle.buyDetailId}" class="font -weight-bold">Presentación:</label>
                                                                            <input type="text" class="form-control" id="presentation_${detalle.buyDetailId}" name="presentation[]" value="${detalle.presentation}">
                                                                        </div>

                                                                        <div class="form-group">
                                                                            <label for="health_record_${detalle.buyDetailId}" class="font-weight-bold">Registro Sanitario:</label>
                                                                            <input type="text" class="form-control" id="health_record_${detalle.buyDetailId}" name="health_record[]" value="${detalle.healthRecord}">
                                                                        </div>
                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="buys_price" class="font-weight-bold">Precio Total:</label>
                                                            <input type="text" class="form-control" id="buys_price" name="buys_price" value="${compra.buys_price}" readonly>
                                                        </div>

                                                        <div class="row mb-4">
                                                            <div class="col-md-6">
                                                                <button type="submit" class="btn btn-primary btn-block">Actualizar Compra</button>
                                                            </div>
                                                            <div class="col-md-6 d-flex justify-content-end">
                                                                <button type="button" class="btn btn-secondary"  onclick="location.href='controlador?accion=listar&page=compras'">Cancelar</button>
                                                            </div>
                                                        </div>
                                                    </form>
                                                </div>

                                                <script>
                                                    function updateTotalPrice() {
                                                        const quantities = document.querySelectorAll('.quantity');
                                                        const unitPrices = document.querySelectorAll('.unit_price');
                                                        let total = 0;

                                                        for (let i = 0; i < quantities.length; i++) {
                                                            const quantity = parseInt(quantities[i].value) || 0;
                                                            const unitPrice = parseFloat(unitPrices[i].value) || 0;
                                                            total += quantity * unitPrice;
                                                        }

                                                        document.getElementById('buys_price').value = total.toFixed(2); // Actualiza el precio total
                                                    }
                                                </script>
                                            </c:when>







                                            <c:when test="${param.page == 'reportes'}">
                                            <style>
                                                .container {
                                                    margin-top: 50px;
                                                    background-color: white;
                                                    padding: 20px;
                                                    border-radius: 8px;
                                                }
                                                .table {
                                                    margin-bottom: 40px;
                                                    width: 100%;
                                                    border-collapse: collapse;
                                                }
                                                .table-bordered td,
                                                .table-bordered th {
                                                    border: 1px solid #ddd;
                                                    padding: 8px;
                                                    text-align: left;
                                                }
                                                .table th {
                                                    background-color: #f7f7f7;
                                                    text-transform: uppercase;
                                                    font-weight: bold;
                                                }
                                                .btn {
                                                    margin-right: 10px;
                                                }
                                            </style>

                                            <div class="container mt-5">
                                                <h2 class="text-center mb-4">Compra</h2>
                                                <form action="controlador?accion=guardarcompra" method="post">
                                                    <div class="row mb-4">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="proveedor">PROVEEDOR:</label>
                                                                <input type="text" class="form-control" id="proveedor" name="proveedor" value="${compraedit.supplierName}" placeholder="Proveedor" readonly>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="ruc">RUC:</label>
                                                                <input type="text" class="form-control" id="ruc" name="ruc" value="${compraedit.ruc_supplier}" placeholder="RUC" required>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row mb-4">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="numero_registro">NUMERO REGISTRO</label>
                                                                <input type="text" class="form-control" id="numero_registro" name="numero_registro" placeholder="Número de Registro" readonly>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="fecha_compra">FECHA DE COMPRA</label>
                                                                <input type="date" class="form-control" id="fecha_compra" value="${compraedit.buys_date}" name="fecha_compra" readonly>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <table class="table table-bordered" id="table">
                                                        <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Producto</th>
                                                            <th>Descripción</th>
                                                            <th>Presentación</th>
                                                            <th>Cantidad</th>
                                                            <th>Precio Unit</th>
                                                        </tr>
                                                        </thead>
                                                        <tbody id="detalle-compra">
                                                        <%
                                                            List<Buys_detail> detalles = (List<Buys_detail>) request.getAttribute("detalles");
                                                            BigDecimal total = BigDecimal.ZERO;
                                                            for (Buys_detail nuevo : detalles) {
                                                                BigDecimal unitPrice = nuevo.getUnitPrice();
                                                                BigDecimal quantity = BigDecimal.valueOf(nuevo.getQuantity());
                                                                total = total.add(unitPrice.multiply(quantity));
                                                        %>
                                                        <tr>
                                                            <td><%= nuevo.getBuyDetailId() %></td>
                                                            <td><%= nuevo.getComercialName() %></td>
                                                            <td><%= nuevo.getDescriptionProduct() %></td>
                                                            <td><%= nuevo.getPresentation() %></td>
                                                            <td><%= quantity %></td>
                                                            <td><%= unitPrice %></td>
                                                        </tr>
                                                        <%
                                                            }
                                                        %>
                                                        <tr>
                                                            <td colspan="5" style="text-align: right;"><strong>Total</strong></td>
                                                            <td><strong><%= total %></strong></td>
                                                        </tr>
                                                        </tbody>
                                                    </table>

                                                    <div class="text-center">
                                                        <button type="button" onclick="exportPdf()" class="btn" style="background-color: #ff0505; color: white">Exportar Pdf</button>
                                                        <button type="button" onclick="exportCSV()" class="btn" style="background-color: #396a45; color: white">Exportar a CSV</button>
                                                        <button type="button" class="btn btn-secondary" onclick="location.href='controlador?accion=listar&page=compras'">Regresar</button>
                                                    </div>
                                                </form>
                                            </div>

                                                            <script>
                                                                function exportCSV() {
                                                                    // Obtener datos del formulario
                                                                    const proveedor = document.getElementById('proveedor').value;
                                                                    const ruc = document.getElementById('ruc').value;
                                                                    const numeroRegistro = document.getElementById('numero_registro').value;
                                                                    const fechaCompra = document.getElementById('fecha_compra').value;

                                                                    // Crear un arreglo para el CSV
                                                                    const csvData = [];

                                                                    // Agregar los encabezados del formulario
                                                                    csvData.push(['Proveedor', proveedor]);
                                                                    csvData.push(['RUC', ruc]);
                                                                    csvData.push(['Número de Registro', numeroRegistro]);
                                                                    csvData.push(['Fecha de Compra', fechaCompra]);
                                                                    csvData.push([]); // Línea en blanco

                                                                    // Función para agregar la tabla al CSV
                                                                    function addTableToCSV(tableId) {
                                                                        const table = document.getElementById(tableId);
                                                                        const rows = table.querySelectorAll('tr');

                                                                        // Iterar sobre las filas de la tabla
                                                                        rows.forEach(row => {
                                                                            const cols = row.querySelectorAll('th, td'); // Selecciona tanto th como td
                                                                            const rowData = Array.from(cols).map(col => col.innerText.replace(/,/g, '')); // Obtener texto y evitar comas
                                                                            csvData.push(rowData); // Agrega la fila al arreglo
                                                                        });
                                                                    }

                                                                    // Agregar la tabla al CSV
                                                                    addTableToCSV('table');

                                                                    // Crear el contenido CSV
                                                                    const csvContent = csvData.map(e => e.join(',')).join('\n'); // Une las filas

                                                                    // Crear un blob y generar un enlace para la descarga
                                                                    const blob = new Blob([csvContent], { type: 'text/csv;charset=utf-8;' });
                                                                    const link = document.createElement('a');
                                                                    const url = URL.createObjectURL(blob);

                                                                    link.setAttribute('href', url);
                                                                    link.setAttribute('download', 'compras.csv'); // Nombre del archivo
                                                                    document.body.appendChild(link);
                                                                    link.click(); // Simula un clic para descargar
                                                                    document.body.removeChild(link); // Limpia el DOM
                                                                }
                                                            </script>


                                                            <script>
                                                                window.jsPDF = window.jspdf.jsPDF;

                                                                function exportPdf() {
                                                                    // Crear un PDF en formato horizontal (landscape)
                                                                    var pdf = new jsPDF('l', 'mm', 'a4');

                                                                    // Cargar la fuente de Times New Roman
                                                                    pdf.addFileToVFS("TimesNewRoman.ttf", "base64_encoded_data_here"); // Reemplaza con el base64 de la fuente
                                                                    pdf.addFont("TimesNewRoman.ttf", "TimesNewRoman", "normal");
                                                                    pdf.setFont("TimesNewRoman");

                                                                    // Obtener el número de registro y la fecha de compra
                                                                    var proveedor =  document.getElementById("proveedor").value;
                                                                    var ruc =  document.getElementById("ruc").value;
                                                                    var numeroRegistro = document.getElementById("numero_registro").value;
                                                                    var fechaCompra = document.getElementById("fecha_compra").value;

                                                                    // Añadir los campos al PDF
                                                                    pdf.text(20, 20, "Proveedor:");
                                                                    pdf.text(60, 20, proveedor);
                                                                    pdf.text(20, 30, "RUC:");
                                                                    pdf.text(60, 30, ruc);

                                                                    // Añadir los campos de número de registro y fecha de compra
                                                                    pdf.text(160, 20, "Número de Registro:");
                                                                    pdf.text(220, 20, numeroRegistro);
                                                                    pdf.text(160, 30, "Fecha de Compra:");
                                                                    pdf.text(220, 30, fechaCompra);

                                                                    // Agregar espacio antes del título de detalles de compra
                                                                    pdf.text(20, 50, "Detalles de Compra:");

                                                                    // Cambiar el estilo de la tabla
                                                                    pdf.autoTable({
                                                                        html: '#table',
                                                                        startY: 60, // Comienza la tabla un poco más abajo
                                                                        theme: 'grid',
                                                                        styles: {
                                                                            cellPadding: 5,  // Espaciado dentro de las celdas
                                                                            fontSize: 10,     // Tamaño de letra de las celdas
                                                                            lineColor: [0, 0, 0], // Color de línea de la tabla
                                                                            fillColor: [255, 255, 255], // Color de fondo de las celdas
                                                                            textColor: [0, 0, 0], // Color del texto
                                                                            minCellHeight: 10   // Altura mínima de las celdas
                                                                        },
                                                                        columnStyles: {
                                                                            0: { cellWidth: 20 },
                                                                            1: { cellWidth: 60 },
                                                                            2: { cellWidth: 40 },
                                                                            3: { cellWidth: 60 },
                                                                            4: { cellWidth: 30 },
                                                                            5: { cellWidth: 30 }
                                                                        },
                                                                        headStyles: {
                                                                            fillColor: [100, 100, 250], // Color de fondo del encabezado
                                                                            textColor: [255, 255, 255], // Color del texto del encabezado
                                                                            fontSize: 12,                // Tamaño de letra del encabezado
                                                                            halign: 'center'              // Alineación del texto del encabezado
                                                                        },
                                                                        bodyStyles: { lineColor: [0, 0, 0] }
                                                                    });

                                                                    // Abrir el PDF
                                                                    window.open(URL.createObjectURL(pdf.output("blob")));
                                                                }
                                                            </script>

                                                        </form>
                                                    </div>
                                                </div>
                                            </div>
                                            </c:when>




                                            <c:when test="${param.page == 'ventas'}">
                                                <h1 style="font-size: 100px">PROXIMAMENTE</h1>
                                                <!-- Aquí puedes incluir el contenido para ventas -->
                                            </c:when>
                                            <c:when test="${param.page == 'busqueda'}">
                                            <div class="container mx-auto mt-10">
                                                <h2 class="text-center text-4xl font-bold my-6 text-green-700">Lista de Productos</h2>
                                                <div class="flex justify-between items-center mb-4">
                                                    <a href="" data-toggle="modal" data-target="#addProductModal" data-accion="add" class="inline-block bg-gradient-to-r from-green-700 to-green-700 text-white font-semibold py-2 px-4 rounded-lg shadow-md transform hover:scale-105 hover:shadow-lg transition duration-300">
                                                        Agregar
                                                    </a>

                                                    <a href="controlador?accion=listar&page=inactivos" class="inline-block bg-gradient-to-r from-green-700 to-green-700 text-white font-semibold py-2 px-6 rounded-lg shadow-lg transform hover:scale-105 hover:shadow-2xl transition duration-300">
                                                        Mostrar inactivos
                                                    </a>
                                                </div>
                                                <div class="mb-4">
                                                    <form action="controlador" method="post" class="flex items-center space-x-2 mb-4">
                                                        <input type="text" name="searchQuery" placeholder="ID / MARCA / CULTIVO" required
                                                               class="w-full max-w-xs p-2 border border-gray-300 rounded-lg shadow-md focus:outline-none focus:ring-2 focus:ring-green-500 transition duration-300">

                                                        <button type="submit" name="accion" value="buscarProductos"
                                                                class=" text-white font-semibold py-2 px-4 rounded-lg shadow-md transform hover:scale-105 hover:shadow-lg transition duration-300" style="background-color: #2E5B3C">
                                                            Search
                                                        </button>
                                                    </form>
                                                </div>


                                                <div class="overflow-x-auto">

                                                    <table class="min-w-full bg-white shadow-lg rounded-lg overflow-hidden">
                                                        <thead class=" text-white" style="background-color: #2E5B3C">
                                                        <tr>
                                                            <th class="py-3 px-4 text-left">ID</th>
                                                            <th class="py-3 px-4 text-left">Nombre Comercial</th>
                                                            <th class="py-3 px-4 text-left">Nombre Genérico</th>
                                                            <th class="py-3 px-4 text-left">Formulación</th>
                                                            <th class="py-3 px-4 text-left">Marca</th>
                                                            <th class="py-3 px-4 text-left">Descripción</th>
                                                            <th class="py-3 px-4 text-left">Categoría</th>
                                                            <th class="py-3 px-4 text-left">Precio Venta</th>
                                                            <th class="py-3 px-4 text-left">Unidad de Medida</th>
                                                            <th class="py-3 px-4 text-left">Estado</th>
                                                            <th class="py-3 px-4 text-left">Concentración</th>
                                                            <th class="py-3 px-4 text-left">Medida de Concentración</th>
                                                            <th class="py-3 px-4 text-left">Modo de Uso</th>
                                                            <th class="py-3 px-4 text-left">Cultivos</th>
                                                            <th class="py-3 px-4 text-left">Enfermedades o Plagas</th>
                                                            <th class="py-3 px-4 text-left">Dosis Recomendada</th>
                                                            <th class="py-3 px-4 text-left">Precauciones</th>
                                                            <th class="py-3 px-4 text-left">Cantidad</th>
                                                            <th class="py-3 px-4 text-left">Acciones</th>
                                                        </tr>
                                                        </thead>
                                                        <c:choose>
                                                            <c:when test="${not empty respuesta}">
                                                                <c:forEach var="producto" items="${respuesta}">
                                                        <tbody class="text-gray-700">
                                                        <tr class="hover:bg-gray-100 transition duration-200">
                                                            <td class="py-2 px-4 border-b">${producto.products_id}</td>
                                                            <td class="py-2 px-4 border-b">${producto.comercial_name}</td>
                                                            <td class="py-2 px-4 border-b">${producto.generic_name}</td>
                                                            <td class="py-2 px-4 border-b">${producto.formulation}</td>
                                                            <td class="py-2 px-4 border-b">${producto.brand}</td>
                                                            <td class="py-2 px-4 border-b">${producto.description}</td>
                                                            <td class="py-2 px-4 border-b">${producto.category}</td>
                                                            <td class="py-2 px-4 border-b">${producto.sales_price}</td>
                                                            <td class="py-2 px-4 border-b">${producto.unit}</td>
                                                            <td class="py-2 px-4 border-b">${producto.status}</td>
                                                            <td class="py-2 px-4 border-b">${producto.concentration}</td>
                                                            <td class="py-2 px-4 border-b">${producto.concentration_unit}</td>
                                                            <td class="py-2 px-4 border-b">${producto.action_mode}</td>
                                                            <td class="py-2 px-4 border-b">${producto.crops}</td>
                                                            <td class="py-2 px-4 border-b">${producto.pests_Diseases}</td>
                                                            <td class="py-2 px-4 border-b">${producto.recomended_dose}</td>
                                                            <td class="py-2 px-4 border-b">${producto.precautions}</td>
                                                            <td class="py-2 px-4 border-b">${producto.quantity}</td>
                                                            <td class="py-2 px-4 border-b">
                                                                <a href="controlador?accion=editar&id=${producto.products_id}&page=EditarProductos" class="btn bg-green-700 text-white py-1 px-3 rounded shadow hover:bg-green-600">
                                                                    Editar
                                                                </a>
                                                                <a href="controlador?accion=eliminar&id=${producto.products_id}" class="btn bg-red-600 text-white py-1 px-3 rounded shadow hover:bg-red-500">
                                                                    Eliminar
                                                                </a>
                                                            </td>
                                                        </tr>
                                                            </c:forEach>
                                                        </c:when>

                                                        </c:choose>

                                                        </tbody>
                                                    </table>


                                                    <div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalLabel" aria-hidden="true">
                                                        <div class="modal-dialog modal-lg" role="document">
                                                            <div class="modal-content rounded-lg shadow-lg">
                                                                <div class="modal-header  text-white rounded-t-lg" style="background-color: #2E5B3C">
                                                                    <h5 class="modal-title" id="addProductModalLabel">Agregar Producto</h5>
                                                                    <button type="button" data-dismiss="modal" aria-label="Close" class="text-white hover:text-gray-200">
                                                                        <i class="lni lni-exit"></i>
                                                                    </button>
                                                                </div>
                                                                <div class="modal-body p-6 bg-white">
                                                                    <form action="controlador" method="post">
                                                                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                                                            <div>
                                                                                <label class="block text-sm font-medium text-gray-700">Nombre Comercial:</label>
                                                                                <input type="text" name="txtComercialName" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                            </div>
                                                                            <div>
                                                                                <label class="block text-sm font-medium text-gray-700">Nombre Genérico:</label>
                                                                                <input type="text" name="txtGenericName" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                            </div>
                                                                            <div>
                                                                                <label class="block text-sm font-medium text-gray-700">Formulación:</label>
                                                                                <select name="txtFormulation" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                                    <option value="">Seleccione una opción</option>
                                                                                    <option value="Suspensión Concentrada (SC)">Suspensión Concentrada (SC)</option>
                                                                                    <option value="Emulsión (EC)">Emulsión (EC)</option>
                                                                                    <option value="Polvo Mojable (WP)">Polvo Mojable (WP)</option>
                                                                                    <option value="Granulado (GR)">Granulado (GR)</option>
                                                                                    <option value="Concentrado Soluble (SL)">Concentrado Soluble (SL)</option>
                                                                                    <option value="Gel">Gel</option>
                                                                                    <option value="Tabletas">Tabletas</option>
                                                                                    <option value="Aerosoles">Aerosoles</option>
                                                                                </select>
                                                                            </div>
                                                                            <div>
                                                                                <label class="block text-sm font-medium text-gray-700">Marca:</label>
                                                                                <select name="txtBrand" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" id="brandSelect" required>
                                                                                    <option value="">Seleccione una marca</option>
                                                                                    <option value="BASF">BASF</option>
                                                                                    <option value="Bayer">Bayer</option>
                                                                                    <option value="Syngenta">Syngenta</option>
                                                                                    <option value="Corteva">Corteva Agriscience</option>
                                                                                    <option value="FMC Corporation">FMC Corporation</option>
                                                                                    <option value="Adama">Adama</option>
                                                                                    <option value="Nufarm">Nufarm</option>
                                                                                    <option value="Monsanto">Monsanto</option>
                                                                                    <option value="Sumitomo Chemical">Sumitomo Chemical</option>
                                                                                    <option value="Zhejiang Yongnong">Zhejiang Yongnong</option>
                                                                                    <option value="UPL">UPL</option>
                                                                                    <option value="Arysta LifeScience">Arysta LifeScience</option>
                                                                                    <option value="Koppert">Koppert</option>
                                                                                    <option value="Agroquímicos Perú">Agroquímicos Perú</option>
                                                                                    <option value="Fertiperú">Fertilizantes del Perú</option>
                                                                                    <option value="Agroindustrias San Miguel">Agroindustrias San Miguel</option>
                                                                                    <option value="Proquiper">Productos Químicos de Perú</option>
                                                                                    <option value="Agrícola Mínima">Agrícola Mínima</option>
                                                                                    <option value="Agro Sostenible">Agro Sostenible</option>
                                                                                    <option value="Otra marca">Otra marca</option>
                                                                                </select>
                                                                                <div id="otherBrandInput" style="display: none;">
                                                                                    <input type="text" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" placeholder="Ingrese otra marca">
                                                                                </div>
                                                                            </div>
                                                                            <div>
                                                                                <label class="block text-sm font-medium text-gray-700">Descripción:</label>
                                                                                <input type="text" name="txtDescription" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                            </div>
                                                                            <div>
                                                                                <%
                                                                                    CategoryDAO catdao = new CategoryDAO();
                                                                                    List<Category> categories = catdao.listar(); // Llamada al método que retorna la lista
                                                                                    request.setAttribute("categories", categories); // Guardar en el request
                                                                                %>
                                                                                <label class="block text-sm font-medium text-gray-700">Categoría:</label>
                                                                                <select name="txtCategory" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                                    <option value="">Seleccione una categoría</option>
                                                                                    <c:forEach items="${categories}" var="category">
                                                                                        <option value="${category.categoryId}">${category.categoryName}</option>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </div>
                                                                            <div>
                                                                                <label class="block text-sm font-medium text-gray-700">Precio Venta:</label>
                                                                                <input type="number" name="txtPsale" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required min="0" step="0.01">
                                                                            </div>
                                                                            <div>
                                                                                <label class="block text-sm font-medium text-gray-700">Unidad:</label>
                                                                                <select name="txtUnit" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                                    <option value="">Seleccione una unidad de medida</option>
                                                                                    <option value="L">Litros (L)</option>
                                                                                    <option value="mL">Mililitros (mL)</option>
                                                                                    <option value="kg">Kilogramos (kg)</option>
                                                                                    <option value="g">Gramos (g)</option>
                                                                                </select>
                                                                            </div>
                                                                            <div>
                                                                                <label class="block text-sm font-medium text-gray-700">Concentración:</label>
                                                                                <input type="number" name="txtConcentration" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required min="0" step="0.01">
                                                                            </div>
                                                                            <div>
                                                                                <label class="block text-sm font-medium text-gray-700">Seleccione la medida de concentración:</label>
                                                                                <select id="concentration" name="txtConcentrationUnit" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                                    <option value="">Seleccione una opción</option>
                                                                                    <option value="% p/p">%p/p</option>
                                                                                    <option value="% v/v">%v/v</option>
                                                                                    <option value="g/L">g/L</option>
                                                                                    <option value="mg/L">mg/L</option>
                                                                                    <option value="mg/kg">mg/kg</option>
                                                                                    <option value="ppm">ppm</option>
                                                                                    <option value="M">M</option>
                                                                                    <option value="g/ha">g/ha</option>
                                                                                    <option value="lb/acre">lb/acre</option>
                                                                                    <option value="kg/ha">kg/ha</option>
                                                                                </select>
                                                                            </div>
                                                                            <div>
                                                                                <label class="block text-sm font-medium text-gray-700">Modo de Acción:</label>
                                                                                <input type="text" name="txtActionMode" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                            </div>
                                                                            <div>
                                                                                <%
                                                                                    CultivosDAO culdao = new CultivosDAO();
                                                                                    List<Cultivos> cultivos = culdao.listar();
                                                                                    request.setAttribute("cultivos", cultivos);
                                                                                %>
                                                                                <label class="block text-sm font-medium text-gray-700">Cultivos:</label>
                                                                                <select name="txtCrops" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                                    <option value="">Seleccione un cultivo</option>
                                                                                    <c:forEach items="${cultivos}" var="cultivo">
                                                                                        <option value="${cultivo.idCultivo}">${cultivo.nombreCultivo}</option>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                        <div class="form-group mb-4">
                                                                            <label for="pestsDiseases" class="block text-sm font-medium text-gray-700">Seleccione una enfermedad o plaga:</label>
                                                                            <select id="pestsDiseases" name="txtPestsDiseases" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                                <option value="">Seleccione una opción</option>
                                                                                <option value="Pulgones">Pulgones</option>
                                                                                <option value="Mosca blanca">Mosca blanca</option>
                                                                                <option value="Ácaros">Ácaros</option>
                                                                                <option value="Gusanos">Gusanos</option>
                                                                                <option value="Podredumbre de raíces">Podredumbre de raíces</option>
                                                                                <option value="Mildiú polvoriento">Mildiú polvoriento</option>
                                                                                <option value="Roya">Roya</option>
                                                                                <option value="Tizón">Tizón</option>
                                                                                <option value="Nematodos">Nematodos</option>
                                                                                <option value="Mildiú hondo">Mildiú hondo</option>
                                                                            </select>
                                                                        </div>
                                                                        <div class="form-group mb-4">
                                                                            <label class="block text-sm font-medium text-gray-700">Dosis Recomendadas:</label>
                                                                            <input type="text" name="txtRecomendedDose" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                        </div>
                                                                        <div class="form-group mb-4">
                                                                            <label class="block text-sm font-medium text-gray-700">Precauciones:</label>
                                                                            <input type="text" name="txtPrecautions" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-green-500 focus:ring focus:ring-green-200" required>
                                                                        </div>
                                                                        <button type="submit" name="accion" value="agregar" class="w-full py-2 px-4 bg-green-700 text-white rounded-lg hover:bg-green-600 transition">Agregar Producto</button>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                            </c:when>


                                            <c:when test="${param.page == 'configuraciones'}">
                            <h2 class="text-center">Configuraciones</h2>
                            <!-- Aquí puedes incluir el contenido para ventas -->
                        </c:when>
                        <c:otherwise>
                            <h2 class="text-center">Seleccione una opción</h2>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>

</div>
<script>
    function openEditProductModal(productData) {
        // Rellenar los campos del formulario con los datos del producto
        document.getElementById('comercialName').value = productData.comercialName;
        // Rellena el resto de campos según productData

        // Mostrar el modal
        $('#addProductModal').modal('show');
    }
    const toggler = document.querySelector(".toggler-btn");
    toggler.addEventListener("click", function () {
        document.querySelector("#sidebar").classList.toggle("collapsed");
    });

    <!-- Funcion para espacio para colocar otra marca -->
    document.getElementById('brandSelect').addEventListener('change', function() {
        const otherBrandInput = document.getElementById('otherBrandInput');
        if (this.value === 'Otra marca') {
            otherBrandInput.style.display = 'block';
        } else {
            otherBrandInput.style.display = 'none';
        }
    });



</script>
<script src="./js/jquery-3.7.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="./js/script.js"></script>
<script src="./js/validaciones.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
<script src="    https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.5.3/jspdf.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.6/jspdf.plugin.autotable.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.17.0/xlsx.full.min.js"></script>


</body>
</html>
