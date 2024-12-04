package pe.edu.vallegrande.demo1.controller;

import pe.edu.vallegrande.demo1.dto.DetalleVentaDTO;
import pe.edu.vallegrande.demo1.dto.ProductoDTO;
import pe.edu.vallegrande.demo1.dto.VentaDTO;
import pe.edu.vallegrande.demo1.service.HistorialSERVICE;
import pe.edu.vallegrande.demo1.service.ProductoSERVICE;
import pe.edu.vallegrande.demo1.service.VentaSERVICE;

import javax.servlet.RequestDispatcher;
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
    private static final String LISTAR = "index.jsp?page=Detalle.jsp";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        request.getRequestDispatcher(LISTAR).forward(request, response);

        switch (action) {

            case "listar":
                System.out.println("ksa");
                response.sendRedirect("index.jsp?page=historial");
                break;
            case "detalleVenta":
                System.out.println("paisana");
                mostrarDetallesCompra(request, response);
                break;

            default:
                response.sendRedirect("index.jsp?page=historial");
                break;

        }

    }

    private void mostrarDetallesCompra(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        HistorialSERVICE historial = new HistorialSERVICE();
        List<VentaDTO> venta = historial.ListarVenta(id);

        request.setAttribute("venta", venta);
        request.setAttribute("id", id);
        RequestDispatcher view = request.getRequestDispatcher("page=historial");
        view.forward(request, response);

    }
}

