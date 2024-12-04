-- Usar la base de datos creada
USE VentaReposteria;


-- Insertar nuevos productos con codeBarra predefinido
INSERT INTO Productos (codeBarra, nombre, descripcion, marca, categoria, precioVenta, descuento, stock, Estatus)
VALUES 
('TOR0003', 'Torta de Manzana Caramelizada', 'Torta con capas de manzana caramelizada y crema pastelera', 'Delicia Dulce', 'Tortas y Pasteles', 28.00, 3.00, 8, 'A'),
('TOR0004', 'Torta de Tres Leches', 'Torta húmeda con mezcla de tres leches y cobertura de merengue', 'Delicia Dulce', 'Tortas y Pasteles', 35.00, 4.00, 7, 'A'),
('GAL0005', 'Galletas de Vainilla con Chispas', 'Galletas de vainilla con chispas de chocolate', 'DulceManía', 'Galletas', 8.00, 2.00, 40, 'A'),
('GAL0006', 'Galletas de Coco', 'Galletas crujientes con coco rallado', 'DulceManía', 'Galletas', 6.50, 1.50, 50, 'A'),
('CUP0007', 'Cupcake de Limón', 'Cupcake con un toque de limón y cobertura de glaseado', 'Sweet Treats', 'Cupcakes y Muffins', 10.00, 2.00, 18, 'A'),
('CUP0008', 'Muffin de Arándanos', 'Muffin esponjoso con arándanos frescos', 'DulceManía', 'Cupcakes y Muffins', 9.50, 1.50, 22, 'A'),
('BRO0009', 'Brownie de Caramelo Salado', 'Brownie con caramelo salado y nueces', 'ChocoBites', 'Brownies y Barras', 14.00, 3.00, 12, 'A'),
('BRO0010', 'Barra de Cereal con Miel', 'Barra energética con cereal y miel natural', 'Energía Natural', 'Brownies y Barras', 5.50, 0.50, 35, 'A'),
('MAC0011', 'Macarons de Pistacho', 'Macarons franceses rellenos de crema de pistacho', 'Delicias Francesas', 'Macarons', 16.00, 4.50, 17, 'A'),
('MAC0012', 'Macarons de Limón', 'Macarons franceses rellenos de crema de limón', 'Delicias Francesas', 'Macarons', 15.50, 5.00, 15, 'A');

update Productos set stock = 1000
where codeBarra = 'TOR0003'

select * from Productos;

-- Insertar datos en la tabla Clientes
INSERT INTO Clientes (Nombre, Apellido, TipoDocumento, NumeroDocumento, FechaNacimiento, Celular, Email, Direccion)
VALUES
('Juan', 'Pérez', 'DNI', '12345678', '1985-02-15', '987654321', 'juan.perez@email.com', 'Av. Siempre Viva 123'),
('María', 'González', 'DNI', '87654321', '1990-08-25', '998877665', 'maria.gonzalez@email.com', 'Calle Falsa 456'),
('Carlos', 'Lopez', 'DNI', '12345378', '1980-06-10', '956732812', 'carlos.lopez@email.com', 'Av. San Martín 789'),
('Jose', 'Yallico', 'DNI', '72786437', '1980-06-10', '956732112', 'jose.lopez@email.com', 'Herbay alto'),
('Rafael', 'Yallico', 'DNI', '72786438', '1980-02-10', '956732002', 'rafael.lopez@email.com', 'Herbay alto'),
('Fiorella', 'Yallico', 'DNI', '72786439', '1080-01-10', '956731112', 'fiorella.lopez@email.com', 'Herbay alto'),
('Xiomara', 'Canales', 'DNI', '12235378', '1980-01-10', '956002812', 'xiomara.lopez@email.com', 'Av. San Agustin');


delete Clientes;

select * from Clientes;


-- Insertar datos en la tabla Ventas
INSERT INTO Ventas (FK_ClienteID, FechaVenta, TotalProductoVendidos, PrecioTotal)
VALUES
(1, '2024-11-01', 5, 140.00), -- Venta realizada por Juan Pérez
(2, '2024-11-02', 3, 105.00), -- Venta realizada por María González
(3, '2024-11-03', 7, 220.00); -- Venta realizada por Carlos Lopez

INSERT INTO Ventas (FK_ClienteID, FechaVenta, TotalProductoVendidos, PrecioTotal)
VALUES
(1, '2024-11-01', 10, 00.00)



-- Insertar datos en la tabla DetalleVentas
INSERT INTO DetalleVentas (FK_VentaID, FK_ProductoID, CantidadProducto, PrecioUnitario, Descuento, TotalDetalle)
VALUES
-- Detalle de la venta 1 (Juan Pérez)
(1, 1, 2, 28.00, 3.00, 50.00), 
(1, 3, 3, 8.00, 2.00, 18.00), 

-- Detalle de la venta 2 (María González)
(2, 5, 2, 10.00, 2.00, 16.00), 
(2, 7, 1, 14.00, 3.00, 11.00),

-- Detalle de la venta 3 (Carlos Lopez)
(3, 9, 4, 16.00, 4.50, 46.00), 
(3, 10, 3, 5.50, 0.50, 15.00);


-- Insertar datos en la tabla DetalleVentas
INSERT INTO DetalleVentas (FK_VentaID, FK_ProductoID, CantidadProducto, PrecioUnitario, Descuento, TotalDetalle)
VALUES
-- Detalle de la venta 1 (Juan Pérez)
(1, 1, 10, 28.00, 3.00, 50.00)

delete DetalleVentas
delete Ventas



SET IDENTITY_INSERT dbo.EMPLEADO ON;  
GO  
  
INSERT INTO EMPLEADO(IDEMP,NOMBRE,APELLIDO,EMAIL,TELEFONO) 
VALUES(1001,'CLAUDIA','RAMOS','cramos@gmail.com',NULL);

INSERT INTO EMPLEADO(IDEMP,NOMBRE,APELLIDO,EMAIL,TELEFONO)  
VALUES(1002,'ANGELICA','TORRES','atorres@gmail.com','967345634');

INSERT INTO EMPLEADO(IDEMP,NOMBRE,APELLIDO,EMAIL,TELEFONO)  
VALUES(1003,'KARLA','GUTIERREZ','kgutierrez@gmail.com','995466783');

INSERT INTO EMPLEADO(IDEMP,NOMBRE,APELLIDO,EMAIL,TELEFONO)  
VALUES(1004,'LEONOR','CARRASCO','lcarrasco@gmail.com','986754373');

INSERT INTO EMPLEADO(IDEMP,NOMBRE,APELLIDO,EMAIL,TELEFONO)  
VALUES(1005,'JOSE','YALLICO','jyallicocama@gmail.com','915925751');

INSERT INTO EMPLEADO(IDEMP,NOMBRE,APELLIDO,EMAIL,TELEFONO)  
VALUES(1006,'XIOMARA','CANALES','xiomara@gmail.com','928818313');





INSERT INTO USUARIO(IDEMP, USUARIO, CLAVE, ESTADO)
VALUES(1002,'atorres',HashBytes('SHA1','suerte'),1);

INSERT INTO USUARIO(IDEMP, USUARIO, CLAVE, ESTADO)
VALUES(1003,'kgutierrez',HashBytes('SHA1','alegria'),1);

INSERT INTO USUARIO(IDEMP, USUARIO, CLAVE, ESTADO)
VALUES(1004,'lcarrasco',HashBytes('SHA1','felicidad'),0);

INSERT INTO USUARIO(IDEMP, USUARIO, CLAVE, ESTADO)
VALUES(1005,'yallico',HashBytes('SHA1','42011dias'),1);


DELETE FROM USUARIO
WHERE USUARIO = 'yallico';


INSERT INTO USUARIO(IDEMP, USUARIO, CLAVE, ESTADO)
VALUES(1006,'xiomara',HashBytes('SHA1','42011dias'),1);

GO

select * from USUARIO;

GO


-----ESTE TRIGGER FUNCIONA PARA PODER SUMAR EL STOCK EN CASO SE INGRESARA NUEVAS COMPRAS--------
CREATE TRIGGER venta_trigger 
ON DetalleVentas
FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar el stock en Products sumando la cantidad de productos comprados
    UPDATE Productos
    SET stock = stock - i.CantidadProducto
    FROM Productos p
    INNER JOIN inserted i ON p.productoID = i.FK_ProductoID;
END
GO



CREATE TRIGGER trg_Calculate_Total_DetalleVentas
ON DetalleVentas
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Actualizar el total_detail basado en la cantidad y el sale_price
    UPDATE sd
    SET TotalDetalle = sd.CantidadProducto * sd.PrecioUnitario
    FROM DetalleVentas sd
    INNER JOIN inserted i ON sd.DetalleVentaID = i.DetalleVentaID;
END;
GO





