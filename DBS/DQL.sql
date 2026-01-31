CREATE TABLE dept (
    deptno NUMBER(2) PRIMARY KEY,
    dname  VARCHAR2(14),
    loc    VARCHAR2(13)
);

CREATE TABLE emp (
    empno    NUMBER(4) PRIMARY KEY,
    ename    VARCHAR2(10),
    job      VARCHAR2(9),
    mgr      NUMBER(4),
    hiredate DATE,
    sal      NUMBER(7,2),
    comm     NUMBER(7,2),
    deptno   NUMBER(2),
    FOREIGN KEY (deptno) REFERENCES dept(deptno)
);

INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO dept VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');

INSERT INTO emp VALUES (7369, 'SMITH',  'CLERK',     7902, TO_DATE('17-DEC-1980','DD-MON-YYYY'),  800, NULL, 20);
INSERT INTO emp VALUES (7499, 'ALLEN',  'SALESMAN',  7698, TO_DATE('20-FEB-1981','DD-MON-YYYY'), 1600, 300, 30);
INSERT INTO emp VALUES (7521, 'WARD',   'SALESMAN',  7698, TO_DATE('22-FEB-1981','DD-MON-YYYY'), 1250, 500, 30);
INSERT INTO emp VALUES (7566, 'JONES',  'MANAGER',   7839, TO_DATE('02-APR-1981','DD-MON-YYYY'), 2975, NULL, 20);
INSERT INTO emp VALUES (7654, 'MARTIN', 'SALESMAN',  7698, TO_DATE('28-SEP-1981','DD-MON-YYYY'), 1250, 1400, 30);
INSERT INTO emp VALUES (7698, 'BLAKE',  'MANAGER',   7839, TO_DATE('01-MAY-1981','DD-MON-YYYY'), 2850, NULL, 30);
INSERT INTO emp VALUES (7782, 'CLARK',  'MANAGER',   7839, TO_DATE('09-JUN-1981','DD-MON-YYYY'), 2450, NULL, 10);
INSERT INTO emp VALUES (7788, 'SCOTT',  'ANALYST',   7566, TO_DATE('13-JUL-1987','DD-MON-YYYY'), 3000, NULL, 20);
INSERT INTO emp VALUES (7839, 'KING',   'PRESIDENT', NULL, TO_DATE('17-NOV-1981','DD-MON-YYYY'), 5000, NULL, 10);
INSERT INTO emp VALUES (7844, 'TURNER', 'SALESMAN',  7698, TO_DATE('08-SEP-1981','DD-MON-YYYY'), 1500,    0, 30);
INSERT INTO emp VALUES (7876, 'ADAMS',  'CLERK',     7788, TO_DATE('13-JUL-1987','DD-MON-YYYY'), 1100, NULL, 20);
INSERT INTO emp VALUES (7900, 'JAMES',  'CLERK',     7698, TO_DATE('03-DEC-1981','DD-MON-YYYY'),  950, NULL, 30);
INSERT INTO emp VALUES (7902, 'FORD',   'ANALYST',   7566, TO_DATE('03-DEC-1981','DD-MON-YYYY'), 3000, NULL, 20);
INSERT INTO emp VALUES (7934, 'MILLER', 'CLERK',     7782, TO_DATE('23-JAN-1982','DD-MON-YYYY'), 1300, NULL, 10);

--Display the emp name, salary, and commission for all employees who earn commissions. Sort data in descending order of salary and commissions.
SELECT ename, sal, comm
FROM emp
WHERE comm IS NOT NULL
ORDER BY sal DESC, comm DESC;
 
--Show empno and ename having deptno 20 or 30 in descending order.
SELECT empno, ename
FROM emp
WHERE deptno IN (20, 30)
ORDER BY ename DESC;
 
--Display employee name (first letter uppercase, rest lowercase) and length of the name, for employees whose names start with J, A, or M. Sort results in descending order of employee name.
SELECT INITCAP(ename) AS employee_name,
       LENGTH(ename) AS name_length
FROM emp
WHERE ename LIKE 'J%' OR ename LIKE 'A%' OR ename LIKE 'M%'
ORDER BY employee_name DESC;
 
--Display emp name and calculate number of months employed (today – hiredate). Label as MONTHS_WORKED. Sort in descending order of months employed.
SELECT ename,
       FLOOR(MONTHS_BETWEEN(SYSDATE, hiredate)) AS months_worked
FROM emp
ORDER BY months_worked DESC;
 
--Display emp name and salary for all employees. Format salary to 8 characters, left-padded with "$". Label column as SALARY.
SELECT ename,
       LPAD(sal, 8, '$') AS salary
FROM emp;

--Display emp name, hire date, number of months employed, first Friday after hire date, and last day of the month.
SELECT ename,
       hiredate,
       FLOOR(MONTHS_BETWEEN(SYSDATE, hiredate)) AS months_employed,
       NEXT_DAY(hiredate, 'FRIDAY') AS first_friday,
       LAST_DAY(hiredate) AS last_day_of_month
FROM emp;
 
--Display emp names and commission amounts. If commission is null, show "No Commission". Label column COMM.
SELECT ename,
       NVL(TO_CHAR(comm), 'No Commission') AS comm
FROM emp;
 
--isplay ename, hiredate and print the date in DD Month YYYY Format. Label as DATE FORMAT.
SELECT ename,
       TO_CHAR(hiredate, 'DD Month YYYY') AS date_format
FROM emp;
 
--Write a query that generates the following output
1. Display emp name and email address. Email is made from first four letters of ename + "@gmail.com".
SELECT ename,
       LOWER(SUBSTR(ename, 1, 4)) || '@gmail.com' AS email
FROM emp;
