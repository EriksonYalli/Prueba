package pe.edu.vallegrande.demo1.service;

import pe.edu.vallegrande.demo1.db.Conexion;
import pe.edu.vallegrande.demo1.dto.ProductoDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class ProductoSERVICE {

    Conexion db = new Conexion();

    public List<ProductoDTO> listarProductos() {
        List<ProductoDTO> productos = new ArrayList<>();
        String sql = "SELECT * FROM Productos";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ProductoDTO producto = new ProductoDTO();
                producto.setProductoID(rs.getInt("ProductoID"));
                producto.setNombre(rs.getString("Nombre"));
                producto.setDescripcion(rs.getString("Descripcion"));
                producto.setMarca(rs.getString("Marca"));
                producto.setCategoria(rs.getString("Categoria"));
                producto.setPrecioVenta(rs.getBigDecimal("PrecioVenta"));
                producto.setDescuento(rs.getBigDecimal("Descuento"));
                producto.setStock(rs.getInt("Stock"));
                producto.setEstatus(rs.getString("Estatus"));
                producto.setFechaIngreso(rs.getString("FechaIngreso"));
                productos.add(producto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productos;
    }

    public List<ProductoDTO> listarProductosPorMarca(String marca) {
        List<ProductoDTO> productos = new ArrayList<>();
        String sql = "SELECT * FROM Productos WHERE Marca = ?";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, marca);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductoDTO producto = new ProductoDTO();
                producto.setProductoID(rs.getInt("ProductoID"));
                producto.setNombre(rs.getString("Nombre"));
                producto.setDescripcion(rs.getString("Descripcion"));
                producto.setMarca(rs.getString("Marca"));
                producto.setCategoria(rs.getString("Categoria"));
                producto.setPrecioVenta(rs.getBigDecimal("PrecioVenta"));
                producto.setDescuento(rs.getBigDecimal("Descuento"));
                producto.setStock(rs.getInt("Stock"));
                producto.setEstatus(rs.getString("Estatus"));
                producto.setFechaIngreso(rs.getString("FechaIngreso"));
                productos.add(producto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productos;
    }



    public void agregarProducto(ProductoDTO producto) {
        String sql = "INSERT INTO Productos (Nombre, Descripcion, Marca, Categoria, PrecioVenta, Descuento, Stock, Estatus, FechaIngreso) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, producto.getNombre());
            ps.setString(2, producto.getDescripcion());
            ps.setString(3, producto.getMarca());
            ps.setString(4, producto.getCategoria());
            ps.setBigDecimal(5, producto.getPrecioVenta());
            ps.setBigDecimal(6, producto.getDescuento());
            ps.setInt(7, producto.getStock());
            ps.setString(8, producto.getEstatus());
            ps.setString(9, producto.getFechaIngreso());

            ps.executeUpdate();
            System.out.println("Producto agregado exitosamente.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int contarProductos() {
        int totalProductos = 0;
        String sql = "SELECT COUNT(*) FROM Productos";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                totalProductos = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalProductos;
    }

    public ProductoDTO editarPorId(int productoID) {
        String sql = "SELECT * FROM Productos WHERE ProductoID = ?";
        ProductoDTO productoDTO = null;
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, productoID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                productoDTO = new ProductoDTO();
                productoDTO.setProductoID(rs.getInt("ProductoID"));
                productoDTO.setNombre(rs.getString("Nombre"));
                productoDTO.setDescripcion(rs.getString("Descripcion"));
                productoDTO.setMarca(rs.getString("Marca"));
                productoDTO.setCategoria(rs.getString("Categoria"));
                productoDTO.setPrecioVenta(rs.getBigDecimal("PrecioVenta"));
                productoDTO.setDescuento(rs.getBigDecimal("Descuento"));
                productoDTO.setStock(Integer.parseInt(String.valueOf(rs.getInt("Stock"))));
                productoDTO.setEstatus(rs.getString("Estatus"));
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                productoDTO.setFechaIngreso(dateFormat.format(rs.getDate("FechaIngreso")));
            }
            System.out.println("Producto encontrado.");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return productoDTO;
    }

    public ProductoDTO actualizarProducto(ProductoDTO id) {
        String sql = "UPDATE Productos SET Nombre = ?, Descripcion = ?, Marca = ?, Categoria = ?, PrecioVenta = ?, Descuento = ?, Stock = ?, Estatus = ?, FechaIngreso = ? WHERE ProductoID = ?";
        ProductoDTO producto = new ProductoDTO();
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, id.getNombre());
            ps.setString(2, id.getDescripcion());
            ps.setString(3, id.getMarca());
            ps.setString(4, id.getCategoria());
            ps.setBigDecimal(5, id.getPrecioVenta());
            ps.setBigDecimal(6, id.getDescuento());
            ps.setInt(7, id.getStock());
            ps.setString(8, id.getEstatus());
            ps.setString(9, id.getFechaIngreso());
            ps.setInt(10, id.getProductoID());

            ps.executeUpdate();
            System.out.println("Producto actualizado exitosamente.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return producto;
    }

    public Object eliminarProductoID(int id) {
        String sql = "UPDATE Productos SET Estatus = ? WHERE ProductoID = ?";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "I");
            ps.setInt(2, id);

            int filasActualizadas = ps.executeUpdate();
            System.out.println("Producto eliminado exitosamente.");
            return filasActualizadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Object restaurarProductoID(int id) {
        String sql = "UPDATE Productos SET Estatus = ? WHERE ProductoID = ?";
        try (Connection con = db.getCon();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "A");
            ps.setInt(2, id);

            int filasActualizadas = ps.executeUpdate();
            System.out.println("Producto restaurado exitosamente.");
            return filasActualizadas > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }




}
