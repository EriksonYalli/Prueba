<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Editar Cliente Jurídico</title>
</head>
<body>
<h1>Editar Cliente Jurídico</h1>
<form action="${pageContext.request.contextPath}/actualizarClienteJuridico" method="post">
    <input type="hidden" name="id" value="${cliente.id}">
    <table>
        <tr>
            <td>Razón Social:</td>
            <td><input type="text" name="companyName" value="${cliente.companyName}" required></td>
        </tr>
        <tr>
            <td>RUC:</td>
            <td><input type="text" name="ruc" value="${cliente.ruc}" required></td>
        </tr>
        <tr>
            <td>Email:</td>
            <td><input type="email" name="email" value="${cliente.email}" required></td>
        </tr>
        <tr>
            <td>Dirección:</td>
            <td><input type="text" name="address" value="${cliente.address}"></td>
        </tr>
        <tr>
            <td>Teléfono:</td>
            <td><input type="tel" name="phone" value="${cliente.phone}"></td>
        </tr>
        <tr>
            <td>Estado:</td>
            <td>
                <select name="status" required>
                    <option value="A" ${cliente.status == 'A' ? 'selected' : ''}>Activo</option>
                    <option value="I" ${cliente.status == 'I' ? 'selected' : ''}>Inactivo</option>
                </select>
            </td>
        </tr>
    </table>
    <input type="submit" value="Actualizar">
    <a href="${pageContext.request.contextPath}/clientesjuridicos">Cancelar</a>
</form>
</body>
</html>