-- Enable output for DBMS_OUTPUT statements
SET SERVEROUTPUT ON;

-------------------------------
-- TABLE CREATION
-------------------------------

-- Department table
CREATE TABLE Department (
    DeptID NUMBER PRIMARY KEY,
    DeptName VARCHAR2(50),
    Location VARCHAR2(50)
);

-- Faculty table with foreign key to Department
CREATE TABLE FacultyMember (
    FacultyID NUMBER PRIMARY KEY,
    HireDate DATE,
    DeptID NUMBER,
    FacultyName VARCHAR2(50),
    Email VARCHAR2(100),
    Designation VARCHAR2(50),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Student table linked to Department
CREATE TABLE Student (
    StudentID NUMBER PRIMARY KEY,
    DeptID NUMBER,
    StudentName VARCHAR2(50),
    Email VARCHAR2(100),
    YearOfStudy NUMBER,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Course table linked to Department
CREATE TABLE Course (
    CourseID NUMBER PRIMARY KEY,
    DeptID NUMBER,
    CourseTitle VARCHAR2(100),
    CreditHours NUMBER,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- Course Sections taught by faculty
CREATE TABLE CourseSection (
    CourseID NUMBER,
    SectionNumber NUMBER,
    FacultyID NUMBER,
    Semester VARCHAR2(20),
    Year NUMBER,
    PRIMARY KEY (CourseID, SectionNumber),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (FacultyID) REFERENCES FacultyMember(FacultyID)
);

-- Enrollment table linking Students to CourseSections
CREATE TABLE Enrollment (
    EnrollmentID NUMBER PRIMARY KEY,
    StudentID NUMBER,
    CourseID NUMBER,
    SectionNumber NUMBER,
    Grade CHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID, SectionNumber) REFERENCES CourseSection(CourseID, SectionNumber),
    UNIQUE (StudentID, CourseID)   -- Prevent duplicate enrollment in same course
);

-- Project table linked to Faculty
CREATE TABLE Project (
    ProjectID NUMBER PRIMARY KEY,
    Title VARCHAR2(100),
    StartDate DATE,
    EndDate DATE,
    FacultyID NUMBER,
    FOREIGN KEY (FacultyID) REFERENCES FacultyMember(FacultyID)
);

-- Publications connected to Projects
CREATE TABLE Publication (
    PublicationID NUMBER PRIMARY KEY,
    Title VARCHAR2(100),
    PublishYear NUMBER,
    PublicationType VARCHAR2(50),
    ProjectID NUMBER,
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);

-- Members of projects (students or faculty)
CREATE TABLE ProjectMember (
    ProjectMemberID NUMBER PRIMARY KEY,
    ProjectID NUMBER NOT NULL,
    StudentID NUMBER,
    FacultyID NUMBER,
    Role VARCHAR2(50),
    FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (FacultyID) REFERENCES FacultyMember(FacultyID)
);

-------------------------------
-- INSERTING DATA
-------------------------------

-- Departments
INSERT INTO Department VALUES (10, 'Computer Science', 'Block A');
INSERT INTO Department VALUES (20, 'Electrical Engineering', 'Block B');
INSERT INTO Department VALUES (30, 'Business Administration', 'Block C');
INSERT INTO Department VALUES (40, 'Mathematics', 'Block D');
INSERT INTO Department VALUES (50, 'Unassigned Dept', NULL);

-- Faculty members
INSERT INTO FacultyMember VALUES (101, DATE '2018-08-20', 10, 'Dr. Ali Khan', 'ali.khan@uni.edu', 'Professor');
INSERT INTO FacultyMember VALUES (102, DATE '2020-02-11', 20, 'Dr. Sara Malik', 'sara.malik@uni.edu', 'Associate Prof');
INSERT INTO FacultyMember VALUES (103, DATE '2018-08-20', 30, 'Mr. Imran Shah', 'imran.shah@uni.edu', 'Lecturer');
INSERT INTO FacultyMember VALUES (104, DATE '2019-07-30', NULL, 'Ms. Nadia Raza', 'nadia.raza@uni.edu', 'Visiting Faculty');
INSERT INTO FacultyMember VALUES (105, DATE '2022-01-10', 10, 'Dr. Bilal Ahmed', 'bilal.ahmed@uni.edu', 'Assistant Prof');

-- Students
INSERT INTO Student VALUES (201, 10, 'Ayesha Noor', 'ayesha.noor@uni.edu', 2);
INSERT INTO Student VALUES (202, 20, 'Hamza Ali', 'hamza.ali@uni.edu', 3);
INSERT INTO Student VALUES (203, 30, 'Fatima Zain', 'fatima.zain@uni.edu', 1);
INSERT INTO Student VALUES (204, NULL, 'Usman Tariq', 'usman.tariq@uni.edu', 2);
INSERT INTO Student VALUES (205, 10, 'Sara Khan', 'sara.khan@uni.edu', 4);

-- Savepoint to allow rollback
SAVEPOINT A;

-- These will be rolled back
INSERT INTO Student VALUES (206, 20, 'Test Rollback 1', 'rollback1@uni.edu', 1);
INSERT INTO Student VALUES (207, 30, 'Test Rollback 2', 'rollback2@uni.edu', 2);

-- Rollback to savepoint A (removes above 2 rows)
ROLLBACK TO A;

-- Insert Courses
INSERT INTO Course VALUES (301, 10, 'Database Systems', 3);
INSERT INTO Course VALUES (302, 10, 'Operating Systems', 4);
INSERT INTO Course VALUES (303, 20, 'Circuit Analysis', 3);
INSERT INTO Course VALUES (304, 30, 'Principles of Marketing', 3);
INSERT INTO Course VALUES (305, NULL, 'Independent Study', 2);

-- Course sections
INSERT INTO CourseSection VALUES (301, 1, 101, 'Fall', 2024);
INSERT INTO CourseSection VALUES (301, 2, 105, 'Spring', 2025);
INSERT INTO CourseSection VALUES (302, 1, 101, 'Fall', 2024);
INSERT INTO CourseSection VALUES (303, 1, 102, 'Spring', 2025);
INSERT INTO CourseSection VALUES (304, 1, NULL, 'Fall', 2024);

-- Enrollment records
INSERT INTO Enrollment VALUES (401, 201, 301, 1, 'A');
INSERT INTO Enrollment VALUES (402, 202, 303, 1, 'B');
INSERT INTO Enrollment VALUES (403, 203, 301, 2, 'A');
INSERT INTO Enrollment VALUES (404, 201, 302, 1, 'B+');

-- Projects
INSERT INTO Project VALUES (501, 'AI Research', DATE '2024-01-10', DATE '2024-12-31', 101);
INSERT INTO Project VALUES (502, 'Smart Grid System', DATE '2023-03-01', DATE '2024-03-01', 102);
INSERT INTO Project VALUES (503, 'Marketing Automation', DATE '2024-05-20', NULL, 103);
INSERT INTO Project VALUES (504, 'Mathematics Modeling', DATE '2024-07-01', NULL, NULL);
INSERT INTO Project VALUES (505, 'Unused Project', DATE '2024-08-01', NULL, 105);

-- Publications
INSERT INTO Publication VALUES (601, 'AI in Healthcare', 2024, 'Journal', 501);
INSERT INTO Publication VALUES (602, 'Smart Grids Future', 2023, 'Conference', 502);
INSERT INTO Publication VALUES (603, 'Market Trends 2024', 2024, 'Journal', 503);
INSERT INTO Publication VALUES (604, 'Machine Learning Basics', 2022, 'Book', NULL);
INSERT INTO Publication VALUES (605, 'Unlinked Paper', 2025, 'Journal', NULL);

-- Project members
INSERT INTO ProjectMember VALUES (701, 501, 201, NULL, 'Student Researcher');
INSERT INTO ProjectMember VALUES (702, 501, 203, NULL, 'Student Researcher');
INSERT INTO ProjectMember VALUES (703, 502, NULL, 102, 'Project Lead');
INSERT INTO ProjectMember VALUES (704, 503, 202, 103, 'Assistant');

-- Commit everything
COMMIT;

-------------------------------
-- SELECT QUERIES
-------------------------------

-- Show all students
SELECT * FROM Student;

-- Faculty in Dept 10 ordered alphabetically
SELECT FacultyName, Email
FROM FacultyMember
WHERE DeptID = 10
ORDER BY FacultyName ASC;

-- Show faculty with their department names
SELECT f.FacultyName, d.DeptName
FROM FacultyMember f
INNER JOIN Department d ON f.DeptID = d.DeptID;

-- Show students with courses they are enrolled in
SELECT s.StudentName, c.CourseTitle, e.SectionNumber
FROM Student s
LEFT JOIN Enrollment e ON s.StudentID = e.StudentID
LEFT JOIN Course c ON e.CourseID = c.CourseID;

-- Show all projects and their publications (RIGHT JOIN)
SELECT proj.Title, pub.Title
FROM Publication pub
RIGHT JOIN Project proj ON pub.ProjectID = proj.ProjectID;

-- Full join of Students and Courses through Enrollment
SELECT StudentName, CourseTitle
FROM Student s
FULL OUTER JOIN Enrollment e ON s.StudentID = e.StudentID
FULL OUTER JOIN Course c ON e.CourseID = c.CourseID;

-- Self join: faculty with same hire date
SELECT f.FacultyID, f.FacultyName,
       m.FacultyID AS MatchID,
       m.FacultyName AS MatchName
FROM FacultyMember f
JOIN FacultyMember m
ON f.HireDate = m.HireDate
AND f.FacultyID <> m.FacultyID;

-- Departments with 2 or more faculty
SELECT DeptID, COUNT(*) AS FacultyAvailable
FROM FacultyMember
GROUP BY DeptID
HAVING COUNT(*) >= 2;

-- Courses with 2 or more enrollments
SELECT CourseID, COUNT(*) AS StudentCount
FROM Enrollment
GROUP BY CourseID
HAVING COUNT(*) >= 2;

-------------------------------
-- TRIGGER
-------------------------------

-- Trigger to validate email format for new students
CREATE OR REPLACE TRIGGER trg_validate_student_email
BEFORE INSERT ON Student
FOR EACH ROW
BEGIN
    IF :NEW.Email IS NULL OR INSTR(:NEW.Email, '@') = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Invalid email! Student email must contain @ symbol.');
    END IF;
END;
/

-------------------------------
-- STORED PROCEDURE
-------------------------------

-- Procedure to display student list of a department
CREATE OR REPLACE PROCEDURE GetStudentsByDept(p_DeptID IN NUMBER)
AS
BEGIN
    FOR rec IN (SELECT StudentName, Email FROM Student WHERE DeptID = p_DeptID) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.StudentName || ' - ' || rec.Email);
    END LOOP;
END;
/

-------------------------------
-- ANONYMOUS BLOCK FOR TRANSACTION CONTROL
-------------------------------

BEGIN
    -- Insert a test student + enrollment
    INSERT INTO Student VALUES (500, 10, 'Test User', 'test@uni.edu', 1);
    INSERT INTO Enrollment VALUES (900, 500, 301, 1, NULL);

    COMMIT; -- Commit transaction
    DBMS_OUTPUT.PUT_LINE('Transaction committed.');
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK; -- Rollback on error
        DBMS_OUTPUT.PUT_LINE('Error! Transaction rolled back: ' || SQLERRM);
END;
/

-- Execute stored procedure
EXEC GetStudentsByDept(10);

-- Example: This will trigger email validation error
-- INSERT INTO Student VALUES (600, 10, 'Trigger Test User', 'triggertestuni.edu', 1);
