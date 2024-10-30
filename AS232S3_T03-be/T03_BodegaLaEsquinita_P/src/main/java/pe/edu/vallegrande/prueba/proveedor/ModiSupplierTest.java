package pe.edu.vallegrande.prueba.proveedor;

import pe.edu.vallegrande.dto.Supplier;
import pe.edu.vallegrande.service.SupplierService;

import java.sql.SQLException;

public class ModiSupplierTest {
    public static void main(String[] args) throws SQLException {
        SupplierService service = new SupplierService();
        Supplier supplier = new Supplier();

        // Configuración de los valores actualizados para el proveedor con ID 2
        supplier.setId(1); // Establece el ID del proveedor que se va a editar
        supplier.setName("Proveedor Actualizado");
        supplier.setDirection("Av. Nueva Dirección 456, Ciudad Actualizada");
        supplier.setEmail("nuevo.contacto@proveedorejemplo.com");
        supplier.setRuc("10987654321"); // Número de RUC actualizado
        supplier.setRepresentative("Ana García");
        supplier.setEmailRepresentative("ana.garcia@proveedorejemplo.com");
        supplier.setPhoneRepresentative("912345678"); // Teléfono del representante actualizado

        // Actualiza el proveedor en la base de datos
        service.editar(supplier);

        System.out.println("Proveedor con ID 2 actualizado exitosamente");
    }
}
