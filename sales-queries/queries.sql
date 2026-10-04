-- Query 1
-- gets all purchases, including customer code, invoice number, invoice date, product description, units purchased, and ppu
-- sorted by customer code, then invoice number, THEN by product description
SELECT customer.Cus_Code, invoice.Inv_Number, invoice.Inv_Date, product.P_Descript, line.Line_Units, line.Line_Price
FROM customer
JOIN invoice ON customer.Cus_Code = invoice.Cus_Code
JOIN line ON invoice.Inv_Number = line.Inv_Number
JOIN product ON line.P_Code = product.P_Code
ORDER BY customer.Cus_Code, invoice.Inv_Number, product.P_Descript;

-- Query 2
-- calculates subtotal for each thing in line with multiplying Line_Units by Line_Price
-- tehn displays customer code, invoice number, product description, units bought, unit price, and then the calculated subtotal

SELECT customer.Cus_Code, invoice.Inv_Number, product.P_Descript AS "P_Description",
       line.Line_Units AS "Units Bought", line.Line_Price AS "Unit Price",
       (line.Line_Units * line.Line_Price) AS "Subtotal"
FROM customer
JOIN invoice ON customer.Cus_Code = invoice.Cus_Code
JOIN line ON invoice.Inv_Number = line.Inv_Number
JOIN product ON line.P_Code = product.P_Code;

-- Query 3
-- first displays customer last name, first name, invoice number, product desc, units bought, unit price, and then subtotal again
-- replaced querry 2 cuscode
SELECT customer.Cus_LName AS "Last Name", customer.Cus_FName AS "First Name", 
       invoice.Inv_Number AS "Invoice Number", product.P_Descript AS "Product Description", 
       line.Line_Units AS "Units Bought", line.Line_Price AS "Unit Price", 
       (line.Line_Units * line.Line_Price) AS "Subtotal"
FROM customer
JOIN invoice ON customer.Cus_Code = invoice.Cus_Code
JOIN line ON invoice.Inv_Number = line.Inv_Number
JOIN product ON line.P_Code = product.P_Code;


-- Query 4
-- displays customers last name, first name, current balance, and total amount they have spent again
-- results grouped by each customer
SELECT customer.Cus_LName AS "Last Name", customer.Cus_FName AS "First Name", 
       customer.Cus_Balance AS "Balance", 
       SUM(line.Line_Units * line.Line_Price) AS "Total Purchases"
FROM customer
JOIN invoice ON customer.Cus_Code = invoice.Cus_Code
JOIN line ON invoice.Inv_Number = line.Inv_Number
GROUP BY customer.Cus_Code;

-- Query 5
-- replaced query 4 with num perchaches of each customer
-- this shows customer last name, first name, current balance, total amount spent, and num of purchases s
-- again grouped by each customer.
SELECT customer.Cus_LName AS "Last Name", customer.Cus_FName AS "First Name", 
       customer.Cus_Balance AS "Balance", 
       SUM(line.Line_Units * line.Line_Price) AS "Total Purchases",
       COUNT(invoice.Inv_Number) AS "Number of Purchases"
FROM customer
JOIN invoice ON customer.Cus_Code = invoice.Cus_Code
JOIN line ON invoice.Inv_Number = line.Inv_Number
GROUP BY customer.Cus_Code;


-- Query 6
-- add on from 5 to include avg purchase amount 
-- get customer last name, first name, total purchases, total number of purchases, and avg purchase amount (total purchases / number of purchases)
SELECT customer.Cus_LName AS "Customer Last Name", customer.Cus_FName AS "Customer First Name",
       SUM(line.Line_Units * line.Line_Price) AS "Total Purchases",
       COUNT(invoice.Inv_Number) AS "Number of Purchases",
       AVG(line.Line_Units * line.Line_Price) AS "Average Purchase Amount"
FROM customer
JOIN invoice ON customer.Cus_Code = invoice.Cus_Code
JOIN line ON invoice.Inv_Number = line.Inv_Number
GROUP BY customer.Cus_Code;


-- Query 7
-- new query type, many aliases
-- gives total number of invoices, total sales amount, smallest purchase amount, largest purchase amount, AND avg purchase amount for all invoices
SELECT COUNT(DISTINCT invoice.Inv_Number) AS "Total Number of Invoices",
       SUM(line.Line_Units * line.Line_Price) AS "Total Sales Amount",
       MIN(line.Line_Units * line.Line_Price) AS "Smallest Purchase Amount",
       MAX(line.Line_Units * line.Line_Price) AS "Largest Purchase Amount",
       AVG(line.Line_Units * line.Line_Price) AS "Average Purchase Amount"
FROM invoice
JOIN line ON invoice.Inv_Number = line.Inv_Number;

-- Query 8
-- pulls last name, first name, and phone number of all customers who never made purchase
-- LEFT JOIN used to puit all customers. WHERE confims that only customers without invoice records are shown
--  names are displayed in "Last Name, First Name" format
SELECT customer.Cus_LName AS "Last Name", customer.Cus_FName AS "First Name", customer.Cus_Phone AS "Phone Number"
FROM customer
LEFT JOIN invoice ON customer.Cus_Code = invoice.Cus_Code
WHERE invoice.Inv_Number IS NULL;

-- Query 9
-- makes total value of products by X quantity on hand by unit price
-- shows the product description, quantity on hand, unit price, and the subtotals
SELECT product.P_Descript AS "Product Description", 
       product.P_QOH AS "Quantity on Hand", 
       product.P_Price AS "Unit Price", 
       (product.P_QOH * product.P_Price) AS "Subtotal"
FROM product;

-- Query 10
-- gets num of products supplied by each vendor & retrieves the vendor with the highest product count in order
-- ties are done with subquery to find the maximum product count
SELECT vendor.V_NAME AS "Vendor Name", COUNT(product.P_CODE) AS "Total Products"
FROM vendor
JOIN product ON vendor.V_CODE = product.V_CODE
GROUP BY vendor.V_NAME
HAVING COUNT(product.P_CODE) = (
    SELECT MAX(ProductCount) 
    FROM (
        SELECT COUNT(product.P_CODE) AS ProductCount
        FROM product
        GROUP BY product.V_CODE
    ) AS Subquery
);