--before normalization
CREATE TABLE Orders_UNF (
    orderId NUMBER,
    customerName VARCHAR2(15),
    customerPhone VARCHAR2(11),
    productList VARCHAR2(25),
    totalAmount NUMBER
);

INSERT INTO Orders_UNF VALUES (1, 'Ali Khan', '03001234567', 'Laptop, Mouse', 145000);
INSERT INTO Orders_UNF VALUES (2, 'Sara Ahmed', '03002345678', 'Keyboard, Mouse', 9000);
INSERT INTO Orders_UNF VALUES (3, 'Ahmad Raza', '03003456789', 'Laptop, Bag', 150000);
INSERT INTO Orders_UNF VALUES (4, 'Hira Tariq', '03004567890', 'Monitor, Laptop', 34000);
INSERT INTO Orders_UNF VALUES (5, 'Bilal Hassan', '03005678901', 'Mouse, Keyboard', 8500);

SELECT * FROM Orders_UNF;

--1NF(eliminates multi-valued attributes)
CREATE TABLE Orders_1NF (
    orderId NUMBER PRIMARY KEY,
    customerName VARCHAR2(15),
    customerPhone VARCHAR2(11),
    totalAmount NUMBER
);

CREATE TABLE OrderProducts_1NF (
    orderId NUMBER,
    productName VARCHAR2(15),
    FOREIGN KEY (orderId) REFERENCES Orders_1NF(orderId)
);

INSERT INTO Orders_1NF VALUES (1, 'Ali Khan', '03001234567', 145000);
INSERT INTO Orders_1NF VALUES (2, 'Sara Ahmed', '03002345678', 9000);
INSERT INTO Orders_1NF VALUES (3, 'Ahmad Raza', '03003456789', 150000);
INSERT INTO Orders_1NF VALUES (4, 'Hira Tariq', '03004567890', 34000);
INSERT INTO Orders_1NF VALUES (5, 'Bilal Hassan', '03005678901', 8500);

INSERT INTO OrderProducts_1NF VALUES (1, 'Laptop');
INSERT INTO OrderProducts_1NF VALUES (1, 'Mouse');
INSERT INTO OrderProducts_1NF VALUES (2, 'Keyboard');
INSERT INTO OrderProducts_1NF VALUES (2, 'Mouse');
INSERT INTO OrderProducts_1NF VALUES (3, 'Laptop');
INSERT INTO OrderProducts_1NF VALUES (3, 'Bag');
INSERT INTO OrderProducts_1NF VALUES (4, 'Monitor');
INSERT INTO OrderProducts_1NF VALUES (4, 'Laptop');
INSERT INTO OrderProducts_1NF VALUES (5, 'Mouse');
INSERT INTO OrderProducts_1NF VALUES (5, 'Keyboard');

SELECT * FROM Orders_1NF;
SELECT * FROM OrderProducts_1NF;

--2NF(have no partial dependencies)
CREATE TABLE Customers_2NF (
    customerId NUMBER PRIMARY KEY,
    customerName VARCHAR2(25),
    customerPhone VARCHAR2(11)
);

CREATE TABLE Orders_2NF (
    orderId NUMBER PRIMARY KEY,
    customerId NUMBER,
    totalAmount NUMBER,
    FOREIGN KEY (customerId) REFERENCES Customers_2NF(customerId)
);

CREATE TABLE Products_2NF (
    productId NUMBER PRIMARY KEY,
    productName VARCHAR2(15),
    productPrice NUMBER
);

CREATE TABLE OrderProducts_2NF (
    orderId NUMBER,
    productId NUMBER,
    FOREIGN KEY (orderId) REFERENCES Orders_2NF(orderId),
    FOREIGN KEY (productId) REFERENCES Products_2NF(productId)
);

INSERT INTO Customers_2NF VALUES (1, 'Ali Khan', '03001234567');
INSERT INTO Customers_2NF VALUES (2, 'Sara Ahmed', '03002345678');
INSERT INTO Customers_2NF VALUES (3, 'Ahmad Raza', '03003456789');
INSERT INTO Customers_2NF VALUES (4, 'Hira Tariq', '03004567890');
INSERT INTO Customers_2NF VALUES (5, 'Bilal Hassan', '03005678901');

INSERT INTO Orders_2NF VALUES (1, 1, 145000);
INSERT INTO Orders_2NF VALUES (2, 2, 9000);
INSERT INTO Orders_2NF VALUES (3, 3, 150000);
INSERT INTO Orders_2NF VALUES (4, 4, 34000);
INSERT INTO Orders_2NF VALUES (5, 5, 8500);

INSERT INTO Products_2NF VALUES (1, 'Laptop', 140000);
INSERT INTO Products_2NF VALUES (2, 'Mouse', 5000);
INSERT INTO Products_2NF VALUES (3, 'Keyboard', 4000);
INSERT INTO Products_2NF VALUES (4, 'Bag', 10000);
INSERT INTO Products_2NF VALUES (5, 'Monitor', 20000);

INSERT INTO OrderProducts_2NF VALUES (1, 1);
INSERT INTO OrderProducts_2NF VALUES (1, 2);
INSERT INTO OrderProducts_2NF VALUES (2, 3);
INSERT INTO OrderProducts_2NF VALUES (2, 2);
INSERT INTO OrderProducts_2NF VALUES (3, 1);
INSERT INTO OrderProducts_2NF VALUES (3, 4);
INSERT INTO OrderProducts_2NF VALUES (4, 5);
INSERT INTO OrderProducts_2NF VALUES (4, 1);
INSERT INTO OrderProducts_2NF VALUES (5, 2);
INSERT INTO OrderProducts_2NF VALUES (5, 3);

select * from Customers_2NF;
select * from Orders_2NF;
select * from Products_2NF;
select * from OrderProducts_2NF;

--3NF(removing transitive dependencies)
CREATE TABLE Customers (
    customerId NUMBER PRIMARY KEY,
    customerName VARCHAR2(15),
    customerPhone VARCHAR2(11)
);

CREATE TABLE Orders (
    orderId NUMBER PRIMARY KEY,
    customerId NUMBER,
    totalAmount NUMBER,
    FOREIGN KEY (customerId) REFERENCES Customers(customerId)
);

CREATE TABLE Products (
    productId NUMBER PRIMARY KEY,
    productName VARCHAR2(15)
);

CREATE TABLE ProductPrices (
    productId NUMBER PRIMARY KEY,
    productPrice NUMBER,
    FOREIGN KEY (productId) REFERENCES Products(productId)
);

CREATE TABLE OrderProducts (
    orderId NUMBER,
    productId NUMBER,
    FOREIGN KEY (orderId) REFERENCES Orders(orderId),
    FOREIGN KEY (productId) REFERENCES Products(productId)
);

INSERT INTO Customers VALUES (1, 'Ali Khan', '03001234567');
INSERT INTO Customers VALUES (2, 'Sara Ahmed', '03002345678');
INSERT INTO Customers VALUES (3, 'Ahmad Raza', '03003456789');
INSERT INTO Customers VALUES (4, 'Hira Tariq', '03004567890');
INSERT INTO Customers VALUES (5, 'Bilal Hassan', '03005678901');

INSERT INTO Orders VALUES (1, 1, 145000);
INSERT INTO Orders VALUES (2, 2, 9000);
INSERT INTO Orders VALUES (3, 3, 150000);
INSERT INTO Orders VALUES (4, 4, 34000);
INSERT INTO Orders VALUES (5, 5, 8500);

INSERT INTO Products VALUES (1, 'Laptop');
INSERT INTO Products VALUES (2, 'Mouse');
INSERT INTO Products VALUES (3, 'Keyboard');
INSERT INTO Products VALUES (4, 'Bag');
INSERT INTO Products VALUES (5, 'Monitor');

INSERT INTO ProductPrices VALUES (1, 140000);
INSERT INTO ProductPrices VALUES (2, 5000);
INSERT INTO ProductPrices VALUES (3, 4000);
INSERT INTO ProductPrices VALUES (4, 10000);
INSERT INTO ProductPrices VALUES (5, 20000);

INSERT INTO OrderProducts VALUES (1, 1);
INSERT INTO OrderProducts VALUES (1, 2);
INSERT INTO OrderProducts VALUES (2, 3);
INSERT INTO OrderProducts VALUES (2, 2);
INSERT INTO OrderProducts VALUES (3, 1);
INSERT INTO OrderProducts VALUES (3, 4);
INSERT INTO OrderProducts VALUES (4, 5);
INSERT INTO OrderProducts VALUES (4, 1);
INSERT INTO OrderProducts VALUES (5, 2);
INSERT INTO OrderProducts VALUES (5, 3);

select * from Customers;
select * from Orders;
select * from Products;
select * from ProductPrices;
select * from OrderProducts;

