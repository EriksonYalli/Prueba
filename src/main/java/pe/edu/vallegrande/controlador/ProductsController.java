package pe.edu.vallegrande.controlador;

import pe.edu.vallegrande.dto.Buys_detail;
import pe.edu.vallegrande.service.BuysDetail;
import pe.edu.vallegrande.service.ProductsDAO;
import pe.edu.vallegrande.dto.Products; // Cambiado a Products

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

import static javax.servlet.jsp.PageContext.PAGE;

@WebServlet(urlPatterns = {"/controlador", "/editar"})
public class ProductsController extends HttpServlet { // Cambiado a Controlador

    private final ProductsDAO dao = new ProductsDAO();
    private static final String Pagina = "vistas/page.jsp";
    String Productos = "vistas/page.jsp?page=productos";
    String dashboard = "vistas/page.jsp?page=dashboard";
    String Ventas = "vistas/page.jsp?page=ventas";

    public ProductsController() throws SQLException {
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("accion");
        String acceso;
        String envio;
        List<Products> lista = null;


        switch (action) {
            case "ingresarPagina":
                acceso = Pagina;
                break;
            case "INICIO":
                acceso = dashboard;
                break;
            case "ventas":
                acceso = Ventas;
                break;
            case "editar":
                    acceso = editarProducto(request);
                    break;
            case "Actualizar":
                    acceso = "vistas/page.jsp?page=productos";
                    break;
                    case "eliminar":
                        acceso = eliminarProducto(request);
                        break;
            case "Restaurar":
               acceso =  Restore(request);
               break;
            default:
                acceso = Pagina; // Por defecto, redirigir a listar
        }
        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);




    }

    private String editarProducto(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));

        Products product = dao.listEdit(id);

        if (product != null) {
            request.setAttribute("product", product);
        } else {
            request.setAttribute("error", "Producto no encontrado");
        }

        return Pagina;
    }



    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("accion");
        String acceso;

        switch (action) {
            case "ingresarPagina":
                acceso = Pagina;
                break;
            case "agregar":
                acceso = agregarProducto(request);
                break;
            case "Actualizar":
                acceso = actualizarProducto(request);
                break;
            case "eliminar":
                acceso = eliminarProducto(request);
                break;
            case "listarDetalles": // Nueva acción para listar detalles
                acceso = listarDetalles(request);
                break;
            // Agrega otros casos según sea necesario
            case "buscarProductos":
                acceso = searchP(request);
                break;
            default:
                acceso = "vistas/page.jsp?param=productos"; // Por defecto, redirigir a listar
        }

        RequestDispatcher vista = request.getRequestDispatcher(acceso);
        vista.forward(request, response);
    }

    private String searchP(HttpServletRequest request) {
        String search = request.getParameter("searchQuery");
        System.out.println(search);

        List<Products> respuesta = dao.listarPorFiltro(search);
        request.setAttribute("respuesta", respuesta);
        System.out.println(respuesta);
        return "vistas/page.jsp?page=busqueda";
    }

    private String listarDetalles(HttpServletRequest request) {
        int idCompra = Integer.parseInt(request.getParameter("id"));
        BuysDetail buysDetailDAO = new BuysDetail();
        List<Buys_detail> detalles = buysDetailDAO.listarDetallesPorCompra(idCompra);
        request.setAttribute("detallesCompra", detalles);
        return "vistas/page.jsp?page=compras"; // Redirige a la página de compras
    }
  
    private String agregarProducto(HttpServletRequest request) {
        Products prod = new Products(); // Cambiado a Products

        prod.setComercial_name(request.getParameter("txtComercialName"));
        prod.setGeneric_name(request.getParameter("txtGenericName"));
        prod.setFormulation(request.getParameter("txtFormulation"));
        prod.setBrand(request.getParameter("txtBrand"));
        prod.setDescription(request.getParameter("txtDescription"));
        prod.setCategory(request.getParameter("txtCategory"));
        prod.setSales_price(new BigDecimal(request.getParameter("txtPsale")));
        prod.setUnit(request.getParameter("txtUnit"));
        prod.setNameSuppliers(request.getParameter("txtNameSuppliers"));
        prod.setStatus(request.getParameter("txtStatus"));
        prod.setConcentration(new BigDecimal(request.getParameter("txtConcentration")));
        prod.setConcentration_unit(request.getParameter("txtConcentrationUnit"));
        prod.setAction_mode(request.getParameter("txtActionMode"));
        prod.setCrops(request.getParameter("txtCrops"));
        prod.setPests_Diseases(request.getParameter("txtPestsDiseases"));
        prod.setRecomended_dose(request.getParameter("txtRecomendedDose"));
        prod.setPrecautions(request.getParameter("txtPrecautions"));

        dao.add(prod);
        return Productos;
    }


    private String actualizarProducto(HttpServletRequest request) {
        Products prod = new Products(); // Cambiado a Products
        try {
            prod.setProducts_id(Integer.parseInt(request.getParameter("id")));
            prod.setComercial_name(request.getParameter("txtComercialName"));
            prod.setGeneric_name(request.getParameter("txtGenericName"));
            prod.setFormulation(request.getParameter("txtFormulation"));
            prod.setBrand(request.getParameter("txtBrand"));
            prod.setDescription(request.getParameter("txtDescription"));
            prod.setCategory(request.getParameter("txtCategory"));
            prod.setSales_price(new BigDecimal(request.getParameter("txtPsale")));
            prod.setUnit(request.getParameter("txtUnit"));
            prod.setNameSuppliers(request.getParameter("txtNameSuppliers"));
            prod.setConcentration(BigDecimal.valueOf(Integer.parseInt(request.getParameter("txtConcentration"))));
            prod.setConcentration_unit(request.getParameter("txtConcentrationUnit"));
            prod.setAction_mode(request.getParameter("txtActionMode"));
            prod.setCrops(request.getParameter("txtCrops"));
            prod.setPests_Diseases(request.getParameter("txtPestsDiseases"));
            prod.setRecomended_dose(request.getParameter("txtRecomendedDose"));
            prod.setPrecautions(request.getParameter("txtPrecautions"));
            dao.edit(prod);



        } catch (NumberFormatException e) {
            e.printStackTrace(); // Manejo de excepciones si la conversión falla
        }
        return Productos;
    }

    private String eliminarProducto(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        dao.eliminar(id);
        return Productos;
    }

    private String Restore(HttpServletRequest request) {
        int id = Integer.parseInt(request.getParameter("id"));
        dao.Restore(id);
        return "vistas/page.jsp?page=inactivos";
    }
}
