-- ====================================================================
-- SQLite TEST VERSION - EXERCISE 1 SCENARIO 1
-- ====================================================================
-- Senior Citizen Discount (1% loan interest reduction for age > 60)
-- SQLite version with simulated output
-- ====================================================================

.headers on
.mode column
.width 12 20 15 12 12

-- Setup: Clear and prepare test data
DELETE FROM Loans;
DELETE FROM Accounts;
DELETE FROM Customers;

INSERT INTO Customers VALUES (1, 'John Davis', '1960-05-15', 15000, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (2, 'Sarah Johnson', '1978-08-22', 8500, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (3, 'Michael Chen', '1965-03-10', 25000, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (4, 'Emily Wilson', '1990-11-30', 5200, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (5, 'Robert Martinez', '1952-07-18', 18000, CURRENT_TIMESTAMP);

INSERT INTO Loans VALUES (1, 1, 50000, 0.05, '2023-01-01', '2026-07-10');
INSERT INTO Loans VALUES (2, 2, 30000, 0.04, '2023-06-15', '2026-08-20');
INSERT INTO Loans VALUES (3, 3, 100000, 0.045, '2022-05-01', '2027-05-01');
INSERT INTO Loans VALUES (4, 5, 75000, 0.055, '2023-03-20', '2026-07-05');

COMMIT;

-- Display report header
SELECT '========================================' AS Report;
SELECT 'SENIOR CITIZEN DISCOUNT PROCESSING' AS Report;
SELECT '========================================' AS Report;
SELECT 'Processing: Applying 1% discount to loans for customers aged > 60' AS Report;
SELECT '' AS Report;

-- Calculate ages and apply discount
SELECT 
    c.CustomerID,
    c.Name,
    c.DOB,
    CAST((julianday('now') - julianday(c.DOB)) / 365.25 AS INTEGER) AS Age,
    CASE 
        WHEN CAST((julianday('now') - julianday(c.DOB)) / 365.25 AS INTEGER) > 60 
        THEN 'SENIOR CITIZEN - Applying 1% discount' 
        ELSE 'Not eligible for discount' 
    END AS Status
FROM Customers c
ORDER BY c.CustomerID;

SELECT '' AS Report;
SELECT 'LOAN INTEREST RATES - AFTER DISCOUNT' AS Report;
SELECT '========================================' AS Report;

-- Show loans with adjusted rates
SELECT 
    l.LoanID,
    l.CustomerID,
    c.Name,
    l.LoanAmount,
    CAST(l.InterestRate * 100 AS TEXT) || '%' AS OriginalRate,
    CASE 
        WHEN CAST((julianday('now') - julianday(c.DOB)) / 365.25 AS INTEGER) > 60
        THEN CAST(l.InterestRate * 0.99 * 100 AS TEXT) || '%'
        ELSE CAST(l.InterestRate * 100 AS TEXT) || '%'
    END AS AdjustedRate,
    CASE 
        WHEN CAST((julianday('now') - julianday(c.DOB)) / 365.25 AS INTEGER) > 60
        THEN '✓ DISCOUNTED'
        ELSE '-'
    END AS Status
FROM Loans l
JOIN Customers c ON l.CustomerID = c.CustomerID
ORDER BY l.CustomerID;

SELECT '' AS Report;
SELECT '========================================' AS Report;
SELECT 'Processing Complete!' AS Report;
SELECT '========================================' AS Report;

-- Simulate the UPDATE
UPDATE Loans 
SET InterestRate = InterestRate * 0.99
WHERE CustomerID IN (
    SELECT CustomerID FROM Customers 
    WHERE CAST((julianday('now') - julianday(DOB)) / 365.25 AS INTEGER) > 60
);

SELECT 'Total Loans Updated: ' || CAST(changes() AS TEXT) AS Summary;
SELECT '========================================' AS Report;

COMMIT;
