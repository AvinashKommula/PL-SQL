DECLARE 
TYPE ASS_ARRAY IS TABLE OF CHAR INDEX BY PLS_INTEGER;
digits ASS_ARRAY;

input_string VARCHAR2(100):='Avinash';
reversed_string VARCHAR2(100);
LENGTH_ARRAY PLS_INTEGER;
BEGIN
    LENGTH_ARRAY:=LENGTH(input_string);
    FOR i in 1..LENGTH_ARRAY LOOP
    digits(i):=SUBSTR(input_string,i,1);
    END LOOP;

FOR i in REVERSE 1..LENGTH_ARRAY LOOP
reversed_string:=reversed_string||digits(i);
END LOOP;
DBMS_OUTPUT.PUT_LINE(reversed_string);
END;
