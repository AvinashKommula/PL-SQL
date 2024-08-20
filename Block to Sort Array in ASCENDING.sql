DECLARE
  TYPE number_array IS TABLE OF NUMBER;
  v_array number_array := number_array(30, 20, 10, 50, 40);
  v_temp  NUMBER;
BEGIN
  FOR i IN v_array.FIRST..v_array.LAST LOOP
    FOR j IN i+1..v_array.LAST LOOP
      IF v_array(i) > v_array(j) THEN
        v_temp := v_array(i);
        v_array(i) := v_array(j);
        v_array(j) := v_temp;
      END IF;
    END LOOP;
  END LOOP;

  FOR i IN v_array.FIRST..v_array.LAST LOOP
    DBMS_OUTPUT.PUT_LINE(v_array(i));
  END LOOP;
END;
