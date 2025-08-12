# Task 1 - Create an ER diagram for the Amazon Fresh database to understand the relationships between tables (e.g., Customers, Products, Orders).
  # ERD Created. 
  
# Task 2 -  Identify the primary keys and foreign keys for each table and describe their relationships.
 # Explained in PPT. 
 
# Task 3 - Write a query to: 
  #Task 3.a - Retrieve all customers from a specific city.
Select* From customers; # we looked into the table 
   select*
   FROM Customers
   Where City = 'Oregon';
   
    #Task 3.b - Retrieve all customers from a specific city.

Select* From products; # we looked into the table 

Select* from products
where category = 'Fruits';

# Task 4 - recreate customer table with customerID as primary key, age is = or above 18 and with only unique names 

CREATE TABLE customersnew (
  customerid INT,
  name VARCHAR(100),
  age INT
);

# Adding data to the new table 
SELECT customerid,name,age
FROM customers 
WHERE age IS NOT NULL AND age > 18
  AND name IN (
      SELECT name
      FROM customers
      GROUP BY name
      HAVING COUNT(*) = 1);

 Select* From customersnew; # Reveiwing the new table that we created
 
 # Task 5 - Adding 3 rows into the product table.
 
 Select* From Products; # Retreaving the table.
 
 # Adding the requested rows into the table. 
 INSERT INTO Products (productid, productname, category, subcategory, priceperunit, stockquantity, supplierID)
VALUES 
  ('1f23a4c1-45df-4bda-94bb-823c2911f1a4', 'Nature Snack', 'Snacks', 'Sub-Snacks-3', 499, 180, '7b3c66df-f582-4912-a68c-1e2ab49ad48e'),
  ('a7bc0f99-b9b5-4826-9c27-49b42b9c7dcb', 'Golden Fruit', 'Fruits', 'Sub-Fruits-2', 389, 85, '3cc3a347-dc21-4ed8-90e2-3d53deee244b'),
  ('eb218cb0-4e58-4c02-8a5f-b9df22147257', 'Fresh Baker', 'Bakery', 'Sub-Bakery-2', 699, 102, '8d29a3cb-bf89-4e12-9433-7794d71b38fa');

# Task 6 - Count the stock quantity for a particular ProductID.

# Choose 1 ProductID 

SELECT count(*)
FROM Products
WHERE productId = 'e9282403-e234-4e35-a711-50acb03bbecc' AND stockquantity = 259;

#Update the quantity to 270

UPDATE Products
SET stockquantity = 270
WHERE ProductID = 'e9282403-e234-4e35-a711-50acb03bbecc';

# Checking if it is updated or not.
Select* From Products;

#Task 7 -  Delete a supplier from the Suppliers table where their city matches a specific value.
#retreaving suppliers table 

Select * From Suppliers;

#Counting the number of supplies from a particular city
Select count(*)
From Suppliers
Where City = 'Smithburgh';

#Deleting the particular row. 
Delete
From Suppliers
Where City = 'Smithburgh';

#Checking if it got deleted.
Select count(*)
From Suppliers
Where City = 'Smithburgh';

#Task 8 - Checking and constraining the Ratings and Primemembers Column.

#Reviewing the table.
Select* From Reviews;

#8.a Constraining the rating from 1 to 5 only. 
Alter table reviews
Add check (Rating between 1 and 5);

#Checking the table.
Select* From Reviews;

#8.b Defaulting the primemembers to only no.

#Reviewing the table.
Select* From customers;

#Applying default query.
ALTER TABLE Customers
ALTER COLUMN PrimeMember SET DEFAULT 'No';

#To check and verify we are adding a new row to the data, and will apply the query again to check the same. (Last row is where name is Yvonne Nichols)

INSERT INTO Customers (
    CustomerID, Name, Age, Gender, City, State, Country, Signupdate)
VALUES (
    '68ec07ff-c21f-4b44-b55f-69f5f05caaf7',
    'Vivek Rao',
    53,
    'Male',
    'Lake Johnmouth',
    'Alabama',
    'India',
    '2021-05-25'
);

#Checking the customer.
SELECT * 
FROM Customers
WHERE CustomerID = '68ec07ff-c21f-4b44-b55f-69f5f05caaf7';

#As checked due to the default query it automatically added 'NO' as the primemeber.

#Task 9 - 9.a Find orders placed after 2024-01-01.

#Retreaving the orders table. 
Select* From Orders;

#Running query. 
SELECT *
FROM Orders
WHERE OrderDate > '2024-01-01';

# 9.b - List products whose average ratings are greater than 4.

#Retreaving reviews table. 
Select* From Reviews;

#Running the query.
SELECT ProductID, AVG(Rating) AS AvgRating
FROM Reviews
GROUP BY ProductID
HAVING AVG(Rating) > 4;

# 9.c - Rank products by total sales (highest to lowest).

#Retreaving reviews table. 
Select* From order_details;

#Running the query. 
SELECT ProductID, SUM(Quantity) AS TotalSales
FROM Order_Details
GROUP BY ProductID
ORDER BY TotalSales DESC; 

# Task 10 - 10.a Calculate each customer's total spending.

#Retreving the table. 
Select* From orders;

#Running the query. 
SELECT 
    CustomerID,
    SUM(OrderAmount) AS TotalSpending
FROM orders
GROUP BY CustomerID;

# 10.b Rank customers based on their spending.

#Running the query. 
SELECT 
    CustomerID,
    SUM(OrderAmount) AS TotalSpending,
    RANK() OVER (ORDER BY SUM(OrderAmount) DESC) AS SpendingRank
FROM orders
GROUP BY CustomerID;

# 10.c Identify customers who have spent more than ₹5,000.

#Running the query 

SELECT 
    CustomerID,
    SUM(OrderAmount) AS TotalSpending
FROM orders
GROUP BY CustomerID
HAVING SUM(OrderAmount) > 5000
ORDER BY TotalSpending DESC;

# Task 11 - 11.a - Join the Orders and OrderDetails tables to calculate total revenue per order.
#retreiving tables. 
Select* From Orders;
Select* From order_details;

#running the query. 
SELECT 
    o.OrderID,
    SUM(od.Quantity * od.UnitPrice * (1 - od.Discount / 100.0)) AS TotalRevenue
FROM orders o
JOIN order_details od ON o.OrderID = od.OrderID
GROUP BY o.OrderID;

# 11.b - Identify customers who placed the most orders in a specific time period.
#Retreiving the table.
Select* From Orders;

#Running the query. 
SELECT 
    CustomerID,
    COUNT(OrderID) AS NumberOfOrders
FROM orders
WHERE OrderDate BETWEEN '2025-01-01' AND '2025-07-31'
GROUP BY CustomerID
ORDER BY NumberOfOrders DESC;

# 11.c - Find the supplier with the most products in stock.
#Retreiving the table. 
Select* From products;

#Running the Query. 
SELECT 
    SupplierID,
    SUM(stockquantity) AS TotalUnitsInStock
FROM products
GROUP BY SupplierID
ORDER BY TotalUnitsInStock DESC;

#Task 12 - Normalize the Products table to 3NF:
  
#Retreiving table. 
Select* From Products;

  # 12.a Separate product categories and subcategories into a new table.
  CREATE TABLE Categories (
    Category VARCHAR(255) UNIQUE NOT NULL primary key
    productname varchar (50),
    Priceperunit int 
);

# Task 12 - Normalize the Products table to 3NF:
   #12.a - Separate product categories and subcategories into a new table.
# We have created view in which we exracted the category and subcategory as table and named it as newcategory.

Create view Newcategory as
Select category,subcategory
from products;

Select* From newcategory;

#12.b - Moving forward when we look into the product table and the newcategory table it is clear that we have subcategory as the foregien key.

# Task 13 - Write a subquery to:
#Retreving the table. 
Select* From Products;

   # 13.a Identify the top 3 products based on sales revenue.
SELECT ProductID, TotalRevenue
FROM (
    SELECT ProductID, 
           SUM(Quantity * UnitPrice * (1 - Discount / 100.0)) AS TotalRevenue
    FROM order_details
    GROUP BY ProductID
    ORDER BY TotalRevenue DESC
    LIMIT 3
) AS TopProducts;
  
# 13.b Find customers who haven’t placed any orders yet.
  #Retreving the Table.
Select* From Customers;

SELECT *
FROM customers
WHERE CustomerID NOT IN (
    SELECT DISTINCT CustomerID
    FROM orders
);

#Task 14 - Actionable Insights
   # Retreving the table. 
Select* From Customers;

 # 14.a - Cities with Highest Concentration of Prime Members. 
 SELECT City, COUNT(*) AS PrimeMemberCount
FROM customers
WHERE PrimeMember = 'Yes'
GROUP BY City
ORDER BY PrimeMemberCount DESC
LIMIT 5;

 # 14.b - Top 3 Most Frequently Ordered Categories
 SELECT p.Category, COUNT(od.OrderID) AS OrderCount
FROM order_details od
JOIN products p ON od.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY OrderCount DESC
LIMIT 3;

