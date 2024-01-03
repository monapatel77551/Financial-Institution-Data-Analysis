CREATE DATABASE finance;
USE finance;

CREATE TABLE Financial_Institution (InstitutionID VARCHAR(100) PRIMARY KEY, InstitutionName VARCHAR(100), Location VARCHAR(100));
CREATE TABLE Investment_Product (ProductID VARCHAR(100) PRIMARY KEY, ProductName VARCHAR(100), InstitutionID VARCHAR(100) REFERENCES Financial_Institution(InstitutionID));
CREATE TABLE Customer (CustomerID VARCHAR(100) PRIMARY KEY, CustomerName VARCHAR(100), Location VARCHAR(100));
CREATE TABLE Investment_Account (AccountID VARCHAR(100) PRIMARY KEY, CustomerID VARCHAR(100) REFERENCES Customer(CustomerID), ProductID VARCHAR(100) REFERENCES Investment_Product(ProductID),Account_Status varchar(100),Created_At date);
CREATE TABLE Loan_Account (LoanID VARCHAR(100) PRIMARY KEY, CustomerID VARCHAR(100) REFERENCES Customer(CustomerID), ProductID VARCHAR(100) REFERENCES Investment_Product(ProductID), LoanAmount FLOAT, LoanStatus VARCHAR(10));
CREATE TABLE Customer_Satisfaction_Survey (SurveyID VARCHAR(100) PRIMARY KEY, CustomerID VARCHAR(100) REFERENCES Customer(CustomerID), SurveyDate DATE, NPSRating INT,PromotorStatus VARCHAR(10));
CREATE TABLE Loan_Details (Start_Date Date,No_of_Years INT, LoanID VARCHAR(100) REFERENCES Loan_Account(LoanID));
-- loan durations in years, payment to be done yearwise

-- Create the Expenses table
CREATE TABLE Expenses (
  ExpenseID INT PRIMARY KEY,
  ExpenseDate DATE,
  ExpenseAmount DECIMAL(10,2),
  InstitutionID VARCHAR(100) REFERENCES Financial_Institution(InstitutionID),
  ExpenseCategory VARCHAR(100)
);


ALTER TABLE Financial_Institution ADD COLUMN PhoneNumber VARCHAR(20);
ALTER TABLE Financial_Institution DROP  Rate_of_Intrest;
ALTER TABLE Customer ADD  InstitutionID VARCHAR(100) REFERENCES Financial_Institution(InstitutionID);
ALTER TABLE Investment_Product DROP  Invested_Amount ;
ALTER TABLE Investment_Account ADD COLUMN AccountBalance DECIMAL(10,2);
ALTER TABLE Loan_Details MODIFY COLUMN End_Date YEAR;
ALTER TABLE Loan_Details RENAME COLUMN End_Date TO No_of_years;
ALTER TABLE No_of_years MODIFY COLUMN No_of_years INT;
ALTER TABLE Loan_Account ADD COLUMN Loan_Type VARCHAR(100);
ALTER TABLE Loan_Account ADD COLUMN Rate_of_Intrest FLOAT;
ALTER TABLE Loan_Account ADD COLUMN InstitutionID VARCHAR(100) REFERENCES Financial_Institution(InstitutionID);
ALTER TABLE Customer_Satisfaction_Survey ADD COLUMN InstitutionID VARCHAR(100) REFERENCES Financial_Institution(InstitutionID);
ALTER TABLE Expenses MODIFY COLUMN ExpenseID VARCHAR(100);

SELECT * FROM Financial_Institution;
SELECT * FROM Investment_Product;
SELECT * FROM Customer;
SELECT * FROM Investment_Account;
SELECT * FROM Loan_Account;
SELECT * FROM Customer_Satisfaction_Survey;
SELECT * FROM Loan_Details;
SELECT * FROM Expenses;


DELETE FROM Financial_Institution;
DELETE FROM Investment_Product;
DELETE FROM Customer;
DELETE FROM Investment_Account;
DELETE FROM Loan_Account;
DELETE FROM Customer_Satisfaction_Survey;
DELETE FROM Expenses;


DROP TABLE Loan_Details;

SELECT FI.InstitutionID
FROM Financial_Institution FI
inner JOIN Investment_Product IP
ON FI.InstitutionID = IP.InstitutionID;

SELECT InstitutionID,COUNT(CustomerID)
FROM Customer
GROUP BY InstitutionID;


-- Aggregate Results Generated
-- Return On Investment table based on loans

-- ROI

CREATE VIEW ROI_Table AS
SELECT FI.InstitutionID, FI.InstitutionName,
       SUM(LA.LoanAmount * LA.Rate_Of_Intrest * LD.No_of_Years) AS Investment_Gain,
       SUM(LA.LoanAmount) AS Investment_Cost,
       ABS((SUM(LA.LoanAmount * LA.Rate_Of_Intrest * LD.No_of_Years) - SUM(LA.LoanAmount)) / SUM(LA.LoanAmount) * 100) AS ROI
FROM Financial_Institution FI
JOIN Loan_Account LA ON LA.InstitutionID = FI.InstitutionID
JOIN Loan_Details LD ON LD.LoanID = LA.LoanID
GROUP BY FI.InstitutionID, FI.InstitutionName;

SELECT * FROM ROI_Table;
DROP VIEW ROI_Table;

-- Assets_Under_Management
CREATE VIEW Assets_Under_Management AS
SELECT FI.InstitutionID, FI.InstitutionName, SUM(IA.AccountBalance) AS AUM
FROM Financial_Institution FI
JOIN Investment_Product IP ON FI.InstitutionID = IP.InstitutionID
JOIN Investment_Account IA ON IP.ProductID = IA.ProductID
WHERE IA.Account_Status = 'active'
GROUP BY FI.InstitutionID, FI.InstitutionName;

SELECT * FROM Assets_Under_Management;

-- NPS Rating
CREATE VIEW NPSRating AS
SELECT FI.InstitutionID,
       (SUM(CASE WHEN CSS.NPSRating >= 9 THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS Promoter_Percentage,
       (SUM(CASE WHEN CSS.NPSRating <= 6 THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS Detractor_Percentage,
       ABS(((SUM(CASE WHEN CSS.NPSRating >= 9 THEN 1 ELSE 0 END) / COUNT(*)) * 100) - ((SUM(CASE WHEN CSS.NPSRating <= 6 THEN 1 ELSE 0 END) / COUNT(*)) * 100)) AS NPS
FROM Financial_Institution FI
JOIN Customer_Satisfaction_Survey CSS ON FI.InstitutionID = CSS.InstitutionID
GROUP BY FI.InstitutionID;

SELECT * FROM NPSRating;

-- Loan Defaulter
CREATE VIEW Customer_Acquisition_Cost AS
SELECT
    FI.InstitutionName,
    COUNT(DISTINCT C.CustomerID) AS TotalCustomers,
    COUNT(DISTINCT CASE WHEN IA.Created_At BETWEEN '2018-01-01' AND '2022-12-31' THEN C.CustomerID END) AS NewCustomers,
    SUM(E.ExpenseAmount) AS TotalExpenses,
    SUM(E.ExpenseAmount) / COUNT(DISTINCT CASE WHEN IA.Created_At BETWEEN '2018-01-01' AND '2022-12-31' THEN C.CustomerID END) AS CAC
FROM
    Financial_Institution FI
JOIN
    Expenses E ON FI.InstitutionID = E.InstitutionID
JOIN
    Customer C ON FI.Location = C.Location
JOIN
    Investment_Account IA ON C.CustomerID = IA.CustomerID
WHERE
    E.ExpenseCategory IN (
        'Marketing and Advertising Expenses',
        'Lead Generation Expenses',
        'Sales Team Expenses',
        'Technology and Infrastructure Expenses',
        'Events and Sponsorships Expenses',
        'Search Engine Optimization Expenses',
        'Call Center and Customer Support Expenses'
    )
GROUP BY
    FI.InstitutionName;
    
SELECT * FROM Customer_Acquisition_Cost;