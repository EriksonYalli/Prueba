package pe.edu.vallegrande.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.math.BigDecimal;
import java.sql.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor

public class Product {
    private int id;
    private String name;
    private String description;
    private String tradeMark;
    private int stock;
    private BigDecimal price;
    private Date expirationDate;
    private int supplierId;


}
