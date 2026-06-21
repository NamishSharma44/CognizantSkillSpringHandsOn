-- ====================================================================
-- VERIFICATION QUERIES
-- ====================================================================
-- Use these queries to verify the results after running exercises
-- ====================================================================

-- ====================================================================
-- EXERCISE 1 - SCENARIO 1 VERIFICATION
-- ====================================================================
-- Query 1: View all customers with their age and senior status
DBMS_OUTPUT.PUT_LINE('EXERCISE 1 - SCENARIO 1 VERIFICATION');
DBMS_OUTPUT.PUT_LINE('======================================');
SELECT 
    CustomerID,
    Name,
    TO_CHAR(DOB, 'DD-MON-YYYY') AS DateOfBirth,
    TRUNC((SYSDATE - DOB) / 365.25) AS Age,
    CASE 
        WHEN TRUNC((SYSDATE - DOB) / 365.25) > 60 THEN 'SENIOR'
        ELSE 'REGULAR'
    END AS Status
FROM Customers
ORDER BY Age DESC;

-- Query 2: View loan interest rates after discount
SELECT 
    l.LoanID,
    l.CustomerID,
    c.Name,
    TRUNC((SYSDATE - c.DOB) / 365.25) AS Age,
    l.LoanAmount,
    ROUND(l.InterestRate * 100, 2) AS InterestRate_Percent,
    ROUND(l.InterestRate * l.LoanAmount, 2) AS AnnualInterestAmount
FROM Loans l
JOIN Customers c ON l.CustomerID = c.CustomerID
ORDER BY l.CustomerID;

DBMS_OUTPUT.PUT_LINE(' ');

-- ====================================================================
-- EXERCISE 1 - SCENARIO 2 VERIFICATION
-- ====================================================================
-- Query 3: View all customers with VIP status
DBMS_OUTPUT.PUT_LINE('EXERCISE 1 - SCENARIO 2 VERIFICATION');
DBMS_OUTPUT.PUT_LINE('======================================');
SELECT 
    CustomerID,
    Name,
    ROUND(Balance, 2) AS Balance,
    IsVIP,
    CASE 
        WHEN IsVIP = 'Y' THEN '✓ VIP Status Active'
        ELSE 'Regular Customer'
    END AS VIPStatus
FROM Customers
ORDER BY Balance DESC;

-- Query 4: VIP Customer Statistics
SELECT 
    COUNT(CASE WHEN IsVIP = 'Y' THEN 1 END) AS VIP_Count,
    COUNT(CASE WHEN IsVIP = 'N' THEN 1 END) AS Regular_Count,
    COUNT(*) AS Total_Customers,
    ROUND(SUM(CASE WHEN IsVIP = 'Y' THEN Balance ELSE 0 END), 2) AS VIP_Total_Balance,
    ROUND(SUM(CASE WHEN IsVIP = 'N' THEN Balance ELSE 0 END), 2) AS Regular_Total_Balance
FROM Customers;

DBMS_OUTPUT.PUT_LINE(' ');

-- ====================================================================
-- EXERCISE 1 - SCENARIO 3 VERIFICATION
-- ====================================================================
-- Query 5: View loans due within next 30 days
DBMS_OUTPUT.PUT_LINE('EXERCISE 1 - SCENARIO 3 VERIFICATION');
DBMS_OUTPUT.PUT_LINE('======================================');
SELECT 
    l.LoanID,
    l.CustomerID,
    c.Name,
    l.LoanAmount,
    ROUND(l.InterestRate * 100, 2) AS InterestRate_Percent,
    TO_CHAR(l.EndDate, 'DD-MON-YYYY') AS DueDate,
    TRUNC(l.EndDate - SYSDATE) AS DaysUntilDue,
    CASE 
        WHEN TRUNC(l.EndDate - SYSDATE) <= 7 THEN 'URGENT'
        WHEN TRUNC(l.EndDate - SYSDATE) <= 14 THEN 'WARNING'
        ELSE 'REMINDER'
    END AS Priority
FROM Loans l
JOIN Customers c ON l.CustomerID = c.CustomerID
WHERE l.EndDate > SYSDATE
  AND l.EndDate <= SYSDATE + 30
ORDER BY l.EndDate ASC;

DBMS_OUTPUT.PUT_LINE(' ');

-- ====================================================================
-- EXERCISE 3 - SCENARIO 1 VERIFICATION
-- ====================================================================
-- Query 6: View savings accounts and their balances
DBMS_OUTPUT.PUT_LINE('EXERCISE 3 - SCENARIO 1 VERIFICATION');
DBMS_OUTPUT.PUT_LINE('======================================');
SELECT 
    a.AccountID,
    a.CustomerID,
    c.Name,
    a.AccountType,
    ROUND(a.Balance, 2) AS Balance,
    TO_CHAR(a.LastModified, 'DD-MON-YYYY HH:MM:SS') AS LastModified
FROM Accounts a
JOIN Customers c ON a.CustomerID = c.CustomerID
WHERE a.AccountType = 'Savings'
ORDER BY a.AccountID;

-- Query 7: View interest transactions
SELECT 
    t.TransactionID,
    t.AccountID,
    t.TransactionDate,
    ROUND(t.Amount, 2) AS InterestAmount,
    t.TransactionType
FROM Transactions t
WHERE t.TransactionType = 'INTEREST'
ORDER BY t.TransactionDate DESC;

DBMS_OUTPUT.PUT_LINE(' ');

-- ====================================================================
-- EXERCISE 3 - SCENARIO 2 VERIFICATION
-- ====================================================================
-- Query 8: View employee salaries by department
DBMS_OUTPUT.PUT_LINE('EXERCISE 3 - SCENARIO 2 VERIFICATION');
DBMS_OUTPUT.PUT_LINE('======================================');
SELECT 
    EmployeeID,
    Name,
    Position,
    Department,
    ROUND(Salary, 2) AS Salary,
    TO_CHAR(HireDate, 'DD-MON-YYYY') AS HireDate
FROM Employees
ORDER BY Department, EmployeeID;

-- Query 9: Department salary statistics
SELECT 
    Department,
    COUNT(*) AS EmployeeCount,
    ROUND(MIN(Salary), 2) AS MinSalary,
    ROUND(MAX(Salary), 2) AS MaxSalary,
    ROUND(AVG(Salary), 2) AS AvgSalary,
    ROUND(SUM(Salary), 2) AS TotalPayroll
FROM Employees
GROUP BY Department
ORDER BY Department;

DBMS_OUTPUT.PUT_LINE(' ');

-- ====================================================================
-- EXERCISE 3 - SCENARIO 3 VERIFICATION
-- ====================================================================
-- Query 10: View all transactions
DBMS_OUTPUT.PUT_LINE('EXERCISE 3 - SCENARIO 3 VERIFICATION');
DBMS_OUTPUT.PUT_LINE('======================================');
SELECT 
    t.TransactionID,
    t.AccountID,
    a.CustomerID,
    c.Name,
    TO_CHAR(t.TransactionDate, 'DD-MON-YYYY HH:MM:SS') AS TransactionDate,
    ROUND(t.Amount, 2) AS Amount,
    t.TransactionType
FROM Transactions t
JOIN Accounts a ON t.AccountID = a.AccountID
JOIN Customers c ON a.CustomerID = c.CustomerID
ORDER BY t.TransactionDate DESC, t.TransactionID DESC;

-- Query 11: Account balance verification
SELECT 
    a.AccountID,
    a.CustomerID,
    c.Name,
    a.AccountType,
    ROUND(a.Balance, 2) AS CurrentBalance
FROM Accounts a
JOIN Customers c ON a.CustomerID = c.CustomerID
ORDER BY a.AccountID;

DBMS_OUTPUT.PUT_LINE(' ');
DBMS_OUTPUT.PUT_LINE('VERIFICATION COMPLETE');
