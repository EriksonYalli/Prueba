package pe.edu.vallegrande.Dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class VehicleDto {

    private int id;
    private int customerId;
    private String model;
    private String brand;
    private int year;
    private String plate;


}
