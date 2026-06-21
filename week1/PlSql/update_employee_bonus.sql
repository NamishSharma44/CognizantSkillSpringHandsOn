-- ====================================================================
-- EXERCISE 3 - STORED PROCEDURE 2: UPDATE EMPLOYEE BONUS
-- ====================================================================
-- Objective: Create a procedure that accepts Department and
--            BonusPercentage parameters and updates employee salaries
-- ====================================================================

-- Drop procedure if it exists (for re-running)
BEGIN
    EXECUTE IMMEDIATE 'DROP PROCEDURE UpdateEmployeeBonus';
EXCEPTION
    WHEN OTHERS THEN
        NULL;  -- Procedure doesn't exist, continue
END;
/

-- Create the stored procedure
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
)
AS
    -- Cursor to fetch employees in specified department
    CURSOR cur_employees IS
        SELECT EmployeeID, Name, Position, Salary, Department
        FROM Employees
        WHERE UPPER(Department) = UPPER(p_department)
        ORDER BY EmployeeID;
    
    -- Variables
    v_employee_id       Employees.EmployeeID%TYPE;
    v_employee_name     Employees.Name%TYPE;
    v_position          Employees.Position%TYPE;
    v_old_salary        Employees.Salary%TYPE;
    v_new_salary        Employees.Salary%TYPE;
    v_bonus_amount      NUMBER;
    v_employees_updated NUMBER := 0;
    v_total_bonus       NUMBER := 0;
    v_department_count  NUMBER := 0;
    
BEGIN
    -- Validate inputs
    IF p_department IS NULL OR TRIM(p_department) = '' THEN
        RAISE_APPLICATION_ERROR(-20001, 'Department parameter cannot be NULL or empty');
    END IF;
    
    IF p_bonus_percentage IS NULL OR p_bonus_percentage < 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Bonus Percentage must be a non-negative number');
    END IF;
    
    IF p_bonus_percentage > 100 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Bonus Percentage cannot exceed 100%');
    END IF;
    
    -- Check if department exists
    SELECT COUNT(*)
    INTO v_department_count
    FROM Employees
    WHERE UPPER(Department) = UPPER(p_department);
    
    IF v_department_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'No employees found in department: ' || p_department);
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('EMPLOYEE BONUS UPDATE');
    DBMS_OUTPUT.PUT_LINE('Processing Date: ' || TO_CHAR(SYSDATE, 'DD-MON-YYYY HH:MM:SS'));
    DBMS_OUTPUT.PUT_LINE('Department: ' || p_department);
    DBMS_OUTPUT.PUT_LINE('Bonus Percentage: ' || p_bonus_percentage || '%');
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE(' ');
    
    -- Loop through employees in department
    FOR rec_employee IN cur_employees LOOP
        v_employee_id := rec_employee.EmployeeID;
        v_employee_name := rec_employee.Name;
        v_position := rec_employee.Position;
        v_old_salary := rec_employee.Salary;
        
        -- Calculate bonus amount
        v_bonus_amount := v_old_salary * (p_bonus_percentage / 100);
        v_new_salary := v_old_salary + v_bonus_amount;
        
        -- Update employee salary
        UPDATE Employees
        SET Salary = v_new_salary,
            HireDate = HireDate  -- Use HireDate to mark as modified (timestamp would be better)
        WHERE EmployeeID = v_employee_id;
        
        -- Update counters
        v_employees_updated := v_employees_updated + 1;
        v_total_bonus := v_total_bonus + v_bonus_amount;
        
        -- Display update details
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_employee_id);
        DBMS_OUTPUT.PUT_LINE('  Name: ' || v_employee_name);
        DBMS_OUTPUT.PUT_LINE('  Position: ' || v_position);
        DBMS_OUTPUT.PUT_LINE('  Old Salary: $' || ROUND(v_old_salary, 2));
        DBMS_OUTPUT.PUT_LINE('  Bonus Amount (' || p_bonus_percentage || '%): $' || ROUND(v_bonus_amount, 2));
        DBMS_OUTPUT.PUT_LINE('  New Salary: $' || ROUND(v_new_salary, 2));
        DBMS_OUTPUT.PUT_LINE('  Percentage Increase: ' || ROUND((v_bonus_amount / v_old_salary) * 100, 2) || '%');
        DBMS_OUTPUT.PUT_LINE(' ');
        
    END LOOP;
    
    -- Summary
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('UPDATE COMPLETE');
    DBMS_OUTPUT.PUT_LINE('Total Employees Updated: ' || v_employees_updated);
    DBMS_OUTPUT.PUT_LINE('Total Bonus Amount: $' || ROUND(v_total_bonus, 2));
    DBMS_OUTPUT.PUT_LINE('Average Bonus per Employee: $' || ROUND(v_total_bonus / v_employees_updated, 2));
    DBMS_OUTPUT.PUT_LINE('========================================');
    
    -- Commit changes
    COMMIT;
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERROR in UpdateEmployeeBonus: ' || SQLCODE || ' - ' || SQLERRM);
        ROLLBACK;
        RAISE;
        
END UpdateEmployeeBonus;
/

-- Verify procedure creation
BEGIN
    DBMS_OUTPUT.PUT_LINE('UpdateEmployeeBonus procedure created successfully!');
END;
/

-- Example execution (uncomment to run with real data)
-- EXEC UpdateEmployeeBonus('IT', 10);
-- EXEC UpdateEmployeeBonus('HR', 5);
-- EXEC UpdateEmployeeBonus('Finance', 8);
