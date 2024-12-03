package pe.edu.vallegrande.controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import pe.edu.vallegrande.Dto.PurcharseDetailDto;
import pe.edu.vallegrande.Dto.PurcharseDto;
import pe.edu.vallegrande.Dto.SupplierDto;
import pe.edu.vallegrande.Dto.SparePartDto;
import pe.edu.vallegrande.service.PurcharseDetailService;
import pe.edu.vallegrande.service.SupplierService;
import pe.edu.vallegrande.service.SparePartService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@WebServlet({"/Registrar_Compras", "/Registrar_ComprasAlmacen", "/RegistrarCompra"})
public class PurchaseDetailPageController extends HttpServlet {
    private SupplierService supplierService = new SupplierService();
    private SparePartService sparePartService = new SparePartService();
    private PurcharseDetailService purchaseService = new PurcharseDetailService();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String path = request.getServletPath();

        switch (path) {
            case "/Registrar_Compras":
                RegistrarCompraAdmin(request, response);
                break;
            case "/Registrar_ComprasAlmacen":
                RegistrarCompraAlmacen(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void RegistrarCompraAlmacen(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cargar proveedores y repuestos
        List<SupplierDto> suppliers = supplierService.getSuppliers();
        List<SparePartDto> spareParts = sparePartService.getSpareParts();


        // Enviar datos al JSP
        request.setAttribute("suppliers", suppliers);
        request.setAttribute("spareParts", spareParts);

        // Despachar al JSP
        request.getRequestDispatcher("/Compra/purcharseDetail.jsp").forward(request, response);
    }

    private void RegistrarCompraAdmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Cargar proveedores y repuestos
        List<SupplierDto> suppliers = supplierService.getSuppliers();
        List<SparePartDto> spareParts = sparePartService.getSpareParts();


        // Enviar datos al JSP
        request.setAttribute("suppliers", suppliers);
        request.setAttribute("spareParts", spareParts);

        // Despachar al JSP
        request.getRequestDispatcher("purcharseDetail.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();
        switch (path) {
            case "/RegistrarCompra":
                RegistrarCompra(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                break;
        }
    }

    private void RegistrarCompra(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            System.out.println("Procesando solicitud POST...");

            BufferedReader reader = req.getReader();
            StringBuilder json = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                json.append(line);
            }

            System.out.println("JSON recibido: " + json.toString());

            Gson gson = new Gson();
            JsonObject data = gson.fromJson(json.toString(), JsonObject.class);

            PurcharseDto purchaseDto = new PurcharseDto();
            purchaseDto.setSupplierId(data.get("supplierId").getAsInt());
            purchaseDto.setPaymentMethod(data.get("paymentMethod").getAsString());
            purchaseDto.setTotalAmount(new BigDecimal(data.get("totalAmount").getAsString()));
            purchaseDto.setDate(new Date(System.currentTimeMillis()));
            purchaseDto.setStatus("A");

            List<PurcharseDetailDto> details = new ArrayList<>();
            JsonArray products = data.getAsJsonArray("products");

            for (JsonElement element : products) {
                JsonObject product = element.getAsJsonObject();
                PurcharseDetailDto detail = new PurcharseDetailDto();
                detail.setSparePartsId(product.get("productId").getAsInt());
                detail.setQuantity(product.get("quantity").getAsInt());
                detail.setPriceUnit(new BigDecimal(product.get("priceUnit").getAsString()));
                detail.setSubtotal(new BigDecimal(product.get("subtotal").getAsString()));
                details.add(detail);
            }

            System.out.println("Cabecera de compra: " + purchaseDto);
            System.out.println("Detalles de compra: " + details);

            boolean success = purchaseService.registrarCompra(purchaseDto, details);

            if (success) {
                resp.setStatus(HttpServletResponse.SC_OK);
            } else {
                resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            resp.getWriter().write("Error: " + e.getMessage());
        }
    }


}
