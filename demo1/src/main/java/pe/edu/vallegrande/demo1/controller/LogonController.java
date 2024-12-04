package pe.edu.vallegrande.demo1.controller;

import pe.edu.vallegrande.demo1.dto.UsuarioDto;
import pe.edu.vallegrande.demo1.service.LogonService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/Logon", "/Salir", "/Admin"})
public class LogonController extends HttpServlet { // Extiende HttpServlet

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        switch (path) {
            case "/Logon":
                logon(request, response);
                break;
            case "/Salir":
                salir(request, response);
                break;
            case "/Admin":
                administrar(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Ruta no válida.");
        }
    }

    private void logon(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Datos
        String usuario = request.getParameter("usuario");
        String clave = request.getParameter("clave");
        // Proceso
        String destino;
        try {
            LogonService service = new LogonService();
            System.out.println("Validando credenciales...");
            UsuarioDto bean = service.validarUsuario(usuario, clave);

            // Si las credenciales son correctas, almacenamos al usuario en la sesión
            HttpSession session = request.getSession();
            session.setAttribute("usuario", bean);

            destino = "index.jsp"; // Redirigir al inicio tras login exitoso
        } catch (Exception e) {
            // En caso de error, volvemos a logon.jsp con un mensaje
            request.setAttribute("mensaje", e.getMessage());
            destino = "logon.jsp";
        }

        // Retorno
        RequestDispatcher rd = request.getRequestDispatcher(destino);
        rd.forward(request, response);
    }

    private void salir(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Invalida la sesión actual y redirige a logon.jsp
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("logon.jsp");
    }

    private void administrar(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Comprueba si el usuario está en sesión
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("usuario") != null) {
            // Redirige al panel de administración
            response.sendRedirect("admin.jsp");
        } else {
            // Si no está autenticado, redirige a logon.jsp
            response.sendRedirect("logon.jsp");
        }
    }
}
