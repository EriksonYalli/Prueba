package pe.edu.vallegrande.controller;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*") // Filtra todas las solicitudes
public class AuthenticationFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Configuración inicial si es necesario
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Rutas públicas que no necesitan autenticación
        String[] publicPaths = {"/login", "/index.jsp", "/logout"};
        String path = httpRequest.getRequestURI().substring(httpRequest.getContextPath().length());

        // Verifica si la ruta actual es pública
        boolean isPublicPath = false;
        for (String publicPath : publicPaths) {
            if (path.equals(publicPath)) {
                isPublicPath = true;
                break;
            }
        }

        // Verifica si el usuario está autenticado
        boolean isAuthenticated = httpRequest.getSession().getAttribute("worker") != null;

        if (isAuthenticated || isPublicPath) {
            // Configura cabeceras para evitar caché en las páginas protegidas
            httpResponse.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
            httpResponse.setHeader("Pragma", "no-cache"); // HTTP 1.0
            httpResponse.setDateHeader("Expires", 0); // Proxies

            // Continúa con el procesamiento normal
            chain.doFilter(request, response);
        } else {
            // Si no está autenticado, redirige al login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/index.jsp");
        }
    }

    @Override
    public void destroy() {
        // Limpieza de recursos si es necesario
    }
}