DECLARE
TYPE V_ARRAY IS TABLE OF NUMBER;
INPUT_ARRAY V_ARRAY:=V_ARRAY(10,20,30,40,90);
MEDIAN_ARRAY NUMBER;
BEGIN
IF MOD(INPUT_ARRAY.COUNT,2)=0 THEN
MEDIAN_ARRAY:=(INPUT_ARRAY(INPUT_ARRAY.COUNT/2)+INPUT_ARRAY((INPUT_ARRAY.COUNT/2)+1))/2;
ELSE
MEDIAN_ARRAY:=INPUT_ARRAY(((INPUT_ARRAY.COUNT)+1)/2);
END IF;
DBMS_OUTPUT.PUT_LINE(MEDIAN_ARRAY);
END;
