#SALES TABLE
#inserting without converting price and date to decimal and date format
insert into Sales (Product_id,date,price,quantity)
select Products.Id as id,
       sales_csv.date as Sales_date,
       sales_csv.price as Sales_price,
       sales_csv.quantity as Qty 
from sales_csv,Products 
where Products.Name=sales_csv.stock_item




#inserting with converted price from string to decimal
insert into sales (product_id,date,price,quantity)
SELECT products.id AS theID,
	   sales_csv.date AS theDate, 
	   CAST( REPLACE( SUBSTRING( sales_csv.price, 2 ) ,  ',',  '.' ) AS DECIMAL( 10, 2 ) ) AS thePrice,
	   sales_csv.quantity AS theQuantity
FROM sales_csv, products
WHERE products.name = sales_csv.stock_item




 
#inserting with converted price and date from string to date format
insert into sales (product_id,date,price,quantity)
SELECT products.id AS theID,
       STR_TO_DATE(CONCAT(sales_csv.date,'-2015'),'%e-%b-%Y') AS theDate, 
       CAST( REPLACE( SUBSTRING( sales_csv.price, 2 ) ,  ',',  '.' ) AS DECIMAL( 10, 2 ) ) AS thePrice, 
       sales_csv.quantity AS theQuantity
FROM sales_csv, products
WHERE products.name = sales_csv.stock_item


#SUPPLIERS TABLE
insert into suppliers (name)
select distinct purchases_csv.supplier from purchases_csv 






#STOCK_PURCHASESTABLE
select stock.date,stock.price,stock.supplier_id,products.id as Product_id from 
(
    SELECT STR_TO_DATE(CONCAT(purchases_csv.date,'-2015'),'%e-%b-%Y') AS DATE,
    	   CAST( REPLACE( SUBSTRING( purchases_csv.cost, 2 ) ,  ',',  '.' ) AS DECIMAL( 10, 2 ) ) AS Price,
           suppliers.id AS Supplier_id,
           purchases_csv.product AS Product
    FROM purchases_csv, suppliers 
WHERE purchases_csv.supplier = suppliers.name
) 
stock,products
where stock.product = products.name
