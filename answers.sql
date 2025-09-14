-- Question 1: Build a Complete Database Management System
-- Instructions:

-- Choose a real-world use case (Student Records).

-- Create a relational database schema that includes:

-- Well-structured tables.

-- Proper constraints (PRIMARY KEY, FOREIGN KEY, NOT NULL, UNIQUE).

-- Relationships (One-to-One, One-to-Many, Many-to-Many, where applicable).

-- Use SQL to implement your design. 
-- Step 1: Create Database
CREATE DATABASE StudentRecordsDB;
-- Step 2: Create Tables
-- Departments Table
USE StudentRecordsDB;
CREATE TABLE Departments (
    DeptID INT AUTO_INCREMENT PRIMARY KEY,
    DeptName VARCHAR(100) NOT NULL UNIQUE
);
USE StudentRecordsDB;

-- Instructors Table
CREATE TABLE Instructors (
    InstructorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DeptID INT NOT NULL,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);
USE StudentRecordsDB;

-- Students Table
CREATE TABLE Students (
    StudentID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DOB DATE NOT NULL,
    Gender ENUM('Male','Female','Other') NOT NULL,
    Email VARCHAR(100) UNIQUE,
    DeptID INT NOT NULL,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)
);
USE StudentRecordsDB;

-- Courses Table
CREATE TABLE Courses (
    CourseID INT AUTO_INCREMENT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL,
    DeptID INT NOT NULL,
    InstructorID INT NOT NULL,
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID),
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);
USE StudentRecordsDB;

-- Enrollment Table (Many-to-Many: Students <-> Courses)
CREATE TABLE Enrollments (
    EnrollmentID INT AUTO_INCREMENT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    Grade CHAR(2),
    UNIQUE (StudentID, CourseID), -- prevent duplicate enrollments
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);
-- Step 3: Insert Sample Data
USE StudentRecordsDB;

-- Departments
INSERT INTO Departments (DeptName) VALUES
('Computer Science'),
('Mathematics'),
('Business Administration');
USE StudentRecordsDB;

-- Instructors
INSERT INTO Instructors (FirstName, LastName, Email, DeptID) VALUES
('Alice', 'Johnson', 'alice.johnson@univ.edu', 1),
('Bob', 'Smith', 'bob.smith@univ.edu', 2),
('Carol', 'Davis', 'carol.davis@univ.edu', 3);
USE StudentRecordsDB;

-- Students
INSERT INTO Students (FirstName, LastName, DOB, Gender, Email, DeptID) VALUES
('John', 'Doe', '2000-05-15', 'Male', 'john.doe@student.edu', 1),
('Jane', 'Smith', '2001-08-20', 'Female', 'jane.smith@student.edu', 2),
('Mike', 'Brown', '1999-11-30', 'Male', 'mike.brown@student.edu', 3);
USE StudentRecordsDB;

-- Courses
INSERT INTO Courses (CourseName, Credits, DeptID, InstructorID) VALUES
('Database Systems', 3, 1, 1),
('Calculus II', 4, 2, 2),
('Business Ethics', 3, 3, 3);
USE StudentRecordsDB;

-- Enrollments
INSERT INTO Enrollments (StudentID, CourseID, Grade) VALUES
(1, 1, 'A'),
(1, 2, 'B'),
(2, 2, 'A'),
(3, 3, 'B');