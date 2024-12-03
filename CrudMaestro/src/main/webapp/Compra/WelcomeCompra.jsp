<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Trabajador</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <style>
    /* Estilo del menú */
    .menu {
      min-height: 100vh;
      width: 300px;
      background-color: #2D2F36; /* Fondo oscuro */
      box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
      border-right: 1px solid #4A4D57; /* Divisor */
    }

    .menu h5 {
      font-size: 1.25rem;
      font-weight: 600;
      color: #FFFFFF; /* Texto claro */
      padding: 15px;
    }

    .nav-item {
      margin-bottom: 10px;
    }

    .nav-link {
      display: flex;
      align-items: center;
      font-size: 1.1rem;
      color: #8E9098; /* Gris claro */
      padding: 12px 15px;
      border-radius: 5px;
      transition: all 0.3s ease-in-out;
    }

    .nav-link:hover,
    .nav-link.active {
      background-color: #F04E30; /* Fondo hover */
      color: #FFFFFF; /* Texto en hover */
      font-weight: 500;
      text-decoration: none;
    }

    .nav-link i {
      font-size: 1.5rem;
      margin-right: 10px;
      color: #F7A440; /* Icono naranja cálido */
      transition: color 0.3s ease-in-out;
    }

    .nav-link:hover i,
    .nav-link.active i {
      color: #FFFFFF; /* Icono blanco en hover */
    }
  </style>
</head>

<body>
<!-- Menú vertical -->
<div class="menu">
  <h5 class="pb-3 border-bottom">K&G Electronic</h5>
  <ul class="nav flex-column">
    <li class="nav-item">
      <a class="nav-link d-flex align-items-center" href="/Compra/WelcomeCompra.jsp">
        <i class="fas fa-home me-2"></i> Inicio
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link d-flex align-items-center" href="/listarCompras">
        <i class="fas fa-tools me-2"></i> Repuestos
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link d-flex align-items-center" href="/ComprasAlmacen">
        <i class="fas fa-shopping-cart me-2"></i> Compra
      </a>
    </li>
    <li class="nav-item">
      <a class="nav-link d-flex align-items-center" href="/logout">
        <i class="fas fa-sign-out-alt me-2"></i> Cerrar sesión
      </a>
    </li>
  </ul>
</div>
</body>
</html>
