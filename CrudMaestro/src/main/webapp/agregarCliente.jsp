<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Cliente</title>
    <script>
        function toggleFields() {
            const tipoCliente = document.getElementById("typePerson").value;
            const personaNaturalFields = document.getElementById("personaNaturalFields");
            const personaJuridicaFields = document.getElementById("personaJuridicaFields");

            if (tipoCliente === "NATURAL") {
                personaNaturalFields.style.display = "block";
                personaJuridicaFields.style.display = "none";
            } else if (tipoCliente === "JURIDICA") {
                personaNaturalFields.style.display = "none";
                personaJuridicaFields.style.display = "block";
            } else {
                personaNaturalFields.style.display = "none";
                personaJuridicaFields.style.display = "none";
            }
        }
    </script>
</head>
<body onload="toggleFields()">
<h1>Agregar Cliente</h1>
<form action="agregarCliente" method="post">
    <!-- Selección del tipo de cliente -->
    <label for="typePerson">Tipo de Cliente:</label>
    <select id="typePerson" name="typePerson" onchange="toggleFields()" required>
        <option value="">Seleccionar...</option>
        <option value="NATURAL">Persona Natural</option>
        <option value="JURIDICA">Persona Jurídica</option>
    </select>

    <!-- Campos para Persona Natural -->
    <div id="personaNaturalFields" style="display: none;">
        <h3>Información de Persona Natural</h3>
        <label for="name">Nombre:</label>
        <input type="text" name="name" id="name" >

        <label for="lastName">Apellido:</label>
        <input type="text" name="lastName" id="lastName" >

        <label for="persona_email">Email:</label>
        <input type="email" name="persona_email" id="persona_email" >

        <label for="documentType">Tipo de Documento:</label>
        <input type="text" name="documentType" id="documentType" >

        <label for="documentNumber">Número de Documento:</label>
        <input type="text" name="documentNumber" id="documentNumber" >

        <label for="birthdate">Fecha de Nacimiento:</label>
        <input type="date" name="birthdate" id="birthdate" >

        <label for="persona_phone">Teléfono:</label>
        <input type="tel" name="persona_phone" id="persona_phone">

        <label for="persona_address">Dirección:</label>
        <input type="text" name="persona_address" id="persona_address">

        <label for="persona_status">Estado:</label>
        <select name="persona_status" id="persona_status">
            <option value="ACTIVO">Activo</option>
            <option value="INACTIVO">Inactivo</option>
        </select>
        <button type="submit">Agregar Cliente</button>
    </div>

    <!-- Campos para Persona Jurídica -->
    <div id="personaJuridicaFields" style="display: none;">
        <h3>Información de Persona Jurídica</h3>
        <label for="companyName">Razón Social:</label>
        <input type="text" name="companyName" id="companyName" >

        <label for="ruc">RUC:</label>
        <input type="text" name="ruc" id="ruc" >

        <label for="juridica_email">Email:</label>
        <input type="email" name="juridica_email"  id="juridica_email">

        <label for="juridica_address">Dirección:</label>
        <input type="text" name="juridica_address" id="juridica_address">

        <label for="juridica_phone">Teléfono:</label>
        <input type="tel" name="juridica_phone" id="juridica_phone">

        <label for="juridica_status">Estado:</label>
        <select name="juridica_status" id="juridica_status">
            <option value="ACTIVO">Activo</option>
            <option value="INACTIVO">Inactivo</option>
        </select>
        <button type="submit">Agregar Cliente</button>
    </div>


</form>
</body>
</html>