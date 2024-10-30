package pe.edu.vallegrande.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Products {
    private int products_id;
    private String comercial_name;
    private String generic_name;
    private String formulation;
    private String brand;
    private String description;
    private String category;
    private BigDecimal sales_price;
    private String unit;
    private String NameSuppliers;
    private int quantity;
    private String status;
    private BigDecimal concentration;
    private String concentration_unit;
    private BigDecimal price;
    private String action_mode;
    private String crops;
    private String pests_Diseases;
    private String recomended_dose;
    private String precautions;
}
