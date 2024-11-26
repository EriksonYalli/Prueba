package pe.edu.vallegrande.demo1.dto;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UsuarioDto {

    private int id;
    private String nombre;
    private String apellido;
    private String usuario;
}
