DECLARE a NUMBER:=10;
b NUMBER:=20;
BEGIN
a:=a+b;
b:=a-b;
a:=a-b;
DBMS_OUTPUT.PUT_LINE('a='||a ||' '||'b='||b);
    END;