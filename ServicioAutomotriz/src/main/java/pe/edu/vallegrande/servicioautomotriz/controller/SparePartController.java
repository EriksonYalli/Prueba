package pe.edu.vallegrande.servicioautomotriz.controller;

import jakarta.servlet.ServletException;
import pe.edu.vallegrande.servicioautomotriz.dto.SparePartDto;
import pe.edu.vallegrande.servicioautomotriz.service.SparePartService;


import java.io.*;

import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet({"/listar","/listarInactivo", "/editar", "/eliminar", "/create","/restaurar"})
public class SparePartController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/listar":
                listarRepuestos(req, resp);
                break;
            case "/listarInactivo":
                listarRepuestosInactivo(req, resp);
                break;
            default:

                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/editar":
                editarRepuestos(req, resp);
                break;
                case "/eliminar":
                    eliminarRepuestos(req, resp);
                    break;
            case "/create":
                crearRepuestos(req, resp);
                break;
            case "/restaurar":
                restaurarRepuesto(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void restaurarRepuesto(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        int id = Integer.parseInt(idStr);


        SparePartService sparePartService = new SparePartService();
        sparePartService.Restaurar(id);


        resp.sendRedirect(req.getContextPath() + "/listarInactivo");
    }

    private void crearRepuestos(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException{
        SparePartService repuestoService = new SparePartService();
        SparePartDto repuesto = new SparePartDto();

        repuesto.setName(req.getParameter("name"));
        repuesto.setDescription(req.getParameter("description"));
        repuesto.setPriceUnit(BigDecimal.valueOf(Double.parseDouble(req.getParameter("priceUnit"))));
        repuesto.setBrand(req.getParameter("brand"));
        repuesto.setStock(Integer.parseInt(req.getParameter("stock")));
        repuesto.setCompatibleModel(req.getParameter("compatibleModel"));
        repuesto.setEntryDate(java.sql.Date.valueOf(req.getParameter("entryDate")));

        repuestoService.insertSparePart(repuesto);

        resp.sendRedirect("/listar");

    }

    private void eliminarRepuestos(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String idStr = req.getParameter("id");
        int id = Integer.parseInt(idStr);


        SparePartService sparePartService = new SparePartService();
        sparePartService.deleteSparePart(id);


        resp.sendRedirect(req.getContextPath() + "/listar");
    }


    private void editarRepuestos(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        SparePartService repuestoService = new SparePartService();
        SparePartDto repuesto = new SparePartDto();

        repuesto.setId(Integer.parseInt(req.getParameter("id")));
        repuesto.setName(req.getParameter("name"));
        repuesto.setDescription(req.getParameter("description"));
        repuesto.setPriceUnit(new BigDecimal(req.getParameter("priceUnit")));
        repuesto.setBrand(req.getParameter("brand"));
        repuesto.setStock(Integer.parseInt(req.getParameter("stock")));
        repuesto.setCompatibleModel(req.getParameter("compatibleModel"));
        repuesto.setEntryDate(java.sql.Date.valueOf(req.getParameter("entryDate")));

        repuestoService.updateSparePart(repuesto);

        resp.sendRedirect("listar");
    }


    private void listarRepuestos(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nombre = req.getParameter("nombre");
        String marca = req.getParameter("marca");

        List<SparePartDto> parts;
        SparePartService sparePartService = new SparePartService();

        if (nombre != null && !nombre.isEmpty() || marca != null && !marca.isEmpty()) {
            parts = sparePartService.buscarRepuestos(nombre != null ? nombre : "", marca != null ? marca : "");
        } else {
            parts = sparePartService.getSpareParts();
        }

        req.setAttribute("parts", parts);
        req.getRequestDispatcher("SparePart.jsp").forward(req, resp);
    }


    private void listarRepuestosInactivo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<SparePartDto> partsI;
        SparePartService sparePartService = new SparePartService();

        String nombre = req.getParameter("nombre");
        String marca = req.getParameter("marca");

        if (nombre != null && !nombre.isEmpty() || marca != null && !marca.isEmpty()) {
            partsI = sparePartService.buscarRepuestosInactivo(nombre != null ? nombre : "", marca != null ? marca : "");
        } else {
            partsI = sparePartService.inactivo();
        }

        System.out.println("Repuestos inactivos = " + partsI);
        req.setAttribute("partsI", partsI);
        req.getRequestDispatcher("SparePartInactivo.jsp").forward(req, resp);
    }

}
