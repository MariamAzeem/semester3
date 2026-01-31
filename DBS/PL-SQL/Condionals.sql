--Do it on FreeSQL
SET SERVEROUTPUT ON;
DECLARE
    num NUMBER;
BEGIN
        num := &ENTER;

        IF num < 5 THEN
            DBMS_OUTPUT.PUT_LINE('SMALLER THAN 5');
        ELSE
            DBMS_OUTPUT.PUT_LINE('BIGGER THAN 5');
        END IF;
END;
/

