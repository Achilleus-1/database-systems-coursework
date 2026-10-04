CREATE DATABASE group8proj;
USE group8proj;

CREATE TABLE Instructor (
    instructor_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    height DECIMAL(5,2) NOT NULL,
    waiver_flag BOOLEAN NOT NULL,
    total_jumps INT NOT NULL DEFAULT 0,
    progress_milestone VARCHAR(100)
);

CREATE TABLE Certifications (
    certification_id INT PRIMARY KEY,
    certification_name VARCHAR(100) NOT NULL,
    certification_provider VARCHAR(100),
    certification_length INT NOT NULL
);

CREATE TABLE Instructor_certification (
    instructor_cert_id INT PRIMARY KEY,
    instructor_id INT NOT NULL,
    certification_id INT NOT NULL,
    expiration_date DATE,
    renewal_date DATE,
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id),
    FOREIGN KEY (certification_id) REFERENCES Certifications(certification_id)
);

CREATE TABLE Student_certification (
    student_cert_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    certification_id INT NOT NULL,
    expiration_date DATE,
    renewal_date DATE,
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (certification_id) REFERENCES Certifications(certification_id)
);

CREATE TABLE Training_session (
    session_id INT PRIMARY KEY,
    instructor_id INT NOT NULL,
    student_id INT NOT NULL,
    session_date DATE NOT NULL,
    jump_count INT NOT NULL,
    session_outcome VARCHAR(100),
    safety_evaluation VARCHAR(255),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE Mentorship (
    mentorship_id INT PRIMARY KEY,
    instructor_id INT NOT NULL,
    student_id INT NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

CREATE TABLE Session_Attendance (
    attendance_id INT PRIMARY KEY,
    session_id INT NOT NULL,
    student_id INT NOT NULL,
    FOREIGN KEY (session_id) REFERENCES Training_session(session_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

-- Fake sample data

INSERT INTO Instructor VALUES (1, 'Instructor A');
INSERT INTO Instructor VALUES (2, 'Instructor B');

INSERT INTO Student VALUES (100, 'Student A', 175.5, TRUE, 5, 'Level 1');
INSERT INTO Student VALUES (101, 'Student B', 180.2, TRUE, 8, 'Level 2');

INSERT INTO Certifications VALUES (1, 'Basic Jump Cert', 'SkyTrain Co.', 12);
INSERT INTO Certifications VALUES (2, 'Advanced Maneuvers', 'SkyTrain Co.', 24);

INSERT INTO Instructor_certification VALUES (1, 1, 1, '2025-12-01', '2025-11-01');
INSERT INTO Instructor_certification VALUES (2, 2, 2, '2026-05-15', '2026-04-15');

INSERT INTO Student_certification VALUES (1, 100, 1, '2025-10-10', '2025-09-10');
INSERT INTO Student_certification VALUES (2, 101, 2, '2026-02-01', '2026-01-01');

INSERT INTO Training_session VALUES (10, 1, 100, '2025-04-01', 3, 'Passed', 'Safe and stable');
INSERT INTO Training_session VALUES (11, 2, 101, '2025-04-02', 5, 'Passed', 'Excellent control');

INSERT INTO Mentorship VALUES (1, 1, 100);
INSERT INTO Mentorship VALUES (2, 2, 101);

INSERT INTO Session_Attendance VALUES (1, 10, 100);
INSERT INTO Session_Attendance VALUES (2, 11, 101);
