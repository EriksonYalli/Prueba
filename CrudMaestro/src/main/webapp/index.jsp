<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - K&G Electronic</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f4f7fc;
            font-family: 'Helvetica Neue', sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }

        .login-container {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            padding: 40px 35px;
        }

        .login-container h2 {
            text-align: center;
            color: #444;
            margin-bottom: 30px;
            font-weight: 600;
        }

        .form-group {
            position: relative;
        }

        .form-control {
            border-radius: 8px;
            border: 1px solid #ddd;
            padding: 15px;
            margin-bottom: 20px;
            font-size: 16px;
            height: 50px; /* Consistent height for input fields */
            transition: border-color 0.3s ease-in-out;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
            padding: 15px;
            font-size: 16px;
            border-radius: 8px;
            width: 100%;
            transition: background-color 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #777;
        }

        .modal-header {
            background-color: #dc3545;
            color: white;
        }
    </style>
</head>

<body>

<div class="login-container">
    <h2>Iniciar sesión</h2>
    <form action="login" method="post">
        <div class="form-group">
            <label for="username" class="form-label">Correo electrónico</label>
            <input type="email" name="username" id="username" class="form-control" placeholder="Correo electrónico" required>
        </div>
        <div class="form-group">
            <label for="password" class="form-label">Contraseña</label>
            <input type="password" name="password" id="password" class="form-control" placeholder="Contraseña" required>
        </div>
        <button type="submit" class="btn btn-primary">Ingresar</button>
    </form>
    <div class="footer">
        <p>&copy; 2024 K&G Electronic. Todos los derechos reservados.</p>
    </div>
</div>

<!-- Modal de error (si aplica) -->
<c:if test="${not empty errorMessage}">
    <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="errorModalLabel"><i class="fas fa-exclamation-triangle"></i> Error</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p><strong>${errorMessage}</strong></p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                </div>
            </div>
        </div>
    </div>
</c:if>

<!-- Bootstrap JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const errorMessage = "${errorMessage}";
        if (errorMessage) {
            const errorModal = new bootstrap.Modal(document.getElementById('errorModal'));
            errorModal.show();
        }
    });
</script>
</body>

</html>