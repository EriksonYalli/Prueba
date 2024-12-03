package pe.edu.vallegrande.controller;

import pe.edu.vallegrande.service.LoginService;
import pe.edu.vallegrande.Dto.WorkerDto;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = {"/login", "/logout"})
public class LoginController extends HttpServlet {
    private final LoginService loginService = new LoginService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Determina si la acción es login o logout mediante la URL
        String action = request.getRequestURI().substring(request.getContextPath().length());

        if ("/login".equals(action)) {
            handleLogin(request, response);  // Maneja el login
        } else if ("/logout".equals(action)) {
            handleLogout(request, response);  // Maneja el logout
        } else {
            response.sendRedirect("index.jsp");  // Redirige si la acción no es válida
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // También permite manejar el logout con GET
        String action = request.getRequestURI().substring(request.getContextPath().length());

        if ("/logout".equals(action)) {
            handleLogout(request, response);  // Maneja el logout
        } else {
            response.sendRedirect("index.jsp");  // Redirige si la acción no es válida
        }
    }

    // Maneja la autenticación del login
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("username");
        String password = request.getParameter("password");

        // Autenticamos al usuario
        WorkerDto worker = loginService.authenticate(email, password);

        if (worker != null) {
            // Si el login es exitoso, almacenar el trabajador en la sesión
            request.getSession().setAttribute("worker", worker);
            // Redirigir según el puesto
            switch (worker.getPost()) {
                case "Administrador":
                    response.sendRedirect("WelcomeAdmin.jsp");
                    break;
                case "Almacenero":
                    response.sendRedirect("/Compra/WelcomeCompra.jsp");
                    break;
                case "Recepcionista":
                    response.sendRedirect("/Citas/WelcomeCitas.jsp");
                    break;
                default:
                    response.sendRedirect("index.jsp");
            }
        } else {
            // Si el login falla, agregar el mensaje de error y redirigir a index.jsp
            request.setAttribute("errorMessage", "Credenciales incorrectas. Por favor, intenta de nuevo.");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        }
    }

    private void handleLogout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Invalida la sesión completa
        request.getSession().invalidate();
        response.sendRedirect("index.jsp");
    }
}