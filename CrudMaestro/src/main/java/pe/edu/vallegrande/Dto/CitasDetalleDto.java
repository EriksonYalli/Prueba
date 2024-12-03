package pe.edu.vallegrande.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CitasDetalleDto {

    private int id; // ID del detalle
    private int citaId; // ID de la cita a la que pertenece (quotes_id)
    private String description; // Descripción del detalle
    private String result; // Resultado del detalle de la cita
    private double cost; // Costo asociado al detalle
    private int serviceId; // ID del servicio asociado (nuevo campo)

    private CitasDto cita; // Relación con la entidad Cita
}
