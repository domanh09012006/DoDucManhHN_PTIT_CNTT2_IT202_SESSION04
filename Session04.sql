CREATE DATABASE online_learning;
USE online_learning;

CREATE TABLE Student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Teacher (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Course (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    description VARCHAR(255),
    total_sessions INT CHECK (total_sessions > 0),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id)
);

CREATE TABLE Enrollment (
    student_id INT,
    course_id INT,
    enroll_date DATE NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Score (
    student_id INT,
    course_id INT,
    mid_score DECIMAL(3,1) CHECK (mid_score BETWEEN 0 AND 10),
    final_score DECIMAL(3,1) CHECK (final_score BETWEEN 0 AND 10),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

INSERT INTO Student (full_name, birth_date, email) VALUES
('Nguyễn Văn A', '2003-05-12', 'a@gmail.com'),
('Nguyễn Văn B', '2003-08-20', 'b@gmail.com'),
('Nguyễn Văn C', '2002-11-01', 'c@gmail.com'),
('Nguyễn Văn D', '2003-02-18', 'd@gmail.com'),
('Nguyễn Văn E', '2002-07-09', 'e@gmail.com');

INSERT INTO Teacher (full_name, email) VALUES
('Thầy Minh', 'minh@edu.vn'),
('Thầy Minh1', 'minh1@edu.vn'),
('Thầy Minh2', 'minh2@edu.vn'),
('Thầy Minh3', 'minh3@edu.vn'),
('Thầy Minh4', 'minh4@edu.vn');

INSERT INTO Course (course_name, description, total_sessions, teacher_id) VALUES
('SQL Cơ bản', 'Nhập môn SQL', 10, 1),
('Java Cơ bản', 'Java cho người mới', 15, 2),
('HTML Cơ bản', 'Thiết kế web cơ bản', 12, 3),
('Python', 'Lập trình Python', 14, 4),
('Cấu trúc dữ liệu', 'CTDL & Giải thuật', 16, 5);

INSERT INTO Enrollment VALUES
(1, 1, '2024-01-10'),
(1, 2, '2024-01-12'),
(2, 1, '2024-01-11'),
(3, 3, '2024-01-15'),
(4, 4, '2024-01-20');

INSERT INTO Score VALUES
(1, 1, 7.5, 8.0),
(1, 2, 6.0, 7.0),
(2, 1, 8.0, 9.0),
(3, 3, 7.0, 7.5),
(4, 4, 6.5, 8.0);

UPDATE Student
SET email = 'newa@gmail.com'
WHERE student_id = 1;

UPDATE Course
SET description = 'SQL từ cơ bản đến nâng cao'
WHERE course_id = 1;

UPDATE Score
SET final_score = 9.0
WHERE student_id = 1 AND course_id = 1;

DELETE FROM Enrollment
WHERE student_id = 4 AND course_id = 4;

DELETE FROM Score
WHERE student_id = 4 AND course_id = 4;

SELECT * FROM Student;

SELECT * FROM Teacher;

SELECT * FROM Course;

SELECT
    (SELECT full_name FROM Student WHERE Student.student_id = Enrollment.student_id),
    (SELECT course_name FROM Course WHERE Course.course_id = Enrollment.course_id),
    enroll_date
FROM Enrollment;

SELECT
    (SELECT full_name FROM Student WHERE Student.student_id = Score.student_id),
    (SELECT course_name FROM Course WHERE Course.course_id = Score.course_id),
    mid_score,
    final_score
FROM Score;
