DECLARE
NO_OF_PRIMES_NEEDED NUMBER:=10;
COUNT_OF_PRIMES NUMBER:=0;
IS_PRIME BOOLEAN:=TRUE;
PRIME_NUMBER NUMBER:=2;
i number;
BEGIN
WHILE(COUNT_OF_PRIMES<NO_OF_PRIMES_NEEDED) LOOP

i:=2;
WHILE i <SQRT(PRIME_NUMBER) LOOP
IF(MOD(PRIME_NUMBER,i)=0) THEN IS_PRIME:=FALSE;
EXIT;
ELSE IS_PRIME:=TRUE;
END IF;
i:=i+1;
END LOOP;

IF(IS_PRIME) THEN 
DBMS_OUTPUT.PUT_LINE(PRIME_NUMBER);
COUNT_OF_PRIMES:=COUNT_OF_PRIMES+1;
PRIME_NUMBER:=PRIME_NUMBER+1;
ELSE 
PRIME_NUMBER:=PRIME_NUMBER+1;
END IF;

END LOOP;
END;