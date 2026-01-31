 SET SERVEROUTPUT ON;
DECLARE
    vol NUMBER := 0;
BEGIN
    FOR i IN 1..10 LOOP
        vol := vol * 10 + i;
        DBMS_OUTPUT.PUT_LINE(vol);
    END LOOP;
END;
/


