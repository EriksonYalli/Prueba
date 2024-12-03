package pe.edu.vallegrande.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@Data
@AllArgsConstructor
@NoArgsConstructor
public class SupplierDto {
    private int id;
    private String ruc;
    private String company;
    private String contact;
    private String telefono;
    private String status;
}
