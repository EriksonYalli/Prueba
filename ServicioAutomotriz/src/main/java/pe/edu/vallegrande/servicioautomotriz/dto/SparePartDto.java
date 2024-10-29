package pe.edu.vallegrande.servicioautomotriz.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import java.math.BigDecimal;
import java.sql.Date;

@ToString
@Data
@AllArgsConstructor
@NoArgsConstructor
public class SparePartDto {
    private int id;
    private String name;
    private String description;
    private BigDecimal priceUnit;
    private String brand;
    private int stock;
    private String compatibleModel;
    private Date entryDate;
    private String state;
}
