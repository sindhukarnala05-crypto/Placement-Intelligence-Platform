-- ==========================================
-- Placement Intelligence Platform
-- Database Schema
-- ==========================================

CREATE DATABASE IF NOT EXISTS placement_platform;
USE placement_platform;

-- ==========================================
-- Students Table
-- ==========================================

CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Gender ENUM('Male','Female','Other'),
    Branch VARCHAR(50) NOT NULL,
    CGPA DECIMAL(3,2) NOT NULL,
    GraduationYear YEAR NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15)
);

-- ==========================================
-- Companies Table
-- ==========================================

CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY AUTO_INCREMENT,
    CompanyName VARCHAR(100) NOT NULL,
    Role VARCHAR(100) NOT NULL,
    Package DECIMAL(5,2),
    Location VARCHAR(100),
    EligibilityCGPA DECIMAL(3,2)
);

-- ==========================================
-- Skills Table
-- ==========================================

CREATE TABLE Skills (
    SkillID INT PRIMARY KEY AUTO_INCREMENT,
    SkillName VARCHAR(100) UNIQUE NOT NULL
);

-- ==========================================
-- Student Skills Table
-- ==========================================

CREATE TABLE StudentSkills (
    StudentSkillID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    SkillID INT NOT NULL,
    SkillLevel ENUM('Beginner','Intermediate','Advanced') NOT NULL,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SkillID) REFERENCES Skills(SkillID)
);

-- ==========================================
-- Assessments Table
-- ==========================================

CREATE TABLE Assessments (
    AssessmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    CompanyID INT NOT NULL,
    CodingScore INT,
    SQLScore INT,
    AptitudeScore INT,
    AssessmentDate DATE,
    Status ENUM('Qualified','Rejected','Pending'),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

-- ==========================================
-- Interviews Table
-- ==========================================

CREATE TABLE Interviews (
    InterviewID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    CompanyID INT NOT NULL,
    TechnicalRound ENUM('Pass','Fail'),
    HRRound ENUM('Pass','Fail','Pending'),
    InterviewDate DATE,
    Result ENUM('Selected','Rejected','Pending'),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

-- ==========================================
-- Offers Table
-- ==========================================

CREATE TABLE Offers (
    OfferID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT NOT NULL,
    CompanyID INT NOT NULL,
    OfferedPackage DECIMAL(5,2),
    OfferDate DATE,
    OfferStatus ENUM('Accepted','Rejected','Pending'),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);