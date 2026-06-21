#!/bin/bash
# ====================================================================
# ORACLE PL/SQL BANKING ASSIGNMENT - FILE MANIFEST
# ====================================================================
# Complete list of deliverables with descriptions
# ====================================================================

cat << 'EOF'

╔════════════════════════════════════════════════════════════════════╗
║   ORACLE PL/SQL BANKING ASSIGNMENT - COMPLETE SOLUTION            ║
║   Exercise 1: Control Structures                                   ║
║   Exercise 3: Stored Procedures                                    ║
╚════════════════════════════════════════════════════════════════════╝

📁 PROJECT STRUCTURE
════════════════════════════════════════════════════════════════════

PlSql/
│
├─ 📄 README.md
│  └─ Comprehensive documentation with all details, examples, and instructions
│
├─ 📄 EXERCISE 1 FILES (Control Structures)
│  │
│  ├─ exercise1_scenario1.sql
│  │  Objective: Apply 1% discount to senior citizen loan interest rates
│  │  Concepts: Explicit cursor, FOR loop, age calculation, UPDATE
│  │  Key Formula: age = (SYSDATE - DOB) / 365.25
│  │
│  ├─ exercise1_scenario2.sql
│  │  Objective: Add IsVIP column and mark VIP customers (Balance > 10000)
│  │  Concepts: Dynamic column check, EXECUTE IMMEDIATE, conditional UPDATE
│  │  Features: Automatically adds IsVIP column if missing
│  │
│  └─ exercise1_scenario3.sql
│     Objective: Find and remind about loans due within 30 days
│     Concepts: JOIN cursor, date arithmetic, urgency levels, summary reporting
│     Features: URGENT (≤7 days), WARNING (8-14 days), REMINDER (15-30 days)
│
├─ 📄 EXERCISE 3 FILES (Stored Procedures)
│  │
│  ├─ process_monthly_interest.sql
│  │  Procedure: ProcessMonthlyInterest
│  │  Objective: Add 1% interest to all Savings accounts
│  │  Parameters: None
│  │  Features: Auto-creates transactions, detailed reporting
│  │
│  ├─ update_employee_bonus.sql
│  │  Procedure: UpdateEmployeeBonus(p_department, p_bonus_percentage)
│  │  Objective: Update employee salaries with bonus based on department
│  │  Parameters: Department name, Bonus percentage (0-100)
│  │  Features: Input validation, error handling, detailed calculations
│  │
│  └─ transfer_funds.sql
│     Procedure: TransferFunds(p_from_account_id, p_to_account_id, p_transfer_amount)
│     Objective: Transfer money between accounts with balance check
│     Parameters: Source account, destination account, transfer amount
│     Features: Validation, SAVEPOINT for rollback, transaction recording
│
├─ 📄 SUPPORT FILES
│  │
│  ├─ sample_data.sql
│  │  Inserts realistic test data:
│  │  - 8 Customers (with varied ages and balances)
│  │  - 10 Accounts (Savings and Checking)
│  │  - 5 Loans (with varying interest rates and due dates)
│  │  - 8 Employees (across IT, HR, Finance departments)
│  │  - 5 Sample Transactions
│  │
│  ├─ verification_queries.sql
│  │  11 comprehensive SELECT queries to verify results:
│  │  - Customer age and senior status
│  │  - Loan interest rates after discounts
│  │  - VIP classification results
│  │  - Loan payment reminders
│  │  - Account balances and interest
│  │  - Employee salary updates
│  │  - Transaction history
│  │
│  ├─ banking_schema.sql
│  │  Database schema creation (SQLite compatible)
│  │  Creates 5 tables with proper foreign keys
│  │
│  ├─ EXECUTION_GUIDE.sh
│  │  Bash script with all execution commands
│  │  Git commands for version control
│  │  Connection string examples
│  │
│  └─ .gitignore
│     Git ignore file for Oracle/Database projects
│
└─ 📄 MANIFEST (this file)

════════════════════════════════════════════════════════════════════
FILE DESCRIPTIONS
════════════════════════════════════════════════════════════════════

EXERCISE 1 - SCENARIO 1: exercise1_scenario1.sql
─────────────────────────────────────────────────
Lines: ~100
Purpose: Demonstrate cursor-based looping with age calculation
Key Elements:
  • Explicit cursor: FOR rec_customer IN cur_customers LOOP
  • Age calculation: TRUNC((SYSDATE - v_dob) / 365.25)
  • Nested cursor for loans: FOR rec_loan IN (SELECT...)
  • UPDATE with SQL%ROWCOUNT for tracking
Output: Detailed processing report with old/new interest rates

EXERCISE 1 - SCENARIO 2: exercise1_scenario2.sql
────────────────────────────────────────────────
Lines: ~110
Purpose: Dynamic column management and conditional classification
Key Elements:
  • EXECUTE IMMEDIATE for DDL: ALTER TABLE ADD COLUMN
  • user_tab_columns system view for column checking
  • ORDER BY clause for sorting results
  • Bulk UPDATE based on condition
Output: Classification report with VIP status and counts

EXERCISE 1 - SCENARIO 3: exercise1_scenario3.sql
────────────────────────────────────────────────
Lines: ~130
Purpose: Multi-table join with date calculations and reporting
Key Elements:
  • Complex JOIN in cursor definition
  • Date arithmetic: EndDate - SYSDATE
  • CASE statement for urgency levels
  • Summary aggregation and reporting
Output: Urgent reminders with detailed loan and customer info

PROCESS_MONTHLY_INTEREST: process_monthly_interest.sql
──────────────────────────────────────────────────────
Lines: ~120
Procedure Name: ProcessMonthlyInterest
Purpose: Monthly compound interest processing
Key Elements:
  • No input parameters
  • Automatic cursor iteration
  • INSERT transaction records
  • Detailed before/after reporting
Output: Interest processing report with totals

UPDATE_EMPLOYEE_BONUS: update_employee_bonus.sql
────────────────────────────────────────────────
Lines: ~140
Procedure Name: UpdateEmployeeBonus
Parameters:
  - p_department IN VARCHAR2
  - p_bonus_percentage IN NUMBER (0-100)
Purpose: Department-based salary bonuses
Key Elements:
  • Input validation with RAISE_APPLICATION_ERROR
  • Department existence check
  • Percentage calculation and tracking
  • Transaction count verification
Output: Detailed salary update report by employee

TRANSFER_FUNDS: transfer_funds.sql
──────────────────────────────────
Lines: ~180
Procedure Name: TransferFunds
Parameters:
  - p_from_account_id IN NUMBER
  - p_to_account_id IN NUMBER
  - p_transfer_amount IN NUMBER
Purpose: Safe fund transfers with balance checking
Key Elements:
  • Comprehensive input validation
  • Dual account lookup
  • Balance sufficiency check
  • SAVEPOINT for transaction safety
  • Automatic DEBIT/CREDIT transactions
Output: Success/failure report with balance updates

════════════════════════════════════════════════════════════════════
DATA MODEL
════════════════════════════════════════════════════════════════════

CUSTOMERS (8 records)
├─ CustomerID: 1-8
├─ Name: Full names
├─ DOB: Various ages (20-64 years old)
├─ Balance: $5,200 - $25,000
└─ IsVIP: Y/N (added in Scenario 2)

ACCOUNTS (10 records)
├─ AccountID: 1-10
├─ CustomerID: References Customers
├─ AccountType: Savings or Checking
├─ Balance: $5,000 - $25,000
└─ LastModified: SYSDATE

LOANS (5 records)
├─ LoanID: 1-5
├─ CustomerID: References Customers
├─ LoanAmount: $30,000 - $100,000
├─ InterestRate: 4% - 5.5%
├─ StartDate: Jan 2022 - May 2023
└─ EndDate: Jun 2026 - May 2027

EMPLOYEES (8 records)
├─ EmployeeID: 101-108
├─ Name: Full names
├─ Position: Manager, Developer, etc.
├─ Salary: $55,000 - $85,000
├─ Department: IT, HR, Finance
└─ HireDate: 2014-2019

TRANSACTIONS (Sample)
├─ TransactionID: Auto-generated
├─ AccountID: References Accounts
├─ TransactionDate: Various
├─ Amount: Variable
└─ TransactionType: DEPOSIT, WITHDRAWAL, TRANSFER, INTEREST, DEBIT, CREDIT

════════════════════════════════════════════════════════════════════
KEY FEATURES IMPLEMENTED
════════════════════════════════════════════════════════════════════

✓ Control Flow
  • IF/ELSIF/ELSE conditionals
  • Explicit cursors with FOR loops
  • Implicit cursors with RETURNING clauses
  • CASE statements

✓ Stored Procedures
  • Procedure creation and execution
  • Input parameter validation
  • RAISE_APPLICATION_ERROR for custom exceptions
  • Exception handling with WHEN OTHERS
  • COMMIT and ROLLBACK

✓ Data Manipulation
  • Cursor-based updates
  • Bulk inserts into Transactions table
  • Date calculations and comparisons
  • Aggregate functions (COUNT, SUM, AVG)

✓ Transactions & Safety
  • SAVEPOINT for nested transactions
  • ROLLBACK on error
  • Dual updates (debit/credit)
  • Balance verification

✓ Reporting
  • DBMS_OUTPUT for formatted output
  • Detailed status messages
  • Summary statistics
  • Before/after values

✓ System Integration
  • System catalog queries (user_tab_columns)
  • Dynamic SQL (EXECUTE IMMEDIATE)
  • SQL%ROWCOUNT usage
  • Multiple table joins

════════════════════════════════════════════════════════════════════
EXPECTED OUTPUTS
════════════════════════════════════════════════════════════════════

Exercise 1 - Scenario 1:
  - Processes: 3-4 senior citizens
  - Updates: 3-5 loans with new rates
  - Total: Shows interest rates reduced by 1%

Exercise 1 - Scenario 2:
  - VIP Customers: 3-4 customers with Balance > 10000
  - Regular Customers: 4-5 remaining
  - IsVIP column: Added if not present

Exercise 1 - Scenario 3:
  - Urgent (≤7 days): 1-2 loans
  - Warning (8-14 days): 1-2 loans
  - Total reminders: 3-5 loans

Exercise 3 - Scenario 1:
  - Accounts Updated: 6 Savings accounts
  - Total Interest: $875.50
  - New transaction records: 6

Exercise 3 - Scenario 2:
  - Employees Updated: 3-4 per department
  - Total Bonus: $5,000-$20,000
  - New salaries: Displayed with increases

Exercise 3 - Scenario 3:
  - Successful Transfers: Show balance updates
  - Failed Transfers: Show error with reason
  - Transaction Records: Created with DEBIT/CREDIT

════════════════════════════════════════════════════════════════════
TESTING CHECKLIST
════════════════════════════════════════════════════════════════════

Before Submission:
☐ All 10 SQL files created
☐ Sample data inserted (8 customers, 10 accounts, 5 loans, 8 employees)
☐ Exercise 1 Scenario 1 runs without errors
☐ Exercise 1 Scenario 2 creates IsVIP column and updates customers
☐ Exercise 1 Scenario 3 shows loan reminders with urgency levels
☐ ProcessMonthlyInterest procedure created and tested
☐ UpdateEmployeeBonus tested with multiple departments
☐ TransferFunds tested with valid and invalid transfers
☐ All verification queries produce expected results
☐ Error handling works for invalid inputs
☐ COMMIT/ROLLBACK working properly
☐ Transaction records being created
☐ README.md complete and accurate
☐ All files committed to Git
☐ Repository pushed to GitHub

════════════════════════════════════════════════════════════════════
EXECUTION SEQUENCE
════════════════════════════════════════════════════════════════════

1. Create Schema
   sqlplus @banking_schema.sql

2. Insert Sample Data
   sqlplus @sample_data.sql

3. Run Exercise 1
   sqlplus @exercise1_scenario1.sql
   sqlplus @exercise1_scenario2.sql
   sqlplus @exercise1_scenario3.sql

4. Create Procedures
   sqlplus @process_monthly_interest.sql
   sqlplus @update_employee_bonus.sql
   sqlplus @transfer_funds.sql

5. Execute Procedures
   EXEC ProcessMonthlyInterest;
   EXEC UpdateEmployeeBonus('IT', 10);
   EXEC TransferFunds(1, 2, 100);

6. Verify Results
   sqlplus @verification_queries.sql

════════════════════════════════════════════════════════════════════
GIT COMMANDS FOR SUBMISSION
════════════════════════════════════════════════════════════════════

# Initialize repository
git init
git remote add origin https://github.com/your-username/oracle-banking-assignment.git
git add .
git commit -m "Initial commit: Oracle PL/SQL banking assignment complete solution"
git push -u origin main

# View history
git log --oneline
git log --graph --all --oneline --decorate

════════════════════════════════════════════════════════════════════
SCREENSHOT REQUIREMENTS (15 total)
════════════════════════════════════════════════════════════════════

Exercise 1:
  1. Scenario 1 execution output
  2. Loan interest rates after discount
  3. Customer age verification

  4. Scenario 2 execution output
  5. VIP classification results
  6. IsVIP column in Customers table

  7. Scenario 3 execution output
  8. Loan reminders with urgency
  9. Summary statistics

Exercise 3:
  10. Scenario 1 procedure creation + execution
  11. Monthly interest transactions
  12. Updated account balances

  13. Scenario 2 procedure creation + salary updates
  14. Department bonus statistics

  15. Scenario 3 procedure creation + transfer results
  16. Account balance updates
  17. Transaction records (DEBIT/CREDIT)

General:
  18. Git repository status
  19. GitHub repository page
  20. All files in VS Code

════════════════════════════════════════════════════════════════════
SUBMISSION PACKAGE
════════════════════════════════════════════════════════════════════

Files to Submit:
  ✓ All 10 SQL files
  ✓ README.md
  ✓ EXECUTION_GUIDE.sh
  ✓ .gitignore
  ✓ 15-20 screenshots (PNG/JPG)
  ✓ Git repository link

Total Lines of Code: ~800+ lines
Total Comments: ~30% of codebase
Documentation: Comprehensive README with examples
Test Coverage: 6 scenarios × multiple test cases

════════════════════════════════════════════════════════════════════

Ready for Submission! ✓

EOF

echo ""
echo "Files created: $(ls -1 /home/nishxnt/VsCode/Cognizant/week1/PlSql | grep -E '\.(sql|md|sh|gitignore)$' | wc -l)"
echo "Total size: $(du -sh /home/nishxnt/VsCode/Cognizant/week1/PlSql)"
