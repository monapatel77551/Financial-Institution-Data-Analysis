import sqlite3

mydb = sqlite3.connector.connect(
    host="localhost",
    user="root",
    password="$Freeman36$"
)

mycursor = mydb.cursor()

# Comment after execution

mycursor.execute("CREATE DATABASE Finance")
mycursor.execute("USE Finance")

# Comment after execution
mycursor.execute("CREATE TABLE Financial_Institution (InstitutionID VARCHAR(100) PRIMARY KEY, InstitutionName VARCHAR(100), Location VARCHAR(100))")
mycursor.execute("CREATE TABLE Investment_Product (ProductID VARCHAR(100) PRIMARY KEY, ProductName VARCHAR(100), InstitutionID VARCHAR(100) REFERENCES Financial_Institution(InstitutionID))")
mycursor.execute("CREATE TABLE Customer (CustomerID VARCHAR(100) PRIMARY KEY, CustomerName VARCHAR(100), Location VARCHAR(100))")
mycursor.execute("CREATE TABLE Investment_Account (AccountID VARCHAR(100) PRIMARY KEY, CustomerID VARCHAR(100) REFERENCES Customer(CustomerID), ProductID VARCHAR(100) REFERENCES Investment_Product(ProductID))")
mycursor.execute("CREATE TABLE Loan_Account (LoanID VARCHAR(100) PRIMARY KEY, CustomerID VARCHAR(100) REFERENCES Customer(CustomerID), ProductID VARCHAR(100) REFERENCES Investment_Product(ProductID), LoanAmount FLOAT, LoanStatus VARCHAR(10))")
mycursor.execute("CREATE TABLE Customer_Satisfaction_Survey (SurveyID VARCHAR(100) PRIMARY KEY, CustomerID VARCHAR(100) REFERENCES Customer(CustomerID), SurveyDate DATE, NPSRating INT)")
