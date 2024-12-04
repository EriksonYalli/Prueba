package pe.edu.vallegrande.demo1.controller;

import pe.edu.vallegrande.demo1.dto.DetalleVentaDTO;
import pe.edu.vallegrande.demo1.dto.ProductoDTO;
import pe.edu.vallegrande.demo1.service.HistorialSERVICE;
import pe.edu.vallegrande.demo1.service.ProductoSERVICE;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet("/historial")
public class HistorialServlet extends HttpServlet {

    private DetalleVentaDTO historialService = new DetalleVentaDTO();
    private static final String LISTAR = "index.jsp?page=historial";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        request.getRequestDispatcher(LISTAR).forward(request, response);

        switch (action) {

            case "listar":
                System.out.println("ksa");
                response.sendRedirect("index.jsp?page=historial");
                break;
            default:
                response.sendRedirect("index.jsp?page=historial");

                break;

        }

    }
}

