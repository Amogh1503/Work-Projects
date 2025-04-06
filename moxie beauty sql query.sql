CREATE TABLE Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL,
    Description TEXT
);

CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Address TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Suppliers (
    SupplierID INT AUTO_INCREMENT PRIMARY KEY,
    SupplierName VARCHAR(100) NOT NULL,
    ContactName VARCHAR(100),
    ContactEmail VARCHAR(100),
    Phone VARCHAR(15),
    Address TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    CategoryID INT,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    SupplierID INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    CustomerID INT NOT NULL,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    ReviewDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Inventory (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY,
    ProductID INT NOT NULL,
    QuantityInStock INT NOT NULL,
    ReorderLevel INT,
    LastRestockDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Shipping (
    ShippingID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ShippingMethod VARCHAR(50),
    ShippingCost DECIMAL(10, 2),
    ShippingAddress TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10),
    ShippedDate DATE,
    DeliveryDate DATE);
    
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    PaymentMethod VARCHAR(50),
    PaymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(10, 2) NOT NULL,
    TransactionID VARCHAR(100));
    
CREATE TABLE Discounts (
    DiscountID INT AUTO_INCREMENT PRIMARY KEY,
    DiscountCode VARCHAR(50) UNIQUE NOT NULL,
    Description TEXT,
    DiscountAmount DECIMAL(10, 2),
    DiscountPercentage DECIMAL(5, 2),
    StartDate DATE,
    EndDate DATE,
    Active BOOLEAN DEFAULT TRUE
);

CREATE TABLE UserRoles (
    RoleID INT AUTO_INCREMENT PRIMARY KEY,
    RoleName VARCHAR(50) NOT NULL,
    Description TEXT
);

CREATE TABLE Employees (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Position VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10, 2),
    RoleID INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (RoleID) REFERENCES UserRoles(RoleID)
);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    Status ENUM('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    ShippingID INT,
    PaymentID INT,
    DiscountID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ShippingID) REFERENCES Shipping(ShippingID),
    FOREIGN KEY (PaymentID) REFERENCES Payments(PaymentID),
    FOREIGN KEY (DiscountID) REFERENCES Discounts(DiscountID)
);

alter table orders
rename column Status to OrderStatus;

Alter table orders
drop column OrderStatus;

Alter table orders
Add column OrderStatus varchar(50);

CREATE TABLE OrderDetails (
    OrderDetailID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Categories (CategoryID, CategoryName, Description) VALUES
(1, 'Accessories', 'Various hair care accessories including scalp massagers'),
(2, 'Conditioner', 'Ultra-hydrating and nourishing conditioners'),
(3, 'Hair finishing stick', 'Products for quick and easy hair styling'),
(4, 'Hair Oil', 'Nourishing hair oils with natural ingredients'),
(5, 'Hair Wax Stick', 'Wax sticks for styling and shaping hair'),
(6, 'Heat Protection Spray', 'Sprays to protect hair from heat damage'),
(7, 'Shampoo', 'Shampoos for different hair needs'),
(8, 'Styling', 'Serums and gels for hair styling and frizz control');
select * from categories;

INSERT INTO Suppliers (SupplierID, SupplierName, ContactName, ContactEmail, Phone, Address, City, State, ZipCode) VALUES
(1, 'CareEssentials', 'Liam Parker', 'liam.parker@careessentials.com', '1234567890', '456 Pine Street', 'Los Angeles', 'CA', '90001'),
(2, 'GlamourWorks', 'Sophia Martinez', 'sophia.martinez@glamourworks.com', '0987654321', '789 Maple Avenue', 'Chicago', 'IL', '60601'),
(3, 'HairGlow', 'Emma Thompson', 'emma.thompson@hairglow.com', '2345678901', '321 Birch Blvd', 'Miami', 'FL', '33101'),
(4, 'NatureLocks', 'James Brown', 'james.brown@naturelocks.com', '5678901234', '654 Cedar Drive', 'Seattle', 'WA', '98101'),
(5, 'StyleSphere', 'Olivia Green', 'olivia.green@stylesphere.com', '3456789012', '987 Aspen Circle', 'Denver', 'CO', '80201'),
(6, 'HeatGuard', 'Noah White', 'noah.white@heatguard.com', '4567890123', '159 Redwood Lane', 'Boston', 'MA', '02101'),
(7, 'SilkyHairCo', 'Ava Davis', 'ava.davis@silkyhairco.com', '8901234567', '741 Spruce Road', 'San Francisco', 'CA', '94101'),
(8, 'FrizzFree', 'Mia Wilson', 'mia.wilson@frizzfree.com', '1230984567', '258 Willow Street', 'Austin', 'TX', '73301'),
(9, 'FlexiHair', 'Liam Moore', 'liam.moore@flexihair.com', '6789012345', '963 Redwood Blvd', 'Portland', 'OR', '97201'),
(10, 'EcoLocks', 'Sophia Taylor', 'sophia.taylor@ecolocks.com', '8907654321', '456 Elm Drive', 'New York', 'NY', '10001');
select * from suppliers;

INSERT INTO Products (ProductID, ProductName, CategoryID, Price, Stock, SupplierID) VALUES
(1, 'Scalp Massager', 1, 15.99, 300, 1),
(2, 'Ultra-Hydrating Conditioner', 2, 12.49, 500, 2),
(3, 'On-the-Fly Hair Finishing Stick', 3, 10.99, 400, 3),
(4, 'Cocoa, Hemp & Almond Hair Oil', 4, 18.99, 350, 4),
(5, 'The Headliner Wax Styling Stick', 5, 14.99, 200, 5),
(6, 'Firefighter Heat Protection Spray', 6, 19.99, 250, 6),
(7, 'Gentle Cleansing Shampoo', 7, 11.99, 450, 7),
(8, 'Frizz-Fighting Hair Serum', 8, 22.99, 300, 8),
(9, 'Flexi Styling Serum Gel', 8, 17.49, 275, 9),
(10, 'Deluxe Hair Care Set', 1, 99.99, 150, 10);
select * from products;

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, Phone, Address, City, State, ZipCode) VALUES
(1, 'Emily', 'Johnson', 'emily.johnson@example.com', '1234567890', '456 Maple Street', 'New York', 'NY', '10001'),
(2, 'Michael', 'Smith', 'michael.smith@example.com', '0987654321', '789 Birch Lane', 'Chicago', 'IL', '60601'),
(3, 'Sophia', 'Brown', 'sophia.brown@example.com', '1230984567', '321 Cedar Drive', 'Miami', 'FL', '33101'),
(4, 'Liam', 'Taylor', 'liam.taylor@example.com', '2345678901', '654 Aspen Circle', 'Seattle', 'WA', '98101'),
(5, 'Olivia', 'Green', 'olivia.green@example.com', '5678901234', '987 Willow Road', 'Denver', 'CO', '80201'),
(6, 'Noah', 'Wilson', 'noah.wilson@example.com', '3456789012', '159 Redwood Lane', 'Austin', 'TX', '73301'),
(7, 'Emma', 'Martinez', 'emma.martinez@example.com', '4567890123', '258 Spruce Blvd', 'San Francisco', 'CA', '94101'),
(8, 'James', 'Clark', 'james.clark@example.com', '8901234567', '741 Birch Drive', 'Portland', 'OR', '97201'),
(9, 'Mia', 'Anderson', 'mia.anderson@example.com', '6789012345', '963 Maple Way', 'Boston', 'MA', '02101'),
(10, 'Ava', 'Moore', 'ava.moore@example.com', '8907654321', '456 Elm Blvd', 'Los Angeles', 'CA', '90001');
select * from customers;

INSERT INTO UserRoles (RoleID, RoleName, Description)
VALUES 
(1, 'Admin', 'Administrative user with full access'),
(2, 'Manager', 'Managerial user with limited access'),
(3, 'Sales Associate', 'Handles sales and customer inquiries'),
(4, 'Inventory Specialist', 'Manages stock and inventory'),
(5,'Customer Support', 'Handles customer issues and complaints'),
(6,'Marketing Coordinator', 'Plans and executes marketing campaigns'),
(7,'IT Specialist', 'Maintains IT systems and troubleshooting'),
(8,'Delivery Driver', 'Delivers products to customers'),
(9,'Receptionist', 'Manages front desk operations'),
(10,'Senior Manager', 'Responsible for managerial decision making and overseeing operations');
select * from userroles;

INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Phone, Position, HireDate, Salary, RoleID)
VALUES
(101,'James', 'Adams', 'james.adams@example.com', '1234567890', 'Manager', '2020-01-01', 60000, 2),
(102,'Laura', 'Smith', 'laura.smith@example.com', '2345678901', 'Sales Associate', '2021-03-15', 40000, 3),
(103,'Robert', 'Jones', 'robert.jones@example.com', '3456789012', 'Inventory Specialist', '2019-06-20', 45000, 4),
(104,'Emily', 'Clark', 'emily.clark@example.com', '4567890123', 'Customer Support', '2022-04-01', 35000, 5),
(105,'David', 'Brown', 'david.brown@example.com', '5678901234', 'Marketing Coordinator', '2020-10-10', 50000, 6),
(106,'Sophia', 'Taylor', 'sophia.taylor@example.com', '6789012345', 'Admin', '2018-05-15', 55000, 1),
(107,'Michael', 'Lee', 'michael.lee@example.com', '7890123456', 'IT Specialist', '2021-11-01', 48000, 7),
(108,'Sarah', 'Wilson', 'sarah.wilson@example.com', '8901234567', 'Senior Manager', '2022-07-20', 32000, 10),
(109,'Chris', 'Martin', 'chris.martin@example.com', '9012345678', 'Delivery Driver', '2021-08-25', 30000, 8),
(110,'Anna', 'Davis', 'anna.davis@example.com', '0123456789', 'Receptionist', '2019-12-10',31000,9);
select * from employees;

INSERT INTO Discounts (DiscountID, DiscountCode, Description, DiscountAmount, DiscountPercentage, StartDate, EndDate, Active)
VALUES 
(1, 'NEWYEAR10', 'New Year Discount', NULL, 10.00, '2024-01-01', '2024-01-31', TRUE),
(2, 'WELCOME5', 'Welcome Offer', 5.00, NULL, '2024-01-01', '2024-12-31', TRUE),
(3, 'SUMMER15', 'Summer Sale', NULL, 15.00, '2024-06-01', '2024-06-30', TRUE),
(4, 'FESTIVE20', 'Festive Offer', NULL, 20.00, '2024-12-01', '2024-12-31', TRUE),
(5, 'SPRING25', 'Spring Discount', 25.00, NULL, '2024-03-01', '2024-03-31', TRUE),
(6, 'BFCM30', 'Black Friday & Cyber Monday', NULL, 30.00, '2024-11-29', '2024-12-02', TRUE),
(7, 'HOLIDAY5', 'Holiday Special', 5.00, NULL, '2024-12-24', '2024-12-26', TRUE),
(8, 'FALL15', 'Fall Offer', NULL, 15.00, '2024-09-01', '2024-09-30', TRUE),
(9, 'VIP20', 'VIP Customer Discount', NULL, 20.00, '2024-01-01', '2024-12-31', TRUE),
(10, 'CLEARANCE10', 'Clearance Sale', NULL, 10.00, '2024-10-01', '2024-10-31', TRUE);
select * from discounts;

INSERT INTO Payments (PaymentID, OrderID, PaymentMethod, PaymentDate, Amount, TransactionID)
VALUES 
(1, 1, 'Credit Card', '2024-01-01 10:00:00', 59.97, 'TXN001'),
(2, 2, 'PayPal', '2024-01-02 11:00:00', 29.98, 'TXN002'),
(3, 3, 'Debit Card', '2024-01-03 12:00:00', 74.95, 'TXN003'),
(4, 4, 'Credit Card', '2024-01-04 13:00:00', 19.99, 'TXN004'),
(5, 5, 'PayPal', '2024-01-05 14:00:00', 89.95, 'TXN005'),
(6, 6, 'Debit Card', '2024-01-06 15:00:00', 39.98, 'TXN006'),
(7, 7, 'Credit Card', '2024-01-07 16:00:00', 124.95, 'TXN007'),
(8, 8, 'PayPal', '2024-01-08 17:00:00', 49.99, 'TXN008'),
(9, 9, 'Debit Card', '2024-01-09 18:00:00', 69.98, 'TXN009'),
(10, 10, 'Credit Card', '2024-01-10 19:00:00', 99.97, 'TXN010');
select * from payments;

INSERT INTO Shipping (ShippingID, OrderID, ShippingMethod, ShippingCost, ShippingAddress, City, State, ZipCode, ShippedDate, DeliveryDate)
VALUES 
(1, 1, 'Standard', 5.99, '123 Main St', 'New York', 'NY', '10001', '2024-01-01', '2024-01-05'),
(2, 2, 'Express', 9.99, '456 Oak Rd', 'Los Angeles', 'CA', '90001', '2024-01-02', '2024-01-03'),
(3, 3, 'Standard', 5.99, '789 Pine Ave', 'Chicago', 'IL', '60601', '2024-01-03', '2024-01-07'),
(4, 4, 'Express', 9.99, '321 Maple Blvd', 'Houston', 'TX', '77001', '2024-01-04', '2024-01-06'),
(5, 5, 'Standard', 5.99, '654 Birch Ct', 'Phoenix', 'AZ', '85001', '2024-01-05', '2024-01-09'),
(6, 6, 'Express', 9.99, '987 Cedar Ln', 'Philadelphia', 'PA', '19101', '2024-01-06', '2024-01-08'),
(7, 7, 'Standard', 5.99, '111 Elm Dr', 'San Antonio', 'TX', '78201', '2024-01-07', '2024-01-11'),
(8, 8, 'Express', 9.99, '222 Walnut Pkwy', 'San Diego', 'CA', '92101', '2024-01-08', '2024-01-10'),
(9, 9, 'Standard', 5.99, '333 Cherry Blvd', 'Dallas', 'TX', '75201', '2024-01-09', '2024-01-13'),
(10, 10, 'Express', 9.99, '444 Spruce Way', 'San Jose', 'CA', '95101', '2024-01-10', '2024-01-12');
select * from shipping;

INSERT INTO Inventory (InventoryID, ProductID, QuantityInStock, ReorderLevel, LastRestockDate)
VALUES 
(1, 1, 100, 10, '2024-01-01'),
(2, 2, 200, 20, '2024-01-02'),
(3, 3, 150, 15, '2024-01-03'),
(4, 4, 50, 5, '2024-01-04'),
(5, 5, 300, 30, '2024-01-05'),
(6, 6, 250, 25, '2024-01-06'),
(7, 7, 80, 8, '2024-01-07'),
(8, 8, 100, 10, '2024-01-08'),
(9, 9, 120, 12, '2024-01-09'),
(10, 10, 40, 4, '2024-01-10');
select * from inventory;

INSERT INTO Reviews (ReviewID, ProductID, CustomerID, Rating, Comment)
VALUES 
(1, 1, 1, 5, 'Amazing product!'),
(2, 2, 2, 4, 'Good value for money'),
(3, 3, 3, 3, 'Average quality'),
(4, 4, 4, 5, 'Excellent fragrance!'),
(5, 5, 5, 2, 'Not as expected'),
(6, 6, 6, 4, 'Very nice and affordable'),
(7, 7, 7, 5, 'Highly recommended!'),
(8, 8, 8, 3, 'Okay, but could be better'),
(9, 9, 9, 4, 'Good for daily use'),
(10, 10, 10, 5, 'Perfect as a gift!');
select * from reviews;

INSERT INTO Orders (OrderID, CustomerID, TotalAmount, OrderStatus, ShippingID, PaymentID, DiscountID)
VALUES 
(1, 1, 59.97, 'Processing', 1, 1, NULL),
(2, 2, 29.98, 'Pending', 2, 2, NULL),
(3, 3, 74.95, 'Shipped', 3, 3, 1),
(4, 4, 19.99, 'Delivered', 4, 4, NULL),
(5, 5, 89.95, 'Processing', 5, 5, 2),
(6, 6, 39.98, 'Pending', 6, 6, NULL),
(7, 7, 124.95, 'Processing', 7, 7, 3),
(8, 8, 49.99, 'Shipped', 8, 8, NULL),
(9, 9, 69.98, 'Processing', 9, 9, 4),
(10, 10, 99.97, 'Pending', 10, 10, NULL);
select * from orders;

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price)
VALUES 
(1, 1, 1, 2, 39.98),
(2, 1, 2, 1, 19.99),
(3, 2, 3, 3, 29.97),
(4, 3, 4, 1, 29.99),
(5, 4, 5, 5, 24.95),
(6, 5, 6, 3, 23.97),
(7, 6, 7, 4, 99.96),
(8, 7, 8, 1, 5.99),
(9, 8, 9, 2, 79.98),
(10, 9, 10, 2, 99.98);
select * from orderdetails;

SELECT 
    p.ProductID, 
    p.ProductName, 
    c.CategoryName, 
    p.Price, 
    p.Stock
FROM 
    Products p
JOIN 
    Categories c ON p.CategoryID = c.CategoryID;

SELECT 
    p.ProductName, 
    SUM(od.Quantity * od.Price) AS TotalRevenue
FROM 
    OrderDetails od
JOIN 
    Products p ON od.ProductID = p.ProductID
GROUP BY 
    p.ProductID, p.ProductName
ORDER BY 
    TotalRevenue DESC;
    
SELECT 
    o.OrderID, 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, 
    o.TotalAmount, 
    o.OrderStatus, 
    s.ShippingMethod, 
    s.ShippingCost, 
    s.DeliveryDate
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID
JOIN 
    Shipping s ON o.ShippingID = s.ShippingID
ORDER BY 
    o.OrderID DESC;
    
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, 
    SUM(o.TotalAmount) AS TotalSpent
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID
GROUP BY 
    c.CustomerID
ORDER BY 
    TotalSpent DESC
LIMIT 5;

SELECT 
    p.ProductName, 
    AVG(r.Rating) AS AverageRating, 
    COUNT(r.ReviewID) AS ReviewCount
FROM 
    Reviews r
JOIN 
    Products p ON r.ProductID = p.ProductID
GROUP BY 
    p.ProductID, p.ProductName
HAVING 
    AVG(r.Rating) >= 4.5
ORDER BY 
    AverageRating DESC, ReviewCount DESC;
    
SELECT 
    d.DiscountCode, 
    d.Description, 
    COUNT(o.DiscountID) AS TimesUsed
FROM 
    Discounts d
LEFT JOIN 
    Orders o ON d.DiscountID = o.DiscountID
GROUP BY 
    d.DiscountID, d.DiscountCode, d.Description
ORDER BY 
    TimesUsed DESC;
    
SELECT 
    DATE_FORMAT(o.OrderDate, '%Y-%m') AS Month, 
    SUM(o.TotalAmount) AS MonthlySales
FROM 
    Orders o
GROUP BY 
    DATE_FORMAT(o.OrderDate, '%Y-%m')
ORDER BY 
    Month DESC;
    
SELECT 
    r.RoleName, 
    COUNT(e.EmployeeID) AS NumberOfEmployees, 
    AVG(e.Salary) AS AverageSalary
FROM 
    Employees e
JOIN 
    UserRoles r ON e.RoleID = r.RoleID
GROUP BY 
    r.RoleName
ORDER BY 
    NumberOfEmployees DESC;
    
SELECT 
    c.CustomerID, 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, 
    p.ProductName, 
    od.Quantity, 
    od.Price, 
    (od.Quantity * od.Price) AS TotalCost, 
    o.OrderDate
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID
ORDER BY 
    c.CustomerID, o.OrderDate DESC;
    
SELECT 
    s.ShippingMethod, 
    COUNT(o.OrderID) AS TotalOrders, 
    SUM(s.ShippingCost) AS TotalShippingRevenue
FROM 
    Shipping s
JOIN 
    Orders o ON s.ShippingID = o.ShippingID
GROUP BY 
    s.ShippingMethod
ORDER BY 
    TotalOrders DESC;
    
SELECT 
    s.SupplierName, 
    COUNT(p.ProductID) AS TotalProducts, 
    GROUP_CONCAT(DISTINCT c.CategoryName) AS CategoriesProvided
FROM 
    Suppliers s
JOIN 
    Products p ON s.SupplierID = p.SupplierID
JOIN 
    Categories c ON p.CategoryID = c.CategoryID
GROUP BY 
    s.SupplierID
ORDER BY 
    TotalProducts ASC;
    
SELECT 
    DATE(o.OrderDate) AS OrderDate, 
    SUM(o.TotalAmount) AS TotalRevenue, 
    COUNT(o.OrderID) AS TotalOrders
FROM 
    Orders o
GROUP BY 
    DATE(o.OrderDate)
ORDER BY 
    OrderDate DESC;
    
SELECT 
    p.ProductName, 
    SUM(od.Quantity * od.Price) AS TotalRevenue,
    RANK() OVER (ORDER BY SUM(od.Quantity * od.Price) DESC) AS RevenueRank
FROM 
    Products p
JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
GROUP BY 
    p.ProductID, p.ProductName;
    
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, 
    GROUP_CONCAT(p.ProductName SEPARATOR ', ') AS ProductsPurchased
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
JOIN 
    OrderDetails od ON o.OrderID = od.OrderID
JOIN 
    Products p ON od.ProductID = p.ProductID
GROUP BY 
    c.CustomerID;
    
SELECT 
    c.CategoryName, 
    AVG(r.Rating) AS AverageRating
FROM 
    Categories c
JOIN 
    Products p ON c.CategoryID = p.CategoryID
JOIN 
    Reviews r ON p.ProductID = r.ProductID
GROUP BY 
    c.CategoryName
ORDER BY 
    AverageRating DESC;
    
SELECT 
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName, 
    TIMESTAMPDIFF(YEAR, e.HireDate, CURDATE()) AS YearsOfService
FROM 
    Employees e
ORDER BY 
    YearsOfService DESC;
    
SELECT 
    o.OrderID, 
    s.DeliveryDate, 
    DATEDIFF(s.DeliveryDate, s.ShippedDate) AS DeliveryDelayDays
FROM 
    Orders o
JOIN 
    Shipping s ON o.ShippingID = s.ShippingID
WHERE 
    DATEDIFF(s.DeliveryDate, s.ShippedDate) > 3;
    
SELECT 
    s.SupplierName, 
    COUNT(DISTINCT od.ProductID) AS ProductsSold
FROM 
    Suppliers s
JOIN 
    Products p ON s.SupplierID = p.SupplierID
JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
GROUP BY 
    s.SupplierID;
    
SELECT 
    p.ProductName, 
    COUNT(od.Quantity) AS TotalUnitsSold, 
    RANK() OVER (ORDER BY COUNT(od.Quantity) DESC) AS PopularityRank
FROM 
    Products p
JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
GROUP BY 
    p.ProductID, p.ProductName;
    
SELECT 
    MAX(TotalAmount) AS MaxOrderAmount, 
    MIN(TotalAmount) AS MinOrderAmount, 
    AVG(TotalAmount) AS AvgOrderAmount
FROM 
    Orders;
    
UPDATE 
    Inventory
SET 
    QuantityInStock = QuantityInStock - 50
WHERE ProductID <> 10 and QuantityInStock >= 50;
select * from inventory;

UPDATE 
    Orders o
JOIN 
    Shipping s ON o.ShippingID = s.ShippingID
SET 
    o.OrderStatus = 'Completed'
WHERE 
    s.DeliveryDate <= CURDATE() AND o.OrderStatus != 'Completed';
select * from orders;

UPDATE 
    Employees e
JOIN 
    UserRoles ur ON e.RoleID = ur.RoleID
SET 
    e.Salary = e.Salary * 1.10
WHERE 
    ur.RoleName = 'Customer Support';
    select * from employees;
    
UPDATE 
    Products p
JOIN 
    Categories c ON p.CategoryID = c.CategoryID
SET 
    p.Price = p.Price * 1.05
WHERE 
    c.CategoryName = 'Hair Care';
select * from products;

CREATE VIEW PopularProducts AS
SELECT 
    p.ProductID, 
    p.ProductName, 
    SUM(od.Quantity) AS TotalUnitsSold, 
    SUM(od.Quantity * od.Price) AS TotalRevenue
FROM 
    Products p
JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
GROUP BY 
    p.ProductID, p.ProductName
HAVING 
    TotalUnitsSold > 100
ORDER BY 
    TotalUnitsSold DESC;
select * from popularproducts;

CREATE OR REPLACE VIEW HighSpendingCustomers AS
SELECT 
    c.CustomerID, 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, 
    SUM(o.TotalAmount) AS TotalSpent
FROM 
    Customers c
JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID
HAVING 
    TotalSpent > 1000
ORDER BY 
    TotalSpent DESC;
select * from highspendingcustomers;

CREATE OR REPLACE VIEW PendingOrders AS
SELECT 
    o.OrderID, 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName, 
    o.TotalAmount, 
    o.OrderStatus, 
    s.ShippingMethod, 
    s.DeliveryDate
FROM 
    Orders o
JOIN 
    Customers c ON o.CustomerID = c.CustomerID
JOIN 
    Shipping s ON o.ShippingID = s.ShippingID
WHERE 
    o.OrderStatus = 'Pending';
select * from pendingorders;

CREATE OR REPLACE VIEW SupplierProductCount AS
SELECT 
    s.SupplierName, 
    COUNT(p.ProductID) AS TotalProducts
FROM 
    Suppliers s
LEFT JOIN 
    Products p ON s.SupplierID = p.SupplierID
GROUP BY 
    s.SupplierID;
select * from supplierproductcount;


CREATE OR REPLACE VIEW EmployeePerformance AS
SELECT 
    e.EmployeeID, 
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName, 
    COUNT(o.OrderID) AS OrdersProcessed, 
    AVG(o.TotalAmount) AS AvgOrderValue
FROM 
    Employees e
LEFT JOIN 
    Orders o ON e.EmployeeID = o.OrderId
GROUP BY 
    e.EmployeeID;
select * from employeeperformance;

SELECT * FROM PopularProducts
WHERE TotalRevenue > 5000;

SELECT 
    h.CustomerName, 
    h.TotalSpent, 
    p.OrderID, 
    p.OrderStatus
FROM 
    HighSpendingCustomers h
JOIN 
    PendingOrders p ON h.CustomerName = p.CustomerName;
    
SELECT * FROM SupplierProductCount
WHERE TotalProducts > 10;

update employees
set salary = 75000
where EmployeeId = 108;
select * from employees;

SELECT 
    r.RoleName, 
    COUNT(e.EmployeeID) AS NumberOfEmployees, 
    AVG(e.Salary) AS AverageSalary
FROM 
    Employees e
JOIN 
    UserRoles r ON e.RoleID = r.RoleID
GROUP BY 
    r.RoleName
ORDER BY 
    NumberOfEmployees DESC;
    
CREATE VIEW PopularProducts AS
SELECT 
    p.ProductID,
    p.ProductName,
    SUM(od.Quantity) AS TotalQuantitySold,
    p.Price,
    p.Stock,
    p.SupplierID
FROM 
    Products p
JOIN 
    OrderDetails od ON p.ProductID = od.ProductID
GROUP BY 
    p.ProductID, p.ProductName, p.Price, p.Stock, p.SupplierID
HAVING 
    TotalQuantitySold > 2;
select * from popularproducts;

CREATE VIEW CustomerOrdersSummary AS
SELECT 
    c.CustomerID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    COUNT(o.OrderID) AS TotalOrders,
    SUM(o.TotalAmount) AS TotalSpent
FROM 
    Customers c
LEFT JOIN 
    Orders o ON c.CustomerID = o.CustomerID
GROUP BY 
    c.CustomerID;
select * from customerorderssummary;

CREATE VIEW ProductStockDetails AS
SELECT 
    p.ProductID,
    p.ProductName,
    c.CategoryName,
    i.QuantityInStock,
    i.ReorderLevel,
    CASE 
        WHEN i.QuantityInStock <= i.ReorderLevel THEN 'Restock Required'
        ELSE 'Stock Sufficient'
    END AS StockStatus
FROM 
    Products p
JOIN 
    Categories c ON p.CategoryID = c.CategoryID
JOIN 
    Inventory i ON p.ProductID = i.ProductID;
select * from productstockdetails;

CREATE VIEW OrderShipmentStatus AS
SELECT 
    o.OrderID,
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    s.ShippingMethod,
    s.ShippingCost,
    s.ShippedDate,
    s.DeliveryDate,
    CASE 
        WHEN s.DeliveryDate IS NULL THEN 'In Transit'
        WHEN s.DeliveryDate < CURDATE() THEN 'Delivered'
        ELSE 'Pending Delivery'
    END AS ShipmentStatus
FROM 
    Orders o
JOIN 
    Shipping s ON o.ShippingID = s.ShippingID
JOIN 
    Customers c ON o.CustomerID = c.CustomerID;
select * from ordershipmentstatus;

CREATE VIEW EmployeeRolesAndSalaries AS
SELECT 
    e.EmployeeID,
    CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
    ur.RoleName,
    e.Position,
    e.Salary
FROM 
    Employees e
JOIN 
    UserRoles ur ON e.RoleID = ur.RoleID;
select * from employeerolesandsalaries;








































