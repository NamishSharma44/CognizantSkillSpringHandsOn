-- ====================================================================
-- EXERCISE 1 - SCENARIO 3: LOAN PAYMENT REMINDERS
-- ====================================================================
-- Objective: Find loans due within the next 30 days and print
--            reminder messages using DBMS_OUTPUT.PUT_LINE
-- ====================================================================

SET SERVEROUTPUT ON;

DECLARE
    -- Cursor to fetch loans expiring within 30 days
    CURSOR cur_upcoming_loans IS
        SELECT 
            l.LoanID,
            l.CustomerID,
            c.Name AS CustomerName,
            c.Balance,
            l.LoanAmount,
            l.InterestRate,
            l.StartDate,
            l.EndDate,
            TRUNC(l.EndDate - SYSDATE) AS DaysUntilDue
        FROM Loans l
        JOIN Customers c ON l.CustomerID = c.CustomerID
        WHERE l.EndDate IS NOT NULL
          AND l.EndDate > SYSDATE  -- Not yet due
          AND l.EndDate <= SYSDATE + 30  -- Due within 30 days
        ORDER BY l.EndDate ASC;
    
    -- Variables
    v_reminder_count    NUMBER := 0;
    v_urgent_count      NUMBER := 0;
    v_warning_count     NUMBER := 0;
    v_total_amount_due  NUMBER := 0;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('LOAN PAYMENT REMINDER REPORT');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Generated on: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH:MM:SS'));
    DBMS_OUTPUT.PUT_LINE('Checking for loans due within 30 days...');
    DBMS_OUTPUT.PUT_LINE(' ');
    
    -- Process each upcoming loan
    FOR rec_loan IN cur_upcoming_loans LOOP
        v_reminder_count := v_reminder_count + 1;
        v_total_amount_due := v_total_amount_due + rec_loan.LoanAmount;
        
        -- Determine urgency level
        IF rec_loan.DaysUntilDue <= 7 THEN
            v_urgent_count := v_urgent_count + 1;
            DBMS_OUTPUT.PUT_LINE('[URGENT] ⚠️  Loan Due Soon!');
        ELSIF rec_loan.DaysUntilDue <= 14 THEN
            v_warning_count := v_warning_count + 1;
            DBMS_OUTPUT.PUT_LINE('[WARNING] Loan Due Approaching');
        ELSE
            DBMS_OUTPUT.PUT_LINE('[REMINDER] Loan Due Notice');
        END IF;
        
        -- Display loan details
        DBMS_OUTPUT.PUT_LINE('  Loan ID: ' || rec_loan.LoanID);
        DBMS_OUTPUT.PUT_LINE('  Customer: ' || rec_loan.CustomerName || 
                           ' (ID: ' || rec_loan.CustomerID || ')');
        DBMS_OUTPUT.PUT_LINE('  Loan Amount: $' || ROUND(rec_loan.LoanAmount, 2));
        DBMS_OUTPUT.PUT_LINE('  Interest Rate: ' || ROUND(rec_loan.InterestRate * 100, 2) || '%');
        DBMS_OUTPUT.PUT_LINE('  Start Date: ' || TO_CHAR(rec_loan.StartDate, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('  Due Date: ' || TO_CHAR(rec_loan.EndDate, 'DD-MON-YYYY'));
        DBMS_OUTPUT.PUT_LINE('  Days Until Due: ' || rec_loan.DaysUntilDue || ' days');
        DBMS_OUTPUT.PUT_LINE('  Customer Account Balance: $' || ROUND(rec_loan.Balance, 2));
        
        -- Calculate total amount with interest
        DECLARE
            v_total_with_interest NUMBER;
        BEGIN
            v_total_with_interest := rec_loan.LoanAmount * (1 + rec_loan.InterestRate);
            DBMS_OUTPUT.PUT_LINE('  Total Amount with Interest: $' || ROUND(v_total_with_interest, 2));
        END;
        
        -- Payment status
        IF rec_loan.Balance >= rec_loan.LoanAmount THEN
            DBMS_OUTPUT.PUT_LINE('  ✓ Customer has sufficient balance to pay');
        ELSE
            DBMS_OUTPUT.PUT_LINE('  ⚠️  WARNING: Customer may have insufficient funds');
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
    
    -- Summary Report
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('REMINDER SUMMARY');
    DBMS_OUTPUT.PUT_LINE('========================================');
    
    IF v_reminder_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No loans due within the next 30 days.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Total Reminders to Send: ' || v_reminder_count);
        DBMS_OUTPUT.PUT_LINE('  Urgent (≤7 days): ' || v_urgent_count);
        DBMS_OUTPUT.PUT_LINE('  Warning (8-14 days): ' || v_warning_count);
        DBMS_OUTPUT.PUT_LINE('  Regular (15-30 days): ' || (v_reminder_count - v_urgent_count - v_warning_count));
        DBMS_OUTPUT.PUT_LINE('Total Amount Due (Principal): $' || ROUND(v_total_amount_due, 2));
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('========================================');
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLCODE || ' - ' || SQLERRM);
END;
/
