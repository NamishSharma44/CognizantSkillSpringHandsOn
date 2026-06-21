-- ====================================================================
-- SAMPLE DATA FOR ORACLE BANKING SYSTEM
-- ====================================================================
-- Populate tables with realistic test data for exercises
-- ====================================================================

-- Clear existing data (optional - comment out if you want to keep data)
-- DELETE FROM Transactions;
-- DELETE FROM Loans;
-- DELETE FROM Accounts;
-- DELETE FROM Employees;
-- DELETE FROM Customers;
-- COMMIT;

-- ====================================================================
-- INSERT CUSTOMERS
-- ====================================================================
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (1, 'John Davis', TO_DATE('1960-05-15', 'YYYY-MM-DD'), 15000, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (2, 'Sarah Johnson', TO_DATE('1978-08-22', 'YYYY-MM-DD'), 8500, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (3, 'Michael Chen', TO_DATE('1965-03-10', 'YYYY-MM-DD'), 25000, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (4, 'Emily Wilson', TO_DATE('1990-11-30', 'YYYY-MM-DD'), 5200, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (5, 'Robert Martinez', TO_DATE('1952-07-18', 'YYYY-MM-DD'), 18000, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (6, 'Jennifer Brown', TO_DATE('1985-02-14', 'YYYY-MM-DD'), 12500, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (7, 'David Kim', TO_DATE('1975-09-05', 'YYYY-MM-DD'), 9750, SYSDATE);

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
VALUES (8, 'Lisa Anderson', TO_DATE('1968-12-25', 'YYYY-MM-DD'), 22000, SYSDATE);

COMMIT;

-- ====================================================================
-- INSERT ACCOUNTS
-- ====================================================================
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (1, 1, 'Savings', 15000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (2, 1, 'Checking', 5000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (3, 2, 'Savings', 8500, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (4, 3, 'Savings', 25000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (5, 3, 'Checking', 10000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (6, 4, 'Checking', 5200, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (7, 5, 'Savings', 18000, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (8, 6, 'Savings', 12500, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (9, 7, 'Checking', 9750, SYSDATE);

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
VALUES (10, 8, 'Savings', 22000, SYSDATE);

COMMIT;

-- ====================================================================
-- INSERT LOANS
-- ====================================================================
INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (1, 1, 50000, 0.05, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2026-07-10', 'YYYY-MM-DD'));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (2, 2, 30000, 0.04, TO_DATE('2023-06-15', 'YYYY-MM-DD'), TO_DATE('2026-08-20', 'YYYY-MM-DD'));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (3, 3, 100000, 0.045, TO_DATE('2022-05-01', 'YYYY-MM-DD'), TO_DATE('2027-05-01', 'YYYY-MM-DD'));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (4, 5, 75000, 0.055, TO_DATE('2023-03-20', 'YYYY-MM-DD'), TO_DATE('2026-07-05', 'YYYY-MM-DD'));

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate)
VALUES (5, 8, 60000, 0.048, TO_DATE('2023-02-10', 'YYYY-MM-DD'), TO_DATE('2026-06-28', 'YYYY-MM-DD'));

COMMIT;

-- ====================================================================
-- INSERT EMPLOYEES
-- ====================================================================
INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (101, 'Alice Smith', 'Manager', 80000, 'IT', TO_DATE('2015-03-10', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (102, 'Bob Johnson', 'Developer', 65000, 'IT', TO_DATE('2017-06-15', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (103, 'Carol White', 'Developer', 62000, 'IT', TO_DATE('2018-01-20', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (104, 'Diana Lee', 'HR Manager', 72000, 'HR', TO_DATE('2016-08-01', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (105, 'Eric Davis', 'HR Specialist', 55000, 'HR', TO_DATE('2019-02-11', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (106, 'Fiona Brown', 'Finance Manager', 85000, 'Finance', TO_DATE('2014-11-05', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (107, 'George Martin', 'Accountant', 58000, 'Finance', TO_DATE('2018-09-18', 'YYYY-MM-DD'));

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate)
VALUES (108, 'Helen Garcia', 'Accountant', 56000, 'Finance', TO_DATE('2019-05-22', 'YYYY-MM-DD'));

COMMIT;

-- ====================================================================
-- INSERT TRANSACTIONS (Sample)
-- ====================================================================
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (1, 1, TO_DATE('2026-06-10', 'YYYY-MM-DD'), 1000, 'DEPOSIT');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (2, 2, TO_DATE('2026-06-12', 'YYYY-MM-DD'), 500, 'WITHDRAWAL');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (3, 3, TO_DATE('2026-06-11', 'YYYY-MM-DD'), 2000, 'DEPOSIT');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (4, 4, TO_DATE('2026-06-13', 'YYYY-MM-DD'), 5000, 'WITHDRAWAL');

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
VALUES (5, 5, TO_DATE('2026-06-09', 'YYYY-MM-DD'), 3000, 'TRANSFER');

COMMIT;

-- ====================================================================
-- VERIFICATION QUERIES
-- ====================================================================
DBMS_OUTPUT.PUT_LINE('Sample data inserted successfully!');
DBMS_OUTPUT.PUT_LINE(' ');
DBMS_OUTPUT.PUT_LINE('Customers: ' || (SELECT COUNT(*) FROM Customers));
DBMS_OUTPUT.PUT_LINE('Accounts: ' || (SELECT COUNT(*) FROM Accounts));
DBMS_OUTPUT.PUT_LINE('Loans: ' || (SELECT COUNT(*) FROM Loans));
DBMS_OUTPUT.PUT_LINE('Employees: ' || (SELECT COUNT(*) FROM Employees));
DBMS_OUTPUT.PUT_LINE('Transactions: ' || (SELECT COUNT(*) FROM Transactions));
