package pe.edu.vallegrande.service;

import pe.edu.vallegrande.db.AccesoDB;
import pe.edu.vallegrande.dto.Suppliers;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SuppliersDAO {
    private final AccesoDB db = new AccesoDB();

    public List<Suppliers> listar() {
        List<Suppliers> list = new ArrayList<>();
        String sql = "SELECT * FROM Suppliers";

        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Suppliers supplier = new Suppliers();
                supplier.setSuppliers_id(rs.getInt("suppliers_id"));
                supplier.setSupplers_name(rs.getString("name"));
                list.add(supplier);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}


