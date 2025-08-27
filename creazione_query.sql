-- ESECUZIONE DELLE QUERY RICHIESTE 
-- - 1)Ogni qual volta un prodotto viene venduto in un negozio, qual è la query da eseguire per aggiornare le tabelle di riferimento?

-- metodo 1:
UPDATE Inventory i
JOIN WarehouseStores ws ON ws.warehouse_id = i.warehouse_id
JOIN Sales sa ON sa.product_id = i.product_id AND sa.store_id = ws.store_id
SET i.quantity = i.quantity - sa.quantity_sold
WHERE sa.id = 1403;
-- metodo 2 :
-- si non hai id sales e vuoi aggiornare la il stock ms devi sapere il store e quantita e il prodotto
SET @product_id = 101;
SET @quantity_sold = 5;
SET @store_id = 1;

UPDATE Inventory i
JOIN WarehouseStores ws ON ws.warehouse_id = i.warehouse_id
SET i.Quantity = i.Quantity - @quantity_sold
WHERE i.Product_id = @product_id
  AND ws.Store_id = @store_id;

select * from inventory;
select * from products;
select * from warehouses;
--  2)Quali sono le query da eseguire per verificare quante unità di un prodotto ci sono in un dato magazzino?

-- METODO 1 -- Mostra il singolo prodotto per singolo magazzino
SELECT i.warehouse_id, p.name AS product_name, SUM(i.quantity) AS total_quantity,ws.Name
FROM products p
JOIN inventory i ON i.product_id = p.id
join warehouses ws on i.Warehouse_id = ws.ID
WHERE i.warehouse_id = 3 AND i.product_id = 42
GROUP BY i.warehouse_id, p.name;

-- METODO 2 -- Mostra più prodotti selezionati per più magazzini selezionati
SELECT i.warehouse_id, p.name AS product_name, SUM(i.quantity) AS total_quantity
FROM inventory i
JOIN products p ON i.product_id = p.id
WHERE i.warehouse_id in (1,4) AND i.product_id in (42, 43)
GROUP BY i.warehouse_id, p.name;

-- metodo 3 :  mostra tutti prodotti in tutti magazzini
SELECT p.name,ws.name,SUM(i.quantity)
FROM products p
JOIN inventory i ON i.product_id = p.id
JOIN warehouses ws ON i.warehouse_id = ws.ID
GROUP BY p.name, ws.name;


-- 3) Quali sono le query da eseguire per monitorare le soglie di restock?
-- METODO 1
-- inserimenti ulteriori per tabella monitoraggio soglie restock
insert into sales (sales_order_number, sales_date, product_id, quantity_sold, unit_price, sales_amount, store_id) values
('FT016', '2024-09-19', 49, 20, 22.00, 440.00, 14),
('FT017', '2024-09-20', 49, 15, 22.00, 330.00, 14),
('FT018', '2024-09-21', 49, 25, 22.00, 550.00, 14),
('FT019', '2024-09-22', 49, 18, 22.00, 396.00, 14),
('FT020', '2024-09-23', 49, 12, 22.00, 264.00, 14),
('FT021', '2024-09-24', 49, 10, 22.00, 220.00, 14),
('FT022', '2024-09-25', 49, 15, 22.00, 330.00, 14),
('FT008', '2024-07-14', 30, 40, 2.20, 88.00, 3),
('FT011', '2024-03-01', 7, 50, 2.00, 100.00, 7);
Select * from Sales;

-- aggiornamento quantità in magazzino per id sales riferiti a inserimenti riga 2193
UPDATE inventory i
JOIN warehouses w ON i.warehouse_id = w.id
JOIN warehousestores ws ON w.id = ws.warehouse_id
JOIN stores s ON ws.store_id = s.id
JOIN sales sa ON sa.product_id = i.product_id AND sa.store_id = s.id
SET i.quantity = i.quantity - sa.quantity_sold
WHERE sa.id = 1402;

UPDATE inventory i
JOIN warehouses w ON i.warehouse_id = w.id
JOIN warehousestores ws ON w.id = ws.warehouse_id
JOIN stores s ON ws.store_id = s.id
JOIN sales sa ON sa.product_id = i.product_id AND sa.store_id = s.id
SET i.quantity = i.quantity - sa.quantity_sold
WHERE sa.id in (1434, 1435, 1436, 1437, 1438, 1439, 1440, 1441);
select * from inventory;
select * from restocklevels;

-- Quali sono le query da eseguire per verificare quante unità di un prodotto ci sono in un dato magazzino riferito agli inserimenti alla riga 2193
start transaction;
SELECT i.warehouse_id, p.name AS product_name, SUM(i.quantity) AS total_quantity
FROM inventory i
JOIN products p ON i.product_id = p.id
WHERE i.warehouse_id in (1, 2, 4) AND i.product_id in (30, 7, 49)
GROUP BY i.warehouse_id, p.name;

-- RISPOSTA > Quali sono le query da eseguire per monitorare le soglie di restock?
-- metodo 1:
SELECT i.warehouse_id, p.ID, p.name AS product_name, SUM(i.quantity) AS total_quantity, Restocklevels.Restock_level
FROM inventory i
JOIN products p ON i.product_id = p.id
join restocklevels on p.id = restocklevels.product_id
WHERE i.warehouse_id in (1, 2, 4)
GROUP BY i.warehouse_id, p.id, p.name, restocklevels.restock_level
HAVING SUM(i.quantity) < restocklevels.restock_level;

-- METODO 2 :SULLA BASE DEL RAGIONAMENTO INIZIATO A RIGA 2193
SELECT p.id, p.Name,r.warehouse_id, w.Name, i.Quantity, r.Restock_level 
FROM RestockLevels r
JOIN Products p ON r.Product_id = p.ID
JOIN Warehouses w ON r.Warehouse_id = w.ID
JOIN Inventory i ON r.Product_id = i.Product_id AND r.Warehouse_id = i.Warehouse_id
WHERE i.Quantity < r.Restock_level;

-- METODO 3 SULLA BASE DEL RAGIONAMENTO INIZIATO A RIGA 2193
SELECT i.warehouse_id, p.ID, p.name AS product_name, SUM(i.quantity) AS total_quantity, rl.restock_level 
FROM inventory i
JOIN products p ON i.product_id = p.id
JOIN restocklevels rl ON p.id = rl.product_id AND i.warehouse_id = rl.warehouse_id
WHERE i.warehouse_id = 1
GROUP BY i.warehouse_id, p.id, p.name, rl.restock_level
HAVING SUM(i.quantity) < rl.restock_level;