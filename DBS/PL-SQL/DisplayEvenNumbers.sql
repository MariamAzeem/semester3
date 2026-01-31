SET SERVEROUTPUT ON;
BEGIN
    FOR i IN 1..10 LOOP
        IF MOD(i, 2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE('EVEN ' || i);
        END IF;
    END LOOP;
END;
/

