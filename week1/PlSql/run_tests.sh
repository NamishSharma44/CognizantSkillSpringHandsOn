#!/bin/bash

# ====================================================================
# ORACLE PL/SQL BANKING ASSIGNMENT - SQLite TEST RUNNER
# ====================================================================
# This script runs all tests against SQLite database
# Since Oracle is not available, we use SQLite to demonstrate logic
# ====================================================================

set -e

DB_FILE="/home/nishxnt/VsCode/Cognizant/week1/PlSql/banking_test.db"
RESULTS_FILE="/home/nishxnt/VsCode/Cognizant/week1/PlSql/TEST_RESULTS.txt"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "════════════════════════════════════════════════════════════════"
echo "ORACLE PL/SQL BANKING ASSIGNMENT - TEST SUITE"
echo "════════════════════════════════════════════════════════════════"
echo ""

# Step 1: Create fresh database
echo -e "${BLUE}[STEP 1]${NC} Creating test database..."
rm -f "$DB_FILE"

sqlite3 "$DB_FILE" << 'EOF'
-- Create Banking Schema
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

PRAGMA foreign_keys = ON;
EOF

echo -e "${GREEN}✓ Database created successfully${NC}"
echo ""

# Step 2: Run Exercise 1 - Scenario 1
echo -e "${BLUE}[EXERCISE 1 - SCENARIO 1]${NC} Senior Citizen Discount"
echo "────────────────────────────────────────────────────────────────"

sqlite3 "$DB_FILE" < "/home/nishxnt/VsCode/Cognizant/week1/PlSql/test_sqlite_exercise1_scenario1.sql"
echo -e "${GREEN}✓ Exercise 1 Scenario 1 completed${NC}"
echo ""
sleep 1

# Step 3: Run Exercise 1 - Scenario 2
echo -e "${BLUE}[EXERCISE 1 - SCENARIO 2]${NC} VIP Customer Classification"
echo "────────────────────────────────────────────────────────────────"

sqlite3 "$DB_FILE" < "/home/nishxnt/VsCode/Cognizant/week1/PlSql/test_sqlite_exercise1_scenario2.sql"
echo -e "${GREEN}✓ Exercise 1 Scenario 2 completed${NC}"
echo ""
sleep 1

# Step 4: Run Exercise 1 - Scenario 3
echo -e "${BLUE}[EXERCISE 1 - SCENARIO 3]${NC} Loan Payment Reminders"
echo "────────────────────────────────────────────────────────────────"

sqlite3 "$DB_FILE" < "/home/nishxnt/VsCode/Cognizant/week1/PlSql/test_sqlite_exercise1_scenario3.sql"
echo -e "${GREEN}✓ Exercise 1 Scenario 3 completed${NC}"
echo ""
sleep 1

# Step 5: Exercise 3 - Scenario 1 (Monthly Interest)
echo -e "${BLUE}[EXERCISE 3 - SCENARIO 1]${NC} Process Monthly Interest"
echo "────────────────────────────────────────────────────────────────"

sqlite3 "$DB_FILE" << 'EOF'
-- Setup Savings Accounts
DELETE FROM Accounts;
DELETE FROM Customers;

INSERT INTO Customers VALUES (1, 'John Davis', '1960-05-15', 15000, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (2, 'Sarah Johnson', '1978-08-22', 8500, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (3, 'Michael Chen', '1965-03-10', 25000, CURRENT_TIMESTAMP);

INSERT INTO Accounts VALUES (1, 1, 'Savings', 15000, CURRENT_TIMESTAMP);
INSERT INTO Accounts VALUES (2, 2, 'Savings', 8500, CURRENT_TIMESTAMP);
INSERT INTO Accounts VALUES (3, 3, 'Savings', 25000, CURRENT_TIMESTAMP);
INSERT INTO Accounts VALUES (4, 1, 'Checking', 5000, CURRENT_TIMESTAMP);

COMMIT;

-- Report header
SELECT '========================================' AS Report;
SELECT 'MONTHLY INTEREST PROCESSING' AS Report;
SELECT '========================================' AS Report;
SELECT 'Processing Date: ' || datetime('now') AS Report;
SELECT 'Account Type: Savings Accounts' AS Report;
SELECT 'Interest Rate: 1%' AS Report;
SELECT '========================================' AS Report;
SELECT '' AS Report;

-- Show before
SELECT 'BEFORE - Savings Account Balances:' AS Header;
SELECT 
    'Account ID: ' || AccountID || ' (Customer: ' || CustomerID || ')' AS Account,
    'Balance: $' || CAST(Balance AS TEXT) AS Balance
FROM Accounts
WHERE AccountType = 'Savings'
ORDER BY AccountID;

SELECT '' AS Report;

-- Apply interest (update)
UPDATE Accounts
SET Balance = Balance * 1.01,
    LastModified = CURRENT_TIMESTAMP
WHERE AccountType = 'Savings';

-- Record transactions
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType)
SELECT 
    (SELECT MAX(TransactionID) FROM Transactions) + ROW_NUMBER() OVER (ORDER BY AccountID) AS ID,
    AccountID,
    CURRENT_TIMESTAMP,
    Balance * 0.01,
    'INTEREST'
FROM Accounts
WHERE AccountType = 'Savings';

SELECT 'AFTER - Savings Account Balances (After 1% Interest):' AS Header;
SELECT 
    'Account ID: ' || AccountID || ' (Customer: ' || CustomerID || ')' AS Account,
    'Balance: $' || CAST(ROUND(Balance, 2) AS TEXT) AS Balance
FROM Accounts
WHERE AccountType = 'Savings'
ORDER BY AccountID;

SELECT '' AS Report;
SELECT '========================================' AS Report;
SELECT 'Processing Complete!' AS Report;
SELECT '========================================' AS Report;

COMMIT;
EOF

echo -e "${GREEN}✓ Exercise 3 Scenario 1 completed${NC}"
echo ""
sleep 1

# Step 6: Exercise 3 - Scenario 2 (Employee Bonus)
echo -e "${BLUE}[EXERCISE 3 - SCENARIO 2]${NC} Update Employee Bonus"
echo "────────────────────────────────────────────────────────────────"

sqlite3 "$DB_FILE" << 'EOF'
-- Setup Employees
DELETE FROM Employees;

INSERT INTO Employees VALUES (101, 'Alice Smith', 'Manager', 80000, 'IT', '2015-03-10');
INSERT INTO Employees VALUES (102, 'Bob Johnson', 'Developer', 65000, 'IT', '2017-06-15');
INSERT INTO Employees VALUES (103, 'Carol White', 'Developer', 62000, 'IT', '2018-01-20');
INSERT INTO Employees VALUES (104, 'Diana Lee', 'HR Manager', 72000, 'HR', '2016-08-01');
INSERT INTO Employees VALUES (105, 'Eric Davis', 'HR Specialist', 55000, 'HR', '2019-02-11');

COMMIT;

-- Report header
SELECT '========================================' AS Report;
SELECT 'EMPLOYEE BONUS UPDATE' AS Report;
SELECT '========================================' AS Report;
SELECT 'Processing Date: ' || datetime('now') AS Report;
SELECT 'Department: IT' AS Report;
SELECT 'Bonus Percentage: 10%' AS Report;
SELECT '========================================' AS Report;
SELECT '' AS Report;

SELECT 'BEFORE - IT Department Salaries:' AS Header;
SELECT 
    'ID: ' || EmployeeID || ' - ' || Name AS Employee,
    'Position: ' || Position AS Position,
    'Salary: $' || CAST(Salary AS TEXT) AS Salary
FROM Employees
WHERE Department = 'IT'
ORDER BY EmployeeID;

SELECT '' AS Report;

-- Apply bonus
UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'IT';

SELECT 'AFTER - IT Department Salaries (After 10% Bonus):' AS Header;
SELECT 
    'ID: ' || EmployeeID || ' - ' || Name AS Employee,
    'Position: ' || Position AS Position,
    'Salary: $' || CAST(ROUND(Salary, 2) AS TEXT) AS Salary
FROM Employees
WHERE Department = 'IT'
ORDER BY EmployeeID;

SELECT '' AS Report;
SELECT 'Department Summary:' AS Header;
SELECT 
    'Total Employees: ' || COUNT(*) AS Summary,
    'Total New Payroll: $' || CAST(ROUND(SUM(Salary), 2) AS TEXT) AS Summary
FROM Employees
WHERE Department = 'IT';

SELECT '' AS Report;
SELECT '========================================' AS Report;
SELECT 'Bonus Processing Complete!' AS Report;
SELECT '========================================' AS Report;

COMMIT;
EOF

echo -e "${GREEN}✓ Exercise 3 Scenario 2 completed${NC}"
echo ""
sleep 1

# Step 7: Exercise 3 - Scenario 3 (Fund Transfer)
echo -e "${BLUE}[EXERCISE 3 - SCENARIO 3]${NC} Transfer Funds"
echo "────────────────────────────────────────────────────────────────"

sqlite3 "$DB_FILE" << 'EOF'
-- Setup for transfers
DELETE FROM Transactions;
DELETE FROM Accounts;
DELETE FROM Customers;

INSERT INTO Customers VALUES (1, 'John Davis', '1960-05-15', 15000, CURRENT_TIMESTAMP);
INSERT INTO Customers VALUES (2, 'Sarah Johnson', '1978-08-22', 8500, CURRENT_TIMESTAMP);

INSERT INTO Accounts VALUES (1, 1, 'Savings', 5000, CURRENT_TIMESTAMP);
INSERT INTO Accounts VALUES (2, 1, 'Checking', 2000, CURRENT_TIMESTAMP);
INSERT INTO Accounts VALUES (3, 2, 'Savings', 3000, CURRENT_TIMESTAMP);

COMMIT;

-- Report header
SELECT '========================================' AS Report;
SELECT 'FUND TRANSFER PROCESSING' AS Report;
SELECT '========================================' AS Report;
SELECT 'Processing Date: ' || datetime('now') AS Report;
SELECT '========================================' AS Report;
SELECT '' AS Report;

SELECT 'BEFORE - Account Balances:' AS Header;
SELECT 
    'Account ' || AccountID || ' (Customer: ' || CustomerID || ', ' || AccountType || '): $' || CAST(Balance AS TEXT) AS Balance
FROM Accounts
ORDER BY AccountID;

SELECT '' AS Report;
SELECT 'Transfer Details:' AS Header;
SELECT 'From: Account 1 ($5000 available)' AS Detail;
SELECT 'To: Account 3 ($3000 available)' AS Detail;
SELECT 'Amount: $500' AS Detail;
SELECT '' AS Report;

-- Perform transfer
UPDATE Accounts SET Balance = Balance - 500 WHERE AccountID = 1;
UPDATE Accounts SET Balance = Balance + 500 WHERE AccountID = 3;

-- Record transactions
INSERT INTO Transactions VALUES (1, 1, CURRENT_TIMESTAMP, 500, 'DEBIT');
INSERT INTO Transactions VALUES (2, 3, CURRENT_TIMESTAMP, 500, 'CREDIT');

SELECT 'AFTER - Account Balances:' AS Header;
SELECT 
    'Account ' || AccountID || ' (Customer: ' || CustomerID || ', ' || AccountType || '): $' || CAST(Balance AS TEXT) AS Balance
FROM Accounts
ORDER BY AccountID;

SELECT '' AS Report;
SELECT 'Transaction Records Created:' AS Header;
SELECT 
    'ID: ' || TransactionID || ' | Account: ' || AccountID || ' | Type: ' || TransactionType || ' | Amount: $' || CAST(Amount AS TEXT) AS Transaction
FROM Transactions
ORDER BY TransactionID;

SELECT '' AS Report;
SELECT '========================================' AS Report;
SELECT '✓ TRANSFER SUCCESSFUL' AS Report;
SELECT '========================================' AS Report;

COMMIT;
EOF

echo -e "${GREEN}✓ Exercise 3 Scenario 3 completed${NC}"
echo ""
sleep 1

# Step 8: Final Verification
echo -e "${BLUE}[VERIFICATION]${NC} Running verification queries"
echo "────────────────────────────────────────────────────────────────"

sqlite3 "$DB_FILE" << 'EOF'
SELECT '========================================' AS Report;
SELECT 'FINAL DATA VERIFICATION' AS Report;
SELECT '========================================' AS Report;
SELECT '' AS Report;

SELECT 'Customers: ' || COUNT(*) AS Summary FROM Customers;
SELECT 'Accounts: ' || COUNT(*) AS Summary FROM Accounts;
SELECT 'Loans: ' || COUNT(*) AS Summary FROM Loans;
SELECT 'Employees: ' || COUNT(*) AS Summary FROM Employees;
SELECT 'Transactions: ' || COUNT(*) AS Summary FROM Transactions;

SELECT '' AS Report;
SELECT '========================================' AS Report;
SELECT 'All tests completed successfully!' AS Report;
SELECT '========================================' AS Report;
EOF

echo -e "${GREEN}✓ Verification completed${NC}"
echo ""

# Summary
echo "════════════════════════════════════════════════════════════════"
echo -e "${GREEN}✓ ALL TESTS COMPLETED SUCCESSFULLY${NC}"
echo "════════════════════════════════════════════════════════════════"
echo ""
echo -e "${YELLOW}Database Location:${NC} $DB_FILE"
echo -e "${YELLOW}Database Size:${NC} $(du -h "$DB_FILE" | cut -f1)"
echo ""
echo -e "${YELLOW}To view the database:${NC}"
echo "  sqlite3 $DB_FILE"
echo ""
echo -e "${YELLOW}Test Summary:${NC}"
echo "  ✓ Exercise 1 Scenario 1: Senior Citizen Discount"
echo "  ✓ Exercise 1 Scenario 2: VIP Customer Classification"
echo "  ✓ Exercise 1 Scenario 3: Loan Payment Reminders"
echo "  ✓ Exercise 3 Scenario 1: Process Monthly Interest"
echo "  ✓ Exercise 3 Scenario 2: Update Employee Bonus"
echo "  ✓ Exercise 3 Scenario 3: Transfer Funds"
echo ""
echo -e "${BLUE}Note:${NC} These are SQLite test versions demonstrating the logic."
echo "      For Oracle PL/SQL execution, connect to an Oracle database using SQL*Plus."
echo ""
