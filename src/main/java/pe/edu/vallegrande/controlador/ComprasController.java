package pe.edu.vallegrande.controlador;

import com.google.gson.Gson;
import pe.edu.vallegrande.dto.Buys;
import pe.edu.vallegrande.dto.Buys_detail;
import pe.edu.vallegrande.dto.Products;
import pe.edu.vallegrande.service.BuysDAO;
import pe.edu.vallegrande.service.BuysDetail;
import pe.edu.vallegrande.service.ProductsDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.SQLOutput;
import java.time.LocalDate;
import java.util.Arrays;

import java.util.ArrayList;
import java.util.List;

@WebServlet("/comprasController")
public class ComprasController extends HttpServlet {
    private BuysDetail buysDetailDAO = new BuysDetail();
    private BuysDAO buysDAO = new BuysDAO();

    String compras = "controlador?accion=listar&page=compras";


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("accion");

        switch (action) {
            case "detallesCompra":
                mostrarDetallesCompra(request, response);
                break;

            case "editarcompra":
                try {
                    int idCompra = Integer.parseInt(request.getParameter("id"));
                    BuysDAO buysDAO = new BuysDAO();

                    // Obtener los detalles de la compra
                    List<Buys_detail> detalles = buysDetailDAO.listarDetallesPorCompra(idCompra); // Asegúrate de que este método exista

                    // Establecer los atributos para la vista
                    request.setAttribute("detalles", detalles);
                    Buys compra = buysDAO.listEdit(idCompra); // Obtener la compra por ID
                    request.setAttribute("compra", compra);

                    // Redirigir a la página de edición
                    request.getRequestDispatcher("vistas/page.jsp?page=editbuys").forward(request, response);
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("error.jsp"); // Redirigir a una página de error
                }
                break;
            case "reportes":
                int id = Integer.parseInt(request.getParameter("id"));
                BuysDAO dao = new BuysDAO();
                BuysDetail detail = new BuysDetail();
                List<Buys_detail> detalles = detail.listarDetallesPorCompra(id);
                System.out.println(detalles + "estos es lo obtenido");
                Buys COM = dao.listEdit(id);
                System.out.println(COM);


                    request.setAttribute("compraedit", COM);
                    request.setAttribute("detalles", detalles);
                    // Redirigir a la página de edición
                    RequestDispatcher dispatcher = request.getRequestDispatcher("controlador?accion=listar&page=reportes"); // Asegúrate de que esta sea la página correcta
                    dispatcher.forward(request, response);

                break;

            default:
                // Opcional: Manejar el caso por defecto si no coincide ninguna acción
                break;
        }



    }

    private void mostrarDetallesCompra(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int compraId = Integer.parseInt(request.getParameter("id"));

        List<Buys_detail> detalles = buysDetailDAO.listarDetallesPorCompra(compraId);

        request.setAttribute("detalles", detalles);
        request.setAttribute("accion", "detallesCompra");
        request.setAttribute("compraId", compraId);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/vistas/page.jsp?page=detallesCompra"); // Asegúrate que la página sea la correcta
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        String action = request.getParameter("accion");
        String acceso;

        switch (action) {
            case "detallesCompra":
                mostrarDetallesCompra(request, response);
                break;

            case "editar":
                editarCompra(request, response); // Pasando también `response`
                break;

            case "agregarCompras":
                try {
                    String dateString = request.getParameter("buys_date");
                    System.out.println("Fecha recibida: " + dateString); // Debugging
                    if (dateString == null || dateString.isEmpty()) {
                        throw new IllegalArgumentException("La fecha no puede estar vacía.");
                    }

                    // Recoger datos del formulario
                    Buys buy = new Buys();
                    buy.setBuys_date(Date.valueOf(dateString)); // Asegúrate de que este campo esté en tu formulario
                    String precioTotalStr = request.getParameter("buys_price");
                    BigDecimal precioTotal = new BigDecimal(precioTotalStr);
                    System.out.println(precioTotal); // Calcula o recibe este valor
                    buy.setBuys_price(precioTotal);
                    buy.setSupplierId(Integer.parseInt(request.getParameter("supplier")));

                    // Crear la lista de detalles
                    List<Buys_detail> details = new ArrayList<>();
                    String[] productIds = request.getParameterValues("productId[]");
                    System.out.println(productIds);
                    String[] quantities = request.getParameterValues("quantity[]");
                    String[] unitPrices = request.getParameterValues("unit_price[]");
                    String[] batches = request.getParameterValues("batch[]");
                    String[] expireDates = request.getParameterValues("expire_date[]");
                    String[] presentations = request.getParameterValues("presentation[]");
                    String[] healthRecords = request.getParameterValues("health_record[]");

                    System.out.println("Product IDs: " + Arrays.toString(productIds));
                    System.out.println("Quantities: " + Arrays.toString(quantities));
                    System.out.println("Unit Prices: " + Arrays.toString(unitPrices));
                    System.out.println("Batches: " + Arrays.toString(batches));
                    System.out.println("Expire Dates: " + Arrays.toString(expireDates));
                    System.out.println("Presentations: " + Arrays.toString(presentations));
                    System.out.println("Health Records: " + Arrays.toString(healthRecords));

                    for (int i = 0; i < productIds.length; i++) {
                        Buys_detail detail = new Buys_detail();
                        detail.setFkproduct_id(Integer.parseInt(productIds[i]));
                        detail.setQuantity(Integer.parseInt(quantities[i]));
                        detail.setUnitPrice(new BigDecimal(unitPrices[i]));
                        detail.setTotalDetail(detail.getUnitPrice().multiply(new BigDecimal(detail.getQuantity())));
                        detail.setBatch(batches[i]);
                        detail.setExpireDate(expireDates[i]);
                        detail.setPresentation(presentations[i]);
                        detail.setHealthRecord(healthRecords[i]);
                        details.add(detail);
                    }

                    // Insertar compra y detalles
                    BuysDAO buysDAO = new BuysDAO();
                    BuysDetail buysDetailDAO = new BuysDetail();
                    int buyId = buysDAO.insertPurchase(buy);
                    buysDetailDAO.insertPurchaseDetails(buyId, details);

                    response.sendRedirect("controlador?accion=listar&page=compras"); // Redirigir a una página de éxito
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("error.jsp"); // Redirigir a una página de error
                }
                break;
            case "actualizarDetalle":
                try {
                    // Recoger el ID de la compra a actualizar
                    int buyId = Integer.parseInt(request.getParameter("buy_id")); // Asegúrate de que el ID se envíe en el formulario

                    // Crear la lista de nuevos detalles
                    List<Buys_detail> newDetails = new ArrayList<>();

                    String[] productIds = request.getParameterValues("productId[]");
                    String[] quantities = request.getParameterValues("quantity[]");
                    String[] unitPrices = request.getParameterValues("unit_price[]");
                    String[] batches = request.getParameterValues("batch[]");
                    String[] expireDates = request.getParameterValues("expire_date[]");
                    String[] presentations = request.getParameterValues("presentation[]");
                    String[] healthRecords = request.getParameterValues("health_record[]");

                    for (int i = 0; i < productIds.length; i++) {
                        Buys_detail detail = new Buys_detail();
                        detail.setFkproduct_id(Integer.parseInt(productIds[i]));
                        detail.setQuantity(Integer.parseInt(quantities[i]));
                        detail.setUnitPrice(new BigDecimal(unitPrices[i]));
                        detail.setTotalDetail(detail.getUnitPrice().multiply(new BigDecimal(detail.getQuantity())));
                        detail.setBatch(batches[i]);
                        detail.setExpireDate(expireDates[i]);
                        detail.setPresentation(presentations[i]);
                        detail.setHealthRecord(healthRecords[i]);
                        newDetails.add(detail);
                    }

                    // Llamar a la DAO para actualizar la compra
                    buysDetailDAO.actualizarCompra(buyId, newDetails);

                    response.sendRedirect("controlador?accion=listar&page=compras"); // Redirigir a una página de éxito
                } catch (Exception e) {
                    e.printStackTrace();
                    response.sendRedirect("error.jsp"); // Redirigir a una página de error
                }
                break;
            case "buscarPorProveedor":
                int supplierId = Integer.parseInt(request.getParameter("supplierId"));
                System.out.println(supplierId);

                List<Buys> comprasPorProveedor = buysDAO.listarComprasPorProveedor(supplierId);
                request.setAttribute("comprasPorProveedor", comprasPorProveedor);
                break;


            default:
                // Opcional: Manejar el caso por defecto si no coincide ninguna acción
                break;
        }



    }

    private void generarReportesPorId(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


    }

    private void editarCompra(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int idBuyDetail= Integer.parseInt((request.getParameter("detail_id[]")));
        System.out.println(idBuyDetail);

        BuysDAO dao = new BuysDAO();
        BuysDetail detail = new BuysDetail();
        List<Buys_detail> nuevo = detail.listarDetallesPorCompra(idBuyDetail);
        System.out.println(nuevo + "estos es lo obtenido");
        Buys compra = dao.listEdit(id);


        if (compra != null) {
            request.setAttribute("compraedit", compra);
            // Redirigir a la página de edición
            RequestDispatcher dispatcher = request.getRequestDispatcher("controlador?accion=listar&page=edit"); // Asegúrate de que esta sea la página correcta
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("error", "Producto no encontrado");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/vistas/error.jsp");
            dispatcher.forward(request, response);
        }
    }







}

