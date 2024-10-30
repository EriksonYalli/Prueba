package pe.edu.vallegrande.service;

import pe.edu.vallegrande.db.AccesoDB;
import pe.edu.vallegrande.dto.Category;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {

    static AccesoDB accesoDB = new AccesoDB();

    public List<Category> listar(){
        List<Category> category = new ArrayList<>();

        String sql = "select * from Category";
        try (Connection con = accesoDB.getCon();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery())
        {
            while (rs.next()) {
                Category c = new Category();
                c.setCategoryId(rs.getInt("category_id"));
                c.setCategoryName(rs.getString("category_name"));
                category.add(c);
            }
        }catch (Exception e) {
            e.printStackTrace();
        }


        return category;
    }
}
