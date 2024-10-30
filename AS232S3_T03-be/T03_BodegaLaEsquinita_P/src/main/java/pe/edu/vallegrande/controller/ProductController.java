package pe.edu.vallegrande.controller;

import pe.edu.vallegrande.dto.Product;
import pe.edu.vallegrande.service.ProductService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.sql.Date;
import pe.edu.vallegrande.service.SupplierService;
import pe.edu.vallegrande.dto.Supplier;

@WebServlet({"/editarProduct", "/agregarProduct", "/eliminarProduct", "/listarProductos"})
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService = new ProductService();

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        switch (path) {
            case "/editarProduct":
                editarProduct(request, response);
                break;
            case "/agregarProduct":
                agregarProduct(request, response);
                break;
            case "/eliminarProduct":
                eliminarProduct(request, response);
                break;
            case "/listarProductos":
                listarProductos(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    protected void mostrarFormulario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        SupplierService supplierService = new SupplierService(); // Asegúrate de tener este servicio
        List<Supplier> suppliers = supplierService.listar(); // Asumiendo que este método existe

        request.setAttribute("suppliers", suppliers);
        RequestDispatcher rd = request.getRequestDispatcher("agregarProducto.jsp"); // Asegúrate de que sea el nombre correcto
        rd.forward(request, response);
    }

    protected void editarProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (request.getMethod().equalsIgnoreCase("GET")) {
            int id = Integer.parseInt(request.getParameter("id"));
            Product producto = productService.buscarPorId(id);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            String formattedDate = sdf.format(producto.getExpirationDate());
            request.setAttribute("producto", producto);
            request.setAttribute("formattedDate", formattedDate);
            RequestDispatcher rd = request.getRequestDispatcher("editarProducto.jsp");
            rd.forward(request, response);
        } else if (request.getMethod().equalsIgnoreCase("POST")) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                String tradeMark = request.getParameter("trade_mark");
                int stock = Integer.parseInt(request.getParameter("stock"));
                BigDecimal price = new BigDecimal(request.getParameter("price"));
                String fechaCadena = request.getParameter("expiry_date");

                // Convertir la fecha desde el formato yyyy/MM/dd
                SimpleDateFormat formatoEntrada = new SimpleDateFormat("yyyy/MM/dd");
                java.util.Date fechaUtil = formatoEntrada.parse(fechaCadena);
                java.sql.Date expirationDate = new java.sql.Date(fechaUtil.getTime());

                // Crear el objeto Product
                Product producto = new Product(id, name, description, tradeMark, stock, price, expirationDate, 0); // supplierId puede ser 0

                // Editar el producto
                productService.editar(producto);
                response.sendRedirect("listarProductos");
            } catch (ParseException e) {
                e.printStackTrace();
                request.setAttribute("error", "Fecha no válida: debe estar en el formato yyyy/MM/dd");
                request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                e.printStackTrace();
                request.setAttribute("error", "Por favor, asegúrese de que los campos numéricos son válidos.");
                request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error al editar el producto: " + e.getMessage());
                request.getRequestDispatcher("editarProducto.jsp").forward(request, response);
            }
        }
    }



    protected void agregarProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String tradeMark = request.getParameter("trade_mark");

        int stock = 0;
        String stockString = request.getParameter("stock");
        if (stockString != null && !stockString.isEmpty()) {
            stock = Integer.parseInt(stockString);
        }

        BigDecimal price = null;
        String priceString = request.getParameter("price");
        if (priceString != null && !priceString.isEmpty()) {
            price = new BigDecimal(priceString);
        }

        // Convertir la fecha desde el formato yyyy/MM/dd
        String fechaCadena = request.getParameter("expiry_date");
        java.sql.Date expirationDate = null;

        try {
            if (fechaCadena != null && !fechaCadena.isEmpty()) {
                // Cambiar el formato de la fecha
                SimpleDateFormat formatoEntrada = new SimpleDateFormat("yyyy/MM/dd");
                java.util.Date fechaUtil = formatoEntrada.parse(fechaCadena); // Convierte a Date
                expirationDate = new java.sql.Date(fechaUtil.getTime()); // Convierte a java.sql.Date
            }
        } catch (ParseException e) {
            e.printStackTrace();
            request.setAttribute("error", "Fecha de vencimiento no válida.");
            request.getRequestDispatcher("agregarProducto.jsp").forward(request, response);
            return; // Detén la ejecución
        }

        int supplierId = 0;
        String supplierIdString = request.getParameter("id_supplier");
        if (supplierIdString != null && !supplierIdString.isEmpty()) {
            supplierId = Integer.parseInt(supplierIdString);
        }

        Product producto = new Product(0, name, description, tradeMark, stock, price, expirationDate, supplierId);
        int resultado = productService.agregar(producto);

        if (resultado > 0) {
            response.sendRedirect("listarProductos");
        } else {
            request.setAttribute("error", "Error al agregar el producto. Intente nuevamente.");
            request.getRequestDispatcher("agregarProducto.jsp").forward(request, response);
        }
    }

    private void eliminarProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        productService.eliminar(id);
        response.sendRedirect("listarProductos");
    }

    private void listarProductos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Product> productListar = productService.listar();
        List<Product> formattedProductList = new ArrayList<>();

        // Formateador para las fechas
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        for (Product product : productListar) {
            // Aquí puedes crear una nueva instancia de Product para agregar a la lista formateada
            Product formattedProduct = new Product();
            formattedProduct.setId(product.getId());
            formattedProduct.setName(product.getName());
            formattedProduct.setDescription(product.getDescription());
            formattedProduct.setTradeMark(product.getTradeMark());
            formattedProduct.setStock(product.getStock());
            formattedProduct.setPrice(product.getPrice());
            formattedProduct.setExpirationDate(product.getExpirationDate());

            // Formatear la fecha como String si es necesario
            if (product.getExpirationDate() != null) {
                String formattedDate = sdf.format(product.getExpirationDate());
                // Puedes agregar la fecha formateada a un nuevo campo en Product o simplemente usarla en tu JSP
                // formattedProduct.setExpirationDate(formattedDate); // Si decides agregar un campo String a Product
            }

            formattedProductList.add(formattedProduct);
        }

        request.setAttribute("productListar", formattedProductList);
        RequestDispatcher rd = request.getRequestDispatcher("productos.jsp");
        rd.forward(request, response);
    }

}
