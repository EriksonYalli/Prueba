<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Validación de usuario autenticado directamente con request
    Object usuario = request.getAttribute("usuario");
    if (usuario != null) {
        // Si el usuario ya está autenticado, redirigir a index.jsp
        response.sendRedirect("index.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ingreso - Pastelería</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Fondo de pantalla completa */
        body {
            background: url("<%= request.getContextPath() %>/img/Hello.png") no-repeat center center fixed;
            background-size: cover;
            font-family: 'Poppins', sans-serif;
            color: #4b2e2e;
        }

        .card {
            background: #fff; /* Fondo sólido blanco */
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            padding: 2rem;
            position: relative;
        }

        .card-header {
            background: #fff;
            text-align: center;
        }

        .card-header img {
            width: 100px;
            animation: float 2s infinite ease-in-out;
        }

        @keyframes float {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0px); }
        }

        .form-control {
            background: #f5f0e1;
            border: 1px solid #d2a679;
            color: #4b2e2e;
            border-radius: 10px;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border: 1px solid #d2a679;
            box-shadow: 0 0 8px rgba(210, 166, 121, 0.5);
        }

        .btn-primary {
            background: #d2a679;
            border: none;
            padding: 0.75rem 1rem;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: bold;
            color: #fff;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background: #b58d5b;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(210, 166, 121, 0.5);
        }

        .alert {
            background: rgba(210, 166, 121, 0.8);
            color: #fff;
            border: none;
            border-radius: 10px;
        }

        .text-muted {
            color: #4b2e2e !important;
        }
    </style>
</head>
<body>
<div class="container min-vh-100 d-flex justify-content-center align-items-center">
    <div class="card shadow-lg" style="max-width: 400px; width: 100%;">
        <div class="card-header">
            <!-- Imagen flotante personalizada -->
            <img src="<%= request.getContextPath() %>/img/Logo.webp" alt="Imagen flotante de cereza" />
        </div>
        <div class="text-center mb-4">
            <h1 class="fw-bold" style="color: #4b2e2e;">¡Bienvenido!</h1>
            <p class="text-muted">Ingresa tus credenciales para acceder</p>
        </div>
        <form method="post" action="Logon">
            <div class="mb-4">
                <label for="usuario" class="form-label">Usuario</label>
                <input type="text" id="usuario" name="usuario" class="form-control" placeholder="Ingresa tu usuario" required />
            </div>
            <div class="mb-4">
                <label for="clave" class="form-label">Clave</label>
                <input type="password" id="clave" name="clave" class="form-control" placeholder="••••••••" required />
            </div>
            <div class="d-grid">
                <button type="submit" class="btn btn-primary btn-lg">Ingresar</button>
            </div>
        </form>
        <%-- Mostrar mensaje de error si existe --%>
        <%
            String mensaje = (String) request.getAttribute("mensaje");
            if (mensaje != null) {
        %>
        <div class="alert mt-4" role="alert">
            <%= mensaje %>
        </div>
        <%
            }
        %>
    </div>
</div>
<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
