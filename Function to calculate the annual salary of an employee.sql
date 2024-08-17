CREATE OR REPLACE FUNCTION ANNUAL_SALARY(V_EMPLOYEE_ID EMPLOYEES.EMPLOYEE_ID%TYPE)
RETURN NUMBER IS 
V_ANNUAL_SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
SELECT SALARY*12 INTO V_ANNUAL_SALARY FROM EMPLOYEES WHERE EMPLOYEE_ID=V_EMPLOYEE_ID;
DBMS_OUTPUT.PUT_LINE('Annual Salary of '||V_EMPLOYEE_ID ||' is '|| V_ANNUAL_SALARY);
RETURN V_ANNUAL_SALARY;
    END;

DECLARE
v_annual_salary NUMBER;
BEGIN
v_annual_salary := ANNUAL_SALARY(1);  -- Replace 10 with a valid employee ID
END;
