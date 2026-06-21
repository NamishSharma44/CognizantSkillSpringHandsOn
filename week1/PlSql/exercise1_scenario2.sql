-- ====================================================================
-- EXERCISE 1 - SCENARIO 2: VIP CUSTOMER CLASSIFICATION
-- ====================================================================
-- Objective: Add IsVIP column if necessary and mark customers as VIP
--            if their balance > 10000
-- ====================================================================

-- First, check if IsVIP column exists and add it if not
DECLARE
    v_column_exists NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_column_exists
    FROM user_tab_columns
    WHERE table_name = 'CUSTOMERS' AND column_name = 'ISVIP';
    
    IF v_column_exists = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE Customers ADD (IsVIP CHAR(1) DEFAULT ''N'')';
        DBMS_OUTPUT.PUT_LINE('IsVIP column added successfully to Customers table');
    ELSE
        DBMS_OUTPUT.PUT_LINE('IsVIP column already exists');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error checking/adding column: ' || SQLERRM);
END;
/

-- Main PL/SQL block to set VIP status
SET SERVEROUTPUT ON;

DECLARE
    -- Cursor to fetch all customers with their balance
    CURSOR cur_customers IS
        SELECT CustomerID, Name, Balance 
        FROM Customers
        ORDER BY Balance DESC;
    
    -- Variables
    v_customer_id    Customers.CustomerID%TYPE;
    v_customer_name  Customers.Name%TYPE;
    v_balance        Customers.Balance%TYPE;
    v_vip_threshold  NUMBER := 10000;
    v_vip_count      NUMBER := 0;
    v_non_vip_count  NUMBER := 0;
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('VIP CUSTOMER CLASSIFICATION');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('VIP Threshold: Balance > ' || v_vip_threshold);
    DBMS_OUTPUT.PUT_LINE(' ');
    
    -- Open cursor and loop through all customers
    FOR rec_customer IN cur_customers LOOP
        v_customer_id := rec_customer.CustomerID;
        v_customer_name := rec_customer.Name;
        v_balance := rec_customer.Balance;
        
        DBMS_OUTPUT.PUT_LINE('Customer: ' || v_customer_name || 
                           ' (ID: ' || v_customer_id || ')');
        DBMS_OUTPUT.PUT_LINE('  Balance: $' || ROUND(v_balance, 2));
        
        -- Check if balance exceeds VIP threshold
        IF v_balance > v_vip_threshold THEN
            DBMS_OUTPUT.PUT_LINE('  Status: UPGRADED TO VIP ✓');
            
            -- Update IsVIP to 'Y'
            UPDATE Customers
            SET IsVIP = 'Y', LastModified = SYSDATE
            WHERE CustomerID = v_customer_id;
            
            v_vip_count := v_vip_count + 1;
        ELSE
            DBMS_OUTPUT.PUT_LINE('  Status: Regular Customer');
            
            -- Ensure IsVIP is 'N'
            UPDATE Customers
            SET IsVIP = 'N', LastModified = SYSDATE
            WHERE CustomerID = v_customer_id;
            
            v_non_vip_count := v_non_vip_count + 1;
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Classification Complete!');
    DBMS_OUTPUT.PUT_LINE('Total VIP Customers: ' || v_vip_count);
    DBMS_OUTPUT.PUT_LINE('Total Regular Customers: ' || v_non_vip_count);
    DBMS_OUTPUT.PUT_LINE('========================================');
    
    -- Commit the changes
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLCODE || ' - ' || SQLERRM);
        ROLLBACK;
END;
/
