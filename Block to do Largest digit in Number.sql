DECLARE
V_NUM NUMBER:=63981;
LAR_NUM NUMBER:=0;

BEGIN
LAR_NUM:=MOD(V_NUM,10);
FOR i in 1..LENGTH(V_NUM) LOOP
V_NUM:=TRUNC(V_NUM/10);
IF(MOD(V_NUM,10))>LAR_NUM THEN LAR_NUM:=MOD(V_NUM,10);
END IF;
END LOOP;
DBMS_OUTPUT.PUT_LINE(LAR_NUM);
END;

-- OTHER APPROACH
DECLARE
  v_number NUMBER := 63942;
  v_largest_digit NUMBER := 0;
  v_digit  NUMBER;
BEGIN
  WHILE v_number > 0 LOOP
    v_digit := MOD(v_number, 10);
    IF v_digit > v_largest_digit THEN
      v_largest_digit := v_digit;
    END IF;
    v_number := TRUNC(v_number / 10);
  END LOOP;

  DBMS_OUTPUT.PUT_LINE('Largest Digit: ' || v_largest_digit);
END;
