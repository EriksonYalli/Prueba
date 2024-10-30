INSERT INTO Category (category_name) VALUES 
('Fertilizantes'),
('Herbicidas'),
('Insecticidas'),
('Fungicidas'),
('Reguladores de crecimiento'),
('Acaricidas'),
('Bioestimulantes');


INSERT INTO Suppliers (name, phone, email, ruc) VALUES 
('Agro Sostenible S.A.', '987654321', 'contacto@agrosostenible.com', '12345678901'),
('Fertilizantes del Perú S.A.C.', '987123456', 'info@fertiperu.com', '23456789012'),
('Productos Químicos de Perú', '987987654', 'ventas@proquiper.com', '34567890123'),
('BASF Perú', '988765432', 'servicio@basf.com', '45678901234'),
('Bayer CropScience', '989876543', 'atencion@bayer.com', '56789012345');

INSERT INTO Crops (name) VALUES 
('Maíz'),
('Arroz'),
('Trigo'),
('Cebolla'),
('Tomate'),
('Pimiento'),
('Papa'),
('Caña de azúcar'),
('Soja'),
('Café');

-- Agregar restricciones adicionales
ALTER TABLE Products
ADD CONSTRAINT chk_sale_price CHECK (sale_price >= 0);

ALTER TABLE Buys_detail
ADD CONSTRAINT chk_quantity CHECK (quantity > 0);

ALTER TABLE Buys_detail
ADD CONSTRAINT chk_unit_price CHECK (unit_price > 0);

ALTER TABLE Buys_detail
ADD CONSTRAINT chk_total_detail CHECK (total_detail = quantity * unit_price);

ALTER TABLE Buys_detail
ADD CONSTRAINT chk_expire_date CHECK (expire_date > GETDATE());


-- Agregar restricciones adicionales
ALTER TABLE Buys
ADD CONSTRAINT chk_buys_price CHECK (buys_price >= 0);

ALTER TABLE Buys
ADD CONSTRAINT chk_buys_date CHECK (buys_date <= GETDATE());

SELECT *
FROM Buys_detail
WHERE expire_date <= GETDATE();

DELETE Buys

UPDATE Inventory SET quantity = 0




