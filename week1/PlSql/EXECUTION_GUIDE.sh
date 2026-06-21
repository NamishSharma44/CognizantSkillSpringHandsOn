#!/bin/bash
# ====================================================================
# QUICK EXECUTION SCRIPT
# ====================================================================
# This script contains all commands to run the Oracle assignment
# Copy and paste into your terminal
# ====================================================================

# Step 1: Navigate to the PlSql directory
cd /home/nishxnt/VsCode/Cognizant/week1/PlSql

# Step 2: Connect to Oracle and run schema creation
# Replace username, password, database with your credentials
sqlplus username/password@database @banking_schema.sql

# Step 3: Insert sample data
sqlplus username/password@database @sample_data.sql

# Step 4: Run Exercise 1 - Scenario 1 (Senior Citizen Discount)
sqlplus username/password@database @exercise1_scenario1.sql

# Step 5: Run Exercise 1 - Scenario 2 (VIP Classification)
sqlplus username/password@database @exercise1_scenario2.sql

# Step 6: Run Exercise 1 - Scenario 3 (Loan Reminders)
sqlplus username/password@database @exercise1_scenario3.sql

# Step 7: Create and test stored procedures
sqlplus username/password@database @process_monthly_interest.sql

sqlplus username/password@database @update_employee_bonus.sql

sqlplus username/password@database @transfer_funds.sql

# Step 8: Run verification queries
sqlplus username/password@database @verification_queries.sql

# ====================================================================
# Alternative: Interactive SQL*Plus Session
# ====================================================================
# sqlplus username/password@database
# 
# Once connected, run:
# SET SERVEROUTPUT ON;
# SET PAGESIZE 50;
# SET LINESIZE 120;
# @exercise1_scenario1.sql
# @exercise1_scenario2.sql
# @exercise1_scenario3.sql
# @process_monthly_interest.sql
# EXEC UpdateEmployeeBonus('IT', 10);
# EXEC TransferFunds(1, 2, 100);
# @verification_queries.sql
# EXIT;

# ====================================================================
# Git Commands
# ====================================================================

# Initialize repository
git init

# Add remote
git remote add origin https://github.com/your-username/oracle-banking-assignment.git

# Create .gitignore
echo "*.db
*.exe
.DS_Store
*.log
*.swp
*.swo
~*
*.tmp" > .gitignore

# Add all files
git add .

# Initial commit
git commit -m "Initial commit: Oracle PL/SQL banking assignment - Exercise 1 and Exercise 3"

# Push to GitHub
git push -u origin main

# ====================================================================
# Git Commands for Individual Exercises
# ====================================================================

# After Exercise 1
git add exercise1_scenario*.sql
git commit -m "feat: Exercise 1 - Control Structures (all 3 scenarios)"
git push

# After Exercise 3
git add process_monthly_interest.sql update_employee_bonus.sql transfer_funds.sql
git commit -m "feat: Exercise 3 - Stored Procedures (all 3 scenarios)"
git push

# After adding documentation
git add README.md sample_data.sql verification_queries.sql
git commit -m "docs: Add comprehensive documentation and support files"
git push

# View commit history
git log --oneline
git log --graph --all --oneline --decorate

# ====================================================================
# File Listing
# ====================================================================
# ls -la /home/nishxnt/VsCode/Cognizant/week1/PlSql/
# 
# Expected files:
# - README.md
# - banking_schema.sql
# - sample_data.sql
# - verification_queries.sql
# - exercise1_scenario1.sql
# - exercise1_scenario2.sql
# - exercise1_scenario3.sql
# - process_monthly_interest.sql
# - update_employee_bonus.sql
# - transfer_funds.sql
# - EXECUTION_GUIDE.sh (this file)
# - .gitignore
# - .git/

# ====================================================================
# Connection String Examples
# ====================================================================
# 
# Local Oracle (default):
# sqlplus username/password@localhost:1521/ORCL
# 
# Remote Oracle:
# sqlplus username/password@remote-server:1521/ORCL
# 
# Using TNS entry:
# sqlplus username/password@ORCL
# 
# As SYSDBA:
# sqlplus / as sysdba
# 
# Verify connection:
# sqlplus -v
