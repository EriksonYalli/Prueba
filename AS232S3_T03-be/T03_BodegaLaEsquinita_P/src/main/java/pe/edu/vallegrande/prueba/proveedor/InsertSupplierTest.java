package pe.edu.vallegrande.prueba.proveedor;

import pe.edu.vallegrande.dto.Supplier;
import pe.edu.vallegrande.service.SupplierService;

import java.sql.SQLException;

public class InsertSupplierTest {
    public static void main(String[] args) throws SQLException {
        SupplierService service = new SupplierService();
        Supplier supplier = new Supplier();

        // Configuración de los valores de ejemplo para el proveedor
        supplier.setName("Proveedor Ejemplo");
        supplier.setDirection("Av. Ejemplo 123, Ciudad Ejemplo");
        supplier.setEmail("contacto@proveedorejemplo.com");
        supplier.setRuc("12345678901"); // Número de RUC de ejemplo
        supplier.setRepresentative("Juan Pérez");
        supplier.setEmailRepresentative("juan.perez@proveedorejemplo.com");
        supplier.setPhoneRepresentative("987654321"); // Teléfono del representante


        // Inserta el proveedor en la base de datos
        service.agregar(supplier);

        System.out.println("Proveedor insertado exitosamente");
    }
}
