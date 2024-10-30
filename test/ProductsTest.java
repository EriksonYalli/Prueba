package pe.edu.vallegrande.test;

import static org.junit.Assert.*;
import org.junit.Test;
import pe.edu.vallegrande.dto.Products;
import pe.edu.vallegrande.service.ProductsDAO;

import java.math.BigDecimal;
import java.util.List;

public class ProductsTest {

    @pe.edu.vallegrande.test.Test
    public void testAddProduct() {
        // Crear un objeto Products con datos de prueba
        Products product = new Products();
        product.setComercial_name("Test 6");
        product.setGeneric_name("Test Generic");
        product.setFormulation("Test Formulation");
        product.setBrand("Test Brand");
        product.setDescription("Test Description");
        product.setCategory("1"); // Asegúrate de que esta categoría exista
        product.setSales_price(new BigDecimal("10.00"));
        product.setUnit("L");
        product.setNameSuppliers("1"); // Asegúrate de que este proveedor exista
        product.setConcentration(new BigDecimal("5.0"));
        product.setConcentration_unit("g/L");
        product.setAction_mode("Contact");
        product.setCrops("1"); // Asegúrate de que este cultivo exista
        product.setPests_Diseases("Test Pests");
        product.setRecomended_dose("1L/ha");
        product.setPrecautions("Handle with care");

        // Crear una instancia de la clase que contiene el método add
        ProductsDAO yourClass = new ProductsDAO(); // Reemplaza con el nombre real de tu clase

        // Llamar al método add y verificar el resultado
        boolean result = yourClass.add(product);
        assertTrue("El producto no se pudo agregar.", result);

        // Opcional: Puedes verificar que el producto se haya insertado correctamente en la base de datos.
        // Esto puede implicar hacer una consulta para buscar el producto por su nombre o ID.
    }

    @Test
    public void testListar() {
        ProductsDAO yourClass = new ProductsDAO();
        List<Products> productos = yourClass.listar();

        assertNotNull("La lista de productos no debería ser nula", productos);
        assertFalse("La lista de productos no debería estar vacía", productos.isEmpty());

        // Verifica que al menos un producto tenga los datos esperados
        Products primerProducto = productos.get(0);
        assertNotNull("El ID del producto no debería ser nulo", primerProducto.getProducts_id());
        assertNotNull("El nombre comercial no debería ser nulo", primerProducto.getComercial_name());
        assertNotNull("La categoría no debería ser nula", primerProducto.getCategory());

        System.out.println("Productos listados:");
        for (Products producto : productos) {
            System.out.println("ID: " + producto.getProducts_id());
            System.out.println("Nombre Comercial: " + producto.getComercial_name());
            System.out.println("Nombre Genérico: " + producto.getGeneric_name());
            System.out.println("Marca: " + producto.getBrand());
            System.out.println("Descripción: " + producto.getDescription());
            System.out.println("Precio de Venta: " + producto.getSales_price());
            System.out.println("Cantidad en Inventario: " + producto.getQuantity());
            System.out.println("------------------------");
        }

        // Puedes agregar más aserciones según los campos que esperas que estén presentes
    }

    public static void main(String[] args) {
        ProductsTest test = new ProductsTest();
        test.testAddProduct();
    }


    @Test
    public void testUpdateProduct() {
        // Crear un objeto Products con datos de prueba
        Products product = new Products();
        product.setProducts_id(1); // Supongamos que el ID del producto a actualizar es 1
        product.setComercial_name("Test perro");
        product.setGeneric_name("Test Generic");
        product.setFormulation("Test Formulation");
        product.setBrand("Test Brand");
        product.setDescription("Test Description");
        product.setCategory("1"); // Asegúrate de que esta categoría exista
        product.setSales_price(new BigDecimal("25.00")); // Nuevo precio
        product.setUnit("L");
        product.setNameSuppliers("1"); // Asegúrate de que este proveedor exista
        product.setConcentration(new BigDecimal("10.0"));
        product.setConcentration_unit("g/L");
        product.setAction_mode("Contact");
        product.setCrops("1"); // Asegúrate de que este cultivo exista
        product.setPests_Diseases("Test Pests");
        product.setRecomended_dose("3L/ha");
        product.setPrecautions("Handle with care");

        // Crear una instancia de la clase que contiene el método update
        ProductsDAO yourClass = new ProductsDAO(); // Reemplaza con el nombre real de tu clase

        // Llamar al método update y verificar el resultado
        boolean updateResult = yourClass.edit(product);
        assertTrue("El producto no se pudo actualizar.", updateResult);

        // Imprimir los datos del producto actualizado
        System.out.println("Producto actualizado:");
        System.out.println("ID: " + product.getProducts_id());
        System.out.println("Nombre Comercial: " + product.getComercial_name());
        System.out.println("Precio de Venta: " + product.getSales_price());
    }

    @Test
    public void testDeleteProduct() {
        int productIdToDelete = 1; // Asegúrate de que este ID exista

        // Crear una instancia de la clase que contiene el método delete
        ProductsDAO yourClass = new ProductsDAO(); // Reemplaza con el nombre real de tu clase

        // Llamar al método delete y verificar el resultado
        boolean deleteResult = yourClass.eliminar(productIdToDelete);
        assertTrue("El producto no se pudo eliminar.", deleteResult);

    }

    public void testRestoreProduct() {
        int productIdToDelete = 1; // Asegúrate de que este ID exista

        // Crear una instancia de la clase que contiene el método delete
        ProductsDAO yourClass = new ProductsDAO();
        boolean restore = yourClass.Restore(productIdToDelete);
        assertTrue("El producto no se pudo actualizar.", restore);


    }




}