package pe.edu.vallegrande.controller;

import pe.edu.vallegrande.Dto.SparePartDto;
import pe.edu.vallegrande.service.SparePartService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

@WebServlet({"/listar", "/listarCompras", "/listarInactivo", "/listarCompraInactivo", "/editar", "/eliminar", "/create", "/restaurar", "/editarAlmacen", "/eliminarAlmacen", "/createAlmacen", "/restaurarAlmacen"})
public class SparePartController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        SparePartService service = new SparePartService();

        req.setAttribute("categories", service.getCategories());
        req.setAttribute("brands", service.getBrands());
        switch (path) {
            case "/listar":
                listarRepuestos(req, resp);
                break;
            case "/listarCompras":
                listarRepuestosCompras(req, resp);
                break;
            case "/listarInactivo":
                listarRepuestosInactivo(req, resp);
                break;
            case "/listarCompraInactivo":
                listarRepuestosCompraInactivo(req, resp);
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
            case "/editarAlmacen":
                editarRepuestosAlmacen(req, resp);
                break;
            case "/eliminarAlmacen":
                eliminarRepuestosAlmacen(req, resp);
                break;
            case "/createAlmacen":
                crearRepuestosAlmacen(req, resp);
                break;
            case "/restaurarAlmacen":
                restaurarRepuestoAlmacen(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void listarRepuestos(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nombre = req.getParameter("nombre");
        String brandIdParam = req.getParameter("brandId");

        Integer brandId = null;
        if (brandIdParam != null && !brandIdParam.isEmpty()) {
            brandId = Integer.parseInt(brandIdParam);
        }

        SparePartService sparePartService = new SparePartService();
        List<SparePartDto> parts;

        if ((nombre != null && !nombre.isEmpty()) || brandId != null) {
            parts = sparePartService.buscarRepuestos(nombre != null ? nombre : "", brandId);
        } else {
            parts = sparePartService.getSpareParts();
        }

        req.setAttribute("parts", parts);
        req.getRequestDispatcher("SparePart.jsp").forward(req, resp);
    }

    private void listarRepuestosCompras(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nombre = req.getParameter("nombre");
        String brandIdParam = req.getParameter("brandId");

        Integer brandId = null;
        if (brandIdParam != null && !brandIdParam.isEmpty()) {
            brandId = Integer.parseInt(brandIdParam);
        }

        SparePartService sparePartService = new SparePartService();
        List<SparePartDto> parts;

        if ((nombre != null && !nombre.isEmpty()) || brandId != null) {
            parts = sparePartService.buscarRepuestos(nombre != null ? nombre : "", brandId);
        } else {
            parts = sparePartService.getSpareParts();
        }

        req.setAttribute("parts", parts);
        req.getRequestDispatcher("/Compra/SparePart.jsp").forward(req, resp);
    }

    private void listarRepuestosInactivo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nombre = req.getParameter("nombre");
        String brandIdParam = req.getParameter("brandId");

        Integer brandId = null;
        if (brandIdParam != null && !brandIdParam.isEmpty()) {
            brandId = Integer.parseInt(brandIdParam);
        }

        SparePartService sparePartService = new SparePartService();
        List<SparePartDto> partsI;

        // Filtrar por nombre y/o marca
        if ((nombre != null && !nombre.isEmpty()) || brandId != null) {
            partsI = sparePartService.buscarRepuestosInactivo(nombre != null ? nombre : "", brandId);
        } else {
            partsI = sparePartService.inactivo();
        }

        req.setAttribute("partsI", partsI);
        req.getRequestDispatcher("SparePartInactivo.jsp").forward(req, resp);
    }

    private void listarRepuestosCompraInactivo(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String nombre = req.getParameter("nombre");
        String brandIdParam = req.getParameter("brandId");

        Integer brandId = null;
        if (brandIdParam != null && !brandIdParam.isEmpty()) {
            brandId = Integer.parseInt(brandIdParam);
        }

        SparePartService sparePartService = new SparePartService();
        List<SparePartDto> partsI;

        // Filtrar por nombre y/o marca
        if ((nombre != null && !nombre.isEmpty()) || brandId != null) {
            partsI = sparePartService.buscarRepuestosInactivo(nombre != null ? nombre : "", brandId);
        } else {
            partsI = sparePartService.inactivo();
        }

        req.setAttribute("partsI", partsI);
        req.getRequestDispatcher("/Compra/SparePartInactivo.jsp").forward(req, resp);
    }

    private void crearRepuestos(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        SparePartDto repuesto = new SparePartDto();

        try {
            // Campos requeridos
            repuesto.setName(req.getParameter("name"));
            repuesto.setDescription(req.getParameter("description"));
            repuesto.setCompatibilityType(req.getParameter("compatibilityType"));
            repuesto.setEntryDate(Date.valueOf(req.getParameter("entryDate")));
            repuesto.setState("Activo");

            // Validar parámetros
            String categoryIdParam = req.getParameter("categoryId");
            String brandIdParam = req.getParameter("brandId");

            if (categoryIdParam == null || categoryIdParam.isEmpty()) {
                throw new IllegalArgumentException("Debe seleccionar una categoría");
            }
            if (brandIdParam == null || brandIdParam.isEmpty()) {
                throw new IllegalArgumentException("Debe seleccionar una marca");
            }

            repuesto.setCategoryId(Integer.parseInt(categoryIdParam));
            repuesto.setBrandId(Integer.parseInt(brandIdParam));

            // Servicio para insertar
            SparePartService sparePartService = new SparePartService();
            sparePartService.insertSparePart(repuesto);

            resp.sendRedirect(req.getContextPath() + "/listar");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error al crear el repuesto: " + e.getMessage());
        }
    }

    private void crearRepuestosAlmacen(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        SparePartDto repuesto = new SparePartDto();

        try {
            // Campos requeridos
            repuesto.setName(req.getParameter("name"));
            repuesto.setDescription(req.getParameter("description"));
            repuesto.setCompatibilityType(req.getParameter("compatibilityType"));
            repuesto.setEntryDate(Date.valueOf(req.getParameter("entryDate")));
            repuesto.setState("Activo");

            // Validar parámetros
            String categoryIdParam = req.getParameter("categoryId");
            String brandIdParam = req.getParameter("brandId");

            if (categoryIdParam == null || categoryIdParam.isEmpty()) {
                throw new IllegalArgumentException("Debe seleccionar una categoría");
            }
            if (brandIdParam == null || brandIdParam.isEmpty()) {
                throw new IllegalArgumentException("Debe seleccionar una marca");
            }

            repuesto.setCategoryId(Integer.parseInt(categoryIdParam));
            repuesto.setBrandId(Integer.parseInt(brandIdParam));

            // Servicio para insertar
            SparePartService sparePartService = new SparePartService();
            sparePartService.insertSparePart(repuesto);

            resp.sendRedirect(req.getContextPath() + "/listarCompras");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Error al crear el repuesto: " + e.getMessage());
        }
    }

    private void editarRepuestos(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        SparePartDto repuesto = new SparePartDto();

        repuesto.setId(Integer.parseInt(req.getParameter("id")));
        repuesto.setName(req.getParameter("name"));
        repuesto.setDescription(req.getParameter("description"));
        repuesto.setCompatibilityType(req.getParameter("compatibilityType"));
        repuesto.setEntryDate(Date.valueOf(req.getParameter("entryDate")));
        repuesto.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
        repuesto.setBrandId(Integer.parseInt(req.getParameter("brandId")));

        SparePartService sparePartService = new SparePartService();
        sparePartService.updateSparePart(repuesto);

        resp.sendRedirect(req.getContextPath() + "/listar");
    }

    private void editarRepuestosAlmacen(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        SparePartDto repuesto = new SparePartDto();

        repuesto.setId(Integer.parseInt(req.getParameter("id")));
        repuesto.setName(req.getParameter("name"));
        repuesto.setDescription(req.getParameter("description"));
        repuesto.setCompatibilityType(req.getParameter("compatibilityType"));
        repuesto.setEntryDate(Date.valueOf(req.getParameter("entryDate")));
        repuesto.setCategoryId(Integer.parseInt(req.getParameter("categoryId")));
        repuesto.setBrandId(Integer.parseInt(req.getParameter("brandId")));

        SparePartService sparePartService = new SparePartService();
        sparePartService.updateSparePart(repuesto);

        resp.sendRedirect(req.getContextPath() + "/listarCompras");
    }

    private void eliminarRepuestos(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        SparePartService sparePartService = new SparePartService();
        sparePartService.deleteSparePart(id);

        resp.sendRedirect(req.getContextPath() + "/listar");
    }

    private void eliminarRepuestosAlmacen(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        SparePartService sparePartService = new SparePartService();
        sparePartService.deleteSparePart(id);

        resp.sendRedirect(req.getContextPath() + "/listarCompras");
    }

    private void restaurarRepuesto(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        SparePartService sparePartService = new SparePartService();
        sparePartService.Restaurar(id);

        resp.sendRedirect(req.getContextPath() + "/listarInactivo");
    }

    private void restaurarRepuestoAlmacen(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));

        SparePartService sparePartService = new SparePartService();
        sparePartService.Restaurar(id);

        resp.sendRedirect(req.getContextPath() + "/listarCompraInactivo");
    }
}
