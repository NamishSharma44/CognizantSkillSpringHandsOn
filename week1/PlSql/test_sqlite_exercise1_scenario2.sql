-- ====================================================================
-- SQLite TEST VERSION - EXERCISE 1 SCENARIO 2
-- ====================================================================
-- VIP Customer Classification (Balance > 10000)
-- SQLite version with simulated output
-- ====================================================================

.headers on
.mode column

-- Setup: Prepare test data
DELETE FROM Accounts;
DELETE FROM Customers;

INSERT INTO Customers VALUES (1, 'John Davis', '1960-05-15', 15000, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (2, 'Sarah Johnson', '1978-08-22', 8500, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (3, 'Michael Chen', '1965-03-10', 25000, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (4, 'Emily Wilson', '1990-11-30', 5200, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (5, 'Robert Martinez', '1952-07-18', 18000, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (6, 'Jennifer Brown', '1985-02-14', 12500, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (7, 'David Kim', '1975-09-05', 9750, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (8, 'Lisa Anderson', '1968-12-25', 22000, CURRENT_TIMESTAMP);

COMMIT;

-- Display report header
SELECT '========================================' AS Report;
SELECT 'VIP CUSTOMER CLASSIFICATION' AS Report;
SELECT '========================================' AS Report;
SELECT 'VIP Threshold: Balance > 10000' AS Report;
SELECT '' AS Report;

-- Add VIP column if not exists
--ALTER TABLE Customers ADD COLUMN IsVIP TEXT DEFAULT 'N';

-- Display customer classification
SELECT 
    c.CustomerID,
    c.Name,
    '$' || CAST(c.Balance AS TEXT) AS Balance,
    CASE 
        WHEN c.Balance > 10000 THEN 'Y' 
        ELSE 'N' 
    END AS IsVIP,
    CASE 
        WHEN c.Balance > 10000 THEN '✓ VIP Status Active' 
        ELSE 'Regular Customer' 
    END AS Status
FROM Customers c
ORDER BY c.Balance DESC;

SELECT '' AS Report;
SELECT '========================================' AS Report;
SELECT 'Classification Summary' AS Report;
SELECT '========================================' AS Report;

-- Summary statistics
SELECT 
    SUM(CASE WHEN Balance > 10000 THEN 1 ELSE 0 END) AS VIP_Count,
    SUM(CASE WHEN Balance <= 10000 THEN 1 ELSE 0 END) AS Regular_Count,
    COUNT(*) AS Total_Customers,
    '$' || CAST(SUM(CASE WHEN Balance > 10000 THEN Balance ELSE 0 END) AS TEXT) AS VIP_Total_Balance,
    '$' || CAST(SUM(CASE WHEN Balance <= 10000 THEN Balance ELSE 0 END) AS TEXT) AS Regular_Total_Balance
FROM Customers;

SELECT '' AS Report;
SELECT '========================================' AS Report;
SELECT 'Processing Complete!' AS Report;
SELECT '========================================' AS Report;

COMMIT;
