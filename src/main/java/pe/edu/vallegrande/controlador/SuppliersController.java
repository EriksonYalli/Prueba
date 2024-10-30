package pe.edu.vallegrande.controlador;


import pe.edu.vallegrande.dto.Suppliers;
import pe.edu.vallegrande.service.ProductsDAO;
import pe.edu.vallegrande.service.SuppliersDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/Suppliers") // Mapeo de la URL
    public class SuppliersController extends HttpServlet {

        private final ProductsDAO dao = new ProductsDAO();
        private final SuppliersDAO suppliersDao = new SuppliersDAO(); // Asegúrate de tener un DAO para proveedores
        private static final String LISTAR = "vistas/Listar.jsp";

    public SuppliersController() throws SQLException {
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
            String action = request.getParameter("accion");
            String acceso = "";

            switch (action) {
                case "listar":
                    acceso = listarProductos(request);
                    break;
                case "agregar":
                    cargarProveedores(request); // Carga la lista de proveedores antes de mostrar el formulario de agregar
                    acceso = "vistas/Agregar.jsp"; // Asegúrate de que esta sea la vista correcta
                    break;
                // Otros casos...
            }

            RequestDispatcher vista = request.getRequestDispatcher(acceso);
            vista.forward(request, response);
        }

    private String listarProductos(HttpServletRequest request) {
        return "";
    }


    private void cargarProveedores(HttpServletRequest request) {
            List<Suppliers> supplierList = suppliersDao.listar();
            request.setAttribute("supplierList", supplierList);
        }
    }

