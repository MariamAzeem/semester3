SET SERVEROUTPUT ON;
DECLARE
    num VARCHAR2(10) := '24SW025';
    rev VARCHAR2(20) := '';
BEGIN
    FOR i IN REVERSE 1..LENGTH(num) LOOP
        rev := rev || SUBSTR(num, i, 1);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(rev);
END;
/

