CREATE TABLE dept (
    deptno NUMBER PRIMARY KEY,
    dname VARCHAR2(15),
    loc VARCHAR2(15)
);

CREATE TABLE emp (
    empno NUMBER PRIMARY KEY,
    ename VARCHAR2(15),
    job VARCHAR2(15),
    mgr NUMBER,
    hiredate DATE,
    sal NUMBER,
    comm NUMBER,
    deptno NUMBER,
    FOREIGN KEY (deptno) REFERENCES dept(deptno)
);

INSERT INTO dept VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO dept VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO dept VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO dept VALUES (40, 'OPERATIONS', 'BOSTON');

INSERT INTO emp VALUES (7369, 'SMITH', 'CLERK', 7902, TO_DATE('17-DEC-80', 'DD-MON-RR'), 800, NULL, 20);
INSERT INTO emp VALUES (7499, 'ALLEN', 'SALESMAN', 7698, TO_DATE('20-FEB-81', 'DD-MON-RR'), 1600, 300, 30);
INSERT INTO emp VALUES (7521, 'WARD', 'SALESMAN', 7698, TO_DATE('22-FEB-81', 'DD-MON-RR'), 1250, 500, 30);
INSERT INTO emp VALUES (7566, 'JONES', 'MANAGER', 7839, TO_DATE('02-APR-81', 'DD-MON-RR'), 2975, NULL, 20);
INSERT INTO emp VALUES (7698, 'BLAKE', 'MANAGER', 7839, TO_DATE('01-MAY-81', 'DD-MON-RR'), 2850, NULL, 30);
INSERT INTO emp VALUES (7782, 'CLARK', 'MANAGER', 7839, TO_DATE('09-JUN-81', 'DD-MON-RR'), 2450, NULL, 10);
INSERT INTO emp VALUES (7788, 'SCOTT', 'ANALYST', 7566, TO_DATE('19-APR-87', 'DD-MON-RR'), 3000, NULL, 20);

--Employee Details with Department Information
SELECT e.ename, e.deptno, d.dname, d.loc
FROM emp e
JOIN dept d ON e.deptno = d.deptno;

--Unique Jobs in Department 30 with Location
SELECT DISTINCT e.job, d.loc
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE e.deptno = 30;

--Commissioned Employees with Department Details
SELECT e.ename, e.sal, d.dname, d.loc
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE e.comm IS NOT NULL AND e.comm > 0;

--Employee and Manager Details with Department Name
SELECT e.empno, e.ename, e.mgr, d.dname
FROM emp e
JOIN dept d ON e.deptno = d.deptno;

--All Employees and All Departments
SELECT e.*, d.dname
FROM emp e
RIGHT JOIN dept d ON e.deptno = d.deptno;

--Employee Salary Grades
SELECT e.empno, e.ename, e.sal,
       CASE 
           WHEN e.sal BETWEEN 700 AND 1200 THEN 1
           WHEN e.sal BETWEEN 1201 AND 1400 THEN 2
           WHEN e.sal BETWEEN 1401 AND 2000 THEN 3
           WHEN e.sal BETWEEN 2001 AND 3000 THEN 4
           WHEN e.sal BETWEEN 3001 AND 3500 THEN 5
           WHEN e.sal BETWEEN 1000 AND 1250 THEN 6
           END AS grade
           FROM emp e;



