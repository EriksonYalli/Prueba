package pe.edu.vallegrande.Dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@ToString
@Data
@AllArgsConstructor
@NoArgsConstructor
public class WorkerDto {
    private int id;
    private String name;
    private String lastName;
    private String email;
    private String post;
    private String specialty;
    private String phone;
    private String password;
}
