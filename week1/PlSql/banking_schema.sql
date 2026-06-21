-- Banking Database Schema for SQLite
-- Converted from Oracle PL/SQL

CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY,
    Name TEXT,
    DOB TEXT,
    Balance REAL,
    LastModified TEXT
);

CREATE TABLE Accounts (
    AccountID INTEGER PRIMARY KEY,
    CustomerID INTEGER,
    AccountType TEXT,
    Balance REAL,
    LastModified TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID INTEGER PRIMARY KEY,
    AccountID INTEGER,
    TransactionDate TEXT,
    Amount REAL,
    TransactionType TEXT,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID INTEGER PRIMARY KEY,
    CustomerID INTEGER,
    LoanAmount REAL,
    InterestRate REAL,
    StartDate TEXT,
    EndDate TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID INTEGER PRIMARY KEY,
    Name TEXT,
    Position TEXT,
    Salary REAL,
    Department TEXT,
    HireDate TEXT
);
