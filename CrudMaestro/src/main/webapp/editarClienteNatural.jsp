<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Cliente Natural</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
<div class="container mt-4">
    <h1 class="mb-4">Editar Cliente Natural</h1>

    <%-- Calcular la fecha máxima permitida (mayores de edad) --%>
    <%
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(new java.util.Date());
        calendar.add(Calendar.YEAR, -18); // Restar 18 años para obtener la fecha límite
        String fechaMaxima = new SimpleDateFormat("yyyy-MM-dd").format(calendar.getTime());
    %>

    <form action="${pageContext.request.contextPath}/actualizarCliente" method="post">
        <input type="hidden" name="id" value="${cliente.id}">
        <div class="form-group">
            <label for="name"><i class="fas fa-user"></i> Nombre:</label>
            <input type="text" id="name" name="name" class="form-control" value="${cliente.name}"
                   pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo letras y espacios" required>
        </div>
        <div class="form-group">
            <label for="lastName"><i class="fas fa-user"></i> Apellido:</label>
            <input type="text" id="lastName" name="lastName" class="form-control" value="${cliente.lastName}"
                   pattern="[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+" title="Solo letras y espacios" required>
        </div>
        <div class="form-group">
            <label for="documentType"><i class="fas fa-id-card"></i> Tipo de Documento:</label>
            <select id="documentType" name="documentType" class="form-control" required>
                <option value="DNI" ${cliente.documentType == 'DNI' ? 'selected' : ''}>DNI</option>
                <option value="CE" ${cliente.documentType == 'CE' ? 'selected' : ''}>CE</option>
            </select>
        </div>
        <div class="form-group">
            <label for="documentNumber"><i class="fas fa-file-alt"></i> Número de Documento:</label>
            <input type="text" id="documentNumber" name="documentNumber" class="form-control" value="${cliente.documentNumber}"
                   pattern="\d{8,20}" title="El número de documento debe tener entre 8 y 20 dígitos" required>
        </div>
        <div class="form-group">
            <label for="birthdate"><i class="fas fa-calendar-alt"></i> Fecha de Nacimiento:</label>
            <input type="date" id="birthdate" name="birthdate" class="form-control" value="${cliente.birthdate}"
                   max="<%= fechaMaxima %>" required>
        </div>
        <div class="form-group">
            <label for="phone"><i class="fas fa-phone"></i> Teléfono:</label>
            <input type="tel" id="phone" name="phone" class="form-control" value="${cliente.phone}"
                   pattern="9\d{8}" title="El teléfono debe tener 9 dígitos y comenzar con 9" required>
        </div>
        <div class="form-group">
            <label for="address"><i class="fas fa-home"></i> Dirección:</label>
            <input type="text" id="address" name="address" class="form-control" value="${cliente.address}">
        </div>
        <div class="form-group">
            <label for="email"><i class="fas fa-envelope"></i> Email:</label>
            <input type="email" id="email" name="email" class="form-control" value="${cliente.email}"
                   required>
        </div>
        <div class="form-group">
            <label for="status"><i class="fas fa-check-circle"></i> Estado:</label>
            <select id="status" name="status" class="form-control" required>
                <option value="A" ${cliente.status == 'A' ? 'selected' : ''}>Activo</option>

            </select>
        </div>
        <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Actualizar</button>
        <a href="${pageContext.request.contextPath}/clientes" class="btn btn-secondary"><i class="fas fa-times"></i> Cancelar</a>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
