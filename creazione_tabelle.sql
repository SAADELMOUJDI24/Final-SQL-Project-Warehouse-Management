create database vendicose_spa;
use vendicose_spa;



CREATE TABLE Categories (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE Warehouses (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(50),
    Postal_code VARCHAR(6),
    City VARCHAR(50),
	Email VARCHAR(50),
    Phone_number VARCHAR(15)
);

CREATE TABLE Products (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Barcode VARCHAR(20),
    Name VARCHAR(50) NOT NULL,
    Category_id INT,
    Unit_price DECIMAL(10,2),
    FOREIGN KEY (category_id) REFERENCES Categories(ID)
);

CREATE TABLE RestockLevels (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Category_id INT,
    Warehouse_id INT,
    Product_id INT,
    Restock_level INT,
    FOREIGN KEY (category_id) REFERENCES Categories(ID),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(ID),
    FOREIGN KEY (product_id) REFERENCES Products(ID)
);

CREATE TABLE Stores (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(50),
    Postal_code VARCHAR(6),
    City VARCHAR(50),
	Email VARCHAR(50),
    Phone_number VARCHAR(15)
);

CREATE TABLE WarehouseStores (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Warehouse_id INT,
    Store_id INT,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(ID),
    FOREIGN KEY (store_id) REFERENCES Stores(ID)
);

CREATE TABLE Inventory (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Product_id INT,
    Warehouse_id INT,
    Quantity INT,
    FOREIGN KEY (product_id) REFERENCES Products(ID),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(ID)
);

CREATE TABLE Sales (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Sales_order_number VARCHAR(6),
    Sales_date DATE, 
    Product_id INT,
    Quantity_sold INT NOT NULL,
    Unit_price DECIMAL(10,2) NOT NULL,
    Sales_amount DECIMAL(10,2) NOT NULL,
    Store_id INT,
    FOREIGN KEY (product_id) REFERENCES Products(ID),
    FOREIGN KEY (store_id) REFERENCES Stores(ID)
);

-- POPOLAMENTO TABELLE 
-- CATEGORIES 
INSERT INTO Categories (Name) VALUES
('Groceries'),('Make_up'),('Stationery'),('Clothing'),('Home_decor'),('Drugs');
SELECT * FROM Categories;

-- WAREHOUSES
INSERT INTO Warehouses (Name, Address, Postal_code, City, Email, Phone_number) VALUES
('Warehouse Wonderland','Via Roma 1','00123','Roma','warehouse.wonderland@domain.com','06-12345678'),
('Milan Marvels','Via Milano 1','20123','Milano','milan.marvels@domain.com','02-87654321'),
('Naples Nexus','Via Napoli 1','80123','Napoli','naples.nexus@domain.com','081-23456789'),
('Florence Treasures','Via Firenze 1','50123','Firenze','florence.treasures@domain.com','055-98765432');
SELECT * FROM Warehouses;

-- PRODUCTS
INSERT INTO Products (Barcode,Name,Category_id,Unit_price) VALUES
-- Groceries
('8000049383772','Milk',1,1.50),('8000049383773','Bread',1,1.00),('8000049383774','Eggs',1,2.00), ('8000049383775','Cheese',1,3.50),('8000049383776','Butter',1,2.50),('8000049383777','Pasta',1,1.80),
('8000049383778','Rice',1,2.20),('8000049383779','Tomato Sauce',1,2.80),('8000049383780','Cereal',1,3.00), ('8000049383781','Juice',1,2.40),
-- Make_up
('8000049383782','Foundation',2,12.00),('8000049383783','Lipstick',2,8.00),('8000049383784','Mascara',2,7.50), ('8000049383785','Blush',2,6.00),('8000049383786','Eye Shadow',2,5.50),('8000049383787','Concealer',2,10.00),
('8000049383788','Powder',2,9.00),('8000049383789','Eyeliner',2,6.50),('8000049383790','Lip Gloss',2,7.00), ('8000049383791','Primer',2,15.00),
-- Stationery
('8000049383792','Notebook',3,2.50),('8000049383793','Pen',3,1.00),('8000049383794','Pencil',3,0.80), ('8000049383795','Eraser',3,0.50),('8000049383796','Ruler',3,1.20),('8000049383797','Highlighter',3,1.50),
('8000049383798','Marker',3,1.80),('8000049383799','Glue',3,2.00),('8000049383800','Scissors',3,3.50), ('8000049383801','Paper Clips',3,0.30),
-- Clothing
('8000049383802','T-shirt',4,10.00),('8000049383803','Jeans',4,20.00),('8000049383804','Jacket',4,30.00), ('8000049383805','Sweater',4,25.00),('8000049383806','Shirt',4,15.00),('8000049383807','Skirt',4,18.00),
('8000049383808','Dress',4,35.00),('8000049383809','Shorts',4,12.00),('8000049383810','Socks',4,3.00), ('8000049383811','Scarf',4,8.00),
-- Home_decor
('8000049383812','Cushion',5,15.00),('8000049383813','Vase',5,20.00),('8000049383814','Picture Frame',5,10.00), ('8000049383815','Lamp',5,25.00),('8000049383816','Curtains',5,18.00),('8000049383817','Rug',5,40.00),
('8000049383818','Candle',5,7.00),('8000049383819','Clock',5,15.00),('8000049383820','Mirror',5,30.00), ('8000049383821','Throw Blanket',5,22.00),
-- Drugs
('8000049383822','Aspirin',6,4.00),('8000049383823','Ibuprofen',6,5.00),('8000049383824','Cough Syrup',6,6.00), ('8000049383825','Antihistamine',6,7.00),('8000049383826','Vitamin C',6,3.00),('8000049383827','Antacid',6,2.50),
('8000049383828','Antibiotic Ointment',6,8.00),('8000049383829','Bandages',6,2.00),('8000049383830','Thermometer',6,10.00), ('8000049383831','Hand Sanitizer',6,3.50);
SELECT * FROM Products;

-- RESTOCKLEVELS
INSERT INTO RestockLevels (Category_id,Warehouse_id,Product_id,Restock_level) VALUES
-- Groceries (prodotti ID da 1 a 10)
(1,1,1,30),  -- Milk in Warehouse Wonderland
(1,1,2,15),  -- Bread in Warehouse Wonderland
(1,1,3,25),  -- Eggs in Warehouse Wonderland
(1,1,4,40),  -- Cheese in Warehouse Wonderland
(1,1,5,35),  -- Butter in Warehouse Wonderland
(1,1,6,20),  -- Pasta in Warehouse Wonderland
(1,1,7,30),  -- Rice in Warehouse Wonderland
(1,1,8,25),  -- Tomato Sauce in Warehouse Wonderland
(1,1,9,40),  -- Cereal in Warehouse Wonderland
(1,1,10,18), -- Juice in Warehouse Wonderland
(1,2,1,28),  -- Milk in Milan Marvels
(1,2,2,35),  -- Bread in Milan Marvels
(1,2,3,20),  -- Eggs in Milan Marvels
(1,2,4,22),  -- Cheese in Milan Marvels
(1,2,5,18),  -- Butter in Milan Marvels
(1,2,6,40),  -- Pasta in Milan Marvels
(1,2,7,30),  -- Rice in Milan Marvels
(1,2,8,15),  -- Tomato Sauce in Milan Marvels
(1,2,9,33),  -- Cereal in Milan Marvels
(1,2,10,28), -- Juice in Milan Marvels
(1,3,1,12),  -- Milk in Naples Nexus
(1,3,2,20),  -- Bread in Naples Nexus
(1,3,3,40),  -- Eggs in Naples Nexus
(1,3,4,30),  -- Cheese in Naples Nexus
(1,3,5,16),  -- Butter in Naples Nexus
(1,3,6,25),  -- Pasta in Naples Nexus
(1,3,7,18),  -- Rice in Naples Nexus
(1,3,8,35),  -- Tomato Sauce in Naples Nexus
(1,3,9,24),  -- Cereal in Naples Nexus
(1,3,10,12), -- Juice in Naples Nexus
(1,4,1,19),  -- Milk in Florence Treasures
(1,4,2,27),  -- Bread in Florence Treasures
(1,4,3,16),  -- Eggs in Florence Treasures
(1,4,4,30),  -- Cheese in Florence Treasures
(1,4,5,25),  -- Butter in Florence Treasures
(1,4,6,22),  -- Pasta in Florence Treasures
(1,4,7,20),  -- Rice in Florence Treasures
(1,4,8,40),  -- Tomato Sauce in Florence Treasures
(1,4,9,17),  -- Cereal in Florence Treasures
(1,4,10,31), -- Juice in Florence Treasures
-- Make_up (prodotti ID da 11 a 20)
(2,1,11,20), -- Foundation in Warehouse Wonderland
(2,1,12,25), -- Lipstick in Warehouse Wonderland
(2,1,13,30), -- Mascara in Warehouse Wonderland
(2,1,14,12), -- Blush in Warehouse Wonderland
(2,1,15,28), -- Eye Shadow in Warehouse Wonderland
(2,1,16,19), -- Concealer in Warehouse Wonderland
(2,1,17,35), -- Powder in Warehouse Wonderland
(2,1,18,22), -- Eyeliner in Warehouse Wonderland
(2,1,19,18), -- Lip Gloss in Warehouse Wonderland
(2,1,20,40), -- Primer in Warehouse Wonderland
(2,2,11,14), -- Foundation in Milan Marvels
(2,2,12,30), -- Lipstick in Milan Marvels
(2,2,13,38), -- Mascara in Milan Marvels
(2,2,14,22), -- Blush in Milan Marvels
(2,2,15,15), -- Eye Shadow in Milan Marvels
(2,2,16,18), -- Concealer in Milan Marvels
(2,2,17,27), -- Powder in Milan Marvels
(2,2,18,30), -- Eyeliner in Milan Marvels
(2,2,19,24), -- Lip Gloss in Milan Marvels
(2,2,20,36), -- Primer in Milan Marvels
(2,3,11,25), -- Foundation in Naples Nexus
(2,3,12,18), -- Lipstick in Naples Nexus
(2,3,13,32), -- Mascara in Naples Nexus
(2,3,14,16), -- Blush in Naples Nexus
(2,3,15,23), -- Eye Shadow in Naples Nexus
(2,3,16,19), -- Concealer in Naples Nexus
(2,3,17,11), -- Powder in Naples Nexus
(2,3,18,21), -- Eyeliner in Naples Nexus
(2,3,19,20), -- Lip Gloss in Naples Nexus
(2,3,20,35), -- Primer in Naples Nexus
(2,4,11,31), -- Foundation in Florence Treasures
(2,4,12,22), -- Lipstick in Florence Treasures
(2,4,13,16), -- Mascara in Florence Treasures
(2,4,14,30), -- Blush in Florence Treasures
(2,4,15,18), -- Eye Shadow in Florence Treasures
(2,4,16,26), -- Concealer in Florence Treasures
(2,4,17,15), -- Powder in Florence Treasures
(2,4,18,25), -- Eyeliner in Florence Treasures
(2,4,19,32), -- Lip Gloss in Florence Treasures
(2,4,20,20), -- Primer in Florence Treasures
-- Stationery (prodotti ID da 21 a 30)
(3,1,21,40), -- Notebook in Warehouse Wonderland
(3,1,22,15), -- Pen in Warehouse Wonderland
(3,1,23,35), -- Pencil in Warehouse Wonderland
(3,1,24,30), -- Eraser in Warehouse Wonderland
(3,1,25,22), -- Ruler in Warehouse Wonderland
(3,1,26,20), -- Highlighter in Warehouse Wonderland
(3,1,27,18), -- Marker in Warehouse Wonderland
(3,1,28,25), -- Glue in Warehouse Wonderland
(3,1,29,32), -- Scissors in Warehouse Wonderland
(3,1,30,10), -- Paper Clips in Warehouse Wonderland
(3,2,21,35), -- Notebook in Milan Marvels
(3,2,22,18), -- Pen in Milan Marvels
(3,2,23,30), -- Pencil in Milan Marvels
(3,2,24,20), -- Eraser in Milan Marvels
(3,2,25,38), -- Ruler in Milan Marvels
(3,2,26,15), -- Highlighter in Milan Marvels
(3,2,27,22), -- Marker in Milan Marvels
(3,2,28,28), -- Glue in Milan Marvels
(3,2,29,40), -- Scissors in Milan Marvels
(3,2,30,16), -- Paper Clips in Milan Marvel
(3,3,21,18), -- Notebook in Naples Nexus
(3,3,22,20), -- Pen in Naples Nexus
(3,3,23,22), -- Pencil in Naples Nexus
(3,3,24,40), -- Eraser in Naples Nexus
(3,3,25,14), -- Ruler in Naples Nexus
(3,3,26,32), -- Highlighter in Naples Nexus
(3,3,27,16), -- Marker in Naples Nexus
(3,3,28,19), -- Glue in Naples Nexus
(3,3,29,30), -- Scissors in Naples Nexus
(3,3,30,35), -- Paper Clips in Naples Nexus
(3,4,21,12), -- Notebook in Florence Treasures
(3,4,22,25), -- Pen in Florence Treasures
(3,4,23,30), -- Pencil in Florence Treasures
(3,4,24,28), -- Eraser in Florence Treasures
(3,4,25,18), -- Ruler in Florence Treasures
(3,4,26,35), -- Highlighter in Florence Treasures
(3,4,27,30), -- Marker in Florence Treasures
(3,4,28,40), -- Glue in Florence Treasures
(3,4,29,20), -- Scissors in Florence Treasures
(3,4,30,32), -- Paper Clips in Florence Treasures
-- Clothing (prodotti ID da 31 a 40)
(4,1,31,28), -- T-shirt in Warehouse Wonderland
(4,1,32,35), -- Jeans in Warehouse Wonderland
(4,1,33,22), -- Jacket in Warehouse Wonderland
(4,1,34,40), -- Sweater in Warehouse Wonderland
(4,1,35,18), -- Shirt in Warehouse Wonderland
(4,1,36,25), -- Skirt in Warehouse Wonderland
(4,1,37,32), -- Dress in Warehouse Wonderland
(4,1,38,14), -- Shorts in Warehouse Wonderland
(4,1,39,30), -- Socks in Warehouse Wonderland
(4,1,40,22), -- Scarf in Warehouse Wonderland
(4,2,31,12), -- T-shirt in Milan Marvels
(4,2,32,28), -- Jeans in Milan Marvels
(4,2,33,35), -- Jacket in Milan Marvels
(4,2,34,24), -- Sweater in Milan Marvels
(4,2,35,20), -- Shirt in Milan Marvels
(4,2,36,19), -- Skirt in Milan Marvels
(4,2,37,40), -- Dress in Milan Marvels
(4,2,38,18), -- Shorts in Milan Marvels
(4,2,39,25), -- Socks in Milan Marvels
(4,2,40,30), -- Scarf in Milan Marvels
(4,3,31,15), -- T-shirt in Naples Nexus
(4,3,32,40), -- Jeans in Naples Nexus
(4,3,33,18), -- Jacket in Naples Nexus
(4,3,34,30), -- Sweater in Naples Nexus
(4,3,35,25), -- Shirt in Naples Nexus
(4,3,36,20), -- Skirt in Naples Nexus
(4,3,37,14), -- Dress in Naples Nexus
(4,3,38,40), -- Shorts in Naples Nexus
(4,3,39,12), -- Socks in Naples Nexus
(4,3,40,38), -- Scarf in Naples Nexus
(4,4,31,22), -- T-shirt in Florence Treasures
(4,4,32,30), -- Jeans in Florence Treasures
(4,4,33,25), -- Jacket in Florence Treasures
(4,4,34,14), -- Sweater in Florence Treasures
(4,4,35,35), -- Shirt in Florence Treasures
(4,4,36,18), -- Skirt in Florence Treasures
(4,4,37,40), -- Dress in Florence Treasures
(4,4,38,19), -- Shorts in Florence Treasures
(4,4,39,12), -- Socks in Florence Treasures
(4,4,40,27), -- Scarf in Florence Treasures
-- Home_decor (prodotti ID da 41 a 50)
(5,1,41,38), -- Cushion in Warehouse Wonderland
(5,1,42,25), -- Vase in Warehouse Wonderland
(5,1,43,32), -- Picture Frame in Warehouse Wonderland
(5,1,44,10), -- Lamp in Warehouse Wonderland
(5,1,45,40), -- Curtains in Warehouse Wonderland
(5,1,46,20), -- Rug in Warehouse Wonderland
(5,1,47,35), -- Candle in Warehouse Wonderland
(5,1,48,22), -- Clock in Warehouse Wonderland
(5,1,49,30), -- Mirror in Warehouse Wonderland
(5,1,50,27), -- Throw Blanket in Warehouse Wonderland
(5,2,41,22), -- Cushion in Milan Marvels
(5,2,42,40), -- Vase in Milan Marvels
(5,2,43,10), -- Picture Frame in Milan Marvels
(5,2,44,30), -- Lamp in Milan Marvels
(5,2,45,18), -- Curtains in Milan Marvels
(5,2,46,12), -- Rug in Milan Marvels
(5,2,47,35), -- Candle in Milan Marvels
(5,2,48,25), -- Clock in Milan Marvels
(5,2,49,32), -- Mirror in Milan Marvels
(5,2,50,28), -- Throw Blanket in Milan Marvels
(5,3,41,30), -- Cushion in Naples Nexus
(5,3,42,18), -- Vase in Naples Nexus
(5,3,43,22), -- Picture Frame in Naples Nexus
(5,3,44,12), -- Lamp in Naples Nexus
(5,3,45,25), -- Curtains in Naples Nexus
(5,3,46,40), -- Rug in Naples Nexus
(5,3,47,15), -- Candle in Naples Nexus
(5,3,48,33), -- Clock in Naples Nexus
(5,3,49,14), -- Mirror in Naples Nexus
(5,3,50,30), -- Throw Blanket in Naples Nexus
(5,4,41,24), -- Cushion in Florence Treasures
(5,4,42,32), -- Vase in Florence Treasures
(5,4,43,10), -- Picture Frame in Florence Treasures
(5,4,44,18), -- Lamp in Florence Treasures
(5,4,45,35), -- Curtains in Florence Treasures
(5,4,46,40), -- Rug in Florence Treasures
(5,4,47,22), -- Candle in Florence Treasures
(5,4,48,25), -- Clock in Florence Treasures
(5,4,49,18), -- Mirror in Florence Treasures
(5,4,50,15), -- Throw Blanket in Florence Treasures
-- Drugs (prodotti ID da 51 a 60)
(6,1,51,30), -- Aspirin in Warehouse Wonderland
(6,1,52,25), -- Ibuprofen in Warehouse Wonderland
(6,1,53,12), -- Cough Syrup in Warehouse Wonderland
(6,1,54,20), -- Antihistamine in Warehouse Wonderland
(6,1,55,40), -- Vitamin C in Warehouse Wonderland
(6,1,56,14), -- Antacid in Warehouse Wonderland
(6,1,57,35), -- Antibiotic Ointment in Warehouse Wonderland
(6,1,58,22), -- Bandages in Warehouse Wonderland
(6,1,59,30), -- Thermometer in Warehouse Wonderland
(6,1,60,10), -- Hand Sanitizer in Warehouse Wonderland
(6,2,51,22), -- Aspirin in Milan Marvels
(6,2,52,35), -- Ibuprofen in Milan Marvels
(6,2,53,28), -- Cough Syrup in Milan Marvels
(6,2,54,16), -- Antihistamine in Milan Marvels
(6,2,55,20), -- Vitamin C in Milan Marvels
(6,2,56,18), -- Antacid in Milan Marvels
(6,2,57,25), -- Antibiotic Ointment in Milan Marvels
(6,2,58,40), -- Bandages in Milan Marvels
(6,2,59,30), -- Thermometer in Milan Marvels
(6,2,60,12), -- Hand Sanitizer in Milan Marvels
(6,3,51,35), -- Aspirin in Naples Nexus
(6,3,52,14), -- Ibuprofen in Naples Nexus
(6,3,53,20), -- Cough Syrup in Naples Nexus
(6,3,54,32), -- Antihistamine in Naples Nexus
(6,3,55,18), -- Vitamin C in Naples Nexus
(6,3,56,22), -- Antacid in Naples Nexus
(6,3,57,28), -- Antibiotic Ointment in Naples Nexus
(6,3,58,30), -- Bandages in Naples Nexus
(6,3,59,40), -- Thermometer in Naples Nexus
(6,3,60,25), -- Hand Sanitizer in Naples Nexus
(6,4,51,28), -- Aspirin in Florence Treasures
(6,4,52,30), -- Ibuprofen in Florence Treasures
(6,4,53,22), -- Cough Syrup in Florence Treasures
(6,4,54,15), -- Antihistamine in Florence Treasures
(6,4,55,10), -- Vitamin C in Florence Treasures
(6,4,56,30), -- Antacid in Florence Treasures
(6,4,57,35), -- Antibiotic Ointment in Florence Treasures
(6,4,58,18), -- Bandages in Florence Treasures
(6,4,59,25), -- Thermometer in Florence Treasures
(6,4,60,40); -- Hand Sanitizer in Florence Treasures
SELECT * FROM RestockLevels;

-- STORES
INSERT INTO Stores (Name,Address,Postal_code,City,Email,Phone_number) VALUES
('Supermercato Roma Centrale','Piazza San Giovanni 2','00124','Roma','roma.centrale@supermercato.it','06-1234567'),
('Market Roma Express','Via Tiburtina 15','00125','Roma','roma.express@market.it','06-2345678'),
('Roma Superstore','Via dei Fori Imperiali 30','00126','Roma','roma.superstore@store.it','06-3456789'),
('Discount Roma','Via Prenestina 100','00127','Roma','roma.discount@store.it','06-4567890'),
('Roma Maxi Market','Piazza Venezia 8','00128','Roma','roma.maxi@market.it','06-5678901'),
('Supermercato Milano City','Corso Buenos Aires 15','20124','Milano','milano.city@supermercato.it','02-1234567'),
('Milano Discount','Via Torino 22','20125','Milano','milano.discount@store.it','02-2345678'),
('Market Milano','Via Giuseppe Mazzini 5','20126','Milano','milano.market@market.it','02-3456789'),
('Super Milano Express','Piazza Duomo 10','20127','Milano','milano.express@super.it','02-4567890'),
('Supermercato Napoli 24h','Via Napoli 30','80124','Napoli','napoli.24h@supermercato.it','081-1234567'),
('Napoli Fresh Market','Via San Gregorio Armeno 12','80125','Napoli','napoli.fresh@market.it','081-2345678'),
('Supermercato Napoli Centro','Piazza del Plebiscito 3','80126','Napoli','napoli.centro@supermercato.it','081-3456789'),
('Supermercato Firenze','Via Nazionale 40','50124','Firenze','firenze@supermercato.it','055-1234567'),
('Firenze Superstore','Piazza della Repubblica 5','50125','Firenze','firenze.superstore@store.it','055-2345678'),
('Firenze Market Express','Via della Vigna Nuova 20','50126','Firenze','firenze.express@market.it','055-3456789');
SELECT * FROM Stores;

-- WAREHOUSESTORES
INSERT INTO WarehouseStores (Warehouse_id, Store_id) VALUES
(1,1),  -- Supermercato Roma Centrale
(1,2),  -- Market Roma Express
(1,3),  -- Roma Superstore
(1,4),  -- Discount Roma
(1,5),  -- Roma Maxi Market
(2,6),  -- Supermercato Milano City
(2,7),  -- Milano Discount
(2,8),  -- Market Milano
(2,9),  -- Super Milano Express
(3,10), -- Supermercato Napoli 24h
(3,11), -- Napoli Fresh Market
(3,12), -- Supermercato Napoli Centro
(4,13), -- Supermercato Firenze
(4,14), -- Firenze Superstore
(4,15); -- Firenze Market Express
SELECT * FROM WarehouseStores;

-- INVENTORY
INSERT INTO Inventory (Product_id,Warehouse_id,Quantity) VALUES
(1,1,35),    -- Milk (Restock level: 30)
(2,1,41),    -- Bread (Restock level: 40)
(3,1,39),    -- Eggs (Restock level: 38)
(4,1,45),    -- Cheese (Restock level: 40)
(5,1,38),    -- Butter (Restock level: 36)
(6,1,48),    -- Pasta (Restock level: 45)
(7,1,45),    -- Rice (Restock level: 47)
(8,1,42),    -- Tomato Sauce (Restock level: 38)
(9,1,37),    -- Cereal (Restock level: 35)
(10,1,28),   -- Juice (Restock level: 30)
(11,1,37),   -- Foundation (Restock level: 30)
(12,1,44),   -- Lipstick (Restock level: 40)
(13,1,45),   -- Mascara (Restock level: 42)
(14,1,35),   -- Blush (Restock level: 43)
(15,1,42),   -- Eye Shadow (Restock level: 39)
(16,1,49),   -- Concealer (Restock level: 44)
(17,1,55),   -- Powder (Restock level: 50)
(18,1,48),   -- Eyeliner (Restock level: 44)
(19,1,52),   -- Lip Gloss (Restock level: 48)
(20,1,55),   -- Primer (Restock level: 51)
(21,1,33),   -- Notebook (Restock level: 32)
(22,1,40),   -- Pen (Restock level: 38)
(23,1,41),   -- Pencil (Restock level: 39)
(24,1,45),   -- Eraser (Restock level: 40)
(25,1,46),   -- Ruler (Restock level: 42)
(26,1,56),   -- Highlighter (Restock level: 50)
(27,1,55),   -- Marker (Restock level: 49)
(28,1,53),   -- Glue (Restock level: 48)
(29,1,52),   -- Scissors (Restock level: 47)
(30,1,42),   -- Paper Clips (Restock level: 38)
(31,1,76),   -- T-shirt (Restock level: 70)
(32,1,81),   -- Jeans (Restock level: 75)
(33,1,88),   -- Jacket (Restock level: 85)
(34,1,94),   -- Sweater (Restock level: 90)
(35,1,105),  -- Shirt (Restock level: 100)
(36,1,85),   -- Skirt (Restock level: 80)
(37,1,91),   -- Dress (Restock level: 85)
(38,1,99),   -- Shorts (Restock level: 95)
(39,1,110),  -- Socks (Restock level: 105)
(40,1,115),  -- Scarf (Restock level: 110)
(41,1,83),   -- Cushion (Restock level: 80)
(42,1,89),   -- Vase (Restock level: 85)
(43,1,91),   -- Picture Frame (Restock level: 90)
(44,1,98),   -- Lamp (Restock level: 95)
(45,1,100),  -- Curtains (Restock level: 95)
(46,1,100),  -- Rug (Restock level: 90)
(47,1,110),  -- Candle (Restock level: 105)
(48,1,115),  -- Clock (Restock level: 110)
(49,1,105),  -- Mirror (Restock level: 100)
(50,1,110),  -- Throw Blanket (Restock level: 105)
(51,1,93),   -- Aspirin (Restock level: 90)
(52,1,100),  -- Ibuprofen (Restock level: 95)
(53,1,90),   -- Cough Syrup (Restock level: 85)
(54,1,95),   -- Antihistamine (Restock level: 90)
(55,1,105),  -- Vitamin C (Restock level: 100)
(56,1,110),  -- Antacid (Restock level: 105)
(57,1,92),   -- Antibiotic Ointment (Restock level: 90)
(58,1,105),  -- Bandages (Restock level: 100)
(59,1,110),  -- Thermometer (Restock level: 105)
(60,1,115),  -- Hand Sanitizer (Restock level: 110)
(1,2,50),    -- Milk (Restock level: 30)
(2,2,48),    -- Bread (Restock level: 40)
(3,2,50),    -- Eggs (Restock level: 45)
(4,2,38),    -- Cheese (Restock level: 35)
(5,2,41),    -- Butter (Restock level: 40)
(6,2,55),    -- Pasta (Restock level: 50)
(7,2,60),    -- Rice (Restock level: 55)
(8,2,44),    -- Tomato Sauce (Restock level: 38)
(9,2,41),    -- Cereal (Restock level: 40)
(10,2,39),   -- Juice (Restock level: 30)
(11,2,42),   -- Foundation (Restock level: 35)
(12,2,49),   -- Lipstick (Restock level: 40)
(13,2,50),   -- Mascara (Restock level: 45)
(14,2,50),   -- Blush (Restock level: 47)
(15,2,45),   -- Eye Shadow (Restock level: 43)
(16,2,51),   -- Concealer (Restock level: 50)
(17,2,57),   -- Powder (Restock level: 55)
(18,2,52),   -- Eyeliner (Restock level: 48)
(19,2,58),   -- Lip Gloss (Restock level: 55)
(20,2,60),   -- Primer (Restock level: 55)
(21,2,49),   -- Notebook (Restock level: 40)
(22,2,50),   -- Pen (Restock level: 45)
(23,2,53),   -- Pencil (Restock level: 47)
(24,2,57),   -- Eraser (Restock level: 50)
(25,2,60),   -- Ruler (Restock level: 55)
(26,2,62),   -- Highlighter (Restock level: 60)
(27,2,64),   -- Marker (Restock level: 60)
(28,2,59),   -- Glue (Restock level: 55)
(29,2,54),   -- Scissors (Restock level: 50)
(30,2,50),   -- Paper Clips (Restock level: 45)
(31,2,80),   -- T-shirt (Restock level: 70)
(32,2,85),   -- Jeans (Restock level: 80)
(33,2,92),   -- Jacket (Restock level: 90)
(34,2,98),   -- Sweater (Restock level: 100)
(35,2,110),  -- Shirt (Restock level: 105)
(36,2,95),   -- Skirt (Restock level: 85)
(37,2,102),  -- Dress (Restock level: 100)
(38,2,109),  -- Shorts (Restock level: 105)
(39,2,112),  -- Socks (Restock level: 110)
(40,2,115),  -- Scarf (Restock level: 110)
(41,2,85),   -- Cushion (Restock level: 80)
(42,2,95),   -- Vase (Restock level: 90)
(43,2,97),   -- Picture Frame (Restock level: 95)
(44,2,105),  -- Lamp (Restock level: 100)
(45,2,110),  -- Curtains (Restock level: 105)
(46,2,107),  -- Rug (Restock level: 100)
(47,2,115),  -- Candle (Restock level: 110)
(48,2,120),  -- Clock (Restock level: 115)
(49,2,108),  -- Mirror (Restock level: 105)
(50,2,115),  -- Throw Blanket (Restock level: 110)
(51,2,103),  -- Aspirin (Restock level: 95)
(52,2,110),  -- Ibuprofen (Restock level: 100)
(53,2,96),   -- Cough Syrup (Restock level: 90)
(54,2,100),  -- Antihistamine (Restock level: 95)
(55,2,105),  -- Vitamin C (Restock level: 100)
(56,2,110),  -- Antacid (Restock level: 105)
(57,2,95),   -- Antibiotic Ointment (Restock level: 90)
(58,2,110),  -- Bandages (Restock level: 100)
(59,2,115),  -- Thermometer (Restock level: 110)
(60,2,120),  -- Hand Sanitizer (Restock level: 115)
(1,3,52),    -- Milk (Restock level: 30)
(2,3,45),    -- Bread (Restock level: 40)
(3,3,48),    -- Eggs (Restock level: 45)
(4,3,41),    -- Cheese (Restock level: 40)
(5,3,38),    -- Butter (Restock level: 35)
(6,3,58),    -- Pasta (Restock level: 50)
(7,3,64),    -- Rice (Restock level: 55)
(8,3,47),    -- Tomato Sauce (Restock level: 38)
(9,3,46),    -- Cereal (Restock level: 40)
(10,3,43),   -- Juice (Restock level: 30)
(11,3,48),   -- Foundation (Restock level: 40)
(12,3,53),   -- Lipstick (Restock level: 45)
(13,3,55),   -- Mascara (Restock level: 50)
(14,3,58),   -- Blush (Restock level: 47)
(15,3,50),   -- Eye Shadow (Restock level: 43)
(16,3,55),   -- Concealer (Restock level: 50)
(17,3,60),   -- Powder (Restock level: 55)
(18,3,56),   -- Eyeliner (Restock level: 48)
(19,3,59),   -- Lip Gloss (Restock level: 55)
(20,3,62),   -- Primer (Restock level: 55)
(21,3,48),   -- Notebook (Restock level: 32)
(22,3,56),   -- Pen (Restock level: 40)
(23,3,59),   -- Pencil (Restock level: 39)
(24,3,61),   -- Eraser (Restock level: 40)
(25,3,64),   -- Ruler (Restock level: 42)
(26,3,68),   -- Highlighter (Restock level: 50)
(27,3,70),   -- Marker (Restock level: 49)
(28,3,63),   -- Glue (Restock level: 48)
(29,3,60),   -- Scissors (Restock level: 47)
(30,3,55),   -- Paper Clips (Restock level: 38)
(31,3,85),   -- T-shirt (Restock level: 70)
(32,3,92),   -- Jeans (Restock level: 75)
(33,3,100),  -- Jacket (Restock level: 85)
(34,3,107),  -- Sweater (Restock level: 90)
(35,3,120),  -- Shirt (Restock level: 100)
(36,3,105),  -- Skirt (Restock level: 80)
(37,3,110),  -- Dress (Restock level: 85)
(38,3,115),  -- Shorts (Restock level: 95)
(39,3,120),  -- Socks (Restock level: 110)
(40,3,125),  -- Scarf (Restock level: 110)
(41,3,90),   -- Cushion (Restock level: 80)
(42,3,100),  -- Vase (Restock level: 85)
(43,3,105),  -- Picture Frame (Restock level: 90)
(44,3,112),  -- Lamp (Restock level: 95)
(45,3,120),  -- Curtains (Restock level: 95)
(46,3,125),  -- Rug (Restock level: 90)
(47,3,130),  -- Candle (Restock level: 105)
(48,3,130),  -- Clock (Restock level: 110)
(49,3,125),  -- Mirror (Restock level: 100)
(50,3,130),  -- Throw Blanket (Restock level: 105)
(51,3,110),  -- Aspirin (Restock level: 90)
(52,3,115),  -- Ibuprofen (Restock level: 95)
(53,3,100),  -- Cough Syrup (Restock level: 85)
(54,3,105),  -- Antihistamine (Restock level: 90)
(55,3,120),  -- Vitamin C (Restock level: 100)
(56,3,125),  -- Antacid (Restock level: 105)
(57,3,105),  -- Antibiotic Ointment (Restock level: 90)
(58,3,110),  -- Bandages (Restock level: 100)
(59,3,120),  -- Thermometer (Restock level: 105)
(60,3,125),  -- Hand Sanitizer (Restock level: 110)
(1,4,55),    -- Milk (Restock level: 30)
(2,4,47),    -- Bread (Restock level: 40)
(3,4,52),    -- Eggs (Restock level: 45)
(4,4,46),    -- Cheese (Restock level: 40)
(5,4,42),    -- Butter (Restock level: 35)
(6,4,60),    -- Pasta (Restock level: 50)
(7,4,65),    -- Rice (Restock level: 55)
(8,4,48),    -- Tomato Sauce (Restock level: 38)
(9,4,49),    -- Cereal (Restock level: 40)
(10,4,45),   -- Juice (Restock level: 30)
(11,4,50),   -- Foundation (Restock level: 40)
(12,4,55),   -- Lipstick (Restock level: 45)
(13,4,58),   -- Mascara (Restock level: 50)
(14,4,60),   -- Blush (Restock level: 47)
(15,4,55),   -- Eye Shadow (Restock level: 43)
(16,4,58),   -- Concealer (Restock level: 50)
(17,4,62),   -- Powder (Restock level: 55)
(18,4,59),   -- Eyeliner (Restock level: 48)
(19,4,63),   -- Lip Gloss (Restock level: 55)
(20,4,65),   -- Primer (Restock level: 55)
(21,4,50),   -- Notebook (Restock level: 32)
(22,4,60),   -- Pen (Restock level: 40)
(23,4,62),   -- Pencil (Restock level: 39)
(24,4,65),   -- Eraser (Restock level: 40)
(25,4,68),   -- Ruler (Restock level: 42)
(26,4,72),   -- Highlighter (Restock level: 50)
(27,4,75),   -- Marker (Restock level: 49)
(28,4,68),   -- Glue (Restock level: 48)
(29,4,64),   -- Scissors (Restock level: 47)
(30,4,60),   -- Paper Clips (Restock level: 38)
(31,4,80),   -- T-shirt (Restock level: 70)
(32,4,90),   -- Jeans (Restock level: 75)
(33,4,100),  -- Jacket (Restock level: 85)
(34,4,110),  -- Sweater (Restock level: 90)
(35,4,120),  -- Shirt (Restock level: 100)
(36,4,115),  -- Skirt (Restock level: 80)
(37,4,125),  -- Dress (Restock level: 85)
(38,4,130),  -- Shorts (Restock level: 95)
(39,4,135),  -- Socks (Restock level: 110)
(40,4,140),  -- Scarf (Restock level: 110)
(41,4,95),   -- Cushion (Restock level: 80)
(42,4,105),  -- Vase (Restock level: 85)
(43,4,110),  -- Picture Frame (Restock level: 90)
(44,4,115),  -- Lamp (Restock level: 95)
(45,4,120),  -- Curtains (Restock level: 95)
(46,4,125),  -- Rug (Restock level: 90)
(47,4,130),  -- Candle (Restock level: 105)
(48,4,135),  -- Clock (Restock level: 110)
(49,4,130),  -- Mirror (Restock level: 100)
(50,4,140),  -- Throw Blanket (Restock level: 105)
(51,4,110),  -- Aspirin (Restock level: 90)
(52,4,120),  -- Ibuprofen (Restock level: 95)
(53,4,105),  -- Cough Syrup (Restock level: 85)
(54,4,115),  -- Antihistamine (Restock level: 90)
(55,4,125),  -- Vitamin C (Restock level: 100)
(56,4,130),  -- Antacid (Restock level: 105)
(57,4,110),  -- Antibiotic Ointment (Restock level: 90)
(58,4,115),  -- Bandages (Restock level: 100)
(59,4,120),  -- Thermometer (Restock level: 105)
(60,4,125);  -- Hand Sanitizer (Restock level: 110)
SELECT * FROM Inventory;

-- SALES
-- Store 1
INSERT INTO Sales (Sales_order_number, Sales_date, Product_id, Quantity_sold, Unit_price, Sales_amount, Store_id) VALUES
('FT001', '2024-02-01', 1, 10, 1.50, 15.00, 1),  
('FT001', '2024-02-01', 2, 8, 1.00, 8.00, 1),    
('FT001', '2024-02-01', 3, 6, 2.00, 12.00, 1),   
('FT001', '2024-02-01', 4, 5, 3.50, 17.50, 1),   
('FT001', '2024-02-01', 5, 7, 2.50, 17.50, 1),   
('FT002', '2024-03-05', 6, 12, 1.80, 21.60, 1),  
('FT002', '2024-03-05', 7, 10, 2.20, 22.00, 1),  
('FT002', '2024-03-05', 8, 8, 2.80, 22.40, 1),   
('FT002', '2024-03-05', 9, 6, 3.00, 18.00, 1),   
('FT002', '2024-03-05', 10, 5, 2.40, 12.00, 1),  
('FT003', '2024-03-10', 11, 8, 12.00, 96.00, 1), 
('FT003', '2024-03-10', 12, 6, 8.00, 48.00, 1),  
('FT003', '2024-03-10', 13, 5, 7.50, 37.50, 1),  
('FT003', '2024-03-10', 14, 7, 6.00, 42.00, 1),  
('FT003', '2024-03-10', 15, 6, 5.50, 33.00, 1),  
('FT004', '2024-04-01', 16, 10, 10.00, 100.00, 1),  
('FT004', '2024-04-01', 17, 12, 9.00, 108.00, 1),  
('FT004', '2024-04-01', 18, 6, 6.50, 39.00, 1),    
('FT004', '2024-04-01', 19, 8, 7.00, 56.00, 1),    
('FT005', '2024-04-10', 20, 5, 15.00, 75.00, 1),  
('FT005', '2024-04-10', 21, 8, 2.50, 20.00, 1),   
('FT005', '2024-04-10', 22, 7, 1.00, 7.00, 1),    
('FT005', '2024-04-10', 23, 5, 0.80, 4.00, 1),    
('FT005', '2024-04-10', 24, 9, 3.00, 27.00, 1),   
('FT006', '2024-04-15', 25, 7, 3.00, 21.00, 1),  
('FT006', '2024-04-15', 26, 6, 1.50, 9.00, 1),   
('FT006', '2024-04-15', 27, 8, 2.20, 17.60, 1),  
('FT006', '2024-04-15', 28, 9, 2.50, 22.50, 1),  
('FT006', '2024-04-15', 29, 10, 3.50, 35.00, 1), 
('FT007', '2024-05-01', 30, 5, 10.00, 50.00, 1), 
('FT007', '2024-05-01', 31, 7, 20.00, 140.00, 1),
('FT007', '2024-05-01', 32, 6, 30.00, 180.00, 1),
('FT007', '2024-05-01', 33, 8, 25.00, 200.00, 1),
('FT007', '2024-05-01', 34, 5, 15.00, 75.00, 1), 
('FT008', '2024-05-10', 35, 10, 18.00, 180.00, 1),
('FT008', '2024-05-10', 36, 8, 12.00, 96.00, 1),   
('FT008', '2024-05-10', 37, 5, 12.00, 60.00, 1),   
('FT008', '2024-05-10', 38, 7, 3.00, 21.00, 1),    
('FT008', '2024-05-10', 39, 6, 8.00, 48.00, 1),    
('FT009', '2024-05-20', 40, 6, 15.00, 90.00, 1),   
('FT009', '2024-05-20', 41, 5, 20.00, 100.00, 1),  
('FT009', '2024-05-20', 42, 8, 10.00, 80.00, 1),   
('FT009', '2024-05-20', 43, 7, 25.00, 175.00, 1),  
('FT009', '2024-05-20', 44, 9, 18.00, 162.00, 1),  
('FT010', '2024-06-01', 45, 5, 40.00, 200.00, 1),  
('FT010', '2024-06-01', 46, 6, 7.00, 42.00, 1),    
('FT010', '2024-06-01', 47, 8, 15.00, 120.00, 1),  
('FT010', '2024-06-01', 48, 7, 30.00, 210.00, 1),  
('FT010', '2024-06-01', 49, 9, 22.00, 198.00, 1),  
('FT011', '2024-06-10', 50, 7, 4.00, 28.00, 1),   
('FT011', '2024-06-10', 51, 6, 5.00, 30.00, 1),   
('FT011', '2024-06-10', 52, 8, 6.00, 48.00, 1),   
('FT011', '2024-06-10', 53, 10, 7.00, 70.00, 1),  
('FT011', '2024-06-10', 54, 5, 2.50, 12.50, 1),   
('FT012', '2024-06-15', 55, 6, 3.50, 21.00, 1),   
('FT012', '2024-06-15', 56, 8, 4.00, 32.00, 1),   
('FT012', '2024-06-15', 57, 7, 2.20, 15.40, 1),   
('FT012', '2024-06-15', 58, 9, 8.50, 76.50, 1),   
('FT012', '2024-06-15', 59, 5, 6.00, 30.00, 1),   
('FT013', '2024-06-20', 1, 8, 1.50, 12.00, 1),   
('FT013', '2024-06-20', 2, 10, 1.00, 10.00, 1),  
('FT013', '2024-06-20', 3, 7, 2.00, 14.00, 1),   
('FT013', '2024-06-20', 4, 6, 3.50, 21.00, 1),   
('FT013', '2024-06-20', 5, 8, 2.50, 20.00, 1),   
('FT014', '2024-07-01', 6, 5, 1.80, 9.00, 1),   
('FT014', '2024-07-01', 7, 9, 2.20, 19.80, 1),    
('FT014', '2024-07-01', 8, 12, 2.80, 33.60, 1),   
('FT014', '2024-07-01', 9, 7, 3.00, 21.00, 1),   
('FT014', '2024-07-01', 10, 6, 2.40, 14.40, 1),   
('FT015', '2024-07-10', 11, 10, 12.00, 120.00, 1), 
('FT015', '2024-07-10', 12, 8, 8.00, 64.00, 1), 
('FT015', '2024-07-10', 13, 5, 7.50, 37.50, 1),  
('FT015', '2024-07-10', 14, 9, 6.00, 54.00, 1),  
('FT015', '2024-07-10', 15, 7, 5.50, 38.50, 1),
('FT016', '2024-07-15', 16, 8, 10.00, 80.00, 1),  
('FT016', '2024-07-15', 17, 5, 9.00, 45.00, 1),   
('FT016', '2024-07-15', 18, 6, 6.50, 39.00, 1),   
('FT016', '2024-07-15', 19, 7, 7.00, 49.00, 1),  
('FT016', '2024-07-15', 20, 9, 15.00, 135.00, 1),
('FT017', '2024-08-01', 21, 8, 2.50, 20.00, 1),  
('FT017', '2024-08-01', 22, 6, 1.00, 6.00, 1),   
('FT017', '2024-08-01', 23, 7, 0.80, 5.60, 1),   
('FT017', '2024-08-01', 24, 5, 3.00, 15.00, 1),  
('FT017', '2024-08-01', 25, 10, 3.00, 30.00, 1), 
('FT018', '2024-08-10', 26, 9, 1.50, 13.50, 1),  
('FT018', '2024-08-10', 27, 8, 2.20, 17.60, 1),  
('FT018', '2024-08-10', 28, 7, 2.50, 17.50, 1),  
('FT018', '2024-08-10', 29, 6, 3.50, 21.00, 1),  
('FT018', '2024-08-10', 30, 5, 10.00, 50.00, 1); 

-- Store 2
INSERT INTO Sales (Sales_order_number, Sales_date, Product_ID, Quantity_sold, Unit_price, Sales_amount, Store_ID) VALUES 
('FT001', '2024-03-07', 57, 10, 11.22, 112.20, 2),
('FT001', '2024-03-07', 49, 19, 40.12, 762.28, 2),
('FT001', '2024-03-07', 29, 17, 19.99, 339.83, 2),
('FT001', '2024-03-07', 13, 6, 1.33, 7.98, 2),
('FT001', '2024-03-07', 8, 10, 21.40, 214.00, 2),
('FT002', '2024-06-15', 20, 8, 3.67, 29.36, 2),
('FT002', '2024-06-15', 35, 14, 12.85, 179.90, 2),
('FT002', '2024-06-15', 58, 5, 9.21, 46.05, 2),
('FT002', '2024-06-15', 12, 7, 2.99, 20.93, 2),
('FT002', '2024-06-15', 41, 6, 17.50, 105.00, 2),
('FT002', '2024-06-15', 24, 9, 5.50, 49.50, 2),
('FT003', '2024-09-23', 17, 12, 7.75, 93.00, 2),
('FT003', '2024-09-23', 2, 15, 1.99, 29.85, 2),
('FT003', '2024-09-23', 37, 10, 18.25, 182.50, 2),
('FT003', '2024-09-23', 53, 6, 6.45, 38.70, 2),
('FT003', '2024-09-23', 9, 11, 14.99, 164.89, 2),
('FT003', '2024-09-23', 46, 7, 22.50, 157.50, 2),
('FT004', '2024-12-11', 33, 5, 8.99, 44.95, 2),
('FT004', '2024-12-11', 21, 13, 2.25, 29.25, 2),
('FT004', '2024-12-11', 55, 9, 16.75, 150.75, 2),
('FT004', '2024-12-11', 38, 6, 9.50, 57.00, 2),
('FT004', '2024-12-11', 10, 10, 3.99, 39.90, 2),
('FT004', '2024-12-11', 27, 8, 6.75, 54.00, 2),
('FT005', '2024-07-20', 45, 14, 12.49, 174.86, 2),
('FT005', '2024-07-20', 7, 7, 4.20, 29.40, 2),
('FT005', '2024-07-20', 31, 10, 14.99, 149.90, 2),
('FT005', '2024-07-20', 59, 6, 5.99, 35.94, 2),
('FT005', '2024-07-20', 1, 8, 2.50, 20.00, 2),
('FT006', '2024-05-02', 50, 9, 18.75, 168.75, 2),
('FT006', '2024-05-02', 28, 12, 6.20, 74.40, 2),
('FT006', '2024-05-02', 40, 15, 11.00, 165.00, 2),
('FT006', '2024-05-02', 22, 8, 4.99, 39.92, 2),
('FT006', '2024-05-02', 16, 11, 7.50, 82.50, 2),
('FT006', '2024-05-02', 54, 5, 23.45, 117.25, 2),
('FT007', '2024-10-05', 34, 6, 9.95, 59.70, 2),
('FT007', '2024-10-05', 3, 10, 1.25, 12.50, 2),
('FT007', '2024-10-05', 14, 7, 8.75, 61.25, 2),
('FT007', '2024-10-05', 26, 9, 13.00, 117.00, 2),
('FT007', '2024-10-05', 42, 12, 7.10, 85.20, 2),
('FT007', '2024-10-05', 18, 8, 9.85, 78.80, 2),
('FT008', '2024-08-30', 11, 5, 3.99, 19.95, 2),
('FT008', '2024-08-30', 36, 15, 10.25, 153.75, 2),
('FT008', '2024-08-30', 48, 6, 14.50, 87.00, 2),
('FT008', '2024-08-30', 30, 9, 5.75, 51.75, 2),
('FT008', '2024-08-30', 60, 10, 17.99, 179.90, 2),
('FT009', '2024-04-18', 5, 11, 2.99, 32.89, 2),
('FT009', '2024-04-18', 23, 7, 6.80, 47.60, 2),
('FT009', '2024-04-18', 39, 12, 11.75, 141.00, 2),
('FT009', '2024-04-18', 44, 6, 18.20, 109.20, 2),
('FT009', '2024-04-18', 19, 9, 5.25, 47.25, 2),
('FT009', '2024-04-18', 52, 8, 14.10, 112.80, 2),
('FT010', '2024-11-09', 9, 10, 3.49, 34.90, 2),
('FT010', '2024-11-09', 32, 6, 7.95, 47.70, 2),
('FT010', '2024-11-09', 47, 14, 16.80, 235.20, 2),
('FT010', '2024-11-09', 6, 8, 5.60, 44.80, 2),
('FT010', '2024-11-09', 15, 7, 9.99, 69.93, 2),
('FT011', '2024-01-27', 51, 12, 4.49, 53.88, 2),
('FT011', '2024-01-27', 56, 8, 22.99, 183.92, 2),
('FT011', '2024-01-27', 4, 9, 3.25, 29.25, 2),
('FT011', '2024-01-27', 43, 6, 11.99, 71.94, 2),
('FT011', '2024-01-27', 25, 7, 8.45, 59.15, 2),
('FT011', '2024-01-27', 1, 10, 2.50, 25.00, 2),
('FT012', '2024-07-05', 14, 11, 8.75, 96.25, 2),
('FT012', '2024-07-05', 28, 7, 6.20, 43.40, 2),
('FT012', '2024-07-05', 33, 9, 8.99, 80.91, 2),
('FT012', '2024-07-05', 45, 6, 12.49, 74.94, 2),
('FT012', '2024-07-05', 55, 8, 16.75, 134.00, 2),
('FT013', '2024-05-22', 12, 13, 2.99, 38.87, 2),
('FT013', '2024-05-22', 27, 10, 6.75, 67.50, 2),
('FT013', '2024-05-22', 53, 5, 6.45, 32.25, 2),
('FT013', '2024-05-22', 48, 9, 14.50, 130.50, 2),
('FT013', '2024-05-22', 21, 7, 2.25, 15.75, 2),
('FT013', '2024-05-22', 38, 6, 9.50, 57.00, 2),
('FT014', '2024-03-19', 42, 10, 7.10, 71.00, 2),
('FT014', '2024-03-19', 17, 12, 7.75, 93.00, 2),
('FT014', '2024-03-19', 35, 8, 12.85, 102.80, 2),
('FT014', '2024-03-19', 46, 6, 22.50, 135.00, 2),
('FT014', '2024-03-19', 30, 9, 5.75, 51.75, 2),
('FT015', '2024-06-27', 50, 10, 18.75, 187.50, 2),
('FT015', '2024-06-27', 41, 7, 17.50, 122.50, 2),
('FT015', '2024-06-27', 60, 9, 17.99, 161.91, 2),
('FT015', '2024-06-27', 58, 6, 9.21, 55.26, 2),
('FT015', '2024-06-27', 39, 8, 11.75, 94.00, 2),
('FT015', '2024-06-27', 5, 11, 2.99, 32.89, 2),
('FT016', '2024-02-14', 7, 12, 4.20, 50.40, 2),
('FT016', '2024-02-14', 10, 6, 3.99, 23.94, 2),
('FT016', '2024-02-14', 18, 8, 9.85, 78.80, 2),
('FT016', '2024-02-14', 44, 10, 18.20, 182.00, 2),
('FT016', '2024-02-14', 32, 9, 7.95, 71.55, 2),
('FT017', '2024-09-09', 1, 15, 2.50, 37.50, 2),
('FT017', '2024-09-09', 22, 10, 4.99, 49.90, 2),
('FT017', '2024-09-09', 31, 9, 14.99, 134.91, 2),
('FT017', '2024-09-09', 48, 8, 14.50, 116.00, 2),
('FT017', '2024-09-09', 26, 6, 13.00, 78.00, 2),
('FT018', '2024-12-05', 37, 11, 18.25, 200.75, 2),
('FT018', '2024-12-05', 15, 6, 9.99, 59.94, 2),
('FT018', '2024-12-05', 53, 8, 6.45, 51.60, 2),
('FT018', '2024-12-05', 19, 9, 5.25, 47.25, 2),
('FT018', '2024-12-05', 11, 10, 3.99, 39.90, 2),
('FT018', '2024-12-05', 27, 12, 6.75, 81.00, 2);

-- Store 3
INSERT INTO Sales (Sales_order_number, Sales_date, Product_id, Quantity_sold, Unit_price, Sales_amount, Store_id) VALUES
('FT001', '2024-02-01', 1, 3, 1.50, 4.50, 3),
('FT001', '2024-02-01', 2, 5, 1.00, 5.00, 3),
('FT001', '2024-02-01', 3, 2, 2.00, 4.00, 3),
('FT001', '2024-02-01', 4, 6, 3.50, 21.00, 3),
('FT001', '2024-02-01', 5, 4, 2.50, 10.00, 3),
('FT002', '2024-03-15', 10, 3, 2.40, 7.20, 3),
('FT002', '2024-03-15', 11, 7, 3.00, 21.00, 3),
('FT002', '2024-03-15', 12, 4, 3.50, 14.00, 3),
('FT002', '2024-03-15', 13, 9, 2.80, 25.20, 3),
('FT002', '2024-03-15', 14, 6, 2.50, 15.00, 3),
('FT003', '2024-05-10', 15, 3, 12.00, 36.00, 3),
('FT003', '2024-05-10', 16, 5, 8.00, 40.00, 3),
('FT003', '2024-05-10', 17, 8, 7.50, 60.00, 3),
('FT003', '2024-05-10', 18, 6, 6.00, 36.00, 3),
('FT003', '2024-05-10', 19, 3, 5.50, 16.50, 3),
('FT003', '2024-05-10', 20, 7, 10.00, 70.00, 3),
('FT004', '2024-06-22', 21, 4, 1.20, 4.80, 3),
('FT004', '2024-06-22', 22, 6, 0.80, 4.80, 3),
('FT004', '2024-06-22', 23, 5, 1.50, 7.50, 3),
('FT004', '2024-06-22', 24, 8, 1.80, 14.40, 3),
('FT004', '2024-06-22', 25, 3, 0.50, 1.50, 3),
('FT004', '2024-06-22', 26, 9, 0.30, 2.70, 3),
('FT005', '2024-07-14', 27, 7, 2.00, 14.00, 3),
('FT005', '2024-07-14', 28, 10, 3.50, 35.00, 3),
('FT005', '2024-07-14', 29, 5, 3.20, 16.00, 3),
('FT005', '2024-07-14', 30, 6, 2.20, 13.20, 3),
('FT005', '2024-07-14', 31, 3, 7.00, 21.00, 3),
('FT005', '2024-07-14', 32, 8, 1.50, 12.00, 3),
('FT006', '2024-09-03', 33, 4, 1.80, 7.20, 3),
('FT006', '2024-09-03', 34, 5, 2.00, 10.00, 3),
('FT006', '2024-09-03', 35, 6, 1.90, 11.40, 3),
('FT006', '2024-09-03', 36, 7, 2.80, 19.60, 3),
('FT006', '2024-09-03', 37, 3, 1.00, 3.00, 3),
('FT007', '2024-10-19', 38, 5, 15.00, 75.00, 3),
('FT007', '2024-10-19', 39, 3, 18.00, 54.00, 3),
('FT007', '2024-10-19', 40, 2, 30.00, 60.00, 3),
('FT007', '2024-10-19', 41, 4, 12.00, 48.00, 3),
('FT007', '2024-10-19', 42, 6, 20.00, 120.00, 3),
('FT007', '2024-10-19', 43, 8, 10.00, 80.00, 3);

-- Store 4
INSERT INTO Sales (Sales_order_number, Sales_date, Product_id, Quantity_sold, Unit_price, Sales_amount, Store_id) VALUES
('FT001', '2024-01-12', 1, 10, 1.50, 15.00, 4),
('FT001', '2024-01-12', 5, 8, 2.50, 20.00, 4),
('FT001', '2024-01-12', 13, 15, 3.50, 52.50, 4),
('FT001', '2024-01-12', 25, 6, 7.50, 45.00, 4),
('FT001', '2024-01-12', 34, 12, 6.00, 72.00, 4),
('FT002', '2024-02-05', 3, 9, 2.20, 19.80, 4),
('FT002', '2024-02-05', 9, 11, 8.00, 88.00, 4),
('FT002', '2024-02-05', 15, 7, 3.50, 24.50, 4),
('FT002', '2024-02-05', 20, 5, 6.50, 32.50, 4),
('FT002', '2024-02-05', 40, 13, 5.00, 65.00, 4),
('FT003', '2024-03-21', 11, 8, 15.00, 120.00, 4),
('FT003', '2024-03-21', 21, 12, 25.00, 300.00, 4),
('FT003', '2024-03-21', 18, 6, 3.00, 18.00, 4),
('FT003', '2024-03-21', 25, 10, 5.00, 50.00, 4),
('FT003', '2024-03-21', 34, 7, 9.00, 63.00, 4),
('FT004', '2024-04-09', 5, 5, 2.50, 12.50, 4),
('FT004', '2024-04-09', 7, 10, 1.50, 15.00, 4),
('FT004', '2024-04-09', 13, 15, 8.00, 120.00, 4),
('FT004', '2024-04-09', 17, 12, 6.00, 72.00, 4),
('FT004', '2024-04-09', 28, 8, 5.50, 44.00, 4),
('FT005', '2024-05-15', 10, 5, 12.00, 60.00, 4),
('FT005', '2024-05-15', 2, 9, 2.00, 18.00, 4),
('FT005', '2024-05-15', 15, 7, 3.50, 24.50, 4),
('FT005', '2024-05-15', 21, 8, 5.50, 44.00, 4),
('FT005', '2024-05-15', 40, 12, 10.00, 120.00, 4),
('FT006', '2024-06-20', 3, 11, 2.20, 24.20, 4),
('FT006', '2024-06-20', 9, 13, 8.00, 104.00, 4),
('FT006', '2024-06-20', 25, 6, 3.50, 21.00, 4),
('FT006', '2024-06-20', 34, 8, 6.00, 48.00, 4),
('FT006', '2024-06-20', 42, 5, 5.50, 27.50, 4),
('FT007', '2024-07-10', 6, 6, 3.50, 21.00, 4),
('FT007', '2024-07-10', 18, 7, 9.00, 63.00, 4),
('FT007', '2024-07-10', 24, 10, 5.50, 55.00, 4),
('FT007', '2024-07-10', 33, 12, 7.50, 90.00, 4),
('FT007', '2024-07-10', 48, 8, 10.00, 80.00, 4),
('FT008', '2024-08-22', 1, 7, 1.50, 10.50, 4),
('FT008', '2024-08-22', 5, 6, 2.50, 15.00, 4),
('FT008', '2024-08-22', 15, 8, 3.50, 28.00, 4),
('FT008', '2024-08-22', 20, 5, 6.50, 32.50, 4),
('FT008', '2024-08-22', 35, 11, 4.50, 49.50, 4),
('FT009', '2024-09-03', 8, 10, 4.00, 40.00, 4),
('FT009', '2024-09-03', 21, 8, 5.50, 44.00, 4),
('FT009', '2024-09-03', 22, 9, 6.00, 54.00, 4),
('FT009', '2024-09-03', 27, 5, 7.00, 35.00, 4),
('FT009', '2024-09-03', 30, 7, 5.50, 38.50, 4),
('FT010', '2024-10-12', 10, 9, 12.00, 108.00, 4),
('FT010', '2024-10-12', 4, 8, 1.00, 8.00, 4),
('FT010', '2024-10-12', 15, 6, 3.50, 21.00, 4),
('FT010', '2024-10-12', 35, 7, 4.50, 31.50, 4),
('FT010', '2024-10-12', 40, 12, 5.50, 66.00, 4),
('FT011', '2024-11-05', 2, 7, 2.00, 14.00, 4),
('FT011', '2024-11-05', 6, 10, 3.50, 35.00, 4),
('FT011', '2024-11-05', 9, 8, 8.00, 64.00, 4),
('FT011', '2024-11-05', 12, 11, 5.50, 60.50, 4),
('FT011', '2024-11-05', 34, 9, 9.00, 81.00, 4),
('FT012', '2024-12-14', 8, 6, 4.00, 24.00, 4),
('FT012', '2024-12-14', 18, 5, 6.00, 30.00, 4),
('FT012', '2024-12-14', 22, 8, 5.00, 40.00, 4),
('FT012', '2024-12-14', 25, 10, 5.50, 55.00, 4),
('FT012', '2024-12-14', 37, 7, 8.00, 56.00, 4),
('FT013', '2024-12-29', 13, 12, 3.50, 42.00, 4),
('FT013', '2024-12-29', 20, 6, 7.00, 42.00, 4),
('FT013', '2024-12-29', 28, 11, 5.50, 60.50, 4),
('FT013', '2024-12-29', 38, 5, 9.00, 45.00, 4),
('FT013', '2024-12-29', 44, 7, 12.00, 84.00, 4),
('FT014', '2025-01-05', 3, 8, 2.20, 17.60, 4),
('FT014', '2025-01-05', 7, 9, 1.50, 13.50, 4),
('FT014', '2025-01-05', 14, 11, 7.00, 77.00, 4),
('FT014', '2025-01-05', 18, 10, 3.00, 30.00, 4),
('FT014', '2025-01-05', 25, 6, 4.50, 27.00, 4),
('FT015', '2025-01-10', 1, 12, 1.50, 18.00, 4),
('FT015', '2025-01-10', 9, 7, 8.00, 56.00, 4),
('FT015', '2025-01-10', 16, 8, 10.00, 80.00, 4),
('FT015', '2025-01-10', 22, 6, 5.50, 33.00, 4),
('FT015', '2025-01-10', 30, 9, 4.00, 36.00, 4),
('FT016', '2025-01-15', 14, 11, 7.50, 82.50, 4),
('FT016', '2025-01-15', 17, 10, 5.50, 55.00, 4),
('FT016', '2025-01-15', 22, 6, 3.00, 18.00, 4),
('FT016', '2025-01-15', 26, 8, 4.50, 36.00, 4),
('FT016', '2025-01-15', 35, 9, 6.50, 58.50, 4),
('FT017', '2025-01-20', 4, 7, 2.50, 17.50, 4),
('FT017', '2025-01-20', 13, 12, 8.00, 96.00, 4),
('FT017', '2025-01-20', 27, 6, 7.50, 45.00, 4),
('FT017', '2025-01-20', 31, 8, 6.00, 48.00, 4),
('FT017', '2025-01-20', 37, 10, 5.50, 55.00, 4),
('FT018', '2025-01-25', 19, 11, 9.00, 99.00, 4),
('FT018', '2025-01-25', 23, 10, 7.50, 75.00, 4),
('FT018', '2025-01-25', 33, 8, 5.00, 40.00, 4),
('FT018', '2025-01-25', 38, 7, 6.00, 42.00, 4),
('FT018', '2025-01-25', 41, 6, 10.00, 60.00, 4),
('FT019', '2025-01-28', 2, 5, 3.50, 17.50, 4),
('FT019', '2025-01-28', 8, 8, 5.00, 40.00, 4),
('FT019', '2025-01-28', 16, 7, 6.50, 45.50, 4),
('FT019', '2025-01-28', 21, 9, 9.00, 81.00, 4),
('FT019', '2025-01-28', 27, 10, 4.00, 40.00, 4),
('FT020', '2025-02-01', 1, 6, 2.00, 12.00, 4),
('FT020', '2025-02-01', 11, 5, 3.00, 15.00, 4),
('FT020', '2025-02-01', 22, 7, 6.50, 45.50, 4),
('FT020', '2025-02-01', 32, 8, 4.50, 36.00, 4),
('FT020', '2025-02-01', 43, 9, 5.50, 49.50, 4),
('FT021', '2025-02-05', 6, 8, 5.50, 44.00, 4),
('FT021', '2025-02-05', 15, 10, 4.00, 40.00, 4),
('FT021', '2025-02-05', 18, 12, 6.00, 72.00, 4),
('FT021', '2025-02-05', 24, 11, 8.00, 88.00, 4),
('FT021', '2025-02-05', 36, 9, 7.50, 67.50, 4),
('FT022', '2025-02-10', 9, 7, 7.00, 49.00, 4),
('FT022', '2025-02-10', 23, 6, 5.50, 33.00, 4),
('FT022', '2025-02-10', 30, 8, 9.00, 72.00, 4),
('FT022', '2025-02-10', 35, 10, 4.50, 45.00, 4),
('FT022', '2025-02-10', 43, 5, 10.00, 50.00, 4),
('FT023', '2025-02-14', 7, 9, 2.50, 22.50, 4),
('FT023', '2025-02-14', 12, 10, 3.50, 35.00, 4),
('FT023', '2025-02-14', 18, 8, 4.00, 32.00, 4),
('FT023', '2025-02-14', 29, 7, 6.50, 45.50, 4),
('FT023', '2025-02-14', 41, 5, 9.00, 45.00, 4),
('FT024', '2025-02-18', 8, 12, 5.50, 66.00, 4),
('FT024', '2025-02-18', 14, 10, 6.00, 60.00, 4),
('FT024', '2025-02-18', 19, 6, 7.00, 42.00, 4),
('FT024', '2025-02-18', 28, 7, 3.50, 24.50, 4),
('FT024', '2025-02-18', 39, 9, 8.00, 72.00, 4),
('FT025', '2025-02-25', 3, 11, 2.20, 24.20, 4),
('FT025', '2025-02-25', 11, 8, 5.50, 44.00, 4),
('FT025', '2025-02-25', 17, 9, 4.50, 40.50, 4),
('FT025', '2025-02-25', 25, 6, 3.00, 18.00, 4),
('FT025', '2025-02-25', 33, 10, 7.00, 70.00, 4);

-- Store 5
INSERT INTO Sales (Sales_order_number, Sales_date, Product_ID, Quantity_sold, Unit_price, Sales_amount, Store_ID) VALUES
('FT001', '2024-02-15', 3, 10, 2.00, 20.00, 5),
('FT001', '2024-02-15', 14, 5, 6.00, 30.00, 5),
('FT001', '2024-02-15', 27, 8, 1.80, 14.40, 5),
('FT001', '2024-02-15', 42, 12, 10.00, 120.00, 5),
('FT001', '2024-02-15', 55, 6, 16.75, 100.50, 5),
('FT002', '2024-03-21', 6, 9, 1.80, 16.20, 5),
('FT002', '2024-03-21', 21, 7, 7.00, 49.00, 5),
('FT002', '2024-03-21', 36, 11, 2.50, 27.50, 5),
('FT002', '2024-03-21', 50, 5, 18.00, 90.00, 5),
('FT002', '2024-03-21', 59, 6, 9.50, 57.00, 5),
('FT002', '2024-03-21', 12, 10, 8.00, 80.00, 5),
('FT003', '2024-06-11', 2, 13, 1.00, 13.00, 5),
('FT003', '2024-06-11', 18, 9, 5.50, 49.50, 5),
('FT003', '2024-06-11', 33, 6, 8.99, 53.94, 5),
('FT003', '2024-06-11', 45, 8, 12.49, 99.92, 5),
('FT003', '2024-06-11', 54, 7, 15.25, 106.75, 5),
('FT003', '2024-06-11', 7, 10, 4.20, 42.00, 5),
('FT004', '2024-08-30', 5, 8, 2.50, 20.00, 5),
('FT004', '2024-08-30', 19, 5, 5.25, 26.25, 5),
('FT004', '2024-08-30', 25, 7, 8.45, 59.15, 5),
('FT004', '2024-08-30', 31, 9, 14.99, 134.91, 5),
('FT004', '2024-08-30', 41, 6, 17.50, 105.00, 5),
('FT005', '2024-10-14', 9, 11, 3.00, 33.00, 5),
('FT005', '2024-10-14', 22, 6, 4.99, 29.94, 5),
('FT005', '2024-10-14', 38, 9, 9.50, 85.50, 5),
('FT005', '2024-10-14', 46, 12, 22.50, 270.00, 5),
('FT005', '2024-10-14', 52, 8, 14.10, 112.80, 5),
('FT006', '2024-04-18', 8, 7, 2.80, 19.60, 5),
('FT006', '2024-04-18', 23, 10, 6.80, 68.00, 5),
('FT006', '2024-04-18', 39, 12, 11.75, 141.00, 5),
('FT006', '2024-04-18', 44, 6, 18.20, 109.20, 5),
('FT006', '2024-04-18', 57, 9, 10.75, 96.75, 5),
('FT007', '2024-12-09', 12, 8, 7.50, 60.00, 5),
('FT007', '2024-12-09', 27, 6, 6.75, 40.50, 5),
('FT007', '2024-12-09', 33, 9, 8.99, 80.91, 5),
('FT007', '2024-12-09', 45, 5, 12.49, 62.45, 5),
('FT007', '2024-12-09', 55, 11, 16.75, 184.25, 5),
('FT008', '2024-07-25', 16, 13, 5.50, 71.50, 5),
('FT008', '2024-07-25', 28, 7, 6.20, 43.40, 5),
('FT008', '2024-07-25', 37, 5, 18.25, 91.25, 5),
('FT008', '2024-07-25', 50, 9, 18.00, 162.00, 5),
('FT008', '2024-07-25', 60, 6, 17.99, 107.94, 5),
('FT009', '2024-05-20', 1, 10, 2.50, 25.00, 5),
('FT009', '2024-05-20', 17, 8, 7.75, 62.00, 5),
('FT009', '2024-05-20', 29, 9, 3.50, 31.50, 5),
('FT009', '2024-05-20', 42, 6, 10.00, 60.00, 5),
('FT009', '2024-05-20', 49, 7, 11.25, 78.75, 5),
('FT010', '2024-11-30', 3, 7, 2.00, 14.00, 5),
('FT010', '2024-11-30', 14, 9, 6.00, 54.00, 5),
('FT010', '2024-11-30', 24, 8, 1.20, 9.60, 5),
('FT010', '2024-11-30', 36, 5, 2.50, 12.50, 5),
('FT010', '2024-11-30', 54, 10, 15.25, 152.50, 5),
('FT011', '2024-03-10', 5, 9, 2.50, 22.50, 5),
('FT011', '2024-03-10', 20, 7, 6.75, 47.25, 5),
('FT011', '2024-03-10', 35, 6, 12.99, 77.94, 5),
('FT011', '2024-03-10', 46, 10, 22.50, 225.00, 5),
('FT011', '2024-03-10', 53, 8, 9.25, 74.00, 5),
('FT012', '2024-06-05', 2, 12, 1.00, 12.00, 5),
('FT012', '2024-06-05', 16, 9, 5.50, 49.50, 5),
('FT012', '2024-06-05', 30, 8, 4.20, 33.60, 5),
('FT012', '2024-06-05', 44, 5, 18.20, 91.00, 5),
('FT012', '2024-06-05', 58, 10, 13.25, 132.50, 5),
('FT013', '2024-09-20', 4, 11, 3.50, 38.50, 5),
('FT013', '2024-09-20', 19, 7, 5.25, 36.75, 5),
('FT013', '2024-09-20', 25, 9, 8.45, 76.05, 5),
('FT013', '2024-09-20', 37, 6, 18.25, 109.50, 5),
('FT013', '2024-09-20', 50, 8, 17.50, 140.00, 5),
('FT014', '2024-02-28', 9, 10, 3.00, 30.00, 5),
('FT014', '2024-02-28', 22, 6, 4.99, 29.94, 5),
('FT014', '2024-02-28', 31, 8, 14.99, 119.92, 5),
('FT014', '2024-02-28', 43, 12, 21.00, 252.00, 5),
('FT014', '2024-02-28', 57, 7, 10.75, 75.25, 5),
('FT015', '2024-07-10', 6, 9, 1.80, 16.20, 5),
('FT015', '2024-07-10', 18, 5, 5.50, 27.50, 5),
('FT015', '2024-07-10', 29, 8, 3.50, 28.00, 5),
('FT015', '2024-07-10', 40, 7, 17.99, 125.93, 5),
('FT015', '2024-07-10', 54, 10, 15.25, 152.50, 5),
('FT016', '2024-05-22', 1, 12, 2.50, 30.00, 5),
('FT016', '2024-05-22', 14, 8, 6.00, 48.00, 5),
('FT016', '2024-05-22', 26, 5, 7.99, 39.95, 5),
('FT016', '2024-05-22', 38, 10, 9.50, 95.00, 5),
('FT016', '2024-05-22', 52, 9, 14.10, 126.90, 5),
('FT017', '2024-11-18', 3, 11, 2.00, 22.00, 5),
('FT017', '2024-11-18', 21, 7, 7.00, 49.00, 5),
('FT017', '2024-11-18', 34, 6, 9.99, 59.94, 5),
('FT017', '2024-11-18', 47, 5, 23.75, 118.75, 5),
('FT017', '2024-11-18', 56, 10, 18.25, 182.50, 5),
('FT018', '2024-10-03', 8, 6, 2.80, 16.80, 5),
('FT018', '2024-10-03', 23, 10, 6.80, 68.00, 5),
('FT018', '2024-10-03', 36, 12, 2.50, 30.00, 5),
('FT018', '2024-10-03', 44, 8, 18.20, 145.60, 5),
('FT018', '2024-10-03', 60, 7, 17.99, 125.93, 5),
('FT019', '2024-08-29', 12, 13, 7.50, 97.50, 5),
('FT019', '2024-08-29', 28, 9, 6.20, 55.80, 5),
('FT019', '2024-08-29', 33, 8, 8.99, 71.92, 5),
('FT019', '2024-08-29', 45, 5, 12.49, 62.45, 5),
('FT019', '2024-08-29', 58, 6, 13.25, 79.50, 5),
('FT020', '2024-04-17', 4, 8, 3.50, 28.00, 5),
('FT020', '2024-04-17', 19, 7, 5.25, 36.75, 5),
('FT020', '2024-04-17', 25, 5, 8.45, 42.25, 5),
('FT020', '2024-04-17', 37, 9, 18.25, 164.25, 5),
('FT020', '2024-04-17', 50, 6, 17.50, 105.00, 5);

-- Store 6
INSERT INTO Sales (Sales_order_number, Sales_date, Product_id, Quantity_sold, Unit_price, Sales_amount, Store_id) VALUES
('FT001', '2024-01-15', 1, 8, 1.50, 12.00, 6),   
('FT001', '2024-01-15', 2, 10, 1.00, 10.00, 6), 
('FT001', '2024-01-15', 3, 7, 2.00, 14.00, 6),   
('FT001', '2024-01-15', 4, 5, 3.50, 17.50, 6),   
('FT001', '2024-01-15', 5, 9, 2.50, 22.50, 6),   
('FT002', '2024-01-20', 6, 10, 1.80, 18.00, 6),   
('FT002', '2024-01-20', 7, 8, 2.20, 17.60, 6),    
('FT002', '2024-01-20', 8, 12, 2.80, 33.60, 6),  
('FT002', '2024-01-20', 9, 7, 3.00, 21.00, 6),  
('FT002', '2024-01-20', 10, 6, 2.40, 14.40, 6),   
('FT003', '2024-02-05', 11, 9, 12.00, 108.00, 6),  
('FT003', '2024-02-05', 12, 6, 8.00, 48.00, 6),   
('FT003', '2024-02-05', 13, 5, 7.50, 37.50, 6),   
('FT003', '2024-02-05', 14, 7, 6.00, 42.00, 6),   
('FT003', '2024-02-05', 15, 8, 5.50, 44.00, 6),   
('FT004', '2024-02-10', 16, 10, 10.00, 100.00, 6),
('FT004', '2024-02-10', 17, 12, 9.00, 108.00, 6), 
('FT004', '2024-02-10', 18, 6, 6.50, 39.00, 6),   
('FT004', '2024-02-10', 19, 7, 7.00, 49.00, 6),   
('FT005', '2024-02-20', 20, 5, 15.00, 75.00, 6),   
('FT005', '2024-02-20', 21, 8, 2.50, 20.00, 6),   
('FT005', '2024-02-20', 22, 7, 1.00, 7.00, 6),   
('FT005', '2024-02-20', 23, 6, 0.80, 4.80, 6),    
('FT005', '2024-02-20', 24, 9, 3.00, 27.00, 6),   
('FT006', '2024-03-01', 25, 7, 3.00, 21.00, 6),   
('FT006', '2024-03-01', 26, 6, 1.50, 9.00, 6),    
('FT006', '2024-03-01', 27, 8, 2.20, 17.60, 6),   
('FT006', '2024-03-01', 28, 9, 2.50, 22.50, 6),   
('FT006', '2024-03-01', 29, 10, 3.50, 35.00, 6),   
('FT007', '2024-03-10', 30, 6, 10.00, 60.00, 6),  
('FT007', '2024-03-10', 31, 8, 20.00, 160.00, 6), 
('FT007', '2024-03-10', 32, 7, 30.00, 210.00, 6), 
('FT007', '2024-03-10', 33, 9, 25.00, 225.00, 6), 
('FT007', '2024-03-10', 34, 5, 15.00, 75.00, 6),  
('FT008', '2024-03-15', 35, 10, 18.00, 180.00, 6),
('FT008', '2024-03-15', 36, 8, 12.00, 96.00, 6),  
('FT008', '2024-03-15', 37, 5, 12.00, 60.00, 6),  
('FT008', '2024-03-15', 38, 7, 3.00, 21.00, 6),    
('FT008', '2024-03-15', 39, 6, 8.00, 48.00, 6),    
('FT009', '2024-03-25', 40, 6, 15.00, 90.00, 6),   
('FT009', '2024-03-25', 41, 5, 20.00, 100.00, 6), 
('FT009', '2024-03-25', 42, 8, 10.00, 80.00, 6),   
('FT009', '2024-03-25', 43, 7, 25.00, 175.00, 6),  
('FT009', '2024-03-25', 44, 9, 18.00, 162.00, 6),  
('FT010', '2024-04-01', 45, 5, 40.00, 200.00, 6),   
('FT010', '2024-04-01', 46, 6, 7.00, 42.00, 6),    
('FT010', '2024-04-01', 47, 8, 15.00, 120.00, 6),   
('FT010', '2024-04-01', 48, 7, 30.00, 210.00, 6),   
('FT010', '2024-04-01', 49, 9, 22.00, 198.00, 6),   
('FT011', '2024-04-05', 50, 8, 4.00, 32.00, 6),  
('FT011', '2024-04-05', 51, 6, 5.00, 30.00, 6), 
('FT011', '2024-04-05', 52, 7, 6.00, 42.00, 6),   
('FT011', '2024-04-05', 53, 10, 7.00, 70.00, 6), 
('FT011', '2024-04-05', 54, 5, 2.50, 12.50, 6),   
('FT012', '2024-04-10', 55, 7, 8.00, 56.00, 6),    
('FT012', '2024-04-10', 56, 9, 1.80, 16.20, 6),    
('FT012', '2024-04-10', 57, 8, 4.00, 32.00, 6),  
('FT012', '2024-04-10', 58, 6, 2.80, 16.80, 6),   
('FT012', '2024-04-10', 59, 7, 10.00, 70.00, 6),   
('FT013', '2024-04-15', 60, 10, 3.50, 35.00, 6);   

-- Store 7
INSERT INTO Sales (Sales_order_number, Sales_date, Product_id, Quantity_sold, Unit_price, Sales_amount, Store_id) VALUES
('FT001', '2024-01-05', 1, 10, 1.50, 15.00, 7),
('FT001', '2024-01-05', 3, 6, 2.00, 12.00, 7),
('FT001', '2024-01-05', 5, 8, 2.50, 20.00, 7),
('FT001', '2024-01-05', 8, 7, 2.20, 15.40, 7),
('FT001', '2024-01-05', 12, 10, 1.00, 10.00, 7),
('FT002', '2024-02-01', 9, 5, 3.00, 15.00, 7),
('FT002', '2024-02-01', 11, 6, 6.00, 36.00, 7),
('FT002', '2024-02-01', 13, 7, 4.50, 31.50, 7),
('FT002', '2024-02-01', 18, 8, 5.50, 44.00, 7),
('FT002', '2024-02-01', 21, 6, 7.50, 45.00, 7),
('FT003', '2024-02-15', 4, 10, 3.50, 35.00, 7),
('FT003', '2024-02-15', 6, 9, 2.50, 22.50, 7),
('FT003', '2024-02-15', 17, 5, 1.20, 6.00, 7),
('FT003', '2024-02-15', 19, 11, 2.80, 30.80, 7),
('FT003', '2024-02-15', 22, 7, 6.50, 45.50, 7),
('FT004', '2024-03-01', 7, 4, 2.00, 8.00, 7),
('FT004', '2024-03-01', 15, 6, 3.50, 21.00, 7),
('FT004', '2024-03-01', 26, 7, 1.50, 10.50, 7),
('FT004', '2024-03-01', 28, 9, 4.00, 36.00, 7),
('FT004', '2024-03-01', 32, 5, 8.00, 40.00, 7),
('FT005', '2024-03-10', 10, 12, 2.40, 28.80, 7),
('FT005', '2024-03-10', 13, 6, 3.50, 21.00, 7),
('FT005', '2024-03-10', 25, 8, 3.00, 24.00, 7),
('FT005', '2024-03-10', 30, 5, 4.80, 24.00, 7),
('FT006', '2024-04-01', 12, 10, 6.00, 60.00, 7),
('FT006', '2024-04-01', 17, 7, 4.50, 31.50, 7),
('FT006', '2024-04-01', 24, 5, 3.80, 19.00, 7),
('FT006', '2024-04-01', 29, 9, 2.20, 19.80, 7),
('FT007', '2024-04-10', 6, 8, 3.50, 28.00, 7),
('FT007', '2024-04-10', 8, 5, 7.00, 35.00, 7),
('FT007', '2024-04-10', 13, 7, 4.00, 28.00, 7),
('FT007', '2024-04-10', 18, 6, 5.00, 30.00, 7),
('FT008', '2024-05-01', 2, 10, 8.50, 85.00, 7),
('FT008', '2024-05-01', 17, 6, 3.20, 19.20, 7),
('FT008', '2024-05-01', 19, 5, 2.00, 10.00, 7),
('FT009', '2024-05-10', 3, 6, 1.90, 11.40, 7),
('FT009', '2024-05-10', 9, 8, 3.60, 28.80, 7),
('FT009', '2024-05-10', 14, 7, 2.50, 17.50, 7),
('FT009', '2024-05-10', 25, 10, 4.00, 40.00, 7),
('FT010', '2024-06-01', 5, 5, 2.80, 14.00, 7),
('FT010', '2024-06-01', 6, 10, 3.20, 32.00, 7),
('FT010', '2024-06-01', 16, 7, 5.00, 35.00, 7),
('FT010', '2024-06-01', 19, 5, 4.50, 22.50, 7);

-- Store 8
INSERT INTO Sales (Sales_order_number, Sales_date, Product_ID, Quantity_sold, Unit_price, Sales_amount, Store_ID) VALUES
('FT001', '2024-01-15', 7, 6, 2.20, 13.20, 8),
('FT001', '2024-01-15', 14, 8, 6.00, 48.00, 8),
('FT001', '2024-01-15', 22, 10, 4.99, 49.90, 8),
('FT001', '2024-01-15', 36, 9, 2.50, 22.50, 8),
('FT001', '2024-01-15', 50, 7, 17.50, 122.50, 8),
('FT002', '2024-03-28', 1, 12, 1.50, 18.00, 8),
('FT002', '2024-03-28', 19, 6, 5.25, 31.50, 8),
('FT002', '2024-03-28', 33, 8, 8.99, 71.92, 8),
('FT002', '2024-03-28', 44, 7, 18.20, 127.40, 8),
('FT002', '2024-03-28', 55, 10, 14.00, 140.00, 8),
('FT003', '2024-06-17', 4, 11, 3.50, 38.50, 8),
('FT003', '2024-06-17', 21, 9, 7.00, 63.00, 8),
('FT003', '2024-06-17', 32, 7, 6.50, 45.50, 8),
('FT003', '2024-06-17', 45, 6, 12.49, 74.94, 8),
('FT003', '2024-06-17', 58, 12, 13.25, 159.00, 8),
('FT004', '2024-09-05', 3, 8, 2.00, 16.00, 8),
('FT004', '2024-09-05', 16, 10, 5.50, 55.00, 8),
('FT004', '2024-09-05', 30, 6, 4.20, 25.20, 8),
('FT004', '2024-09-05', 42, 9, 20.00, 180.00, 8),
('FT004', '2024-09-05', 57, 5, 10.75, 53.75, 8),
('FT005', '2024-12-22', 5, 7, 2.50, 17.50, 8),
('FT005', '2024-12-22', 18, 6, 5.50, 33.00, 8),
('FT005', '2024-12-22', 27, 9, 7.99, 71.91, 8),
('FT005', '2024-12-22', 40, 10, 17.99, 179.90, 8),
('FT005', '2024-12-22', 52, 8, 14.10, 112.80, 8),
('FT006', '2024-07-01', 9, 13, 3.00, 39.00, 8),
('FT006', '2024-07-01', 22, 11, 4.99, 54.89, 8),
('FT006', '2024-07-01', 31, 10, 14.99, 149.90, 8),
('FT006', '2024-07-01', 48, 8, 24.50, 196.00, 8),
('FT006', '2024-07-01', 60, 6, 17.99, 107.94, 8),
('FT007', '2024-10-15', 8, 5, 2.80, 14.00, 8),
('FT007', '2024-10-15', 20, 9, 6.75, 60.75, 8),
('FT007', '2024-10-15', 37, 7, 9.50, 66.50, 8),
('FT007', '2024-10-15', 49, 12, 22.00, 264.00, 8),
('FT007', '2024-10-15', 55, 8, 14.00, 112.00, 8),
('FT008', '2024-04-10', 2, 10, 1.00, 10.00, 8),
('FT008', '2024-04-10', 12, 6, 7.50, 45.00, 8),
('FT008', '2024-04-10', 29, 9, 8.45, 76.05, 8),
('FT008', '2024-04-10', 38, 8, 9.50, 76.00, 8),
('FT008', '2024-04-10', 53, 7, 9.25, 64.75, 8),
('FT009', '2024-08-30', 11, 9, 8.00, 72.00, 8),
('FT009', '2024-08-30', 24, 12, 4.80, 57.60, 8),
('FT009', '2024-08-30', 35, 8, 12.99, 103.92, 8),
('FT009', '2024-08-30', 47, 6, 23.75, 142.50, 8),
('FT009', '2024-08-30', 59, 10, 19.25, 192.50, 8),
('FT010', '2024-02-14', 6, 11, 1.80, 19.80, 8),
('FT010', '2024-02-14', 15, 7, 6.50, 45.50, 8),
('FT010', '2024-02-14', 28, 9, 6.20, 55.80, 8),
('FT010', '2024-02-14', 41, 8, 15.99, 127.92, 8),
('FT010', '2024-02-14', 54, 5, 15.25, 76.25, 8),
('FT011', '2024-05-10', 3, 7, 2.00, 14.00, 8),
('FT011', '2024-05-10', 17, 6, 10.00, 60.00, 8),
('FT011', '2024-05-10', 27, 9, 7.99, 71.91, 8),
('FT011', '2024-05-10', 40, 8, 17.99, 143.92, 8),
('FT011', '2024-05-10', 52, 5, 14.10, 70.50, 8),
('FT012', '2024-09-15', 9, 5, 3.00, 15.00, 8),
('FT012', '2024-09-15', 23, 7, 5.75, 40.25, 8),
('FT012', '2024-09-15', 35, 6, 9.99, 59.94, 8),
('FT012', '2024-09-15', 47, 9, 23.75, 213.75, 8),
('FT012', '2024-09-15', 59, 8, 19.25, 154.00, 8),
('FT013', '2024-06-18', 5, 11, 2.50, 27.50, 8),
('FT013', '2024-06-18', 19, 6, 5.25, 31.50, 8),
('FT013', '2024-06-18', 30, 10, 8.45, 84.50, 8),
('FT013', '2024-06-18', 42, 7, 20.00, 140.00, 8),
('FT013', '2024-06-18', 57, 12, 10.75, 129.00, 8),
('FT014', '2024-07-20', 2, 8, 1.00, 8.00, 8),
('FT014', '2024-07-20', 12, 7, 7.50, 52.50, 8),
('FT014', '2024-07-20', 26, 9, 9.99, 89.91, 8),
('FT014', '2024-07-20', 38, 6, 9.50, 57.00, 8),
('FT014', '2024-07-20', 53, 5, 9.25, 46.25, 8),
('FT015', '2024-12-10', 4, 9, 3.50, 31.50, 8),
('FT015', '2024-12-10', 15, 8, 6.50, 52.00, 8),
('FT015', '2024-12-10', 29, 6, 6.20, 37.20, 8),
('FT015', '2024-12-10', 41, 12, 15.99, 191.88, 8),
('FT015', '2024-12-10', 54, 7, 15.25, 106.75, 8),
('FT016', '2024-08-03', 1, 5, 1.50, 7.50, 8),
('FT016', '2024-08-03', 16, 6, 5.50, 33.00, 8),
('FT016', '2024-08-03', 32, 8, 6.50, 52.00, 8),
('FT016', '2024-08-03', 48, 10, 24.50, 245.00, 8),
('FT016', '2024-08-03', 60, 9, 17.99, 161.91, 8),
('FT017', '2024-04-25', 7, 12, 2.20, 26.40, 8),
('FT017', '2024-04-25', 20, 6, 6.75, 40.50, 8),
('FT017', '2024-04-25', 36, 9, 2.50, 22.50, 8),
('FT017', '2024-04-25', 50, 8, 17.50, 140.00, 8),
('FT017', '2024-04-25', 55, 7, 14.00, 98.00, 8),
('FT018', '2024-11-14', 6, 10, 1.80, 18.00, 8),
('FT018', '2024-11-14', 14, 5, 6.00, 30.00, 8),
('FT018', '2024-11-14', 27, 8, 7.99, 63.92, 8),
('FT018', '2024-11-14', 42, 7, 20.00, 140.00, 8),
('FT018', '2024-11-14', 56, 9, 11.50, 103.50, 8),
('FT019', '2024-02-19', 2, 13, 1.00, 13.00, 8),
('FT019', '2024-02-19', 13, 6, 8.00, 48.00, 8),
('FT019', '2024-02-19', 25, 9, 6.20, 55.80, 8),
('FT019', '2024-02-19', 37, 7, 9.50, 66.50, 8),
('FT019', '2024-02-19', 49, 12, 22.00, 264.00, 8),
('FT020', '2024-10-21', 8, 6, 2.80, 16.80, 8),
('FT020', '2024-10-21', 21, 5, 7.00, 35.00, 8),
('FT020', '2024-10-21', 33, 9, 8.99, 80.91, 8),
('FT020', '2024-10-21', 45, 7, 12.49, 87.43, 8),
('FT020', '2024-10-21', 58, 10, 13.25, 132.50, 8);

-- Store 9
INSERT INTO Sales (Sales_order_number, Sales_date, Product_id, Quantity_sold, Unit_price, Sales_amount, Store_id) VALUES
('FT001', '2024-01-12', 1, 4, 1.50, 6.00, 9),
('FT001', '2024-01-12', 2, 5, 1.00, 5.00, 9),
('FT001', '2024-01-12', 3, 3, 2.00, 6.00, 9),
('FT001', '2024-01-12', 4, 7, 3.50, 24.50, 9),
('FT001', '2024-01-12', 5, 6, 2.50, 15.00, 9),
('FT002', '2024-02-25', 10, 5, 2.40, 12.00, 9),
('FT002', '2024-02-25', 11, 4, 3.00, 12.00, 9),
('FT002', '2024-02-25', 12, 6, 2.50, 15.00, 9),
('FT002', '2024-02-25', 13, 3, 2.80, 8.40, 9),
('FT002', '2024-02-25', 14, 9, 3.00, 27.00, 9),
('FT003', '2024-03-17', 15, 2, 12.00, 24.00, 9),
('FT003', '2024-03-17', 16, 6, 8.00, 48.00, 9),
('FT003', '2024-03-17', 17, 4, 7.50, 30.00, 9),
('FT003', '2024-03-17', 18, 5, 6.00, 30.00, 9),
('FT003', '2024-03-17', 19, 3, 5.50, 16.50, 9),
('FT003', '2024-03-17', 20, 7, 10.00, 70.00, 9),
('FT004', '2024-04-03', 21, 6, 1.20, 7.20, 9),
('FT004', '2024-04-03', 22, 4, 0.80, 3.20, 9),
('FT004', '2024-04-03', 23, 5, 1.50, 7.50, 9),
('FT004', '2024-04-03', 24, 3, 1.80, 5.40, 9),
('FT004', '2024-04-03', 25, 6, 0.50, 3.00, 9),
('FT004', '2024-04-03', 26, 9, 0.30, 2.70, 9),
('FT005', '2024-06-21', 27, 7, 2.00, 14.00, 9),
('FT005', '2024-06-21', 28, 8, 3.50, 28.00, 9),
('FT005', '2024-06-21', 29, 5, 3.20, 16.00, 9),
('FT005', '2024-06-21', 30, 6, 2.20, 13.20, 9),
('FT005', '2024-06-21', 31, 4, 7.00, 28.00, 9),
('FT005', '2024-06-21', 32, 8, 1.50, 12.00, 9),
('FT006', '2024-08-05', 33, 3, 15.00, 45.00, 9),
('FT006', '2024-08-05', 34, 5, 2.50, 12.50, 9),
('FT006', '2024-08-05', 35, 7, 3.20, 22.40, 9),
('FT006', '2024-08-05', 36, 4, 1.90, 7.60, 9),
('FT006', '2024-08-05', 37, 6, 1.80, 10.80, 9),
('FT007', '2024-09-19', 38, 8, 10.00, 80.00, 9),
('FT007', '2024-09-19', 39, 3, 18.00, 54.00, 9),
('FT007', '2024-09-19', 40, 2, 30.00, 60.00, 9),
('FT007', '2024-09-19', 41, 4, 12.00, 48.00, 9),
('FT007', '2024-09-19', 42, 5, 20.00, 100.00, 9),
('FT007', '2024-09-19', 43, 6, 10.00, 60.00, 9),
('FT008', '2024-11-15', 44, 7, 13.00, 91.00, 9),
('FT008', '2024-11-15', 45, 4, 12.50, 50.00, 9),
('FT008', '2024-11-15', 46, 3, 9.00, 27.00, 9),
('FT008', '2024-11-15', 47, 5, 7.50, 37.50, 9),
('FT008', '2024-11-15', 48, 6, 10.00, 60.00, 9),
('FT008', '2024-11-15', 49, 8, 5.00, 40.00, 9),
('FT009', '2024-12-05', 50, 3, 3.00, 9.00, 9),
('FT009', '2024-12-05', 51, 5, 2.50, 12.50, 9),
('FT009', '2024-12-05', 52, 7, 4.00, 28.00, 9),
('FT009', '2024-12-05', 53, 6, 3.20, 19.20, 9),
('FT009', '2024-12-05', 54, 9, 6.00, 54.00, 9),
('FT009', '2024-12-05', 55, 8, 1.50, 12.00, 9),
('FT010', '2024-12-25', 56, 4, 1.20, 4.80, 9),
('FT010', '2024-12-25', 57, 6, 1.80, 10.80, 9),
('FT010', '2024-12-25', 58, 3, 2.00, 6.00, 9),
('FT010', '2024-12-25', 59, 5, 2.50, 12.50, 9),
('FT010', '2024-12-25', 60, 7, 3.00, 21.00, 9),
('FT011', '2024-01-07', 1, 6, 1.50, 9.00, 9),
('FT011', '2024-01-07', 2, 4, 1.00, 4.00, 9),
('FT011', '2024-01-07', 3, 7, 2.00, 14.00, 9),
('FT011', '2024-01-07', 4, 3, 3.50, 10.50, 9),
('FT011', '2024-01-07', 5, 5, 2.50, 12.50, 9),
('FT012', '2024-02-01', 6, 5, 2.20, 11.00, 9),
('FT012', '2024-02-01', 7, 6, 2.50, 15.00, 9),
('FT012', '2024-02-01', 8, 7, 1.80, 12.60, 9),
('FT012', '2024-02-01', 9, 5, 2.00, 10.00, 9),
('FT012', '2024-02-01', 10, 4, 3.00, 12.00, 9),
('FT012', '2024-02-01', 11, 6, 1.80, 10.80, 9),
('FT013', '2024-03-02', 12, 8, 2.50, 20.00, 9),
('FT013', '2024-03-02', 13, 6, 3.00, 18.00, 9),
('FT013', '2024-03-02', 14, 4, 2.80, 11.20, 9),
('FT013', '2024-03-02', 15, 9, 3.20, 28.80, 9),
('FT013', '2024-03-02', 16, 5, 2.50, 12.50, 9),
('FT014', '2024-04-10', 17, 3, 1.50, 4.50, 9),
('FT014', '2024-04-10', 18, 4, 1.80, 7.20, 9),
('FT014', '2024-04-10', 19, 6, 1.20, 7.20, 9),
('FT014', '2024-04-10', 20, 5, 2.20, 11.00, 9),
('FT014', '2024-04-10', 21, 3, 2.50, 7.50, 9),
('FT014', '2024-04-10', 22, 4, 3.50, 14.00, 9),
('FT015', '2024-05-03', 23, 5, 3.00, 15.00, 9),
('FT015', '2024-05-03', 24, 7, 4.50, 31.50, 9),
('FT015', '2024-05-03', 25, 6, 2.80, 16.80, 9),
('FT015', '2024-05-03', 26, 3, 2.20, 6.60, 9),
('FT015', '2024-05-03', 27, 4, 1.50, 6.00, 9),
('FT016', '2024-06-14', 28, 6, 2.00, 12.00, 9),
('FT016', '2024-06-14', 29, 5, 3.20, 16.00, 9),
('FT016', '2024-06-14', 30, 7, 2.40, 16.80, 9),
('FT016', '2024-06-14', 31, 6, 1.80, 10.80, 9),
('FT016', '2024-06-14', 32, 4, 3.00, 12.00, 9),
('FT017', '2024-07-09', 33, 7, 3.00, 21.00, 9),
('FT017', '2024-07-09', 34, 5, 4.50, 22.50, 9),
('FT017', '2024-07-09', 35, 6, 1.50, 9.00, 9),
('FT017', '2024-07-09', 36, 8, 2.00, 16.00, 9),
('FT017', '2024-07-09', 37, 3, 2.50, 7.50, 9),
('FT017', '2024-07-09', 38, 4, 2.80, 11.20, 9),
('FT018', '2024-08-25', 39, 4, 3.20, 12.80, 9),
('FT018', '2024-08-25', 40, 6, 2.00, 12.00, 9),
('FT018', '2024-08-25', 41, 5, 1.80, 9.00, 9),
('FT018', '2024-08-25', 42, 3, 2.50, 7.50, 9),
('FT018', '2024-08-25', 43, 7, 4.00, 28.00, 9),
('FT018', '2024-08-25', 44, 4, 2.60, 10.40, 9),
('FT019', '2024-09-15', 45, 3, 3.00, 9.00, 9),
('FT019', '2024-09-15', 46, 7, 1.20, 8.40, 9),
('FT019', '2024-09-15', 47, 6, 3.00, 18.00, 9),
('FT019', '2024-09-15', 48, 4, 2.50, 10.00, 9),
('FT019', '2024-09-15', 49, 3, 3.00, 9.00, 9),
('FT019', '2024-09-15', 50, 5, 2.80, 14.00, 9),
('FT020', '2024-10-20', 51, 6, 1.80, 10.80, 9),
('FT020', '2024-10-20', 52, 4, 2.00, 8.00, 9),
('FT020', '2024-10-20', 53, 7, 3.50, 24.50, 9),
('FT020', '2024-10-20', 54, 5, 3.20, 16.00, 9),
('FT020', '2024-10-20', 55, 8, 1.80, 14.40, 9),
('FT021', '2024-11-10', 56, 7, 4.00, 28.00, 9),
('FT021', '2024-11-10', 57, 5, 2.80, 14.00, 9),
('FT021', '2024-11-10', 58, 6, 1.50, 9.00, 9),
('FT021', '2024-11-10', 59, 3, 2.80, 8.40, 9),
('FT021', '2024-11-10', 60, 7, 1.20, 8.40, 9),
('FT022', '2024-12-13', 1, 5, 2.50, 12.50, 9),
('FT022', '2024-12-13', 2, 4, 1.80, 7.20, 9),
('FT022', '2024-12-13', 3, 6, 2.20, 13.20, 9),
('FT022', '2024-12-13', 4, 8, 3.00, 24.00, 9),
('FT022', '2024-12-13', 5, 2, 2.50, 5.00, 9),
('FT023', '2024-12-21', 6, 7, 3.50, 24.50, 9),
('FT023', '2024-12-21', 7, 6, 1.80, 10.80, 9),
('FT023', '2024-12-21', 8, 5, 3.00, 15.00, 9),
('FT023', '2024-12-21', 9, 4, 2.50, 10.00, 9),
('FT023', '2024-12-21', 10, 6, 2.50, 15.00, 9),
('FT023', '2024-12-21', 11, 7, 3.20, 22.40, 9),
('FT024', '2024-12-31', 12, 4, 3.00, 12.00, 9),
('FT024', '2024-12-31', 13, 6, 2.80, 16.80, 9),
('FT024', '2024-12-31', 14, 5, 2.50, 12.50, 9),
('FT024', '2024-12-31', 15, 7, 3.20, 22.40, 9),
('FT024', '2024-12-31', 16, 6, 1.50, 9.00, 9),
('FT025', '2025-01-01', 17, 5, 2.20, 11.00, 9),
('FT025', '2025-01-01', 18, 4, 3.00, 12.00, 9),
('FT025', '2025-01-01', 19, 3, 2.50, 7.50, 9),
('FT025', '2025-01-01', 20, 6, 3.00, 18.00, 9),
('FT025', '2025-01-01', 21, 4, 2.20, 8.80, 9);

-- Store 10
INSERT INTO Sales (Sales_order_number, Sales_date, Product_id, Quantity_sold, Unit_price, Sales_amount, Store_id) VALUES
('FT001', '2024-01-10', 1, 6, 1.50, 9.00, 10),
('FT001', '2024-01-10', 2, 8, 1.00, 8.00, 10),
('FT001', '2024-01-10', 5, 4, 2.50, 10.00, 10),
('FT001', '2024-01-10', 8, 7, 2.80, 19.60, 10),
('FT001', '2024-01-10', 12, 5, 12.00, 60.00, 10),
('FT002', '2024-02-05', 11, 3, 8.00, 24.00, 10),
('FT002', '2024-02-05', 14, 6, 6.00, 36.00, 10),
('FT002', '2024-02-05', 18, 9, 7.50, 67.50, 10),
('FT002', '2024-02-05', 25, 5, 3.50, 17.50, 10),
('FT003', '2024-03-05', 6, 7, 3.50, 24.50, 10),
('FT003', '2024-03-05', 16, 8, 5.50, 44.00, 10),
('FT003', '2024-03-05', 23, 4, 25.00, 100.00, 10),
('FT003', '2024-03-05', 27, 5, 18.00, 90.00, 10),
('FT004', '2024-04-12', 3, 6, 2.00, 12.00, 10),
('FT004', '2024-04-12', 9, 7, 2.40, 16.80, 10),
('FT004', '2024-04-12', 15, 5, 7.00, 35.00, 10),
('FT004', '2024-04-12', 21, 9, 20.00, 180.00, 10),
('FT004', '2024-04-12', 27, 8, 18.00, 144.00, 10),
('FT005', '2024-05-22', 20, 5, 15.00, 75.00, 10),
('FT005', '2024-05-22', 22, 6, 10.00, 60.00, 10),
('FT005', '2024-05-22', 31, 7, 35.00, 245.00, 10),
('FT005', '2024-05-22', 38, 5, 25.00, 125.00, 10),
('FT006', '2024-06-17', 33, 6, 3.00, 18.00, 10),
('FT006', '2024-06-17', 39, 9, 6.50, 58.50, 10),
('FT006', '2024-06-17', 45, 4, 2.00, 8.00, 10),
('FT006', '2024-06-17', 50, 5, 7.00, 35.00, 10),
('FT007', '2024-07-10', 47, 8, 7.00, 56.00, 10),
('FT007', '2024-07-10', 51, 10, 15.00, 150.00, 10),
('FT007', '2024-07-10', 55, 6, 30.00, 180.00, 10),
('FT007', '2024-07-10', 58, 7, 8.00, 56.00, 10),
('FT008', '2024-08-05', 2, 9, 1.00, 9.00, 10),
('FT008', '2024-08-05', 7, 5, 1.80, 9.00, 10),
('FT008', '2024-08-05', 14, 6, 6.00, 36.00, 10),
('FT008', '2024-08-05', 19, 7, 3.00, 21.00, 10),
('FT008', '2024-08-05', 21, 4, 2.50, 10.00, 10),
('FT009', '2024-09-18', 29, 7, 9.00, 63.00, 10),
('FT009', '2024-09-18', 36, 9, 10.00, 90.00, 10),
('FT009', '2024-09-18', 42, 8, 5.50, 44.00, 10),
('FT009', '2024-09-18', 49, 5, 18.00, 90.00, 10),
('FT010', '2024-10-25', 16, 7, 5.50, 38.50, 10),
('FT010', '2024-10-25', 10, 9, 12.00, 108.00, 10),
('FT010', '2024-10-25', 13, 5, 9.50, 47.50, 10),
('FT010', '2024-10-25', 40, 5, 6.00, 30.00, 10),
('FT011', '2024-10-30', 4, 5, 2.00, 10.00, 10),
('FT011', '2024-10-30', 18, 6, 7.50, 45.00, 10),
('FT011', '2024-10-30', 24, 7, 9.00, 63.00, 10),
('FT011', '2024-10-30', 30, 8, 15.00, 120.00, 10),
('FT012', '2024-08-05', 31, 9, 20.00, 180.00, 10),
('FT012', '2024-08-05', 42, 5, 7.00, 35.00, 10),
('FT012', '2024-08-05', 53, 4, 8.50, 34.00, 10),
('FT012', '2024-08-05', 59, 6, 22.00, 132.00, 10),
('FT013', '2024-08-20', 33, 8, 3.00, 24.00, 10),
('FT013', '2024-08-20', 37, 7, 9.50, 66.50, 10),
('FT013', '2024-09-20', 45, 5, 5.00, 25.00, 10),
('FT013', '2024-09-20', 51, 6, 11.00, 66.00, 10),
('FT013', '2024-09-20', 56, 8, 18.00, 144.00, 10),
('FT014', '2024-09-28', 2, 5, 1.50, 7.50, 10),
('FT014', '2024-09-28', 10, 6, 5.00, 30.00, 10),
('FT014', '2024-09-28', 16, 8, 4.00, 32.00, 10),
('FT014', '2024-09-28', 20, 5, 12.00, 60.00, 10),
('FT015', '2024-10-02', 19, 7, 5.50, 38.50, 10),
('FT015', '2024-10-02', 21, 5, 6.00, 30.00, 10),
('FT015', '2024-10-02', 29, 9, 3.00, 27.00, 10),
('FT016', '2024-10-12', 8, 8, 3.50, 28.00, 10),
('FT016', '2024-10-12', 13, 5, 4.00, 20.00, 10),
('FT016', '2024-10-12', 27, 9, 20.00, 180.00, 10),
('FT016', '2024-10-12', 44, 6, 9.00, 54.00, 10),
('FT017', '2024-11-04', 9, 6, 1.80, 10.80, 10),
('FT017', '2024-11-04', 11, 7, 6.50, 45.50, 10),
('FT017', '2024-11-04', 19, 4, 18.00, 72.00, 10),
('FT017', '2024-11-04', 41, 8, 9.00, 72.00, 10),
('FT018', '2024-11-22', 5, 5, 2.50, 12.50, 10),
('FT018', '2024-11-22', 14, 6, 3.50, 21.00, 10),
('FT018', '2024-11-22', 22, 8, 12.00, 96.00, 10),
('FT018', '2024-11-22', 31, 5, 11.00, 55.00, 10),
('FT019', '2024-12-13', 7, 7, 2.40, 16.80, 10),
('FT019', '2024-12-13', 16, 8, 8.50, 68.00, 10),
('FT019', '2024-12-13', 23, 5, 3.50, 17.50, 10),
('FT019', '2024-12-13', 39, 7, 6.00, 42.00, 10),
('FT020', '2024-12-17', 24, 8, 3.00, 24.00, 10),
('FT020', '2024-12-17', 28, 7, 5.00, 35.00, 10),
('FT020', '2024-12-17', 33, 6, 12.00, 72.00, 10),
('FT020', '2024-12-17', 44, 8, 20.00, 160.00, 10);

-- Store 11
INSERT INTO Sales (Sales_order_number, Sales_date, Product_ID, Quantity_sold, Unit_price, Sales_amount, Store_ID) VALUES
('FT001', '2024-01-15', 1, 10, 1.50, 15.00, 11),
('FT001', '2024-01-15', 6, 7, 1.80, 12.60, 11),
('FT001', '2024-01-15', 9, 5, 3.00, 15.00, 11),
('FT001', '2024-01-15', 41, 6, 15.99, 95.94, 11),
('FT001', '2024-01-15', 50, 8, 17.50, 140.00, 11),
('FT002', '2024-02-20', 2, 8, 1.00, 8.00, 11),
('FT002', '2024-02-20', 5, 12, 2.50, 30.00, 11),
('FT002', '2024-02-20', 8, 9, 2.80, 25.20, 11),
('FT002', '2024-02-20', 44, 10, 19.99, 199.90, 11),
('FT002', '2024-02-20', 58, 6, 13.25, 79.50, 11),
('FT003', '2024-03-05', 3, 6, 2.00, 12.00, 11),
('FT003', '2024-03-05', 7, 9, 2.20, 19.80, 11),
('FT003', '2024-03-05', 10, 8, 2.40, 19.20, 11),
('FT003', '2024-03-05', 46, 5, 21.99, 109.95, 11),
('FT003', '2024-03-05', 55, 7, 14.00, 98.00, 11),
('FT004', '2024-04-10', 4, 7, 3.50, 24.50, 11),
('FT004', '2024-04-10', 6, 5, 1.80, 9.00, 11),
('FT004', '2024-04-10', 9, 6, 3.00, 18.00, 11),
('FT004', '2024-04-10', 45, 12, 18.75, 225.00, 11),
('FT004', '2024-04-10', 57, 8, 10.75, 86.00, 11),
('FT005', '2024-05-21', 1, 9, 1.50, 13.50, 11),
('FT005', '2024-05-21', 5, 11, 2.50, 27.50, 11),
('FT005', '2024-05-21', 8, 10, 2.80, 28.00, 11),
('FT005', '2024-05-21', 43, 7, 12.99, 90.93, 11),
('FT005', '2024-05-21', 52, 6, 17.25, 103.50, 11),
('FT006', '2024-06-15', 2, 5, 1.00, 5.00, 11),
('FT006', '2024-06-15', 7, 9, 2.20, 19.80, 11),
('FT006', '2024-06-15', 10, 8, 2.40, 19.20, 11),
('FT006', '2024-06-15', 41, 10, 15.99, 159.90, 11),
('FT006', '2024-06-15', 59, 7, 19.25, 134.75, 11),
('FT007', '2024-07-03', 3, 6, 2.00, 12.00, 11),
('FT007', '2024-07-03', 6, 7, 1.80, 12.60, 11),
('FT007', '2024-07-03', 9, 5, 3.00, 15.00, 11),
('FT007', '2024-07-03', 42, 8, 16.50, 132.00, 11),
('FT007', '2024-07-03', 50, 12, 17.50, 210.00, 11),
('FT008', '2024-08-19', 4, 10, 3.50, 35.00, 11),
('FT008', '2024-08-19', 7, 9, 2.20, 19.80, 11),
('FT008', '2024-08-19', 10, 7, 2.40, 16.80, 11),
('FT008', '2024-08-19', 49, 5, 22.00, 110.00, 11),
('FT008', '2024-08-19', 58, 6, 13.25, 79.50, 11),
('FT009', '2024-09-22', 2, 5, 1.00, 5.00, 11),
('FT009', '2024-09-22', 5, 8, 2.50, 20.00, 11),
('FT009', '2024-09-22', 8, 10, 2.80, 28.00, 11),
('FT009', '2024-09-22', 46, 12, 21.99, 263.88, 11),
('FT009', '2024-09-22', 56, 6, 11.50, 69.00, 11),
('FT010', '2024-10-10', 3, 6, 2.00, 12.00, 11),
('FT010', '2024-10-10', 6, 9, 1.80, 16.20, 11),
('FT010', '2024-10-10', 9, 7, 3.00, 21.00, 11),
('FT010', '2024-10-10', 43, 5, 12.99, 64.95, 11),
('FT010', '2024-10-10', 57, 8, 10.75, 86.00, 11),
('FT011', '2024-10-25', 1, 8, 1.50, 12.00, 11),
('FT011', '2024-10-25', 6, 10, 1.80, 18.00, 11),
('FT011', '2024-10-25', 9, 6, 3.00, 18.00, 11),
('FT011', '2024-10-25', 42, 9, 16.50, 148.50, 11),
('FT011', '2024-10-25', 55, 7, 14.00, 98.00, 11),
('FT012', '2024-11-02', 2, 5, 1.00, 5.00, 11),
('FT012', '2024-11-02', 7, 8, 2.20, 17.60, 11),
('FT012', '2024-11-02', 10, 10, 2.40, 24.00, 11),
('FT012', '2024-11-02', 41, 12, 15.99, 191.88, 11),
('FT012', '2024-11-02', 59, 6, 19.25, 115.50, 11),
('FT013', '2024-12-18', 3, 6, 2.00, 12.00, 11),
('FT013', '2024-12-18', 5, 10, 2.50, 25.00, 11),
('FT013', '2024-12-18', 8, 9, 2.80, 25.20, 11),
('FT013', '2024-12-18', 49, 5, 22.00, 110.00, 11),
('FT013', '2024-12-18', 53, 7, 16.50, 115.50, 11),
('FT014', '2024-12-30', 4, 7, 3.50, 24.50, 11),
('FT014', '2024-12-30', 6, 9, 1.80, 16.20, 11),
('FT014', '2024-12-30', 9, 6, 3.00, 18.00, 11),
('FT014', '2024-12-30', 46, 12, 21.99, 263.88, 11),
('FT014', '2024-12-30', 57, 8, 10.75, 86.00, 11),
('FT015', '2025-01-01', 1, 8, 1.50, 12.00, 11),
('FT015', '2025-01-01', 5, 11, 2.50, 27.50, 11),
('FT015', '2025-01-01', 8, 10, 2.80, 28.00, 11),
('FT015', '2025-01-01', 44, 10, 19.99, 199.90, 11),
('FT015', '2025-01-01', 58, 6, 13.25, 79.50, 11),
('FT016', '2024-07-12', 2, 6, 1.00, 6.00, 11),
('FT016', '2024-07-12', 6, 7, 1.80, 12.60, 11),
('FT016', '2024-07-12', 10, 9, 2.40, 21.60, 11),
('FT016', '2024-07-12', 42, 11, 16.50, 181.50, 11),
('FT016', '2024-07-12', 55, 5, 14.00, 70.00, 11),
('FT017', '2024-08-05', 3, 8, 2.00, 16.00, 11),
('FT017', '2024-08-05', 7, 6, 2.20, 13.20, 11),
('FT017', '2024-08-05', 9, 5, 3.00, 15.00, 11),
('FT017', '2024-08-05', 49, 9, 22.00, 198.00, 11),
('FT017', '2024-08-05', 58, 7, 13.25, 92.75, 11),
('FT018', '2024-09-22', 5, 7, 2.50, 17.50, 11),
('FT018', '2024-09-22', 8, 10, 2.80, 28.00, 11),
('FT018', '2024-09-22', 10, 6, 2.40, 14.40, 11),
('FT018', '2024-09-22', 41, 8, 15.99, 127.92, 11),
('FT018', '2024-09-22', 54, 10, 17.50, 175.00, 11),
('FT019', '2024-10-08', 1, 12, 1.50, 18.00, 11),
('FT019', '2024-10-08', 4, 9, 3.50, 31.50, 11),
('FT019', '2024-10-08', 7, 5, 2.20, 11.00, 11),
('FT019', '2024-10-08', 44, 10, 19.99, 199.90, 11),
('FT019', '2024-10-08', 56, 8, 12.50, 100.00, 11),
('FT020', '2024-11-18', 3, 10, 2.00, 20.00, 11),
('FT020', '2024-11-18', 6, 8, 1.80, 14.40, 11),
('FT020', '2024-11-18', 9, 7, 3.00, 21.00, 11),
('FT020', '2024-11-18', 45, 9, 20.99, 188.91, 11),
('FT020', '2024-11-18', 59, 6, 19.25, 115.50, 11);

-- Store 12
INSERT INTO Sales (Sales_order_number, Sales_date, Product_id, Quantity_sold, Unit_price, Sales_amount, Store_id) VALUES
('FT001', '2024-01-01', 1, 5, 1.50, 7.50, 12),
('FT001', '2024-01-01', 2, 7, 1.80, 12.60, 12),
('FT001', '2024-01-01', 3, 6, 2.00, 12.00, 12),
('FT001', '2024-01-01', 4, 5, 3.00, 15.00, 12),
('FT001', '2024-01-01', 5, 8, 2.50, 20.00, 12),
('FT002', '2024-02-01', 6, 9, 2.20, 19.80, 12),
('FT002', '2024-02-01', 7, 6, 1.80, 10.80, 12),
('FT002', '2024-02-01', 8, 4, 2.00, 8.00, 12),
('FT002', '2024-02-01', 9, 7, 2.50, 17.50, 12),
('FT002', '2024-02-01', 10, 5, 3.00, 15.00, 12),
('FT003', '2024-03-03', 41, 6, 3.00, 18.00, 12),
('FT003', '2024-03-03', 42, 7, 4.00, 28.00, 12),
('FT003', '2024-03-03', 43, 8, 2.50, 20.00, 12),
('FT003', '2024-03-03', 44, 5, 2.20, 11.00, 12),
('FT003', '2024-03-03', 45, 9, 3.20, 28.80, 12),
('FT004', '2024-04-10', 46, 5, 2.80, 14.00, 12),
('FT004', '2024-04-10', 47, 6, 1.80, 10.80, 12),
('FT004', '2024-04-10', 48, 7, 2.40, 16.80, 12),
('FT004', '2024-04-10', 49, 4, 3.00, 12.00, 12),
('FT004', '2024-04-10', 50, 5, 2.50, 12.50, 12),
('FT005', '2024-05-05', 51, 7, 3.00, 21.00, 12),
('FT005', '2024-05-05', 52, 6, 2.80, 16.80, 12),
('FT005', '2024-05-05', 53, 8, 2.20, 17.60, 12),
('FT005', '2024-05-05', 54, 5, 1.80, 9.00, 12),
('FT005', '2024-05-05', 55, 4, 2.50, 10.00, 12),
('FT006', '2024-06-10', 56, 5, 2.60, 13.00, 12),
('FT006', '2024-06-10', 57, 6, 1.90, 11.40, 12),
('FT006', '2024-06-10', 58, 7, 3.00, 21.00, 12),
('FT006', '2024-06-10', 59, 4, 2.80, 11.20, 12),
('FT006', '2024-06-10', 60, 8, 1.80, 14.40, 12),
('FT007', '2024-07-01', 1, 6, 1.50, 9.00, 12),
('FT007', '2024-07-01', 2, 5, 1.80, 9.00, 12),
('FT007', '2024-07-01', 3, 7, 2.00, 14.00, 12),
('FT007', '2024-07-01', 4, 8, 2.50, 20.00, 12),
('FT007', '2024-07-01', 5, 9, 2.80, 25.20, 12),
('FT008', '2024-08-02', 6, 5, 2.20, 11.00, 12),
('FT008', '2024-08-02', 7, 6, 1.80, 10.80, 12),
('FT008', '2024-08-02', 8, 5, 2.50, 12.50, 12),
('FT008', '2024-08-02', 9, 7, 2.00, 14.00, 12),
('FT008', '2024-08-02', 10, 6, 3.00, 18.00, 12),
('FT009', '2024-09-12', 41, 7, 3.20, 22.40, 12),
('FT009', '2024-09-12', 42, 5, 2.40, 12.00, 12),
('FT009', '2024-09-12', 43, 6, 1.80, 10.80, 12),
('FT009', '2024-09-12', 44, 8, 2.50, 20.00, 12),
('FT009', '2024-09-12', 45, 4, 3.00, 12.00, 12),
('FT010', '2024-10-03', 46, 6, 3.00, 18.00, 12),
('FT010', '2024-10-03', 47, 7, 2.80, 19.60, 12),
('FT010', '2024-10-03', 48, 5, 2.20, 11.00, 12),
('FT010', '2024-10-03', 49, 8, 2.60, 20.80, 12),
('FT010', '2024-10-03', 50, 6, 3.20, 19.20, 12),
('FT011', '2024-11-11', 51, 5, 2.80, 14.00, 12),
('FT011', '2024-11-11', 52, 6, 2.50, 15.00, 12),
('FT011', '2024-11-11', 53, 4, 1.90, 7.60, 12),
('FT011', '2024-11-11', 54, 7, 3.00, 21.00, 12),
('FT011', '2024-11-11', 55, 9, 1.80, 16.20, 12),
('FT012', '2024-12-15', 56, 6, 3.20, 19.20, 12),
('FT012', '2024-12-15', 57, 5, 2.00, 10.00, 12),
('FT012', '2024-12-15', 58, 8, 2.50, 20.00, 12),
('FT012', '2024-12-15', 59, 6, 2.80, 16.80, 12),
('FT012', '2024-12-15', 60, 5, 1.50, 7.50, 12),
('FT013', '2024-01-20', 1, 5, 1.50, 7.50, 12),
('FT013', '2024-01-20', 2, 7, 1.80, 12.60, 12),
('FT013', '2024-01-20', 3, 6, 2.00, 12.00, 12),
('FT013', '2024-01-20', 4, 5, 3.00, 15.00, 12),
('FT013', '2024-01-20', 5, 8, 2.50, 20.00, 12),
('FT014', '2024-02-12', 6, 9, 2.20, 19.80, 12),
('FT014', '2024-02-12', 7, 6, 1.80, 10.80, 12),
('FT014', '2024-02-12', 8, 4, 2.00, 8.00, 12),
('FT014', '2024-02-12', 9, 7, 2.50, 17.50, 12),
('FT014', '2024-02-12', 10, 5, 3.00, 15.00, 12),
('FT015', '2024-03-03', 41, 6, 3.00, 18.00, 12),
('FT015', '2024-03-03', 42, 7, 4.00, 28.00, 12),
('FT015', '2024-03-03', 43, 8, 2.50, 20.00, 12),
('FT015', '2024-03-03', 44, 5, 2.20, 11.00, 12),
('FT015', '2024-03-03', 45, 9, 3.20, 28.80, 12),
('FT016', '2024-04-10', 46, 5, 2.80, 14.00, 12),
('FT016', '2024-04-10', 47, 6, 1.80, 10.80, 12),
('FT016', '2024-04-10', 48, 7, 2.40, 16.80, 12),
('FT016', '2024-04-10', 49, 4, 3.00, 12.00, 12),
('FT016', '2024-04-10', 50, 5, 2.50, 12.50, 12),
('FT017', '2024-05-05', 51, 7, 3.00, 21.00, 12),
('FT017', '2024-05-05', 52, 6, 2.80, 16.80, 12),
('FT017', '2024-05-05', 53, 8, 2.20, 17.60, 12),
('FT017', '2024-05-05', 54, 5, 1.80, 9.00, 12),
('FT017', '2024-05-05', 55, 4, 2.50, 10.00, 12),
('FT018', '2024-06-10', 56, 5, 2.60, 13.00, 12),
('FT018', '2024-06-10', 57, 6, 1.90, 11.40, 12),
('FT018', '2024-06-10', 58, 7, 3.00, 21.00, 12),
('FT018', '2024-06-10', 59, 4, 2.80, 11.20, 12),
('FT018', '2024-06-10', 60, 8, 1.80, 14.40, 12),
('FT019', '2024-07-01', 1, 6, 1.50, 9.00, 12),
('FT019', '2024-07-01', 2, 5, 1.80, 9.00, 12),
('FT019', '2024-07-01', 3, 7, 2.00, 14.00, 12),
('FT019', '2024-07-01', 4, 8, 2.50, 20.00, 12),
('FT019', '2024-07-01', 5, 9, 2.80, 25.20, 12),
('FT020', '2024-08-02', 6, 5, 2.20, 11.00, 12),
('FT020', '2024-08-02', 7, 6, 1.80, 10.80, 12),
('FT020', '2024-08-02', 8, 5, 2.50, 12.50, 12),
('FT020', '2024-08-02', 9, 7, 2.00, 14.00, 12),
('FT020', '2024-08-02', 10, 6, 3.00, 18.00, 12),
('FT021', '2024-09-12', 41, 7, 3.20, 22.40, 12),
('FT021', '2024-09-12', 42, 5, 2.40, 12.00, 12),
('FT021', '2024-09-12', 43, 6, 1.80, 10.80, 12),
('FT021', '2024-09-12', 44, 8, 2.50, 20.00, 12),
('FT021', '2024-09-12', 45, 4, 3.00, 12.00, 12),
('FT022', '2024-10-03', 46, 6, 3.00, 18.00, 12),
('FT022', '2024-10-03', 47, 7, 2.80, 19.60, 12),
('FT022', '2024-10-03', 48, 5, 2.20, 11.00, 12),
('FT022', '2024-10-03', 49, 8, 2.60, 20.80, 12),
('FT022', '2024-10-03', 50, 6, 3.20, 19.20, 12),
('FT023', '2024-11-11', 51, 5, 2.80, 14.00, 12),
('FT023', '2024-11-11', 52, 6, 2.50, 15.00, 12),
('FT023', '2024-11-11', 53, 4, 1.90, 7.60, 12),
('FT023', '2024-11-11', 54, 7, 3.00, 21.00, 12),
('FT023', '2024-11-11', 55, 9, 1.80, 16.20, 12),
('FT024', '2024-12-15', 56, 6, 3.20, 19.20, 12),
('FT024', '2024-12-15', 57, 5, 2.00, 10.00, 12),
('FT024', '2024-12-15', 58, 8, 2.50, 20.00, 12),
('FT024', '2024-12-15', 59, 6, 2.80, 16.80, 12),
('FT024', '2024-12-15', 60, 5, 1.50, 7.50, 12),
('FT025', '2025-01-01', 1, 5, 1.50, 7.50, 12),
('FT025', '2025-01-01', 2, 6, 1.80, 10.80, 12),
('FT025', '2025-01-01', 3, 7, 2.00, 14.00, 12),
('FT025', '2025-01-01', 4, 8, 2.50, 20.00, 12),
('FT025', '2025-01-01', 5, 9, 2.80, 25.20, 12);

-- Store 13
INSERT INTO Sales (Sales_order_number, Sales_date, Product_id, Quantity_sold, Unit_price, Sales_amount, Store_id) VALUES
('FT001', '2024-01-05', 1, 8, 1.50, 12.00, 13),
('FT001', '2024-01-05', 2, 5, 1.80, 9.00, 13),
('FT001', '2024-01-05', 3, 7, 2.00, 14.00, 13),
('FT001', '2024-01-05', 4, 5, 2.50, 12.50, 13),
('FT001', '2024-01-05', 5, 6, 2.80, 16.80, 13),
('FT002', '2024-02-10', 6, 4, 2.20, 8.80, 13),
('FT002', '2024-02-10', 7, 9, 1.80, 16.20, 13),
('FT002', '2024-02-10', 8, 6, 2.00, 12.00, 13),
('FT002', '2024-02-10', 9, 5, 2.40, 12.00, 13),
('FT002', '2024-02-10', 10, 7, 2.50, 17.50, 13),
('FT003', '2024-03-15', 41, 8, 3.00, 24.00, 13),
('FT003', '2024-03-15', 42, 6, 4.00, 24.00, 13),
('FT003', '2024-03-15', 43, 5, 2.20, 11.00, 13),
('FT003', '2024-03-15', 44, 7, 2.50, 17.50, 13),
('FT003', '2024-03-15', 45, 9, 2.80, 25.20, 13),
('FT004', '2024-04-01', 46, 6, 3.00, 18.00, 13),
('FT004', '2024-04-01', 47, 8, 2.50, 20.00, 13),
('FT004', '2024-04-01', 48, 5, 2.80, 14.00, 13),
('FT004', '2024-04-01', 49, 7, 2.40, 16.80, 13),
('FT004', '2024-04-01', 50, 6, 3.20, 19.20, 13),
('FT005', '2024-05-10', 51, 7, 3.00, 21.00, 13),
('FT005', '2024-05-10', 52, 5, 2.60, 13.00, 13),
('FT005', '2024-05-10', 53, 6, 3.00, 18.00, 13),
('FT005', '2024-05-10', 54, 4, 3.20, 12.80, 13),
('FT005', '2024-05-10', 55, 9, 1.90, 17.10, 13),
('FT006', '2024-06-12', 56, 5, 2.80, 14.00, 13),
('FT006', '2024-06-12', 57, 7, 2.50, 17.50, 13),
('FT006', '2024-06-12', 58, 6, 3.20, 19.20, 13),
('FT006', '2024-06-12', 59, 8, 2.80, 22.40, 13),
('FT006', '2024-06-12', 60, 5, 1.80, 9.00, 13),
('FT007', '2024-07-05', 1, 9, 1.50, 13.50, 13),
('FT007', '2024-07-05', 2, 5, 1.80, 9.00, 13),
('FT007', '2024-07-05', 3, 8, 2.00, 16.00, 13),
('FT007', '2024-07-05', 4, 6, 2.50, 15.00, 13),
('FT007', '2024-07-05', 5, 7, 2.80, 19.60, 13),
('FT008', '2024-08-20', 6, 8, 2.20, 17.60, 13),
('FT008', '2024-08-20', 7, 6, 1.80, 10.80, 13),
('FT008', '2024-08-20', 8, 5, 2.00, 10.00, 13),
('FT008', '2024-08-20', 9, 7, 2.40, 16.80, 13),
('FT008', '2024-08-20', 10, 8, 2.50, 20.00, 13),
('FT009', '2024-09-11', 41, 5, 3.00, 15.00, 13),
('FT009', '2024-09-11', 42, 7, 2.40, 16.80, 13),
('FT009', '2024-09-11', 43, 6, 2.50, 15.00, 13),
('FT009', '2024-09-11', 44, 8, 3.20, 25.60, 13),
('FT009', '2024-09-11', 45, 6, 3.00, 18.00, 13),
('FT010', '2024-10-05', 46, 6, 3.20, 19.20, 13),
('FT010', '2024-10-05', 47, 8, 2.80, 22.40, 13),
('FT010', '2024-10-05', 48, 7, 3.00, 21.00, 13),
('FT010', '2024-10-05', 49, 5, 3.00, 15.00, 13),
('FT010', '2024-10-05', 50, 6, 2.80, 16.80, 13),
('FT011', '2024-11-01', 51, 9, 3.00, 27.00, 13),
('FT011', '2024-11-01', 52, 5, 2.50, 12.50, 13),
('FT011', '2024-11-01', 53, 6, 3.00, 18.00, 13),
('FT011', '2024-11-01', 54, 4, 3.20, 12.80, 13),
('FT011', '2024-11-01', 55, 6, 3.00, 18.00, 13),
('FT012', '2024-12-01', 56, 8, 2.80, 22.40, 13),
('FT012', '2024-12-01', 57, 7, 3.00, 21.00, 13),
('FT012', '2024-12-01', 58, 6, 2.50, 15.00, 13),
('FT012', '2024-12-01', 59, 8, 3.00, 24.00, 13),
('FT012', '2024-12-01', 60, 5, 1.80, 9.00, 13),
('FT013', '2024-12-25', 1, 7, 1.50, 10.50, 13),
('FT013', '2024-12-25', 2, 9, 1.80, 16.20, 13),
('FT013', '2024-12-25', 3, 6, 2.00, 12.00, 13),
('FT013', '2024-12-25', 4, 5, 2.50, 12.50, 13),
('FT013', '2024-12-25', 5, 7, 2.80, 19.60, 13),
('FT014', '2024-01-10', 6, 8, 2.20, 17.60, 13),
('FT014', '2024-01-10', 7, 6, 2.50, 15.00, 13),
('FT014', '2024-01-10', 8, 7, 2.00, 14.00, 13),
('FT014', '2024-01-10', 9, 5, 2.40, 12.00, 13),
('FT014', '2024-01-10', 10, 6, 2.50, 15.00, 13),
('FT015', '2024-02-02', 41, 9, 3.00, 27.00, 13),
('FT015', '2024-02-02', 42, 7, 2.80, 19.60, 13),
('FT015', '2024-02-02', 43, 5, 3.20, 16.00, 13),
('FT015', '2024-02-02', 44, 6, 2.50, 15.00, 13),
('FT015', '2024-02-02', 45, 8, 2.80, 22.40, 13),
('FT016', '2024-03-03', 46, 6, 3.20, 19.20, 13),
('FT016', '2024-03-03', 47, 5, 3.00, 15.00, 13),
('FT016', '2024-03-03', 48, 7, 2.80, 19.60, 13),
('FT016', '2024-03-03', 49, 8, 2.40, 19.20, 13),
('FT016', '2024-03-03', 50, 5, 3.20, 16.00, 13),
('FT017', '2024-04-08', 51, 9, 3.00, 27.00, 13),
('FT017', '2024-04-08', 52, 8, 2.50, 20.00, 13),
('FT017', '2024-04-08', 53, 6, 3.00, 18.00, 13),
('FT017', '2024-04-08', 54, 7, 3.20, 22.40, 13),
('FT017', '2024-04-08', 55, 6, 2.80, 16.80, 13),
('FT018', '2024-05-20', 56, 8, 2.80, 22.40, 13),
('FT018', '2024-05-20', 57, 5, 2.50, 12.50, 13),
('FT018', '2024-05-20', 58, 6, 2.80, 16.80, 13),
('FT018', '2024-05-20', 59, 9, 2.40, 21.60, 13),
('FT018', '2024-05-20', 60, 5, 1.80, 9.00, 13),
('FT019', '2024-06-14', 1, 8, 1.50, 12.00, 13),
('FT019', '2024-06-14', 2, 6, 1.80, 10.80, 13),
('FT019', '2024-06-14', 3, 7, 2.00, 14.00, 13),
('FT019', '2024-06-14', 4, 6, 2.50, 15.00, 13),
('FT019', '2024-06-14', 5, 8, 2.80, 22.40, 13),
('FT020', '2024-07-22', 41, 9, 3.00, 27.00, 13),
('FT020', '2024-07-22', 42, 7, 3.20, 22.40, 13),
('FT020', '2024-07-22', 43, 8, 2.50, 20.00, 13),
('FT020', '2024-07-22', 44, 5, 3.00, 15.00, 13),
('FT020', '2024-07-22', 45, 6, 3.20, 19.20, 13),
('FT021', '2024-08-30', 46, 5, 2.80, 14.00, 13),
('FT021', '2024-08-30', 47, 9, 3.00, 27.00, 13),
('FT021', '2024-08-30', 48, 7, 2.50, 17.50, 13),
('FT021', '2024-08-30', 49, 5, 2.40, 12.00, 13),
('FT021', '2024-08-30', 50, 6, 3.00, 18.00, 13),
('FT022', '2024-09-15', 51, 7, 3.20, 22.40, 13),
('FT022', '2024-09-15', 52, 9, 3.00, 27.00, 13),
('FT022', '2024-09-15', 53, 8, 3.00, 24.00, 13),
('FT022', '2024-09-15', 54, 6, 3.00, 18.00, 13),
('FT022', '2024-09-15', 55, 7, 2.80, 19.60, 13),
('FT023', '2024-10-19', 56, 8, 3.20, 25.60, 13),
('FT023', '2024-10-19', 57, 7, 2.80, 19.60, 13),
('FT023', '2024-10-19', 58, 6, 3.00, 18.00, 13),
('FT023', '2024-10-19', 59, 5, 2.50, 12.50, 13),
('FT023', '2024-10-19', 60, 7, 1.80, 12.60, 13),
('FT024', '2024-11-10', 1, 5, 1.50, 7.50, 13),
('FT024', '2024-11-10', 2, 6, 1.80, 10.80, 13),
('FT024', '2024-11-10', 3, 7, 2.00, 14.00, 13),
('FT024', '2024-11-10', 4, 6, 2.50, 15.00, 13),
('FT024', '2024-11-10', 5, 9, 2.80, 25.20, 13),
('FT025', '2024-12-05', 41, 7, 3.00, 21.00, 13),
('FT025', '2024-12-05', 42, 9, 2.80, 25.20, 13),
('FT025', '2024-12-05', 43, 6, 3.00, 18.00, 13),
('FT025', '2024-12-05', 44, 8, 3.20, 25.60, 13),
('FT025', '2024-12-05', 45, 5, 2.50, 12.50, 13);

-- Store 14
INSERT INTO Sales (Sales_order_number, Sales_date, Product_ID, Quantity_sold, Unit_price, Sales_amount, Store_ID) VALUES
('FT001', '2024-02-15', 12, 7, 8.00, 56.00, 14),
('FT001', '2024-02-15', 15, 6, 6.00, 36.00, 14),
('FT001', '2024-02-15', 18, 10, 7.00, 70.00, 14),
('FT001', '2024-02-15', 42, 8, 16.50, 132.00, 14),
('FT001', '2024-02-15', 49, 9, 22.00, 198.00, 14),
('FT002', '2024-03-10', 11, 5, 12.00, 60.00, 14),
('FT002', '2024-03-10', 14, 8, 5.50, 44.00, 14),
('FT002', '2024-03-10', 19, 7, 10.00, 70.00, 14),
('FT002', '2024-03-10', 41, 10, 15.99, 159.90, 14),
('FT002', '2024-03-10', 45, 6, 20.99, 125.94, 14),
('FT003', '2024-04-05', 13, 6, 7.50, 45.00, 14),
('FT003', '2024-04-05', 17, 9, 15.00, 135.00, 14),
('FT003', '2024-04-05', 20, 10, 15.00, 150.00, 14),
('FT003', '2024-04-05', 44, 8, 19.99, 159.92, 14),
('FT003', '2024-04-05', 50, 12, 18.50, 222.00, 14),
('FT004', '2024-05-12', 11, 8, 12.00, 96.00, 14),
('FT004', '2024-05-12', 16, 5, 9.00, 45.00, 14),
('FT004', '2024-05-12', 19, 7, 10.00, 70.00, 14),
('FT004', '2024-05-12', 43, 9, 17.99, 161.91, 14),
('FT004', '2024-05-12', 48, 10, 21.50, 215.00, 14),
('FT005', '2024-06-22', 12, 10, 8.00, 80.00, 14),
('FT005', '2024-06-22', 15, 6, 6.00, 36.00, 14),
('FT005', '2024-06-22', 18, 9, 7.00, 63.00, 14),
('FT005', '2024-06-22', 41, 5, 15.99, 79.95, 14),
('FT005', '2024-06-22', 47, 8, 20.00, 160.00, 14),
('FT006', '2024-07-03', 13, 6, 7.50, 45.00, 14),
('FT006', '2024-07-03', 15, 9, 6.00, 54.00, 14),
('FT006', '2024-07-03', 20, 7, 15.00, 105.00, 14),
('FT006', '2024-07-03', 42, 8, 16.50, 132.00, 14),
('FT006', '2024-07-03', 49, 10, 22.00, 220.00, 14),
('FT007', '2024-08-14', 12, 8, 8.00, 64.00, 14),
('FT007', '2024-08-14', 17, 6, 15.00, 90.00, 14),
('FT007', '2024-08-14', 19, 10, 10.00, 100.00, 14),
('FT007', '2024-08-14', 43, 5, 17.99, 89.95, 14),
('FT007', '2024-08-14', 50, 9, 18.50, 166.50, 14),
('FT008', '2024-09-21', 11, 5, 12.00, 60.00, 14),
('FT008', '2024-09-21', 14, 7, 5.50, 38.50, 14),
('FT008', '2024-09-21', 18, 8, 7.00, 56.00, 14),
('FT008', '2024-09-21', 45, 6, 20.99, 125.94, 14),
('FT008', '2024-09-21', 48, 10, 21.50, 215.00, 14),
('FT009', '2024-10-30', 13, 9, 7.50, 67.50, 14),
('FT009', '2024-10-30', 16, 5, 9.00, 45.00, 14),
('FT009', '2024-10-30', 20, 12, 15.00, 180.00, 14),
('FT009', '2024-10-30', 41, 8, 15.99, 127.92, 14),
('FT009', '2024-10-30', 44, 6, 19.99, 119.94, 14),
('FT010', '2024-11-25', 12, 10, 8.00, 80.00, 14),
('FT010', '2024-11-25', 14, 6, 5.50, 33.00, 14),
('FT010', '2024-11-25', 17, 9, 15.00, 135.00, 14),
('FT010', '2024-11-25', 46, 5, 21.00, 105.00, 14),
('FT010', '2024-11-25', 50, 8, 18.50, 148.00, 14),
('FT011', '2024-12-01', 11, 6, 12.00, 72.00, 14),
('FT011', '2024-12-01', 15, 7, 6.00, 42.00, 14),
('FT011', '2024-12-01', 19, 8, 10.00, 80.00, 14),
('FT011', '2024-12-01', 42, 9, 16.50, 148.50, 14),
('FT011', '2024-12-01', 47, 5, 20.00, 100.00, 14),
('FT012', '2024-12-15', 12, 5, 8.00, 40.00, 14),
('FT012', '2024-12-15', 14, 9, 5.50, 49.50, 14),
('FT012', '2024-12-15', 16, 8, 9.00, 72.00, 14),
('FT012', '2024-12-15', 43, 6, 17.99, 107.94, 14),
('FT012', '2024-12-15', 50, 10, 18.50, 185.00, 14),
('FT013', '2025-01-02', 13, 7, 7.50, 52.50, 14),
('FT013', '2025-01-02', 18, 6, 7.00, 42.00, 14),
('FT013', '2025-01-02', 20, 10, 15.00, 150.00, 14),
('FT013', '2025-01-02', 41, 5, 15.99, 79.95, 14),
('FT013', '2025-01-02', 46, 9, 21.00, 189.00, 14),
('FT014', '2024-06-07', 11, 8, 12.00, 96.00, 14),
('FT014', '2024-06-07', 17, 5, 15.00, 75.00, 14),
('FT014', '2024-06-07', 19, 7, 10.00, 70.00, 14),
('FT014', '2024-06-07', 45, 10, 20.99, 209.90, 14),
('FT014', '2024-06-07', 48, 6, 21.50, 129.00, 14),
('FT015', '2024-09-18', 12, 10, 8.00, 80.00, 14),
('FT015', '2024-09-18', 15, 6, 6.00, 36.00, 14),
('FT015', '2024-09-18', 18, 9, 7.00, 63.00, 14),
('FT015', '2024-09-18', 42, 5, 16.50, 82.50, 14),
('FT015', '2024-09-18', 49, 8, 22.00, 176.00, 14);

-- Store 15
INSERT INTO Sales (Sales_order_number, Sales_date, Product_id, Quantity_sold, Unit_price, Sales_amount, Store_id) VALUES
('FT001', '2024-01-05', 11, 6, 10.00, 60.00, 15),
('FT001', '2024-01-06', 15, 8, 12.00, 96.00, 15),
('FT001', '2024-01-07', 13, 5, 15.00, 75.00, 15),
('FT001', '2024-01-08', 18, 7, 9.00, 63.00, 15),
('FT001', '2024-01-09', 45, 9, 8.00, 72.00, 15),
('FT002', '2024-02-01', 12, 10, 11.00, 110.00, 15),
('FT002', '2024-02-02', 14, 6, 13.00, 78.00, 15),
('FT002', '2024-02-03', 16, 8, 14.00, 112.00, 15),
('FT002', '2024-02-04', 41, 5, 7.50, 37.50, 15),
('FT002', '2024-02-05', 44, 7, 6.50, 45.50, 15),
('FT003', '2024-02-10', 19, 11, 9.50, 104.50, 15),
('FT003', '2024-02-11', 11, 9, 10.00, 90.00, 15),
('FT003', '2024-02-12', 13, 7, 15.00, 105.00, 15),
('FT003', '2024-02-13', 17, 6, 12.00, 72.00, 15),
('FT003', '2024-02-14', 47, 8, 5.00, 40.00, 15),
('FT004', '2024-02-20', 15, 5, 12.50, 62.50, 15),
('FT004', '2024-02-21', 18, 8, 9.50, 76.00, 15),
('FT004', '2024-02-22', 50, 9, 14.00, 126.00, 15),
('FT004', '2024-02-23', 41, 7, 7.00, 49.00, 15),
('FT004', '2024-02-24', 46, 6, 10.00, 60.00, 15),
('FT005', '2024-02-28', 11, 12, 10.00, 120.00, 15),
('FT005', '2024-03-01', 19, 9, 9.50, 85.50, 15),
('FT005', '2024-03-02', 14, 8, 13.00, 104.00, 15),
('FT005', '2024-03-03', 43, 10, 8.50, 85.00, 15),
('FT005', '2024-03-04', 47, 5, 6.00, 30.00, 15),
('FT006', '2024-03-10', 12, 11, 11.50, 126.50, 15),
('FT006', '2024-03-11', 13, 6, 15.00, 90.00, 15),
('FT006', '2024-03-12', 50, 7, 14.00, 98.00, 15),
('FT006', '2024-03-13', 44, 8, 6.00, 48.00, 15),
('FT006', '2024-03-14', 18, 5, 9.00, 45.00, 15),
('FT007', '2024-03-15', 16, 10, 14.00, 140.00, 15),
('FT007', '2024-03-16', 42, 12, 7.00, 84.00, 15),
('FT007', '2024-03-17', 17, 9, 12.00, 108.00, 15),
('FT007', '2024-03-18', 48, 8, 9.00, 72.00, 15),
('FT007', '2024-03-19', 45, 7, 8.00, 56.00, 15),
('FT008', '2024-03-20', 20, 5, 11.00, 55.00, 15),
('FT008', '2024-03-21', 14, 8, 13.00, 104.00, 15),
('FT008', '2024-03-22', 50, 9, 10.50, 94.50, 15),
('FT008', '2024-03-23', 42, 6, 7.50, 45.00, 15),
('FT008', '2024-03-24', 49, 7, 9.00, 63.00, 15),
('FT009', '2024-03-25', 13, 8, 15.00, 120.00, 15),
('FT009', '2024-03-26', 17, 9, 14.00, 126.00, 15),
('FT009', '2024-03-27', 18, 7, 12.00, 84.00, 15),
('FT009', '2024-03-28', 48, 6, 9.00, 54.00, 15),
('FT009', '2024-03-29', 46, 11, 10.00, 110.00, 15),
('FT010', '2024-04-01', 16, 8, 14.50, 116.00, 15),
('FT010', '2024-04-02', 12, 7, 12.00, 84.00, 15),
('FT010', '2024-04-03', 50, 5, 10.50, 52.50, 15),
('FT010', '2024-04-04', 42, 9, 7.00, 63.00, 15),
('FT011', '2024-04-05', 11, 6, 10.00, 60.00, 15),
('FT011', '2024-04-06', 14, 10, 13.00, 130.00, 15),
('FT011', '2024-04-07', 19, 5, 9.50, 47.50, 15),
('FT011', '2024-04-08', 45, 8, 8.00, 64.00, 15),
('FT011', '2024-04-09', 50, 12, 10.00, 120.00, 15),
('FT012', '2024-04-10', 18, 7, 9.50, 66.50, 15),
('FT012', '2024-04-11', 16, 9, 14.00, 126.00, 15),
('FT012', '2024-04-12', 41, 5, 7.00, 35.00, 15),
('FT012', '2024-04-13', 43, 11, 8.50, 93.50, 15),
('FT012', '2024-04-14', 46, 8, 6.00, 48.00, 15),
('FT013', '2024-04-15', 12, 10, 11.00, 110.00, 15),
('FT013', '2024-04-16', 13, 6, 15.00, 90.00, 15),
('FT013', '2024-04-17', 42, 7, 7.50, 52.50, 15),
('FT013', '2024-04-18', 17, 9, 12.50, 112.50, 15),
('FT013', '2024-04-19', 49, 8, 9.00, 72.00, 15),
('FT014', '2024-04-20', 16, 7, 14.00, 98.00, 15),
('FT014', '2024-04-21', 45, 12, 8.00, 96.00, 15),
('FT014', '2024-04-22', 50, 6, 10.50, 63.00, 15),
('FT014', '2024-04-23', 42, 10, 7.00, 70.00, 15),
('FT014', '2024-04-24', 47, 8, 5.50, 44.00, 15),
('FT015', '2024-04-25', 13, 6, 15.00, 90.00, 15),
('FT015', '2024-04-26', 18, 8, 9.00, 72.00, 15),
('FT015', '2024-04-27', 19, 7, 9.50, 66.50, 15),
('FT015', '2024-04-28', 44, 12, 6.00, 72.00, 15),
('FT015', '2024-04-29', 46, 11, 10.00, 110.00, 15),
('FT016', '2024-05-01', 13, 8, 15.00, 120.00, 15),
('FT016', '2024-05-02', 44, 10, 6.50, 65.00, 15),
('FT016', '2024-05-03', 42, 12, 7.00, 84.00, 15),
('FT016', '2024-05-04', 47, 7, 5.50, 38.50, 15),
('FT016', '2024-05-05', 46, 6, 10.00, 60.00, 15),
('FT017', '2024-05-06', 11, 9, 10.00, 90.00, 15),
('FT017', '2024-05-07', 14, 7, 13.00, 91.00, 15),
('FT017', '2024-05-08', 17, 8, 12.50, 100.00, 15),
('FT017', '2024-05-09', 45, 5, 8.00, 40.00, 15),
('FT017', '2024-05-10', 42, 9, 7.00, 63.00, 15),
('FT018', '2024-05-11', 16, 6, 14.50, 87.00, 15),
('FT018', '2024-05-12', 12, 8, 11.00, 88.00, 15),
('FT018', '2024-05-13', 50, 9, 10.50, 94.50, 15),
('FT018', '2024-05-14', 49, 7, 9.00, 63.00, 15),
('FT018', '2024-05-15', 44, 5, 6.50, 32.50, 15),
('FT019', '2024-05-16', 41, 10, 7.00, 70.00, 15),
('FT019', '2024-05-17', 19, 9, 9.50, 85.50, 15),
('FT019', '2024-05-18', 44, 8, 6.00, 48.00, 15),
('FT019', '2024-05-19', 47, 6, 6.50, 39.00, 15),
('FT019', '2024-05-20', 50, 7, 10.50, 73.50, 15),
('FT020', '2024-05-21', 15, 8, 12.00, 96.00, 15),
('FT020', '2024-05-22', 42, 10, 7.50, 75.00, 15),
('FT020', '2024-05-23', 49, 6, 9.00, 54.00, 15),
('FT020', '2024-05-24', 48, 5, 8.00, 40.00, 15),
('FT020', '2024-05-25', 44, 9, 6.50, 58.50, 15);
Select * from Sales;

