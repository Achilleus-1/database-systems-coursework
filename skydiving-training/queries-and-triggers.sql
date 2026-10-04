USE group8proj;

-- SELECT w two 
SELECT name, progress_milestone
FROM Student;

-- SELECT w JOIN, CONCAT, DISTINCT
SELECT DISTINCT 
    i.instructor_id, 
    CONCAT(i.name, ' - ', c.certification_name) AS instructor_cert
FROM Instructor i
JOIN Instructor_certification ic ON i.instructor_id = ic.instructor_id
JOIN Certifications c ON ic.certification_id = c.certification_id;

-- SELECT w subquery
SELECT name
FROM Student
WHERE total_jumps > (
    SELECT AVG(total_jumps) FROM Student
);

-- SELECT w ORDER BY
SELECT session_id, student_id, jump_count
FROM Training_session
ORDER BY jump_count DESC;

-- trigger to update total_jumps after INSERT
DROP TRIGGER IF EXISTS trg_update_total_jumps;
DELIMITER $$
CREATE TRIGGER trg_update_total_jumps
AFTER INSERT ON Training_session
FOR EACH ROW
BEGIN
    UPDATE Student
    SET total_jumps = total_jumps + NEW.jump_count
    WHERE student_id = NEW.student_id;
END$$
DELIMITER ;

-- test INSERT for updater trigger
INSERT INTO Training_session 
VALUES (14, 1, 100, '2025-05-01', 2, 'Passed', 'Stable posture');

-- Delete attendance before the parent row so the foreign key remains valid.
DROP TRIGGER IF EXISTS trg_delete_attendance;
DELIMITER $$
CREATE TRIGGER trg_delete_attendance
BEFORE DELETE ON Training_session
FOR EACH ROW
BEGIN
    DELETE FROM Session_Attendance
    WHERE session_id = OLD.session_id;
END$$
DELIMITER ;

-- Test deletion with attendance still present; the trigger removes it.
DELETE FROM Training_session
WHERE session_id = 10;

-- Contributor Q1, shows list of students who signed waivers on file
SELECT student_id, name
FROM Student
WHERE waiver_flag = TRUE;

-- Contributor Q2, shows instructor certs expiring this year, 2025
SELECT instructor_id, certification_id, expiration_date
FROM Instructor_certification
WHERE YEAR(expiration_date) = 2025;

-- Contributor Q1, shows mentor pairings by combining student and instructor tables
SELECT m.mentorship_id, i.name AS instructor_name, s.name AS student_name
FROM Mentorship m
JOIN Instructor i ON m.instructor_id = i.instructor_id
JOIN Student s ON m.student_id = s.student_id;

-- Contributor Q2, shows cert count per student. shows how many certs each student has
SELECT student_id, COUNT(*) AS cert_count
FROM Student_certification
GROUP BY student_id;

-- Contributor Q1, shows total jumps from all students
SELECT SUM(total_jumps) AS total_all_jumps
FROM Student;

-- Contributor Q2, searches jump logs, sees if key word unstable is used to track insufficient jumps
SELECT session_id, student_id, safety_evaluation
FROM Training_session
WHERE safety_evaluation LIKE '%unstable%';

-- Contributor Q1, shows students without any certs
SELECT s.student_id, s.name
FROM Student s
LEFT JOIN Student_certification sc ON s.student_id = sc.student_id
WHERE sc.student_id IS NULL;

-- Contributor Q2, shows how many sessions each instructor has done
SELECT instructor_id, COUNT(*) AS total_sessions
FROM Training_session
GROUP BY instructor_id;
