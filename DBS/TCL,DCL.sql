CREATE TABLE STUDENT (
    StudentID NUMBER PRIMARY KEY,
    Name      VARCHAR2(15),
    Age       NUMBER,
    City      VARCHAR2(15)
);
CREATE TABLE EMPLOYEE (
    EmployeeID NUMBER PRIMARY KEY,
    Name       VARCHAR2(15),
    Salary     NUMBER,
    Commission NUMBER,
    DeptID     NUMBER
);
CREATE TABLE DEPARTMENT (
    DeptID    NUMBER PRIMARY KEY,
    DeptName  VARCHAR2(15),
    Location  VARCHAR2(15)
);


--COMMIT:
INSERT INTO STUDENT (StudentID, Name, Age, City)
VALUES (200, 'Hina', 21, 'Rawalpindi');

INSERT INTO STUDENT (StudentID, Name, Age, City)
VALUES (201, 'Ahmed', 22, 'Lahore');

COMMIT; 

 

--ROLLBACK:
INSERT INTO EMPLOYEE (EmployeeID, Name, Salary, Commission, DeptID)
VALUES (900, 'WrongData', 99999, NULL, NULL);

ROLLBACK; 
 
--SAVEPOINT:
INSERT INTO STUDENT (StudentID, Name, Age, City)
VALUES (300, 'Nimra', 20, 'Karachi');

SAVEPOINT A;  

INSERT INTO STUDENT (StudentID, Name, Age, City)
VALUES (301, 'Zain', 23, 'Islamabad');

ROLLBACK TO A;

COMMIT;
 

--GRANT:
--GRANT SELECT, UPDATE ON EMPLOYEE TO user1;

--REVOKE:
--REVOKE UPDATE ON EMPLOYEE FROM user1;

--ROLES:
-- CREATE ROLE deletion;
-- GRANT DELETE ON DEPARTMENT to deletion;
-- GRANT deletion to user1;

SELECT * FROM STUDENT;
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
