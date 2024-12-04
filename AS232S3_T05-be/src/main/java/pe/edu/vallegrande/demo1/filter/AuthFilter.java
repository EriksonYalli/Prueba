package pe.edu.vallegrande.demo1.filter;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Inicialización si es necesaria
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        HttpSession session = httpRequest.getSession(false); // Obtener la sesión actual (si existe)

        String uri = httpRequest.getRequestURI();

        // Excepciones: logon.jsp y recursos estáticos
        if (uri.endsWith("logon.jsp") || uri.contains("/resources/") || uri.endsWith("/Logon")) {
            chain.doFilter(request, response); // Permitir acceso
            return;
        }

        // Validación de sesión
        if (session == null || session.getAttribute("usuario") == null) {
            // Si no hay sesión o el usuario no está autenticado, redirigir a logon.jsp
            httpResponse.sendRedirect("logon.jsp");
        } else {
            // Si el usuario está autenticado, permitir acceso a la página solicitada
            chain.doFilter(request, response);
        }
    }

    @Override
    public void destroy() {
        // Limpieza si es necesaria
    }
}
