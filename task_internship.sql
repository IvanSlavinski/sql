--start
USE MyDatabase;

-- 1. Write a SELECT statement to display all columns and rows from the "Users" table.
SELECT * 
  FROM Users;

-- 2. Write a SELECT statement to display the "UserName" and "Email" columns from the "Users" table.
SELECT UserName, Email FROM Users;

-- 3. Write a SELECT statement to display all columns and rows from the "Orders" table, sorted by the "OrderDate" column in descending order.
SELECT * 
  FROM Orders
 ORDER BY OrderDate DESC;

-- 4. Write a SELECT statement to display the "ProductName" and "Price" columns from the "Products" table where the "Price" is greater than $30.
SELECT ProductName, Price 
  FROM Products
 WHERE Price > 30;

-- 5. Write a SELECT statement to display the "UserName" and "OrderDate" columns from the "Users" and "Orders" tables, using an inner join on the "UserId" column.
SELECT UserName, OrderDate
  FROM Users
       INNER JOIN Orders
       ON Users.UserId = Orders.UserId;

-- 6. Write a SELECT statement to display the "ProductName" and "CategoryName" columns from the "Products", "ProductCategories", and "Categories" tables, using an inner join on the "ProductId" and "CategoryId" columns.
SELECT ProductName, CategoryName
  FROM Products
       INNER JOIN ProductCategories
       ON Products.ProductId = ProductCategories.ProductId
       INNER JOIN Categories
       ON ProductCategories.CategoryId = Categories.CategoryId;

-- 7. Write a SELECT statement to display the "UserName", "AddressLine1", and "City" columns from the "Users" and "ShippingAddresses" tables, using a left join on the "UserId" column.
SELECT UserName, AddressLine1, City
  FROM Users
       LEFT JOIN ShippingAddresses
       ON Users.UserId = ShippingAddresses.UserId;

-- 8. Write a SELECT statement to display the "UserName", "PaymentType", and "CardNumber" columns from the "Users" and "PaymentMethods" tables, using a right join on the "UserId" column.
SELECT UserName, PaymentType, CardNumber
  FROM Users
       RIGHT JOIN PaymentMethods
       ON Users.UserId = PaymentMethods.UserId;

-- 9 Retrieve the names and email addresses of all users who are female and have an American Express payment method.
SELECT UserName, Email
  FROM Users
       INNER JOIN PaymentMethods
       ON Users.UserId = PaymentMethods.UserId
 WHERE Gender = 'Female' AND PaymentType = 'American Express';

-- 10 Retrieve the names of all products that belong to the "Electronics" category and cost more than $500.
SELECT ProductName
  FROM Products
       INNER JOIN ProductCategories
       ON Products.ProductId = ProductCategories.ProductId
       INNER JOIN Categories
       ON ProductCategories.CategoryId = Categories.CategoryId
 WHERE CategoryName = 'Electronics'
   AND Price > 500;

-- 11 Retrieve the names of all users who have placed an order in June 2022.
SELECT UserName
  FROM Users
       INNER JOIN Orders
       ON Users.UserId = Orders.UserId
 WHERE OrderDate BETWEEN '2022-06-01' AND '2022-06-30';

-- 12 Retrieve the names of all products that have been ordered exactly once.
SELECT ProductName
  FROM Products
       INNER JOIN OrderItems
       ON Products.ProductId = OrderItems.ProductId
 GROUP BY ProductName
HAVING COUNT(Quantity) = 1;

-- 13 Retrieve the names of all users who have placed an order and live in Los Angeles or Seattle.
SELECT DISTINCT UserName
  FROM Users
       INNER JOIN ShippingAddresses
       ON Users.UserId = ShippingAddresses.UserId
 WHERE City IN ('Los Angeles', 'Seattle');

-- 14 Retrieve the names of all products that have been ordered at least once.
SELECT ProductName
  FROM Products
       INNER JOIN OrderItems
       ON Products.ProductId = OrderItems.ProductId
 GROUP BY ProductName
HAVING COUNT(Quantity) >= 1;

-- 15 Retrieve the names of all users who have placed exactly one order.
SELECT UserName
  FROM Users
       INNER JOIN Orders
       ON Users.UserId = Orders.UserId
 GROUP BY UserName
HAVING COUNT(OrderId) = 1;

-- 16 Retrieve the names of all categories that have at least 3 products belonging to them.
SELECT CategoryName
  FROM ProductCategories
       INNER JOIN Categories
       ON ProductCategories.CategoryId = Categories.CategoryId
 GROUP BY CategoryName
HAVING COUNT(Categories.CategoryId) >= 3;

-- 17 Retrieve the names of all users who have placed an order and have a Discover or American Express payment method.
SELECT DISTINCT UserName
  FROM Users
       INNER JOIN Orders
       ON Users.UserId = Orders.UserId
	     INNER JOIN PaymentMethods
       ON Orders.UserId = PaymentMethods.UserId
 WHERE PaymentType IN ('Discover', 'American Express');

-- 18 Retrieve the names and email addresses of all users who have placed an order in January 2022 and have a payment method that is either a Visa or Mastercard.
SELECT DISTINCT UserName, Email
  FROM Users
       INNER JOIN Orders
       ON Users.UserId = Orders.UserId
	     INNER JOIN PaymentMethods
       ON Orders.UserId = PaymentMethods.UserId
 WHERE PaymentType IN ('Visa', 'Mastercard')
   AND OrderDate BETWEEN '2022-01-01' AND '2022-01-31';

-- 19 Retrieve the names of all products that have never been ordered, and do not belong to the "Laptops" or "Tablets" categories.
SELECT ProductName
  FROM Categories
       LEFT JOIN ProductCategories
       ON Categories.CategoryId = ProductCategories.CategoryId
	     LEFT JOIN Products
       ON ProductCategories.ProductId = Products.ProductId 
	     LEFT JOIN OrderItems
	     ON Products.ProductId = OrderItems.ProductId
 WHERE CategoryName NOT IN ('Laptops', 'Tablets')
   AND OrderId IS NULL;

SELECT ProductName
  FROM Categories
       LEFT JOIN ProductCategories
       ON Categories.CategoryId = ProductCategories.CategoryId
	     LEFT JOIN Products AS Ps
       ON ProductCategories.ProductId = Ps.ProductId 
 WHERE CategoryName NOT IN ('Laptops', 'Tablets')
   AND NOT EXISTS (SELECT ProductId 
                     FROM OrderItems AS OI
					     WHERE Ps.ProductId = OI.ProductId);

SELECT ProductName
  FROM Categories
       LEFT JOIN ProductCategories
       ON Categories.CategoryId = ProductCategories.CategoryId
	     LEFT JOIN Products AS Ps
       ON ProductCategories.ProductId = Ps.ProductId 
 WHERE CategoryName NOT IN ('Laptops', 'Tablets')
   AND Ps.ProductId NOT IN (SELECT ProductId 
                              FROM OrderItems AS OI
					              WHERE Ps.ProductId = OI.ProductId);

-- 20 Retrieve the names of all categories that have at least 2 products belonging to them, and at least one of those products has been ordered by a user who is female.
SELECT CategoryName
  FROM Categories
       INNER JOIN ProductCategories
       ON Categories.CategoryId = ProductCategories.CategoryId 
	     INNER JOIN OrderItems
	     ON ProductCategories.ProductId = OrderItems.ProductId
	     INNER JOIN Orders
	     ON OrderItems.OrderId = Orders.OrderId
	     INNER JOIN Users
	     ON Orders.UserId = Users.UserId
 GROUP BY CategoryName
HAVING COUNT(ProductCategories.CategoryId) >= 2
   AND COUNT(CASE 
			            WHEN Users.Gender = 'Female' THEN 1 
		         END) >= 1;

-- 21 Retrieve the names of all users who have placed an order and have a payment method that is either an American Express or Discover card, and have placed their order in either May or June 2022.
SELECT DISTINCT UserName
  FROM PaymentMethods
	     INNER JOIN Users
	     ON PaymentMethods.UserId = Users.UserId
       INNER JOIN Orders
       ON Users.UserId = Orders.UserId
	     INNER JOIN OrderItems
	     ON Orders.OrderId = OrderItems.OrderId
 WHERE OrderDate BETWEEN '2022-05-01' AND '2022-06-30'
   AND PaymentType IN ('Discover', 'American Express');

-- 22 Insert a new user with the following details: UserName "JohnDoe", Email "johndoe@example.com", Gender "Male", and DateOfBirth "1990-01-01".
INSERT INTO Users (UserName, Email, Gender, DateOfBirth)
VALUES ('JohnDoe', 'johndoe@example.com', 'Male', '1990-01-01');

-- 23 Insert a new payment method for the user "JohnDoe" with the following details: PaymentType "Visa" and CardNumber "1234567890".
INSERT INTO PaymentMethods(UserId, PaymentType, CardNumber)
SELECT Us.UserId, 'Visa', '1234567890'
  FROM Users Us
 WHERE UserName = 'JohnDoe';

-- 24 Insert a new shipping address for the user "JohnDoe" with the following details: AddressLine1 "123 Main Street", City "New York", State "NY", and ZipCode "10001".
INSERT INTO ShippingAddresses (UserId, AddressLine1, City, State, ZipCode)
SELECT Us.UserId, '123 Main Street', 'New York', 'NY','10001'
  FROM Users Us
 WHERE UserName = 'JohnDoe';

-- 25 Insert a new product with the following details: ProductName "Macbook Pro", Price 1000.
INSERT INTO Products (ProductName, Price)
VALUES ('Macbook Pro', 1000);

-- 26 Insert a new category with the name "Desktops".
INSERT INTO Categories (CategoryName)
VALUES ('Desktops');

-- 27 Assign the product "Macbook Pro" to the category "Desktops".
INSERT INTO ProductCategories (ProductId, CategoryId)
SELECT Ps.ProductId, Cat.CategoryId
  FROM Products Ps, Categories Cat
 WHERE Ps.ProductName = 'Macbook Pro' 
   AND Cat.CategoryName = 'Desktops';

-- 28 Update the Price for the product "Macbook Pro" to 2000.
UPDATE Products
   SET Price = 2000
 WHERE ProductName = 'Macbook Pro';

-- 29 Update the Email for the user "JohnDoe" to "johndoe123@example.com".
UPDATE Users
   SET Email = 'johndoe123@example.com'
 WHERE UserName = 'JohnDoe';

-- 30 Create a new table "ProductRatings" with the following columns: RatingId (primary key, auto-increment), ProductId (foreign key to Products), UserId (foreign key to Users), Rating (integer), and Review (text).
GO
CREATE TABLE ProductRatings (
	RatingId INT IDENTITY(1,1) NOT NULL,
	ProductId INT NOT NULL,
	UserId INT NOT NULL,
	Rating INT NOT NULL,
	Review VARCHAR(255) NOT NULL,
	PRIMARY KEY (RatingId),
	FOREIGN KEY (ProductId) REFERENCES Products(ProductId),
	FOREIGN KEY (UserId) REFERENCES Users(UserId)
);

-- 31 Insert a new rating for the product "Macbook Pro" with the following details: UserId of the user "JohnDoe", Rating 4, and Review "Great product!".
INSERT INTO ProductRatings(ProductId, UserId, Rating, Review)
SELECT Ps.ProductId, Us.UserId, 4, 'Great product!'
  FROM Products Ps, Users Us
 WHERE Ps.ProductName = 'Macbook Pro'
   AND Us.UserName = 'JohnDoe';

-- 32 Create a new table "CategoryPromotions" with the following columns: PromotionId (primary key, auto-increment), CategoryId (foreign key to Categories), PromotionName (text), DiscountAmount (integer), and ValidFrom (date).
GO 
CREATE TABLE CategoryPromotions(
	PromotionId INT IDENTITY(1,1) NOT NULL,
	CategoryId INT NOT NULL,
	PromotionName VARCHAR(30) NOT NULL,
	DiscountAmount INT NOT NULL,
	ValidFrom DATE NOT NULL,
	PRIMARY KEY (PromotionId),
	FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);

-- 33 Insert a new promotion for the category "Desktops" with the following details: PromotionName "New Year Sale", DiscountAmount 100, and ValidFrom "2022-01-01".
INSERT INTO CategoryPromotions(CategoryId, PromotionName, DiscountAmount, ValidFrom)
SELECT Cat.CategoryId, 'New Year Sale', 100, '2022-01-01'
  FROM Categories Cat
 WHERE Cat.CategoryName = 'Desktops';

-- 34 Create a new table "OrderPromotions" with the following columns: OrderId (foreign key to Orders), PromotionId (foreign key to CategoryPromotions), and DiscountAmount (integer).
GO
CREATE TABLE OrderPromotions(
	OrderId INT NOT NULL,
	PromotionId INT NOT NULL, 
	DiscountAmount INT NOT NULL,
	FOREIGN KEY (OrderId) REFERENCES Orders (OrderId),
	FOREIGN KEY (PromotionId) REFERENCES CategoryPromotions (PromotionId)
);

-- 35 Insert a new entry in the "OrderPromotions" table for the order with OrderId 1, using the promotion with PromotionId 1, and a DiscountAmount of 50.
INSERT INTO OrderPromotions (OrderId, PromotionId, DiscountAmount)
SELECT Os.OrderId, CatP.PromotionId, 50
  FROM Orders Os, CategoryPromotions CatP
 WHERE Os.OrderId = 1
   AND CatP.PromotionId = 1;

-- 36 Delete the payment method with the PaymentType "Visa" and the CardNumber "1234567890".
DELETE FROM PaymentMethods
 WHERE PaymentType = 'Visa' AND CardNumber = '1234567890';

-- 37 Modify the Gender of the user with the UserId 1 to "Female".
UPDATE Users
   SET Gender = 'Female'
 WHERE UserId = 1;

-- 38 Modify the PromotionName of the promotion with the PromotionId 1 to "Winter Sale".
UPDATE CategoryPromotions
   SET PromotionName = 'Winter Sale'
 WHERE PromotionId = 1;

-- 39 Modify the DiscountAmount of the promotion with the PromotionId 1 to 50.
UPDATE CategoryPromotions
   SET DiscountAmount = 50
 WHERE PromotionId = 1;

-- 40 Add a new column "LastLogin" to the "Users" table, with a data type of datetime.
ALTER TABLE Users
  ADD LastLogin DATE NULL;

-- 41 Add a new column "PhoneNumber" to the "ShippingAddresses" table, with a data type of varchar(20).
ALTER TABLE ShippingAddresses
  ADD PhoneNumber VARCHAR(20) NULL;

-- 42 Change the data type of the "Price" column in the "Products" table from integer to decimal.
ALTER TABLE Products
ALTER COLUMN Price DECIMAL;

-- 43 Rename the "PromotionName" column to "Name" in the "CategoryPromotions" table.
EXEC sp_rename 'CategoryPromotions.PromotionName', 'Name', 'COLUMN';

-- 44 Change the data type of the "ValidFrom" column in the "CategoryPromotions" table from date to datetime.
ALTER TABLE CategoryPromotions
ALTER COLUMN ValidFrom DATETIME;


WITH temp AS (
              SELECT ERM.RunId AS RunId, el.BteId, COUNT(p.Id) AS perf_num
                FROM [dbo].[om_EventLookup] el
				             INNER JOIN [dbo].[om_EventRunMapping] ERM
                     ON el.BteId = ERM.BteId
                     INNER JOIN [dbo].[om_EventPerformerMapping] EPM
                     ON el.BteId = EPM.BteId
                     INNER JOIN [dbo].[om_Performer] p
                     ON EPM.PerformerId = p.Id
               GROUP BY ERM.RunId, el.BteId
              )
SELECT RunId, MIN(perf_num) AS min_perf_num, MAX(perf_num) AS max_perf_num
  FROM temp
 GROUP BY RunId
HAVING MIN(perf_num) <> MAX(perf_num);

-------------------------------------------------------------------------------------------------
DECLARE @number_of_events INT;
 SELECT @number_of_events = COUNT(el.BteId)
   FROM [dbo].[om_EventLookup] el;

SELECT temp.RunId
  FROM (
        SELECT sub.RunId, sub.BteId, STRING_AGG (CAST(sub.pId AS varchar), ',') AS unique_pIds
		      FROM (
		            SELECT TOP (@number_of_events) ERM.RunId AS RunId, el.BteId AS BteId, p.Id AS pId
				          FROM [dbo].[om_EventLookup] el
				               LEFT JOIN [dbo].[om_EventRunMapping] ERM
					             ON el.BteId = ERM.BteId
					             LEFT JOIN [dbo].[om_EventRun] er
					             ON ERM.RunId = er.Id
					             LEFT JOIN [dbo].[om_EventPerformerMapping] EPM
					             ON el.BteId = EPM.BteId
					             LEFT JOIN [dbo].[om_Performer] p
					             ON EPM.PerformerId = p.Id
				         WHERE EPM.RemovedFromApi = 0
				           AND ERM.IsDeleted = 0
				           AND EPM.IsDeleted = 0
				           AND p.IsDeleted = 0
				         ORDER BY ERM.RunId, el.BteId, p.Id
				       ) sub
		     GROUP BY sub.RunId, sub.BteId
		   ) temp
 GROUP BY temp.RunId
HAVING COUNT(DISTINCT temp.unique_pIds) > 1;
-------------------------------------------------------------------------------------------------
SELECT ermapping.RunId, MIN(gr.PerformerComb), MAX(gr.PerformerComb) 
  FROM om_EventRunMapping ermapping
       INNER JOIN (
                   SELECT el.BteId,
                                   (
                                    SELECT CAST(epm.PerformerId as varchar) + ','
                                      FROM om_EventPerformerMapping epm 
                                     WHERE epm.BteId = el.BteId 
                                       AND epm.IsDeleted = 0 
                                       AND epm.RemovedFromApi = 0
                                     ORDER BY epm.PerformerId
                                       FOR XML PATH('')
                                    ) AS PerformerComb 
                     FROM om_EventLookup el 
                          LEFT JOIN om_EventPerformerMapping epm ON el.BteId = epm.BteId
                    WHERE epm.IsDeleted = 0 AND epm.RemovedFromApi = 0
                    GROUP BY el.BteId
                  ) gr 
       ON ermapping.BteId = gr.BteId
 WHERE ermapping.IsDeleted = 0
 GROUP BY ermapping.RunId
HAVING MIN(gr.PerformerComb) <> MAX(gr.PerformerComb) AND MIN(gr.PerformerComb) IS NOT NULL
 ORDER BY ermapping.RunId;
-------------------------------------------------------------------------------------------------