-- ====================================================================
-- EXERCISE 3 - STORED PROCEDURE 1: PROCESS MONTHLY INTEREST
-- ====================================================================
-- Objective: Create a procedure that adds 1% interest to all
--            Savings accounts
-- ====================================================================

-- Drop procedure if it exists (for re-running)
BEGIN
    EXECUTE IMMEDIATE 'DROP PROCEDURE ProcessMonthlyInterest';
EXCEPTION
    WHEN OTHERS THEN
        NULL;  -- Procedure doesn't exist, continue
END;
/

-- Create the stored procedure
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest
AS
    -- Cursor to fetch all Savings accounts
    CURSOR cur_savings_accounts IS
        SELECT AccountID, CustomerID, Balance
        FROM Accounts
        WHERE AccountType = 'Savings'
        ORDER BY AccountID;
    
    -- Variables
    v_account_id        Accounts.AccountID%TYPE;
    v_customer_id       Accounts.CustomerID%TYPE;
    v_old_balance       Accounts.Balance%TYPE;
    v_new_balance       Accounts.Balance%TYPE;
    v_interest_amount   NUMBER;
    v_interest_rate     NUMBER := 0.01;  -- 1% monthly interest
    v_accounts_updated  NUMBER := 0;
    v_total_interest    NUMBER := 0;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('MONTHLY INTEREST PROCESSING');
    DBMS_OUTPUT.PUT_LINE('Processing Date: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH:MM:SS'));
    DBMS_OUTPUT.PUT_LINE('Account Type: Savings Accounts');
    DBMS_OUTPUT.PUT_LINE('Interest Rate: ' || (v_interest_rate * 100) || '%');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE(' ');
    
    -- Loop through all Savings accounts
    FOR rec_account IN cur_savings_accounts LOOP
        v_account_id := rec_account.AccountID;
        v_customer_id := rec_account.CustomerID;
        v_old_balance := rec_account.Balance;
        
        -- Calculate interest
        v_interest_amount := v_old_balance * v_interest_rate;
        v_new_balance := v_old_balance + v_interest_amount;
        
        -- Update account balance
        UPDATE Accounts
        SET Balance = v_new_balance,
            LastModified = SYSDATE
        WHERE AccountID = v_account_id;
        
        -- Record the transaction
        INSERT INTO Transactions (
            TransactionID,
            AccountID,
            TransactionDate,
            Amount,
            TransactionType
        ) VALUES (
            (SELECT NVL(MAX(TransactionID), 0) + 1 FROM Transactions),
            v_account_id,
            SYSDATE,
            v_interest_amount,
            'INTEREST'
        );
        
        -- Update counters
        v_accounts_updated := v_accounts_updated + 1;
        v_total_interest := v_total_interest + v_interest_amount;
        
        -- Display processing details
        DBMS_OUTPUT.PUT_LINE('Account ID: ' || v_account_id || 
                           ' (Customer: ' || v_customer_id || ')');
        DBMS_OUTPUT.PUT_LINE('  Old Balance: $' || ROUND(v_old_balance, 2));
        DBMS_OUTPUT.PUT_LINE('  Interest Added: $' || ROUND(v_interest_amount, 2));
        DBMS_OUTPUT.PUT_LINE('  New Balance: $' || ROUND(v_new_balance, 2));
        DBMS_OUTPUT.PUT_LINE(' ');
        
    END LOOP;
    
    -- Summary
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('PROCESSING COMPLETE');
    DBMS_OUTPUT.PUT_LINE('Total Accounts Updated: ' || v_accounts_updated);
    DBMS_OUTPUT.PUT_LINE('Total Interest Credited: $' || ROUND(v_total_interest, 2));
    DBMS_OUTPUT.PUT_LINE('========================================');
    
    -- Commit changes
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR in ProcessMonthlyInterest: ' || SQLCODE || ' - ' || SQLERRM);
        ROLLBACK;
        RAISE;
        
END ProcessMonthlyInterest;
/

-- Verify procedure creation
BEGIN
    DBMS_OUTPUT.PUT_LINE('ProcessMonthlyInterest procedure created successfully!');
END;
/

-- Execute the procedure
EXEC ProcessMonthlyInterest;
