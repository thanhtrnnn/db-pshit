-- Tables: Student
-- Technique: DDL (dialect: Mysql)

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    BirthDate DATE,
    GPA DECIMAL(3,2) NOT NULL
);