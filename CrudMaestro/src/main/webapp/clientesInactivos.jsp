<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clientes Naturales Inactivos</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
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
<div class="d-flex">
    <!-- Menú vertical -->
    <div class="menu p-3">
        <h5 class="pb-3 border-bottom">K&G Electronic</h5>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link d-flex align-items-center" href="/WelcomeAdmin.jsp">
                    <i class="fas fa-home me-2"></i> Inicio
                </a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle d-flex align-items-center" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-users me-2"></i> Clientes
                </a>
                <ul class="dropdown-menu">
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/clientes">
                            <i class="fas fa-user me-2"></i> Cliente Natural
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/clientesjuridicos">
                            <i class="fas fa-building me-2"></i> Cliente Jurídico
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/clientesjuridicosinactivos">
                            <i class="fas fa-building me-2"></i> Cliente Jurídico Inactivos
                        </a>
                    </li>
                    <li>
                        <a class="dropdown-item" href="${pageContext.request.contextPath}/clientesinactivos">
                            <i class="fas fa-user me-2"></i> Cliente Natural Inactivos
                        </a>
                    </li>
                </ul>
            </li>
            <li class="nav-item">
                <a class="nav-link d-flex align-items-center" href="cita?action=view">
                    <i class="fas fa-calendar-check me-2"></i> Citas
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link d-flex align-items-center" href="/listar">
                    <i class="fas fa-cog me-2"></i> Repuestos
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link d-flex align-items-center" href="/Compras">
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

    <!-- Contenido principal -->
    <div class="p-4 flex-grow-1 content">
        <h1>Clientes Naturales Inactivos</h1>
        <table class="table table-striped table-bordered table-hover">
            <thead class="table-light">
            <tr>
                <th>ID</th>
                <th>Tipo de persona</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Tipo de Documento</th>
                <th>N° Documento</th>
                <th>F. Nacimiento</th>
                <th>Teléfono</th>
                <th>Direccion</th>
                <th>Email</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="cliente" items="${clientesInactivos}">
                <tr>
                    <td>${cliente.id}</td>
                    <td>${cliente.typePerson}</td>
                    <td>${cliente.name}</td>
                    <td>${cliente.lastName}</td>
                    <td>${cliente.documentType}</td>
                    <td>${cliente.documentNumber}</td>
                    <td>${cliente.birthdate}</td>
                    <td>${cliente.phone}</td>
                    <td>${cliente.address}</td>
                    <td>${cliente.email}</td>
                    <td>${cliente.status}</td>
                    <td>
                        <form action="reactivarCliente" method="post">
                            <input type="hidden" name="id" value="${cliente.id}">
                            <input type="hidden" name="tipo" value="natural">
                            <button type="submit" class="btn btn-primary">Reactivar</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Bootstrap y Font Awesome JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>