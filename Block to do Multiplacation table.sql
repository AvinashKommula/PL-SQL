DECLARE
INPUT_NUMBER NUMBER:=5;
OUTPUT_NUMBER NUMBER:=0;
BEGIN
FOR i in 1..10 LOOP
OUTPUT_NUMBER:=INPUT_NUMBER*i;
DBMS_OUTPUT.PUT_LINE(INPUT_NUMBER||'*'||i||'='||OUTPUT_NUMBER);
END LOOP;
END;