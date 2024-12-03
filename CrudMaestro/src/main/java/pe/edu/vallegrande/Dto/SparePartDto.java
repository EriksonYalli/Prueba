package pe.edu.vallegrande.Dto;

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
    private String compatibilityType;
    private int stock;
    private Date entryDate;
    private String state;
    private int categoryId;
    private int brandId;
    private String categoryName;
    private String brandName;
}
