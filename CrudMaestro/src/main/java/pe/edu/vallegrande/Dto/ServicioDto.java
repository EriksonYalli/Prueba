package pe.edu.vallegrande.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ServicioDto {

    private int id; // ID del servicio
    private String name; // Nombre del servicio
    private String description; // Descripción del servicio
    private double cost; // Costo del servicio
    private String duration; // Duración del servicio (por ejemplo, "2 horas")
}
