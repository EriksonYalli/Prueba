import java.math.BigDecimal;
import java.sql.Date;
import pe.edu.vallegrande.Dto.SparePartDto;
import pe.edu.vallegrande.service.SparePartService;

public class SparePartActualizacion {
    public static void main(String[] args) {
        SparePartService service = new SparePartService();

        // Crear un objeto SparePartDto con los datos actualizados
        SparePartDto repuestoExistente = new SparePartDto();
        repuestoExistente.setId(1); // ID del repuesto a actualizar
        repuestoExistente.setName("Filtro de Aire");
        repuestoExistente.setDescription("Filtro de aire modificado");
        repuestoExistente.setCompatibilityType("Original");
        repuestoExistente.setStock(120);
        repuestoExistente.setEntryDate(Date.valueOf("2024-10-29"));
        repuestoExistente.setCategoryId(3); // ID de categoría existente
        repuestoExistente.setBrandId(2); // ID de marca existente

        // Llamar al servicio para actualizar el repuesto
        service.updateSparePart(repuestoExistente);

    }
}
