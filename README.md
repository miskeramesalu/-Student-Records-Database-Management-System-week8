# -Student-Records-Database-Management-System-week8
# 🎓 Student Records Database Management System

## 📌 Project Overview
This project implements a **relational database** for managing student records in a university using **MySQL**.  
It models the relationships between **Students, Instructors, Courses, Departments, and Enrollments** and ensures data integrity using constraints.

The database supports typical operations such as student enrollment, course assignments, and grade tracking.

---

## 🏗️ Database Schema

### Tables

1. **Departments**
   - Stores academic departments.
   - Columns: `DeptID` (PK), `DeptName` (unique).

2. **Instructors**
   - Faculty members teaching courses.
   - Columns: `InstructorID` (PK), `FirstName`, `LastName`, `Email` (unique), `DeptID` (FK → Departments).

3. **Students**
   - Records student personal and academic info.
   - Columns: `StudentID` (PK), `FirstName`, `LastName`, `DOB`, `Gender`, `Email` (unique), `DeptID` (FK → Departments).

4. **Courses**
   - Stores university courses.
   - Columns: `CourseID` (PK), `CourseName`, `Credits`, `DeptID` (FK → Departments), `InstructorID` (FK → Instructors).

5. **Enrollments**
   - Junction table for **many-to-many** relation between students and courses.
   - Columns: `EnrollmentID` (PK), `StudentID` (FK → Students), `CourseID` (FK → Courses), `EnrollmentDate`, `Grade`.
   - Unique constraint on `(StudentID, CourseID)` prevents duplicate enrollments.

---

## 🔑 Relationships

- **One-to-Many**
  - Department → Students
  - Department → Instructors
  - Instructor → Courses

- **Many-to-Many**
  - Students ↔ Courses (via Enrollments)

---

## ⚙️ How to Use

1. Open MySQL and run the SQL script:

```sql
SOURCE path_to/student_records.sql;

USE StudentRecordsDB;
SELECT * FROM Students;

SELECT s.FirstName, s.LastName, c.CourseName, e.Grade
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE s.StudentID = 1;

SELECT c.CourseName, AVG(CASE
  WHEN e.Grade = 'A' THEN 4
  WHEN e.Grade = 'B' THEN 3
  WHEN e.Grade = 'C' THEN 2
  WHEN e.Grade = 'D' THEN 1
  ELSE 0 END) AS GPA
FROM Enrollments e
JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY c.CourseName;

