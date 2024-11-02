select * from Sales_Dataset;

--retrieve the total sales for each product category.
SELECT 
  Product,
  SUM(Quantity * UnitPrice) AS TotalSales
FROM 
  Sales_Dataset
GROUP BY 
  Product
ORDER BY 
  TotalSales DESC;

--find the number of sales transactions in each region.
SELECT 
  Region,
  COUNT(OrderID) AS NumberOfSalesTransactions
FROM 
  Sales_Dataset
GROUP BY 
  Region
ORDER BY 
  NumberOfSalesTransactions DESC;

--find the highest-selling product by total sales value.
SELECT TOP 1 
  Product,
  SUM(Quantity * UnitPrice) AS TotalSales
FROM 
  Sales_Dataset
GROUP BY 
  Product
ORDER BY 
 TotalSales DESC;

--calculate total revenue per product.
SELECT 
  Product,
  SUM(Quantity * UnitPrice) AS TotalRevenue
FROM 
  Sales_Dataset
GROUP BY 
  Product
ORDER BY 
  TotalRevenue DESC;

---calculate monthly sales totals for the current year.
SELECT 
  MONTH(OrderDate) AS MonthNumber,
  DATENAME(MONTH, OrderDate) AS MonthName,
  SUM(Quantity * UnitPrice) AS MonthlySales
FROM 
  Sales_Dataset
WHERE 
  YEAR(OrderDate) = YEAR(GETDATE())
GROUP BY 
  MONTH(OrderDate), DATENAME(MONTH, OrderDate)
ORDER BY 
  MonthNumber;

---find the top 5 customers by total purchase amount.
SELECT TOP 5 
  Customer_ID,
  SUM(Quantity * UnitPrice) AS TotalPurchaseAmount
FROM 
  Sales_Dataset
GROUP BY 
  Customer_ID
ORDER BY 
  TotalPurchaseAmount DESC;

---calculate the percentage of total sales contributed by each region.
SELECT 
  Region,
  SUM(Quantity * UnitPrice) AS RegionalSales,
  (SUM(Quantity * UnitPrice) * 1.0 / (SELECT SUM(Quantity * UnitPrice) FROM Sales_Dataset)) * 100 AS SalesPercentage
FROM 
  Sales_Dataset
GROUP BY 
  Region
ORDER BY 
  RegionalSales DESC;

  --identify products with no sales in the last quarter.
SELECT DISTINCT 
  Product
FROM 
  Sales_Dataset
WHERE 
  Product NOT IN (
    SELECT 
      Product
    FROM 
      Sales_Dataset
    WHERE 
      OrderDate >= DATEADD(quarter, -1, GETDATE())
  );
