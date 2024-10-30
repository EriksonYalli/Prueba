package pe.edu.vallegrande.service;

import pe.edu.vallegrande.db.AccesoDB;
import pe.edu.vallegrande.dto.Cultivos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CultivosDAO {

    static AccesoDB db = new AccesoDB();

    public static List<Cultivos> listar(){
        List<Cultivos> cultivos = new ArrayList<>();
        String sql = "SELECT * FROM Crops";

        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()){
                Cultivos cultivo = new Cultivos();
                cultivo.setIdCultivo(rs.getInt("crops_id"));
                cultivo.setNombreCultivo(rs.getString("name"));
                cultivos.add(cultivo);

        }

        }catch (Exception e) {
            e.printStackTrace();
        }
        return cultivos;
    }
}
