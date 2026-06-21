-- ====================================================================
-- EXERCISE 3 - STORED PROCEDURE 3: TRANSFER FUNDS
-- ====================================================================
-- Objective: Create a procedure that transfers money between accounts
--            after checking for sufficient balance
-- ====================================================================

-- Drop procedure if it exists (for re-running)
BEGIN
    EXECUTE IMMEDIATE 'DROP PROCEDURE TransferFunds';
EXCEPTION
    WHEN OTHERS THEN
        NULL;  -- Procedure doesn't exist, continue
END;
/

-- Create the stored procedure
CREATE OR REPLACE PROCEDURE TransferFunds (
    p_from_account_id IN NUMBER,
    p_to_account_id IN NUMBER,
    p_transfer_amount IN NUMBER
)
AS
    -- Variables
    v_from_balance      Accounts.Balance%TYPE;
    v_to_balance        Accounts.Balance%TYPE;
    v_from_customer_id  Accounts.CustomerID%TYPE;
    v_to_customer_id    Accounts.CustomerID%TYPE;
    v_from_account_type Accounts.AccountType%TYPE;
    v_to_account_type   Accounts.AccountType%TYPE;
    v_from_name         Customers.Name%TYPE;
    v_to_name           Customers.Name%TYPE;
    v_new_transaction_id NUMBER;
    
BEGIN
    -- Input validation
    IF p_from_account_id IS NULL OR p_to_account_id IS NULL THEN
        RAISE_APPLICATION_ERROR(-20001, 'From and To Account IDs cannot be NULL');
    END IF;
    
    IF p_transfer_amount IS NULL OR p_transfer_amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Transfer amount must be greater than 0');
    END IF;
    
    IF p_from_account_id = p_to_account_id THEN
        RAISE_APPLICATION_ERROR(-20003, 'Cannot transfer to the same account');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('FUND TRANSFER PROCESSING');
    DBMS_OUTPUT.PUT_LINE('Processing Date: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH:MM:SS'));
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE(' ');
    
    -- Fetch FROM account details
    BEGIN
        SELECT a.Balance, a.CustomerID, a.AccountType, c.Name
        INTO v_from_balance, v_from_customer_id, v_from_account_type, v_from_name
        FROM Accounts a
        JOIN Customers c ON a.CustomerID = c.CustomerID
        WHERE a.AccountID = p_from_account_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20004, 'FROM Account ID ' || p_from_account_id || ' not found');
    END;
    
    -- Fetch TO account details
    BEGIN
        SELECT a.Balance, a.CustomerID, a.AccountType, c.Name
        INTO v_to_balance, v_to_customer_id, v_to_account_type, v_to_name
        FROM Accounts a
        JOIN Customers c ON a.CustomerID = c.CustomerID
        WHERE a.AccountID = p_to_account_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20005, 'TO Account ID ' || p_to_account_id || ' not found');
    END;
    
    -- Display transaction details
    DBMS_OUTPUT.PUT_LINE('FROM Account:');
    DBMS_OUTPUT.PUT_LINE('  Account ID: ' || p_from_account_id);
    DBMS_OUTPUT.PUT_LINE('  Customer: ' || v_from_name);
    DBMS_OUTPUT.PUT_LINE('  Account Type: ' || v_from_account_type);
    DBMS_OUTPUT.PUT_LINE('  Current Balance: $' || ROUND(v_from_balance, 2));
    DBMS_OUTPUT.PUT_LINE(' ');
    
    DBMS_OUTPUT.PUT_LINE('TO Account:');
    DBMS_OUTPUT.PUT_LINE('  Account ID: ' || p_to_account_id);
    DBMS_OUTPUT.PUT_LINE('  Customer: ' || v_to_name);
    DBMS_OUTPUT.PUT_LINE('  Account Type: ' || v_to_account_type);
    DBMS_OUTPUT.PUT_LINE('  Current Balance: $' || ROUND(v_to_balance, 2));
    DBMS_OUTPUT.PUT_LINE(' ');
    
    DBMS_OUTPUT.PUT_LINE('Transfer Amount: $' || ROUND(p_transfer_amount, 2));
    DBMS_OUTPUT.PUT_LINE(' ');
    
    -- Check sufficient balance
    IF v_from_balance < p_transfer_amount THEN
        DBMS_OUTPUT.PUT_LINE('❌ TRANSFER FAILED');
        DBMS_OUTPUT.PUT_LINE('Reason: Insufficient balance in FROM account');
        DBMS_OUTPUT.PUT_LINE('Available: $' || ROUND(v_from_balance, 2));
        DBMS_OUTPUT.PUT_LINE('Required: $' || ROUND(p_transfer_amount, 2));
        RAISE_APPLICATION_ERROR(-20006, 'Insufficient balance for transfer');
    END IF;
    
    -- Perform the transfer using SAVEPOINT for rollback capability
    SAVEPOINT transfer_start;
    
    BEGIN
        -- Deduct from source account
        UPDATE Accounts
        SET Balance = Balance - p_transfer_amount,
            LastModified = SYSDATE
        WHERE AccountID = p_from_account_id;
        
        -- Add to destination account
        UPDATE Accounts
        SET Balance = Balance + p_transfer_amount,
            LastModified = SYSDATE
        WHERE AccountID = p_to_account_id;
        
        -- Get next transaction ID
        SELECT NVL(MAX(TransactionID), 0) + 1
        INTO v_new_transaction_id
        FROM Transactions;
        
        -- Record DEBIT transaction for source account
        INSERT INTO Transactions (
            TransactionID,
            AccountID,
            TransactionDate,
            Amount,
            TransactionType
        ) VALUES (
            v_new_transaction_id,
            p_from_account_id,
            SYSDATE,
            p_transfer_amount,
            'DEBIT'
        );
        
        -- Record CREDIT transaction for destination account
        INSERT INTO Transactions (
            TransactionID,
            AccountID,
            TransactionDate,
            Amount,
            TransactionType
        ) VALUES (
            v_new_transaction_id + 1,
            p_to_account_id,
            SYSDATE,
            p_transfer_amount,
            'CREDIT'
        );
        
        -- Commit transaction
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('✓ TRANSFER SUCCESSFUL');
        DBMS_OUTPUT.PUT_LINE(' ');
        DBMS_OUTPUT.PUT_LINE('Updated Balances:');
        DBMS_OUTPUT.PUT_LINE('  FROM Account: $' || ROUND(v_from_balance - p_transfer_amount, 2));
        DBMS_OUTPUT.PUT_LINE('  TO Account: $' || ROUND(v_to_balance + p_transfer_amount, 2));
        DBMS_OUTPUT.PUT_LINE(' ');
        DBMS_OUTPUT.PUT_LINE('Transaction IDs: ' || v_new_transaction_id || ', ' || (v_new_transaction_id + 1));
        DBMS_OUTPUT.PUT_LINE('========================================');
        
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK TO transfer_start;
            DBMS_OUTPUT.PUT_LINE('❌ TRANSFER FAILED');
            DBMS_OUTPUT.PUT_LINE('Error during transfer: ' || SQLCODE || ' - ' || SQLERRM);
            RAISE;
    END;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR in TransferFunds: ' || SQLCODE || ' - ' || SQLERRM);
        RAISE;
        
END TransferFunds;
/

-- Verify procedure creation
BEGIN
    DBMS_OUTPUT.PUT_LINE('TransferFunds procedure created successfully!');
END;
/

-- Example execution (uncomment to run with real data)
-- EXEC TransferFunds(1, 2, 100);   -- Transfer $100 from Account 1 to Account 2
-- EXEC TransferFunds(2, 3, 250);   -- Transfer $250 from Account 2 to Account 3
