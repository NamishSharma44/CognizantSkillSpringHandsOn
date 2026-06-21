-- ====================================================================
-- EXERCISE 1 - SCENARIO 1: SENIOR CITIZEN DISCOUNT
-- ====================================================================
-- Objective: Loop through all customers, calculate age from DOB,
--            and if age > 60, apply 1% discount to loan interest rates
-- ====================================================================

SET SERVEROUTPUT ON;

DECLARE
    -- Cursor to fetch all customers with their DOB
    CURSOR cur_customers IS
        SELECT CustomerID, Name, DOB 
        FROM Customers;
    
    -- Variables
    v_customer_id    Customers.CustomerID%TYPE;
    v_customer_name  Customers.Name%TYPE;
    v_dob            Customers.DOB%TYPE;
    v_age            NUMBER;
    v_updated_count  NUMBER := 0;
    v_discount_rate  NUMBER := 0.01; -- 1% discount
    
BEGIN
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('SENIOR CITIZEN DISCOUNT PROCESSING');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Processing: Applying 1% discount to loans for customers aged > 60');
    DBMS_OUTPUT.PUT_LINE(' ');
    
    -- Open cursor and loop through all customers
    FOR rec_customer IN cur_customers LOOP
        v_customer_id := rec_customer.CustomerID;
        v_customer_name := rec_customer.Name;
        v_dob := rec_customer.DOB;
        
        -- Calculate age: (SYSDATE - DOB) / 365.25
        v_age := TRUNC((SYSDATE - v_dob) / 365.25);
        
        DBMS_OUTPUT.PUT_LINE('Customer: ' || v_customer_name || ' (ID: ' || v_customer_id || ')');
        DBMS_OUTPUT.PUT_LINE('  DOB: ' || TO_CHAR(v_dob, 'DD-MON-YYYY') || ' | Age: ' || v_age);
        
        -- Check if customer is senior (age > 60)
        IF v_age > 60 THEN
            DBMS_OUTPUT.PUT_LINE('  Status: SENIOR CITIZEN - Applying 1% discount');
            
            -- Update loan interest rate: New Rate = Old Rate * (1 - 0.01)
            UPDATE Loans
            SET InterestRate = InterestRate * (1 - v_discount_rate)
            WHERE CustomerID = v_customer_id;
            
            v_updated_count := v_updated_count + SQL%ROWCOUNT;
            
            -- Display updated rates
            FOR rec_loan IN (
                SELECT LoanID, LoanAmount, InterestRate 
                FROM Loans 
                WHERE CustomerID = v_customer_id
            ) LOOP
                DBMS_OUTPUT.PUT_LINE('    Loan ID: ' || rec_loan.LoanID || 
                                     ' | New Rate: ' || ROUND(rec_loan.InterestRate * 100, 2) || '%');
            END LOOP;
        ELSE
            DBMS_OUTPUT.PUT_LINE('  Status: Not eligible for discount');
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Processing Complete!');
    DBMS_OUTPUT.PUT_LINE('Total Loan Interest Rates Updated: ' || v_updated_count);
    DBMS_OUTPUT.PUT_LINE('========================================');
    
    -- Commit the changes
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLCODE || ' - ' || SQLERRM);
        ROLLBACK;
END;
/
