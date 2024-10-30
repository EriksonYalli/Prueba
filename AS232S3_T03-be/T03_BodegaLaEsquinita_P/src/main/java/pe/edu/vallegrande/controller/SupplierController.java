package pe.edu.vallegrande.controller;

import pe.edu.vallegrande.dto.Supplier;
import pe.edu.vallegrande.service.SupplierService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({"/agregarSupplier", "/editarSupplier", "/eliminarSupplier", "/listarSupplier", "/listarSupplierInactivos", "/restaurarSupplier"})
public class SupplierController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private SupplierService supplierService = new SupplierService();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        switch (path) {
            case "/agregarSupplier":
                agregarSupplier(request, response);
                break;
            case "/editarSupplier":
                editarSupplier(request, response);
                break;
            case "/eliminarSupplier":
                eliminarSupplier(request, response);
                break;
            case "/listarSupplier":
                listarSupplier(request, response);
                break;
            case "/listarSupplierInactivos":
                listarSupplierInactivos(request, response);
                break;
            case "/restaurarSupplier":
                restaurarSupplier(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void agregarSupplier(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String direction = request.getParameter("direction");
        String email = request.getParameter("email");
        String ruc = request.getParameter("ruc");
        String representative = request.getParameter("representative");
        String emailRepresentative = request.getParameter("emailRepresentative");
        String phoneRepresentative = request.getParameter("phoneRepresentative");
        char status = 'A'; // Estado inicial como activo

        Supplier supplier = new Supplier(0, name, direction, email, ruc, representative, emailRepresentative, phoneRepresentative, status);
        supplierService.agregar(supplier);

        RequestDispatcher rd = request.getRequestDispatcher("listarSupplier");
        rd.forward(request, response);
    }

    private void editarSupplier(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getMethod().equalsIgnoreCase("GET")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Supplier supplier = supplierService.buscarPorId(id);
            request.setAttribute("supplier", supplier);
            RequestDispatcher rd = request.getRequestDispatcher("editarProveedor.jsp");
            rd.forward(request, response);
        } else if (request.getMethod().equalsIgnoreCase("POST")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            String direction = request.getParameter("direction");
            String email = request.getParameter("email");
            String ruc = request.getParameter("ruc");
            String representative = request.getParameter("representative");
            String emailRepresentative = request.getParameter("emailRepresentative");
            String phoneRepresentative = request.getParameter("phoneRepresentative");
            char status = 'A'; // Estado inicial como activo

            Supplier supplier = new Supplier(id, name, direction, email, ruc, representative, emailRepresentative, phoneRepresentative, status);
            supplierService.editar(supplier);
            response.sendRedirect("listarSupplier");
        }
    }

    private void eliminarSupplier(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        supplierService.eliminar(id);

        RequestDispatcher rd = request.getRequestDispatcher("listarSupplier");
        rd.forward(request, response);
    }

    private void listarSupplier(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        String searchType = request.getParameter("searchType");
        List<Supplier> supplierList;

        if (query != null && !query.trim().isEmpty()) {
            if ("ruc".equals(searchType)) {
                supplierList = supplierService.buscarPorRuc(query); // Llama al nuevo método en SupplierService
            } else {
                supplierList = supplierService.buscarPorNombre(query); // Método existente
            }
        } else {
            supplierList = supplierService.listar(); // Cambiar a listar solo activos
        }

        request.setAttribute("supplierList", supplierList);
        RequestDispatcher rd = request.getRequestDispatcher("proveedores.jsp");
        rd.forward(request, response);
    }




    private void listarSupplierInactivos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        String searchType = request.getParameter("searchType");
        List<Supplier> supplierInactivos;

        if (query != null && !query.trim().isEmpty()) {
            if ("ruc".equals(searchType)) {
                supplierInactivos = supplierService.buscarPorRucInactivos(query);
            } else {
                supplierInactivos = supplierService.buscarPorNombreInactivos(query);
            }
        } else {
            supplierInactivos = supplierService.listarInactivos(); // Obtener todos los proveedores inactivos
        }

        request.setAttribute("supplierInactivos", supplierInactivos);
        RequestDispatcher rd = request.getRequestDispatcher("ProveedoresInactivos.jsp");
        rd.forward(request, response);
    }


    private void restaurarSupplier(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        supplierService.restaurar(id); // Cambia el estado a 'A' (Activo)

        response.sendRedirect("listarSupplierInactivos"); // Redirige a la lista de inactivos para ver los cambios
    }


}
