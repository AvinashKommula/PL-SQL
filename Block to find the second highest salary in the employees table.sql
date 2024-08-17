DECLARE CURSOR RANK_SALARY IS
SELECT EMPLOYEE_ID,SALARY FROM(
    SELECT EMPLOYEE_ID,SALARY,DENSE_RANK()OVER(ORDER BY SALARY DESC) AS SALARY_RANK FROM EMPLOYEES) WHERE SALARY_RANK=2;

V_ID EMPLOYEES.EMPLOYEE_ID%TYPE;
V_SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
    OPEN RANK_SALARY;
    LOOP
    FETCH RANK_SALARY INTO  V_ID,V_SALARY;
    EXIT WHEN RANK_SALARY%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('RANKING OF '||V_SALARY || 'in Employee'||V_ID);
    END LOOP;
    CLOSE RANK_SALARY;
    END;