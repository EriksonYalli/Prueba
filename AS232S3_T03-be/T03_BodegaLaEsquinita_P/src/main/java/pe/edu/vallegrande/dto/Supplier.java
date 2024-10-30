package pe.edu.vallegrande.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Supplier {
    private int id;
    private String name;
    private String direction;
    private String email;
    private String ruc;
    private String representative;
    private String emailRepresentative;
    private String phoneRepresentative;
    private char status;
}
