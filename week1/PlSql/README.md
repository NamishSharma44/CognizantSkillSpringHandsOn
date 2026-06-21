# Oracle PL/SQL Banking Assignment

Complete solution for Exercise 1 (Control Structures) and Exercise 3 (Stored Procedures) with detailed documentation and execution instructions.

---

## 📋 Table of Contents

1. [Project Overview](#project-overview)
2. [Database Schema](#database-schema)
3. [Exercise 1: Control Structures](#exercise-1-control-structures)
4. [Exercise 3: Stored Procedures](#exercise-3-stored-procedures)
5. [Setup Instructions](#setup-instructions)
6. [Execution Guide](#execution-guide)
7. [Verification Queries](#verification-queries)
8. [Screenshot Checklist](#screenshot-checklist)
9. [Git Workflow](#git-workflow)

---

## 🎯 Project Overview

This banking system assignment demonstrates advanced PL/SQL programming concepts:

- **Control Structures**: Loops, conditionals, and cursor processing
- **Stored Procedures**: Parameterized procedures with input validation
- **Transaction Management**: COMMIT, ROLLBACK, and SAVEPOINT
- **Error Handling**: Exception handling and validation
- **Data Manipulation**: Complex UPDATE, INSERT operations

### Target Database
- **Oracle Database** (11g R2 or higher)
- Compatible with SQL*Plus, SQLcl, or VS Code Oracle extension

---

## 📊 Database Schema

### Tables

```
CUSTOMERS
├── CustomerID (PK)
├── Name
├── DOB (Date of Birth)
├── Balance
├── LastModified
└── IsVIP (added in Scenario 2)

ACCOUNTS
├── AccountID (PK)
├── CustomerID (FK)
├── AccountType (Savings/Checking)
├── Balance
└── LastModified

TRANSACTIONS
├── TransactionID (PK)
├── AccountID (FK)
├── TransactionDate
├── Amount
└── TransactionType

LOANS
├── LoanID (PK)
├── CustomerID (FK)
├── LoanAmount
├── InterestRate
├── StartDate
└── EndDate

EMPLOYEES
├── EmployeeID (PK)
├── Name
├── Position
├── Salary
├── Department
└── HireDate
```

---

## 🔄 Exercise 1: Control Structures

### Scenario 1: Senior Citizen Discount

**File**: `exercise1_scenario1.sql`

**Objective**: Loop through all customers, calculate age from DOB, and if age > 60, apply 1% discount to loan interest rates.

**Key Concepts**:
- Explicit Cursor with FOR loop
- Age calculation: `(SYSDATE - DOB) / 365.25`
- IF condition checking
- UPDATE statement within loop
- DBMS_OUTPUT for reporting

**Algorithm**:
```
FOR each customer:
    1. Calculate age from DOB
    2. IF age > 60:
        a. Apply 1% discount to all their loans
        b. Update InterestRate = InterestRate * 0.99
        c. Display update details
    3. COMMIT changes
```

**Expected Output**:
```
========================================
SENIOR CITIZEN DISCOUNT PROCESSING
========================================
Processing: Applying 1% discount to loans for customers aged > 60

Customer: John Davis (ID: 1)
  DOB: 15-MAY-1960 | Age: 64
  Status: SENIOR CITIZEN - Applying 1% discount
    Loan ID: 1 | New Rate: 4.95%

Customer: Sarah Johnson (ID: 2)
  DOB: 22-AUG-1978 | Age: 47
  Status: Not eligible for discount
```

---

### Scenario 2: VIP Customer Classification

**File**: `exercise1_scenario2.sql`

**Objective**: Add IsVIP column if necessary and mark customers as VIP if Balance > 10000.

**Key Concepts**:
- Dynamic column addition check
- `user_tab_columns` system view
- `EXECUTE IMMEDIATE` for DDL
- Cursor ordering by Balance DESC
- UPDATE based on balance threshold

**Algorithm**:
```
1. Check if IsVIP column exists
2. IF NOT EXISTS:
    a. ALTER TABLE to add IsVIP column (default 'N')
3. FOR each customer ORDER BY Balance DESC:
    a. IF Balance > 10000:
        i. Set IsVIP = 'Y'
        ii. Update Customers table
    b. ELSE:
        i. Set IsVIP = 'N'
4. Display classification results
5. COMMIT changes
```

**Expected Output**:
```
========================================
VIP CUSTOMER CLASSIFICATION
========================================
VIP Threshold: Balance > 10000

Customer: Michael Chen (ID: 3)
  Balance: $25000.00
  Status: UPGRADED TO VIP ✓

Customer: John Davis (ID: 1)
  Balance: $15000.00
  Status: UPGRADED TO VIP ✓

Customer: Robert Martinez (ID: 5)
  Balance: $18000.00
  Status: UPGRADED TO VIP ✓
```

---

### Scenario 3: Loan Payment Reminders

**File**: `exercise1_scenario3.sql`

**Objective**: Find loans due within 30 days and print reminder messages.

**Key Concepts**:
- Cursor with JOIN operations
- Date arithmetic: `EndDate - SYSDATE`
- CASE statement for urgency levels
- Conditional calculations within loop
- Summary reporting

**Algorithm**:
```
1. Create cursor for loans WHERE:
    a. EndDate > SYSDATE (not yet due)
    b. EndDate <= SYSDATE + 30 (due within 30 days)
2. FOR each upcoming loan:
    a. Calculate DaysUntilDue = EndDate - SYSDATE
    b. Determine urgency:
        i. IF DaysUntilDue <= 7: URGENT
        ii. ELSIF DaysUntilDue <= 14: WARNING
        iii. ELSE: REMINDER
    c. Display loan details with urgency level
    d. Check customer's available balance
3. Display summary with totals
```

**Expected Output**:
```
========================================
LOAN PAYMENT REMINDER REPORT
========================================
Generated on: 21-JUN-2026 14:30:00
Checking for loans due within 30 days...

[URGENT] ⚠️  Loan Due Soon!
  Loan ID: 1
  Customer: John Davis (ID: 1)
  Loan Amount: $50000.00
  Interest Rate: 4.95%
  Start Date: 01-JAN-2023
  Due Date: 10-JUL-2026
  Days Until Due: 9 days
  Customer Account Balance: $15000.00
  Total Amount with Interest: $74750.00
  ✓ Customer has sufficient balance to pay
```

---

## 🔧 Exercise 3: Stored Procedures

### Scenario 1: ProcessMonthlyInterest

**File**: `process_monthly_interest.sql`

**Objective**: Create procedure that adds 1% interest to all Savings accounts.

**Signature**:
```sql
PROCEDURE ProcessMonthlyInterest
```

**Key Concepts**:
- Procedure without parameters
- Cursor looping
- Transaction INSERT into Transactions table
- COMMIT and error handling with ROLLBACK

**Functionality**:
```
1. FOR each Savings account:
    a. Calculate InterestAmount = Balance * 0.01
    b. UPDATE Accounts Balance = Balance + InterestAmount
    c. INSERT transaction record with type = 'INTEREST'
    d. Track total interest added
2. COMMIT all changes
3. Display detailed report
```

**Execution**:
```sql
SET SERVEROUTPUT ON;
EXEC ProcessMonthlyInterest;
```

**Expected Output**:
```
========================================
MONTHLY INTEREST PROCESSING
Processing Date: 21-JUN-2026 14:45:30
Account Type: Savings Accounts
Interest Rate: 1%
========================================

Account ID: 1 (Customer: 1)
  Old Balance: $15000.00
  Interest Added: $150.00
  New Balance: $15150.00

Account ID: 3 (Customer: 2)
  Old Balance: $8500.00
  Interest Added: $85.00
  New Balance: $8585.00

========================================
PROCESSING COMPLETE
Total Accounts Updated: 6
Total Interest Credited: $875.50
========================================
```

---

### Scenario 2: UpdateEmployeeBonus

**File**: `update_employee_bonus.sql`

**Objective**: Update employee salaries based on department and bonus percentage.

**Signature**:
```sql
PROCEDURE UpdateEmployeeBonus (
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
)
```

**Parameters**:
- `p_department` (IN VARCHAR2): Department name (IT, HR, Finance, etc.)
- `p_bonus_percentage` (IN NUMBER): Bonus percentage (0-100)

**Input Validation**:
- Department cannot be NULL
- Bonus percentage must be 0-100
- Department must exist in Employees table

**Functionality**:
```
1. Validate inputs:
    a. IF p_department is NULL: Raise error
    b. IF p_bonus_percentage < 0 or > 100: Raise error
    c. IF no employees in department: Raise error
2. FOR each employee in department:
    a. Calculate BonusAmount = Salary * (p_bonus_percentage / 100)
    b. NewSalary = Salary + BonusAmount
    c. UPDATE Employees SET Salary = NewSalary
    d. Track total bonus given
3. COMMIT changes
4. Display detailed report with calculations
```

**Execution**:
```sql
SET SERVEROUTPUT ON;
EXEC UpdateEmployeeBonus('IT', 10);
EXEC UpdateEmployeeBonus('Finance', 8);
EXEC UpdateEmployeeBonus('HR', 5);
```

**Expected Output**:
```
========================================
EMPLOYEE BONUS UPDATE
Processing Date: 21-JUN-2026 15:00:00
Department: IT
Bonus Percentage: 10%
========================================

Employee ID: 101
  Name: Alice Smith
  Position: Manager
  Old Salary: $80000.00
  Bonus Amount (10%): $8000.00
  New Salary: $88000.00
  Percentage Increase: 10.00%

Employee ID: 102
  Name: Bob Johnson
  Position: Developer
  Old Salary: $65000.00
  Bonus Amount (10%): $6500.00
  New Salary: $71500.00
  Percentage Increase: 10.00%

========================================
UPDATE COMPLETE
Total Employees Updated: 3
Total Bonus Amount: $20500.00
Average Bonus per Employee: $6833.33
========================================
```

---

### Scenario 3: TransferFunds

**File**: `transfer_funds.sql`

**Objective**: Transfer money between accounts with balance validation.

**Signature**:
```sql
PROCEDURE TransferFunds (
    p_from_account_id IN NUMBER,
    p_to_account_id IN NUMBER,
    p_transfer_amount IN NUMBER
)
```

**Parameters**:
- `p_from_account_id` (IN NUMBER): Source account ID
- `p_to_account_id` (IN NUMBER): Destination account ID
- `p_transfer_amount` (IN NUMBER): Amount to transfer

**Input Validation**:
- Account IDs cannot be NULL
- Transfer amount must be > 0
- Cannot transfer to same account
- FROM account must exist
- TO account must exist
- FROM account must have sufficient balance

**Functionality**:
```
1. Validate all inputs
2. Fetch FROM account details (balance, customer info)
3. Fetch TO account details
4. Check IF FROM balance < transfer amount:
    a. Display error and rollback
5. SAVEPOINT transfer_start
6. UPDATE FROM account: Balance -= transfer_amount
7. UPDATE TO account: Balance += transfer_amount
8. INSERT DEBIT transaction for FROM account
9. INSERT CREDIT transaction for TO account
10. COMMIT
11. Display success with new balances
```

**Execution**:
```sql
SET SERVEROUTPUT ON;
EXEC TransferFunds(1, 2, 100);    -- Transfer $100
EXEC TransferFunds(2, 3, 250);    -- Transfer $250
EXEC TransferFunds(1, 3, 500000); -- Will fail (insufficient funds)
```

**Expected Output**:
```
========================================
FUND TRANSFER PROCESSING
Processing Date: 21-JUN-2026 15:15:30
========================================

FROM Account:
  Account ID: 1
  Customer: John Davis
  Account Type: Savings
  Current Balance: $15000.00

TO Account:
  Account ID: 2
  Customer: John Davis
  Account Type: Checking
  Current Balance: $5000.00

Transfer Amount: $100.00

✓ TRANSFER SUCCESSFUL

Updated Balances:
  FROM Account: $14900.00
  TO Account: $5100.00

Transaction IDs: 6, 7
========================================
```

---

## 🚀 Setup Instructions

### Prerequisites
- Oracle Database 11g R2 or higher
- SQL*Plus, SQLcl, or VS Code Oracle extension installed
- Connection to Oracle database

### Step 1: Create Database Objects

Run the schema creation file (if not already done):
```bash
sqlplus username/password@database @banking_schema.sql
```

### Step 2: Insert Sample Data

```bash
sqlplus username/password@database @sample_data.sql
```

This will create 8 customers, 10 accounts, 5 loans, and 8 employees.

### Step 3: Verify Schema

```bash
sqlplus username/password@database @verification_queries.sql
```

---

## 🔧 Execution Guide

### Using SQL*Plus

```bash
# Connect to Oracle
sqlplus username/password@database

# Enable output display
SET SERVEROUTPUT ON;

# Run Exercise 1 - Scenario 1
@exercise1_scenario1.sql

# Run Exercise 1 - Scenario 2
@exercise1_scenario2.sql

# Run Exercise 1 - Scenario 3
@exercise1_scenario3.sql

# Create procedures (Exercise 3)
@process_monthly_interest.sql
@update_employee_bonus.sql
@transfer_funds.sql

# Execute procedures
EXEC ProcessMonthlyInterest;
EXEC UpdateEmployeeBonus('IT', 10);
EXEC TransferFunds(1, 2, 100);
```

### Using SQLcl

```bash
# Connect
sqlcl username/password@database

# Run scripts
@exercise1_scenario1.sql
@exercise1_scenario2.sql
@exercise1_scenario3.sql
```

### Using VS Code Oracle Extension

1. Install Oracle Database Explorer extension
2. Create connection to database
3. Right-click on connection → New SQL File
4. Copy contents from exercise files
5. Execute with F5 or right-click → Run

---

## ✅ Verification Queries

File: `verification_queries.sql`

Key verification queries:

**1. View Senior Citizens with Age**:
```sql
SELECT CustomerID, Name, Age, Status
FROM (SELECT CustomerID, Name, TRUNC((SYSDATE - DOB) / 365.25) AS Age FROM Customers)
WHERE Age > 60;
```

**2. View VIP Customers**:
```sql
SELECT CustomerID, Name, Balance, IsVIP 
FROM Customers 
WHERE IsVIP = 'Y' 
ORDER BY Balance DESC;
```

**3. View Loans Due Within 30 Days**:
```sql
SELECT LoanID, CustomerID, EndDate, TRUNC(EndDate - SYSDATE) AS DaysUntilDue
FROM Loans
WHERE EndDate BETWEEN SYSDATE AND SYSDATE + 30
ORDER BY EndDate ASC;
```

**4. View Savings Account Balances**:
```sql
SELECT a.AccountID, c.Name, a.Balance
FROM Accounts a
JOIN Customers c ON a.CustomerID = c.CustomerID
WHERE a.AccountType = 'Savings'
ORDER BY a.Balance DESC;
```

**5. View Transaction History**:
```sql
SELECT t.TransactionID, a.AccountID, c.Name, t.Amount, t.TransactionType, t.TransactionDate
FROM Transactions t
JOIN Accounts a ON t.AccountID = a.AccountID
JOIN Customers c ON a.CustomerID = c.CustomerID
ORDER BY t.TransactionDate DESC;
```

---

## 📸 Screenshot Checklist

Take screenshots of the following for submission:

### Exercise 1 - Scenario 1
- [ ] SQL*Plus output showing senior citizen processing
- [ ] Query result showing updated loan interest rates
- [ ] Table showing ages and discount status

### Exercise 1 - Scenario 2
- [ ] SQL*Plus output showing VIP classification
- [ ] Customers table with IsVIP column
- [ ] Department statistics showing VIP vs regular customers

### Exercise 1 - Scenario 3
- [ ] SQL*Plus output showing loan reminders
- [ ] Result set with urgency levels and days until due
- [ ] Summary statistics

### Exercise 3 - Scenario 1
- [ ] Procedure creation output
- [ ] SQL*Plus execution output for ProcessMonthlyInterest
- [ ] Accounts table before and after showing updated balances
- [ ] Transactions table showing INTEREST entries

### Exercise 3 - Scenario 2
- [ ] Procedure creation output
- [ ] SQL*Plus execution with different department calls
- [ ] Employees table before and after showing updated salaries
- [ ] Department salary statistics

### Exercise 3 - Scenario 3
- [ ] Procedure creation output
- [ ] Successful transfer execution
- [ ] Failed transfer execution (insufficient funds)
- [ ] Accounts table showing balance updates
- [ ] Transactions table showing DEBIT and CREDIT entries

### General
- [ ] DB Schema diagram or text description
- [ ] Sample data query results
- [ ] Verification queries output
- [ ] Code files in VS Code
- [ ] All files committed to Git

---

## 📦 Git Workflow

### Initialize Repository

```bash
# Navigate to project directory
cd /home/nishxnt/VsCode/Cognizant/week1/PlSql

# Initialize git repository
git init

# Add remote origin
git remote add origin https://github.com/your-username/oracle-banking-assignment.git

# Create .gitignore
cat > .gitignore << 'EOF'
*.db
*.exe
.DS_Store
*.log
EOF

# Add all files
git add .

# Initial commit
git commit -m "Initial commit: Oracle PL/SQL banking assignment"

# Push to GitHub
git push -u origin main
```

### Workflow After Each Exercise

```bash
# After completing Exercise 1 - Scenario 1
git add exercise1_scenario1.sql
git commit -m "feat: Exercise 1 Scenario 1 - Senior citizen discount logic"
git push

# After completing Exercise 1 - Scenario 2
git add exercise1_scenario2.sql
git commit -m "feat: Exercise 1 Scenario 2 - VIP customer classification"
git push

# After completing Exercise 1 - Scenario 3
git add exercise1_scenario3.sql
git commit -m "feat: Exercise 1 Scenario 3 - Loan payment reminders"
git push

# After creating stored procedures
git add process_monthly_interest.sql update_employee_bonus.sql transfer_funds.sql
git commit -m "feat: Exercise 3 - All stored procedures implemented"
git push

# After adding documentation
git add README.md sample_data.sql verification_queries.sql
git commit -m "docs: Add comprehensive documentation and test data"
git push
```

### View Git Log

```bash
git log --oneline
git log --graph --all --oneline --decorate
```

### Create GitHub Repository

1. Go to https://github.com/new
2. Repository name: `oracle-banking-assignment`
3. Description: "Oracle PL/SQL Banking System - Control Structures & Stored Procedures"
4. Make it Public
5. Click "Create repository"
6. Follow commands above to push

---

## 📚 File Structure

```
PlSql/
├── README.md                      # This file
├── banking_schema.sql             # Database schema creation
├── sample_data.sql                # Sample data for testing
├── verification_queries.sql       # Verification queries
│
├── exercise1_scenario1.sql        # Senior citizen discount
├── exercise1_scenario2.sql        # VIP classification
├── exercise1_scenario3.sql        # Loan reminders
│
├── process_monthly_interest.sql   # Monthly interest procedure
├── update_employee_bonus.sql      # Employee bonus procedure
└── transfer_funds.sql             # Fund transfer procedure
```

---

## 🆘 Troubleshooting

### Issue: "Package or type does not exist: DBMS_OUTPUT"
**Solution**: Enable output in SQL*Plus
```sql
SET SERVEROUTPUT ON;
SET PAGESIZE 50;
SET LINESIZE 120;
```

### Issue: "ORA-01403: no data found"
**Solution**: Ensure sample data is inserted
```sql
@sample_data.sql
```

### Issue: Procedure not found
**Solution**: Recreate procedure
```sql
@process_monthly_interest.sql
DROP PROCEDURE ProcessMonthlyInterest;
-- Then recreate
@process_monthly_interest.sql
```

### Issue: Column IsVIP already exists
**Solution**: The script handles this gracefully, but if error occurs:
```sql
ALTER TABLE Customers DROP COLUMN IsVIP;
```

---

## 📋 Checklist Before Submission

- [ ] All 6 SQL files created and tested
- [ ] Sample data inserted successfully
- [ ] All scenarios execute without errors
- [ ] Verification queries show expected results
- [ ] Screenshots taken for all scenarios
- [ ] README.md complete with documentation
- [ ] All files added to Git
- [ ] Repository pushed to GitHub
- [ ] Code comments explain logic
- [ ] Error handling implemented
- [ ] Transactions properly committed/rolled back

---

## 👤 Author Notes

This assignment demonstrates:
1. **PL/SQL Control Flow**: Loops, conditions, cursors
2. **Procedure Design**: Parameters, validation, error handling
3. **Database Transactions**: COMMIT, ROLLBACK, SAVEPOINT
4. **Reporting**: DBMS_OUTPUT for user feedback
5. **Data Integrity**: Balance checks, constraint validation
6. **Real-world Scenarios**: Banking operations, payroll, transfers

---

## 📞 Support

For issues or questions:
1. Check Oracle documentation
2. Review error messages carefully
3. Verify sample data is present
4. Ensure database connection is active
5. Check user privileges (CREATE PROCEDURE, ALTER TABLE)

---

**Last Updated**: 21-JUN-2026
**Version**: 1.0
**Status**: Ready for Submission
