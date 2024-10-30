<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Proveedor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container">
    <h2 class="mb-4">Editar Proveedor</h2>
    <form action="editarSupplier" method="post" onsubmit="return validateForm()">
        <input type="hidden" name="id" value="${supplier.id}"/>

        <div class="mb-3">
            <label for="name" class="form-label">Razón Social</label>
            <input type="text" class="form-control" id="name" name="name" value="${supplier.name}" required>
        </div>

        <div class="mb-3">
            <label for="direction" class="form-label">Dirección</label>
            <input type="text" class="form-control" id="direction" name="direction" value="${supplier.direction}" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Correo Electrónico</label>
            <input type="email" class="form-control" id="email" name="email" value="${supplier.email}" required>
        </div>

        <div class="mb-3">
            <label for="ruc" class="form-label">RUC</label>
            <input type="text" class="form-control" id="ruc" name="ruc" value="${supplier.ruc}" required>
        </div>

        <div class="mb-3">
            <label for="representative" class="form-label">Representante</label>
            <input type="text" class="form-control" id="representative" name="representative" value="${supplier.representative}" required>
        </div>

        <div class="mb-3">
            <label for="emailRepresentative" class="form-label">Correo del Representante</label>
            <input type="email" class="form-control" id="emailRepresentative" name="emailRepresentative" value="${supplier.emailRepresentative}" required>
        </div>

        <div class="mb-3">
            <label for="phoneRepresentative" class="form-label">Teléfono del Representante</label>
            <input type="tel" class="form-control" id="phoneRepresentative" name="phoneRepresentative" value="${supplier.phoneRepresentative}" required>
        </div>

        <button type="submit" class="btn btn-danger">Actualizar Proveedor</button>
        <a href="listarSupplier" class="btn btn-secondary">Cancelar</a>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function validateForm() {
        const name = document.getElementById("name").value;
        const direction = document.getElementById("direction").value;
        const email = document.getElementById("email").value;
        const ruc = document.getElementById("ruc").value;
        const representative = document.getElementById("representative").value;
        const emailRepresentative = document.getElementById("emailRepresentative").value;
        const phoneRepresentative = document.getElementById("phoneRepresentative").value;

        // Validación de campos vacíos
        if (!name || !direction || !email || !ruc || !representative || !emailRepresentative || !phoneRepresentative) {
            alert("Por favor, complete todos los campos.");
            return false;
        }

        // Validación de nombre (solo letras y espacios)
        if (!/^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$/.test(name)) {
            alert("Por favor ingrese bien la Razón social.");
            return false;
        }

        // Validación de dirección (mínimo 5 caracteres)
        if (direction.length < 5) {
            alert("La Dirección debe tener al menos 5 caracteres.");
            return false;
        }

        // Validación de correo electrónico
        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailPattern.test(email)) {
            alert("Por favor ingrese un correo electrónico válido.");
            return false;
        }

        // Validación de RUC (exactamente 11 dígitos)
        if (!/^\d{11}$/.test(ruc)) {
            alert("El RUC debe contener exactamente 11 dígitos.");
            return false;
        }

        // Validación del representante (solo letras y espacios)
        if (!/^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$/.test(representative)) {
            alert("Por favor ingrese bien el nombre del Representante.");
            return false;
        }

        // Validación de correo del representante
        if (!emailPattern.test(emailRepresentative)) {
            alert("Por favor ingrese un correo electrónico válido para el Representante.");
            return false;
        }

        // Validación de teléfono del representante (exactamente 9 dígitos)
        if (!/^\d{9}$/.test(phoneRepresentative)) {
            alert("El Teléfono del Representante debe contener exactamente 9 dígitos.");
            return false;
        }

        return true;
    }
</script>
</body>
</html>
