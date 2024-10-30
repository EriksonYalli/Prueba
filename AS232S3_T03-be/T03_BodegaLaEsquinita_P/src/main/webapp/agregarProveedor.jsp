<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Agregar Proveedor</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f5f5f5;
    }
    .container {
      margin-top: 50px;
      max-width: 600px;
    }
  </style>
</head>
<body>
<div class="container">
  <h2 class="mb-4">Agregar Proveedor</h2>
  <form action="${pageContext.request.contextPath}/agregarSupplier" method="post" onsubmit="return validateForm()">
    <div class="mb-3">
      <label for="name" class="form-label">Razón Social</label>
      <input type="text" class="form-control" id="name" name="name">
    </div>
    <div class="mb-3">
      <label for="direction" class="form-label">Dirección</label>
      <input type="text" class="form-control" id="direction" name="direction">
    </div>
    <div class="mb-3">
      <label for="email" class="form-label">Correo Electrónico</label>
      <input type="text" class="form-control" id="email" name="email">
    </div>
    <div class="mb-3">
      <label for="ruc" class="form-label">RUC</label>
      <input type="text" class="form-control" id="ruc" name="ruc">
    </div>
    <div class="mb-3">
      <label for="representative" class="form-label">Representante</label>
      <input type="text" class="form-control" id="representative" name="representative">
    </div>
    <div class="mb-3">
      <label for="emailRepresentative" class="form-label">Correo del Representante</label>
      <input type="text" class="form-control" id="emailRepresentative" name="emailRepresentative">
    </div>
    <div class="mb-3">
      <label for="phoneRepresentative" class="form-label">Teléfono del Representante</label>
      <input type="text" class="form-control" id="phoneRepresentative" name="phoneRepresentative">
    </div>

    <button type="submit" class="btn btn-danger">Añadir Proveedor</button>
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

    // Validación de datos incompletos
    if (!name || !direction || !email || !ruc || !representative || !emailRepresentative || !phoneRepresentative) {
      alert("Por favor, termine de rellenar todos los campos.");
      return false;
    }

    // Validar Razón Social (solo letras y espacios)
    if (!/^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$/.test(name)) {
      alert("Por favor ingrese bien la Razón social.");
      return false;
    }

    // Validar Dirección (mínimo 5 caracteres)
    if (direction.length < 5) {
      alert("La Dirección debe tener al menos 5 caracteres.");
      return false;
    }

    // Validar correo electrónico
    const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    if (!emailPattern.test(email)) {
      alert("Por favor ingresa un correo electrónico válido.");
      return false;
    }

    // Validar RUC (exactamente 11 dígitos)
    if (!/^\d{11}$/.test(ruc)) {
      alert("El RUC debe contener exactamente 11 dígitos.");
      return false;
    }

    // Validar Representante (solo letras y espacios)
    if (!/^[A-Za-zÁÉÍÓÚáéíóúÑñ ]+$/.test(representative)) {
      alert("Por favor ingrese bien el nombre del Representante.");
      return false;
    }

    // Validar correo del Representante
    if (!emailPattern.test(emailRepresentative)) {
      alert("Por favor ingresa un correo electrónico válido para el Representante.");
      return false;
    }

    // Validar teléfono del Representante (exactamente 9 dígitos)
    if (!/^\d{9}$/.test(phoneRepresentative)) {
      alert("El teléfono del Representante debe contener exactamente 9 dígitos.");
      return false;
    }

    return true;
  }
</script>
</body>
</html>
