-- ====================================================================
-- SQLite TEST VERSION - EXERCISE 1 SCENARIO 3
-- ====================================================================
-- Loan Payment Reminders (Due within 30 days)
-- SQLite version with simulated output
-- ====================================================================

.headers on
.mode column

-- Setup: Prepare test data
DELETE FROM Loans;
DELETE FROM Accounts;
DELETE FROM Customers;

INSERT INTO Customers VALUES (1, 'John Davis', '1960-05-15', 15000, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (2, 'Sarah Johnson', '1978-08-22', 8500, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (3, 'Michael Chen', '1965-03-10', 25000, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (5, 'Robert Martinez', '1952-07-18', 18000, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (8, 'Lisa Anderson', '1968-12-25', 22000, CURRENT_TIMESTAMP);

INSERT INTO Loans VALUES (1, 1, 50000, 0.05, '2023-01-01', '2026-07-10');
INSERT INTO Loans VALUES (2, 2, 30000, 0.04, '2023-06-15', '2026-08-20');
INSERT INTO Loans VALUES (3, 3, 100000, 0.045, '2022-05-01', '2027-05-01');
INSERT INTO Loans VALUES (4, 5, 75000, 0.055, '2023-03-20', '2026-07-05');
INSERT INTO Loans VALUES (5, 8, 60000, 0.048, '2023-02-10', '2026-06-28');

COMMIT;

-- Display report header
SELECT '========================================' AS Report;
SELECT 'LOAN PAYMENT REMINDER REPORT' AS Report;
SELECT '========================================' AS Report;
SELECT 'Generated on: ' || datetime('now') AS Report;
SELECT 'Checking for loans due within 30 days...' AS Report;
SELECT '' AS Report;

-- Get current date for calculations
WITH loan_analysis AS (
    SELECT 
        l.LoanID,
        l.CustomerID,
        c.Name,
        c.Balance,
        l.LoanAmount,
        l.InterestRate,
        l.StartDate,
        l.EndDate,
        CAST((julianday(l.EndDate) - julianday('now')) AS INTEGER) AS DaysUntilDue,
        CASE 
            WHEN CAST((julianday(l.EndDate) - julianday('now')) AS INTEGER) <= 7 THEN 'URGENT'
            WHEN CAST((julianday(l.EndDate) - julianday('now')) AS INTEGER) <= 14 THEN 'WARNING'
            ELSE 'REMINDER'
        END AS Priority,
        CASE 
            WHEN CAST((julianday(l.EndDate) - julianday('now')) AS INTEGER) <= 7 THEN '[URGENT] ⚠️  Loan Due Soon!'
            WHEN CAST((julianday(l.EndDate) - julianday('now')) AS INTEGER) <= 14 THEN '[WARNING] Loan Due Approaching'
            ELSE '[REMINDER] Loan Due Notice'
        END AS Message
    FROM Loans l
    JOIN Customers c ON l.CustomerID = c.CustomerID
    WHERE l.EndDate > datetime('now')
    AND l.EndDate <= datetime('now', '+30 days')
)
SELECT 
    Message,
    'Loan ID: ' || LoanID AS Detail1,
    'Customer: ' || Name || ' (ID: ' || CustomerID || ')' AS Detail2,
    'Loan Amount: $' || CAST(LoanAmount AS TEXT) AS Detail3,
    'Interest Rate: ' || CAST(ROUND(InterestRate * 100, 2) AS TEXT) || '%' AS Detail4,
    'Start Date: ' || StartDate AS Detail5,
    'Due Date: ' || EndDate AS Detail6,
    'Days Until Due: ' || CAST(DaysUntilDue AS TEXT) || ' days' AS Detail7,
    'Customer Balance: $' || CAST(Balance AS TEXT) AS Detail8,
    CASE 
        WHEN Balance >= LoanAmount THEN '✓ Customer has sufficient balance to pay'
        ELSE '⚠️  WARNING: Customer may have insufficient funds'
    END AS PaymentStatus
FROM loan_analysis
ORDER BY EndDate ASC;

SELECT '' AS Report;
SELECT '----------------------------------------' AS Report;
SELECT '' AS Report;

-- Summary Report
SELECT '========================================' AS Report;
SELECT 'REMINDER SUMMARY' AS Report;
SELECT '========================================' AS Report;

WITH loan_analysis AS (
    SELECT 
        l.LoanID,
        CAST((julianday(l.EndDate) - julianday('now')) AS INTEGER) AS DaysUntilDue,
        l.LoanAmount
    FROM Loans l
    WHERE l.EndDate > datetime('now')
    AND l.EndDate <= datetime('now', '+30 days')
)
SELECT 
    'Total Reminders to Send: ' || COUNT(*) AS Summary
FROM loan_analysis;

SELECT 
    'Urgent (≤7 days): ' || CAST(SUM(CASE WHEN DaysUntilDue <= 7 THEN 1 ELSE 0 END) AS TEXT) AS Summary
FROM (
    SELECT CAST((julianday(EndDate) - julianday('now')) AS INTEGER) AS DaysUntilDue
    FROM Loans
    WHERE EndDate > datetime('now')
    AND EndDate <= datetime('now', '+30 days')
);

SELECT 
    'Total Amount Due (Principal): $' || CAST(SUM(LoanAmount) AS TEXT) AS Summary
FROM Loans
WHERE EndDate > datetime('now')
AND EndDate <= datetime('now', '+30 days');

SELECT '' AS Report;
SELECT '========================================' AS Report;
SELECT 'Processing Complete!' AS Report;
SELECT '========================================' AS Report;

COMMIT;
