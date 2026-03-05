--1- Find the number of orders sent by each shipper.
SELECT S.CompanyName, COUNT(O.OrderID)Totalorders
FROM Orders O
JOIN Shippers S 
ON O.ShipVia = S.ShipperID
GROUP BY S.CompanyName;

--2- Find the number of orders sent by each shipper, sent by each employee
SELECT S.CompanyName,E.FirstName,E.LastName,COUNT(O.OrderID)TotalOrder
FROM Orders  O
JOIN Shippers S
ON o.ShipVia = s.ShipperID
JOIN Employees E
ON E.EmployeeID=O.EmployeeID
GROUP BY S.CompanyName,E.FirstName,E.LastName

--3- Find  name  of  employees who has registered more than 100 orders.
SELECT E.FirstName+' '+E.LastName EmployeeName,COUNT(O.OrderID)TotalOrders
FROM Orders O
JOIN Employees E
ON E.EmployeeID=O.EmployeeID
GROUP BY E.FirstName+' '+E.LastName
HAVING COUNT(O.OrderID)>100

--4-Find if the employees "Davolio" or "Fuller" have registered more than 25 orders.
SELECT EmployeeID,COUNT(OrderID)TotalOrders
FROM Orders
WHERE EmployeeID IN (
    SELECT EmployeeID
	FROM Employees
	WHERE LastName IN ('Davolio' , 'Fuller')
	)
	GROUP BY EmployeeID
	HAVING COUNT(OrderID)>25;


--5-Find the customer_id and name of customers who had placed orders more than one time and 
-- how many times they have placed the order
SELECT CustomerID,COUNT(OrderID)TotalOrder
FROM  Orders
GROUP BY CustomerID
HAVING COUNT(OrderID)>1;


--6-Select all the orders where the employee’s city and order’s ship city are same.
SELECT O.OrderID,O.ShipCity,E.City
FROM Orders O
JOIN Employees E 
ON O.EmployeeID =E.EmployeeID
WHERE O.ShipCity=E.City;


--7-Create a report that shows the order ids and the associated employee names for orders that shipped after the required date.
SELECT o.OrderID,e.FirstName,e.LastName
FROM Orders o
JOIN Employees e
ON o.EmployeeID = e.EmployeeID
WHERE o.ShippedDate>o.RequiredDate;


--8-Create a report that shows the total quantity of products ordered fewer than 200.
SELECT p.ProductName,SUM(od.Quantity)TotalQuantity
FROM [Order Details] od
JOIN Products P
ON od.ProductID=p.ProductID
GROUP BY p.ProductName
HAVING SUM(od.Quantity)<200;


--9-Create a report that shows the total number of orders by Customer since December 31, 1996 and the NumOfOrders is greater than 15. 
SELECT CustomerID, COUNT(OrderID)NumOfOrders
FROM Orders
WHERE OrderDate > '1996-12-31'
GROUP BY CustomerID
HAVING COUNT(OrderID) > 15;


--10-Create a report that shows the company name, order id, and total price of all products of which Northwind
-- has sold more than $10,000 worth.
SELECT c.CompanyName, o.OrderID, SUM(od.UnitPrice * od.Quantity)TotalPrice
FROM Orders o
JOIN Customers c 
ON o.CustomerID = c.CustomerID
JOIN [Order Details] od 
ON o.OrderID = od.OrderID
GROUP BY c.CompanyName, o.OrderID
HAVING SUM(od.UnitPrice * od.Quantity) > 10000;


--11-Create a report showing the Order ID, the name of the company that placed the order,
--and the first and last name of the associated employee. Only show orders placed after January 1, 1998 
--that shipped after they were required. Sort by Company Name.
SELECT o.OrderID, c.CompanyName, e.FirstName, e.LastName
FROM Orders o
JOIN Customers c
 ON o.CustomerID = c.CustomerID
JOIN Employees e 
ON o.EmployeeID = e.EmployeeID
WHERE o.OrderDate > '1998-01-01' AND o.ShippedDate > o.RequiredDate
ORDER BY c.CompanyName;


--12-Get the phone numbers of all shippers, customers, and suppliers

SELECT 'Shipper' AS Type, CompanyName, Phone 
FROM Shippers
UNION
SELECT 'Customer' AS Type, CompanyName, Phone 
FROM Customers
UNION
SELECT 'Supplier' AS Type, CompanyName, Phone 
FROM Suppliers;

--13-Create a report showing the contact name and phone numbers for all employees,customers, and suppliers.
SELECT 'Employee' AS Type, (FirstName+' '+LastName)ContactName, HomePhone  Phone 
FROM Employees
UNION
SELECT 'Customer' AS Type, ContactName, Phone 
FROM Customers
UNION
SELECT 'Supplier' AS Type, ContactName, Phone 
FROM Suppliers;


--14-Fetch all the orders for a given customer’s phone number 030-0074321.
SELECT Orders.* 
FROM Orders
JOIN Customers 
ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.Phone = '030-0074321';

--15-Fetch all the products which are available under Category ‘Seafood’.
SELECT Products.*
FROM Products
JOIN Categories 
ON Products.CategoryID = Categories.CategoryID
WHERE Categories.CategoryName = 'Seafood';

--16-Fetch all the products which are supplied by a company called ‘Pavlova, Ltd.’
SELECT Products.*
FROM Products
JOIN Suppliers
ON Products.SupplierID = Suppliers.SupplierID
WHERE Suppliers.CompanyName = 'Pavlova, Ltd.';


--17-All orders placed by the customers belong to London city.
SELECT Orders.*
FROM Orders
JOIN Customers 
ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.City = 'London';

--18-All orders placed by the customers not belong to London city.
SELECT Orders.*
FROM Orders
JOIN Customers 
ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.City <> 'London';


--19-All the orders placed for the product Chai.
SELECT Orders.*
FROM Orders
JOIN [Order Details]
ON Orders.OrderID = [Order Details].OrderID
JOIN Products 
ON [Order Details].ProductID = Products.ProductID
WHERE Products.ProductName = 'Chai';

--20-Find the name of the company that placed order 10290.
SELECT C.CompanyName
FROM Orders O
JOIN Customers C
ON O.CustomerID = C.CustomerID
WHERE O.OrderID = 10290;

--21-Find the Companies that placed orders in 1997
SELECT DISTINCT C.CompanyName
FROM Orders O
JOIN Customers C
ON O.CustomerID = C.CustomerID
WHERE YEAR(OrderDate) = 1997;


--22-Get the product name , count of orders processed 
SELECT P.ProductName, COUNT(O.OrderID)OrderCount
FROM [Order Details] O
JOIN Products P
ON O.ProductID = P.ProductID
GROUP BY P.ProductName;

--23-Get the top 3 products which has more orders
SELECT TOP 3 P.ProductName, COUNT(O.OrderID)OrderCount
FROM [Order Details] O
JOIN Products P
ON O.ProductID = P.ProductID
GROUP BY P.ProductName
ORDER BY OrderCount DESC;

--24-Get the list of employees who processed the order “chai”
SELECT DISTINCT E.FirstName, E.LastName
FROM Orders O
JOIN [Order Details] OD
ON O.OrderID = O.OrderID
JOIN Products P
ON OD.ProductID = P.ProductID
JOIN Employees E
ON O.EmployeeID = E.EmployeeID
WHERE P.ProductName = 'Chai';

--25-Get the shipper company who processed the order categories “Seafood” 
SELECT DISTINCT S.CompanyName
FROM Orders O
JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
JOIN Products P
ON OD.ProductID = P.ProductID
JOIN Categories C
ON P.CategoryID = C.CategoryID
JOIN Shippers S
ON O.ShipVia = S.ShipperID
WHERE C.CategoryName = 'Seafood';

--26-Get category name , count of orders processed by the USA employees
SELECT C.CategoryName, COUNT(O.OrderID)OrderCount
FROM Orders O
JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
JOIN Products P
ON OD.ProductID = P.ProductID
JOIN Categories C
ON P.CategoryID = C.CategoryID
JOIN Employees E
ON O.EmployeeID = E.EmployeeID
WHERE E.Country = 'USA'
GROUP BY C.CategoryName;

--27-Select CategoryName and Description from the Categories table sorted by CategoryName.
SELECT CategoryName, Description
FROM Categories
ORDER BY CategoryName;

--28-Select ContactName, CompanyName, ContactTitle, and Phone from the Customers table sorted byPhone.
SELECT ContactName, CompanyName, ContactTitle, Phone
FROM Customers
ORDER BY Phone;

--29-Create a report showing employees' first and last names and hire dates sorted from newest to oldest employee
SELECT FirstName, LastName, HireDate
FROM Employees
ORDER BY HireDate DESC;

--30-Create a report showing Northwind's orders sorted by Freight from most expensive to cheapest. Show OrderID, 
--OrderDate, ShippedDate, CustomerID, and Freight
SELECT OrderID, OrderDate, ShippedDate, CustomerID, Freight
FROM Orders
ORDER BY Freight DESC;

--31-Select CompanyName, Fax, Phone, HomePage and Country from the Suppliers table sorted by Country in descending 
--order and then by CompanyName in ascending order
SELECT CompanyName, Fax, Phone, HomePage, Country
FROM Suppliers
ORDER BY Country DESC, CompanyName ASC;

--32-Create a report showing all the company names and contact names of Northwind's customers in Buenos Aires
SELECT CompanyName, ContactName
FROM Customers
WHERE City = 'Buenos Aires';

--33-Create a report showing the product name, unit price and quantity per unit of all products that are out of stock
SELECT ProductName, UnitPrice, QuantityPerUnit
FROM Products
WHERE UnitsInStock = 0;

--34-Create a report showing the order date, shipped date, customer id, and freight of all orders placed on May 19, 1997
SELECT OrderDate, ShippedDate, CustomerID, Freight
FROM Orders
WHERE OrderDate = '1997-05-19';

--35-Create a report showing the first name, last name, and country of all employees not in the United States.
SELECT FirstName, LastName, Country
FROM Employees
WHERE Country <> 'USA';

--36-Create a report that shows the city, company name, and contact name of all customers who are in cities that begin with "A" or "B."
SELECT City, CompanyName, ContactName
FROM Customers
WHERE City LIKE 'A%' OR City LIKE 'B%';

--37-Create a report that shows all orders that have a freight cost of more than $500.00.
SELECT OrderID, OrderDate, Freight
FROM Orders
WHERE Freight > 500.00;

--38-Create a report that shows the product name, units in stock, units on order, and reorder level of all
-- products that are up for reorder
SELECT ProductName, UnitsInStock, UnitsOnOrder, ReorderLevel
FROM Products
WHERE UnitsInStock + UnitsOnOrder <= ReorderLevel;

--39-Create a report that shows the company name, contact name and fax number of all customers that have a fax number.
SELECT CompanyName, ContactName, Fax
FROM Customers
WHERE Fax IS NOT NULL;

--40-Create a report that shows the first and last name of all employees who do not report to anybody
SELECT FirstName, LastName
FROM Employees
WHERE ReportsTo IS NULL;

--41-Create a report that shows the company name, contact name and fax number of all customers that have a fax number, 
--Sort by company name.
SELECT CompanyName, ContactName, Fax
FROM Customers
WHERE Fax IS NOT NULL
ORDER BY CompanyName ASC;

--42-Create a report that shows the city, company name, and contact name of all customers who are in cities 
--that begin with "A" or "B." Sort by contact name in descending order
SELECT City, CompanyName, ContactName
FROM Customers
WHERE City LIKE 'A%' OR City LIKE 'B%'
ORDER BY ContactName DESC;

--43-Create a report that shows the first and last names and birth date of all employees born in the 1950s
SELECT FirstName, LastName, BirthDate
FROM Employees
WHERE BirthDate BETWEEN '1950-01-01' AND '1959-12-31';

--44-Create a report that shows the shipping postal code, order id, and order date for all orders with a ship postal code 
--beginning with "02389".
SELECT ShipPostalCode, OrderID, OrderDate
FROM Orders
WHERE ShipPostalCode LIKE '02389%';

--45-Create a report that shows the contact name and title and the company name for all customers whose contact title
-- does not contain the word "Sales".
SELECT ContactName, ContactTitle, CompanyName
FROM Customers
WHERE ContactTitle NOT LIKE '%Sales%';

--46-Create a report that shows the first and last names and cities of employees from cities other than Seattle
-- in the state of Washington.
SELECT FirstName, LastName, City
FROM Employees
WHERE City <> 'Seattle' AND Region = 'WA';


--47-Create a report that shows the company name, contact title, city and country of all customers in Mexico 
--or in any city in Spain except Madrid.
SELECT CompanyName, ContactTitle, City, Country
FROM Customers
WHERE Country = 'Mexico' OR (Country = 'Spain' AND City <> 'Madrid');

--48-List of Employees along with the Manager
SELECT e.FirstName  EmployeeFirstName, e.LastName  EmployeeLastName,
 m.FirstName  ManagerFirstName, m.LastName  ManagerLastName
FROM Employees e
LEFT JOIN Employees m 
ON e.ReportsTo = m.EmployeeID;

--49-List of Employees along with the Manager and his/her title
SELECT e.FirstName  EmployeeFirstName, e.LastName  EmployeeLastName,
 m.FirstName  ManagerFirstName,
 m.LastName  ManagerLastName, m.Title  ManagerTitle
FROM Employees e
LEFT JOIN Employees m 
ON e.ReportsTo = m.EmployeeID;

--50-Provide Agerage Sales per order
SELECT AVG(O.UnitPrice * O.Quantity)AverageSalesPerOrder
FROM [Order Details] O;

--51-Employee wise Agerage Freight
SELECT e.FirstName, e.LastName, AVG(o.Freight)AverageFreight
FROM Orders o
JOIN Employees e
ON o.EmployeeID = e.EmployeeID
GROUP BY e.FirstName, e.LastName;

--52-Agerage Freight per employee
SELECT AVG(O.Freight)AvgFreightPerEmployee
FROM Orders O
JOIN Employees E 
ON O.EmployeeID = E.EmployeeID;


--53-Average no. of orders per customer
SELECT AVG(OrderCount)AvgOrdersPerCustomer
FROM (
    SELECT COUNT(OrderID)OrderCount
    FROM Orders
    GROUP BY CustomerID
) AS OrdersPerCustomer;

--54-AverageSales per product within Category

SELECT C.CategoryName, P.ProductName, AVG(OD.UnitPrice * OD.Quantity)AvgSales
FROM [Order Details] OD
JOIN Products P 
ON OD.ProductID = P.ProductID
JOIN Categories C 
ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName, P.ProductName;

--55-PoductName which have more than 100 no.of UnitsinStock
SELECT ProductName
FROM Products
WHERE UnitsInStock > 100;


--56-Query to Provide Product Name and Sales Amount for Category Beverages
SELECT P.ProductName, SUM(OI.UnitPrice * OI.Quantity)SalesAmount
FROM [Order Details] OI
JOIN Products P 
ON OI.ProductID = P.ProductID
JOIN Categories C 
ON P.CategoryID = C.CategoryID
WHERE C.CategoryName = 'Beverages'
GROUP BY P.ProductName;

--57-Query That Will Give  CategoryWise Yearwise number of Orders
SELECT C.CategoryName, YEAR(O.OrderDate) AS OrderYear, COUNT(O.OrderID)OrderCount
FROM Orders O
JOIN [Order Details] OI
ON O.OrderID = OI.OrderID
JOIN Products P 
ON OI.ProductID = P.ProductID
JOIN Categories C 
ON P.CategoryID = C.CategoryID
GROUP BY C.CategoryName, YEAR(O.OrderDate);

--58-Query to Get ShipperWise employeewise Total Freight for shipped year 1997
SELECT S.CompanyName, E.FirstName + ' ' + E.LastName AS EmployeeName, SUM(O.Freight)TotalFreight
FROM Orders O
JOIN Shippers S 
ON O.ShipVia = S.ShipperID
JOIN Employees E 
ON O.EmployeeID = E.EmployeeID
WHERE YEAR(O.ShippedDate) = 1997
GROUP BY S.CompanyName, E.FirstName, E.LastName;

--59-Query That Gives Employee Full Name, Territory Description and Region Description
SELECT E.FirstName + ' ' + E.LastName AS FullName, 
T.TerritoryDescription, R.RegionDescription
FROM Employees E
JOIN EmployeeTerritories ET 
ON E.EmployeeID = ET.EmployeeID
JOIN Territories T 
ON ET.TerritoryID = T.TerritoryID
JOIN Region R 
ON T.RegionID = R.RegionID;

--60-Query That Will Give Managerwise Total Sales for each year 
SELECT M.FirstName + ' ' + M.LastName AS ManagerName, 
YEAR(O.OrderDate) AS OrderYear, SUM(OI.UnitPrice * OI.Quantity)TotalSales
FROM Orders O
JOIN [Order Details] OI
ON O.OrderID = OI.OrderID
JOIN Employees E 
ON O.EmployeeID = E.EmployeeID
JOIN Employees M 
ON E.ReportsTo = M.EmployeeID
GROUP BY M.FirstName, M.LastName, YEAR(O.OrderDate);

--61-Names of customers to whom we are sellinng less than average sales per cusotmer
WITH AvgSalesPerCustomer AS (
    SELECT AVG(TotalSales)AvgSales
    FROM (
        SELECT SUM(OI.UnitPrice * OI.Quantity)TotalSales
        FROM Orders O
        JOIN [Order Details] OI 
		ON O.OrderID = OI.OrderID
        GROUP BY O.CustomerID
    ) AS SalesPerCustomer
)
SELECT C.CompanyName
FROM Customers C
JOIN Orders O 
ON C.CustomerID = O.CustomerID
JOIN [Order Details] OI 
ON O.OrderID = OI.OrderID
GROUP BY C.CompanyName
HAVING SUM(OI.UnitPrice * OI.Quantity) < (SELECT AvgSales FROM AvgSalesPerCustomer);

--62-Query That Gives Average Freight Per Employee and Average Freight Per Customer
SELECT
    (SELECT AVG(Freight)
	 FROM Orders)AvgFreightPerCustomer,
    (SELECT AVG(Freight) 
	FROM Orders O 
	JOIN Employees E 
	ON O.EmployeeID = E.EmployeeID)AvgFreightPerEmployee;

--63-Query That Gives Category Wise Total Sale Where Category Total Sale < the Average Sale Per Category
WITH CategorySales AS (
    SELECT C.CategoryName, SUM(OI.UnitPrice * OI.Quantity)TotalSales
    FROM [Order Details] OI
    JOIN Products P 
	ON OI.ProductID = P.ProductID
    JOIN Categories C
	ON P.CategoryID = C.CategoryID
    GROUP BY C.CategoryName
)
SELECT C.CategoryName, C.TotalSales
FROM CategorySales C
WHERE C.TotalSales < (SELECT AVG(TotalSales) FROM CategorySales);

--64-Query That Provides Month No and Month OF Total Sales < Average Sale for Month for Year 1997
WITH MonthlySales AS (
    SELECT MONTH(O.OrderDate) AS Month, SUM(OI.UnitPrice * OI.Quantity)TotalSales
    FROM Orders O
    JOIN [Order Details] OI 
	ON O.OrderID = OI.OrderID
    WHERE YEAR(O.OrderDate) = 1997
    GROUP BY MONTH(O.OrderDate)
)
SELECT Month, TotalSales
FROM MonthlySales
WHERE TotalSales < (SELECT AVG(TotalSales) FROM MonthlySales);

--65-Find out the contribution of each employee towards the total sales done by Northwind for selected year
SELECT E.FirstName + ' ' + E.LastName AS EmployeeName, 
       SUM(OI.UnitPrice * OI.Quantity) / (SELECT SUM(OI.UnitPrice * OI.Quantity)
FROM [Order Details] OI 
JOIN Orders O 
ON OI.OrderID = O.OrderID 
WHERE YEAR(O.OrderDate) = 1997) * 100 AS ContributionPercentage
FROM Employees E
JOIN Orders O 
ON E.EmployeeID = O.EmployeeID
JOIN [Order Details] OI 
ON O.OrderID = OI.OrderID
WHERE YEAR(O.OrderDate) = 1997
GROUP BY E.FirstName, E.LastName;

--66-Give the Customer names that contribute 80% of the total sale done by Northwind for given year
WITH SalesByCustomer AS (
    SELECT c.CustomerID,c.CompanyName AS CustomerName,SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
    FROM Orders o
    JOIN [Order Details] od 
	ON o.OrderID = od.OrderID
    JOIN Customers c 
	ON o.CustomerID = c.CustomerID
    WHERE YEAR(o.OrderDate) = 1997 
    GROUP BY c.CustomerID, c.CompanyName
),
RankedSales AS (
    SELECT CustomerName,TotalSales,
        SUM(TotalSales) OVER (ORDER BY TotalSales DESC) AS CumulativeSales,
        SUM(TotalSales) OVER () AS TotalAnnualSales
    FROM SalesByCustomer
),
CumulativePercentage AS (
    SELECT CustomerName, TotalSales, CumulativeSales,TotalAnnualSales,
        (CumulativeSales * 100.0) / TotalAnnualSales AS CumulativePercentage
    FROM RankedSales
)
SELECT 
    CustomerName,TotalSales,CumulativePercentage
FROM CumulativePercentage
WHERE CumulativePercentage <= 80
ORDER BY CumulativePercentage;

--67-Top 3 performing employees by freight cost for given year
SELECT TOP 3 EmployeeID, SUM(Freight) AS TotalFreight
FROM Orders
WHERE YEAR(OrderDate) = 1997
GROUP BY EmployeeID
ORDER BY TotalFreight DESC;


--68-Find the bottom 5 customers per product based on Sales Amount

WITH CustomerSales AS (
    SELECT o.CustomerID,SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
    FROM Orders o
    JOIN [Order Details] od 
	ON o.OrderID = od.OrderID
    GROUP BY o.CustomerID
),
RankedSales AS (
    SELECT CustomerID,TotalSales,RANK() OVER (ORDER BY TotalSales ASC) AS Rank
    FROM CustomerSales
)
SELECT 
    CustomerID,TotalSales
FROM RankedSales
WHERE Rank <= 5
ORDER BY TotalSales;


--69-Display first and the last row of the table
SELECT TOP 1 * 
FROM [Order Details] 
ORDER BY OrderID ASC;


SELECT TOP 1 *
FROM [Order Details]
ORDER BY OrderID DESC;

--70-Display employee doing highest sale and lowest sale in each year
WITH EmployeeSales AS (
    SELECT YEAR(o.OrderDate) AS SaleYear,e.EmployeeID,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
    FROM Orders o
    JOIN [Order Details] od
	 ON o.OrderID = od.OrderID
    JOIN Employees e 
	ON o.EmployeeID = e.EmployeeID
    GROUP BY YEAR(o.OrderDate), e.EmployeeID
)
SELECT  SaleYear,EmployeeID,TotalSales
FROM (
    SELECT SaleYear,EmployeeID,TotalSales,
        RANK() OVER (PARTITION BY SaleYear ORDER BY TotalSales DESC) AS MaxRank,
        RANK() OVER (PARTITION BY SaleYear ORDER BY TotalSales ASC) AS MinRank
    FROM EmployeeSales
) RankedSales
WHERE MaxRank = 1 OR MinRank = 1;


--71-Top 3 products of each employee by sales for given year
WITH ProductSalesByEmployee AS (
    SELECT o.EmployeeID, od.ProductID,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
    FROM Orders o
    JOIN [Order Details] od 
	ON o.OrderID = od.OrderID
    WHERE YEAR(o.OrderDate) = 1997 
    GROUP BY o.EmployeeID, od.ProductID
),
RankedProducts AS (
    SELECT EmployeeID,ProductID,TotalSales,
        RANK() OVER (PARTITION BY EmployeeID ORDER BY TotalSales DESC) AS Rank
    FROM ProductSalesByEmployee
)
SELECT EmployeeID, ProductID, TotalSales
FROM RankedProducts
WHERE Rank <= 3;

--72-Query That Will Give territorywise number of Orders for given region for given year
SELECT 
    t.TerritoryID,
    COUNT(o.OrderID)OrderCount
FROM Orders o
JOIN Employees e 
ON o.EmployeeID = e.EmployeeID
JOIN EmployeeTerritories et 
ON e.EmployeeID = et.EmployeeID
JOIN Territories t 
ON et.TerritoryID = t.TerritoryID
WHERE t.RegionID = RegionID AND YEAR(o.OrderDate) = 1997
GROUP BY t.TerritoryID;

--73-Display sales amount by category for given year
SELECT 
    c.CategoryName,
    SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))TotalSales
FROM Orders o
JOIN [Order Details] od 
ON o.OrderID = od.OrderID
JOIN Products p 
ON od.ProductID = p.ProductID
JOIN Categories c 
ON p.CategoryID = c.CategoryID
WHERE YEAR(o.OrderDate) =1997 
GROUP BY c.CategoryName;

--74-Find  name  of customers who has registered orders less than 10 times.
SELECT CustomerID, COUNT(OrderID)OrderCount
FROM Orders
GROUP BY CustomerID
HAVING COUNT(OrderID) < 10;

--75-Regions with the Sale in the range of +/- 30% of average sale per Region for year 1997...
WITH RegionSales AS (
    SELECT  t.RegionID,SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
    FROM Orders o
    JOIN [Order Details] od
	 ON o.OrderID = od.OrderID
    JOIN Employees e 
	ON o.EmployeeID = e.EmployeeID
    JOIN EmployeeTerritories et 
	ON e.EmployeeID = et.EmployeeID
    JOIN Territories t 
	ON et.TerritoryID = t.TerritoryID
    WHERE YEAR(o.OrderDate) = 1997
    GROUP BY t.RegionID
)
SELECT RegionID,TotalSales
FROM RegionSales
WHERE TotalSales BETWEEN 0.7 * (SELECT AVG(TotalSales) FROM RegionSales)
                     AND 1.3 * (SELECT AVG(TotalSales) FROM RegionSales);

--76-Top 5 countries based on Order Count for year 1998...
SELECT TOP 5  o.ShipCountry, COUNT(o.OrderID)OrderCount
FROM Orders o
WHERE YEAR(o.OrderDate) = 1998
GROUP BY o.ShipCountry
ORDER BY OrderCount DESC;

--77-Category-wise Sale along with deviation % wrt average sale per category for year 1996...
WITH CategorySales AS (
    SELECT c.CategoryName,SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))TotalSales
    FROM Orders o
    JOIN [Order Details] od
	 ON o.OrderID = od.OrderID
    JOIN Products p 
	ON od.ProductID = p.ProductID
    JOIN Categories c
	 ON p.CategoryID = c.CategoryID
    WHERE YEAR(o.OrderDate) = 1996
    GROUP BY c.CategoryName
),
CategoryAvgSales AS (
    SELECT AVG(TotalSales)AvgSales
    FROM CategorySales
)
SELECT  CategoryName, TotalSales,
    ((TotalSales - (SELECT AvgSales FROM CategoryAvgSales)) / (SELECT AvgSales FROM CategoryAvgSales)) * 100 AS DeviationPercent
FROM CategorySales;

--78-Count of orders by Customers which are shipped in the same month as ordered...
SELECT 
    o.CustomerID,COUNT(o.OrderID) AS OrderCount
FROM Orders o
WHERE MONTH(o.OrderDate) = MONTH(o.ShippedDate)
  AND YEAR(o.OrderDate) = YEAR(o.ShippedDate)
GROUP BY o.CustomerID;

--79-Average Demand Days per Order per country for year 1997...
SELECT o.ShipCountry,AVG(DATEDIFF(DAY, o.OrderDate, o.ShippedDate))AvgDemandDays
FROM Orders o
WHERE YEAR(o.OrderDate) = 1997
GROUP BY o.ShipCountry;

--80-Create the report as Country, Classification, Product Count, Average Sale per Product, Threshold... 

--Classification will be based on Sales and as follows -
--Top if the sale is 1.5 times the average sale per product...
--Excellent if the sale is between 1.2 and 1.5 times the average sale per product...
--Acceptable if the sale is between 0.8 to 1.2 time the average sale per product...
--Need Improvement if the sale is 0.5 to 0.8 times the average sale per product...
--Discontinue for remaining products...
--Produce this report for year 1998..
WITH ProductNumberSales AS (
    SELECT 
        YEAR(ORD.OrderDate) AS Years,
        ORD.ShipCountry AS Country,
        PROD.ProductName AS Product,
        COUNT(OD.ProductID) AS NoOfProducts, 
        ROUND(SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)), 2) AS Sales
    FROM Orders AS ORD
    JOIN [Order Details] AS OD ON ORD.OrderID = OD.OrderID
    JOIN Products AS PROD ON OD.ProductID = PROD.ProductID
    GROUP BY YEAR(ORD.OrderDate), ORD.ShipCountry, PROD.ProductName
    HAVING YEAR(ORD.OrderDate) = 1998
), AverageSales AS (
    SELECT 
        Country,
        ROUND(AVG(Sales), 2) AS AvgSales
    FROM ProductNumberSales
    GROUP BY Country
), Comparison AS (
    SELECT 
        PNS.*, 
        AVS.AvgSales, 
        ROUND((PNS.Sales / AVS.AvgSales), 2) AS Ratio
    FROM ProductNumberSales AS PNS
    JOIN AverageSales AS AVS ON PNS.Country = AVS.Country
), TopTable AS (
    SELECT 
        *, 
        'Top' AS Classification  
    FROM Comparison
    WHERE Comparison.Ratio >= 1.5
), ExcellentTable AS (
    SELECT 
        *, 
        'Excellent' AS Classification  
    FROM Comparison
    WHERE Comparison.Ratio < 1.5 AND Comparison.Ratio >= 1.2
), AcceptableTable AS (
    SELECT 
        *, 
        'Acceptable' AS Classification  
    FROM Comparison
    WHERE Comparison.Ratio < 1.2 AND Comparison.Ratio >= 0.8
), ImprovementTable AS (
    SELECT 
        *, 
        'Improvement Needed' AS Classification  
    FROM Comparison
    WHERE Comparison.Ratio < 0.8 AND Comparison.Ratio >= 0.5
)
SELECT * 
FROM TopTable
UNION
SELECT * 
FROM ExcellentTable
UNION
SELECT * 
FROM AcceptableTable
UNION
SELECT * 
FROM ImprovementTable
ORDER BY Country, Sales DESC;  


--81-Top 30% products in each Category by their Sale for year 1997...
WITH ProductSales AS (
    SELECT 
        p.CategoryID,
        p.ProductID,
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS TotalSales
    FROM Orders o
    JOIN [Order Details] od ON o.OrderID = od.OrderID
    JOIN Products p ON od.ProductID = p.ProductID
    WHERE YEAR(o.OrderDate) = 1997
    GROUP BY p.CategoryID, p.ProductID
)
SELECT 
    CategoryID,
    ProductID,
    TotalSales
FROM ProductSales
WHERE TotalSales > (SELECT AVG(TotalSales) FROM ProductSales);

--82-Bottom 40% countries by the Freight for year 1997 along with the Freight to Sale ratio in %...
SELECT 
    ORD.ShipCountry AS Country,
    SUM(ORD.Freight) AS TotalFreight,
    SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) AS TotalSales,
    ROUND((SUM(ORD.Freight) / SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount))) * 100, 2) AS FreightToSaleRatio
FROM Orders ORD
JOIN [Order Details] OD ON ORD.OrderID = OD.OrderID
WHERE YEAR(ORD.OrderDate) = 1997
GROUP BY ORD.ShipCountry
ORDER BY FreightToSaleRatio DESC
OFFSET 0 ROWS FETCH NEXT (SELECT COUNT(*) / 5 FROM Orders) ROWS ONLY;


--83-Countries contributing to 50% of the total sale for the year 1997...
WITH TotalSales AS (
    SELECT SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) AS AllSales
    FROM Orders ORD
    JOIN [Order Details] OD ON ORD.OrderID = OD.OrderID
    WHERE YEAR(ORD.OrderDate) = 1997
)
SELECT 
    ORD.ShipCountry AS Country,
    SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) AS TotalSales,
    ROUND((SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) / (SELECT AllSales FROM TotalSales)) * 100, 2) AS ContributionPercentage
FROM Orders ORD
JOIN [Order Details] OD ON ORD.OrderID = OD.OrderID
WHERE YEAR(ORD.OrderDate) = 1997
GROUP BY ORD.ShipCountry
ORDER BY ContributionPercentage DESC;


--84-Top 5 repeat customers for each country in year 1997...
WITH CustomerOrders AS (
    SELECT 
        ORD.ShipCountry AS Country,
        ORD.CustomerID,
        COUNT(ORD.OrderID) AS OrderCount
    FROM Orders ORD
    WHERE YEAR(ORD.OrderDate) = 1997
    GROUP BY ORD.ShipCountry, ORD.CustomerID
    HAVING COUNT(ORD.OrderID) > 1
)
SELECT TOP 5
    Country,
    CustomerID,
    OrderCount
FROM CustomerOrders
WHERE OrderCount > 1
ORDER BY Country, OrderCount DESC;


--85- Week over Week Order Count and change % over previous week for year 1997 as Week Number,
-- Week Start Date, Week End Date, Order Count, Change %

 WITH WeeklyOrderCount AS (
    SELECT 
        DATEPART(ISO_WEEK, ORD.OrderDate) AS WeekNumber,
        COUNT(ORD.OrderID) AS OrderCount,
        MIN(ORD.OrderDate) AS WeekStartDate,
        MAX(ORD.OrderDate) AS WeekEndDate
    FROM Orders ORD
    WHERE YEAR(ORD.OrderDate) = 1997
    GROUP BY DATEPART(ISO_WEEK, ORD.OrderDate)
)
SELECT 
    WeekNumber,
    WeekStartDate,
    WeekEndDate,
    OrderCount,
    LAG(OrderCount) OVER (ORDER BY WeekNumber) AS PrevWeekOrderCount,
    CASE 
        WHEN LAG(OrderCount) OVER (ORDER BY WeekNumber) IS NULL THEN NULL
        ELSE ROUND(((OrderCount - LAG(OrderCount) OVER (ORDER BY WeekNumber)) * 100.0) / LAG(OrderCount) OVER (ORDER BY WeekNumber), 2)
    END AS ChangePercentage
FROM WeeklyOrderCount
ORDER BY WeekNumber;

