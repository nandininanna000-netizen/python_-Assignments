--  Create students table
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT CHECK (age > 0),
    grade INT DEFAULT 1,
    city VARCHAR(50),
    marks INT
);

--  Create courses table
CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    course_name VARCHAR(50) UNIQUE NOT NULL,
    teacher VARCHAR(50),
    max_seats INT
);

--  Create enrollments table
CREATE TABLE enrollments (
    student_id INT REFERENCES students(id),
    course_id INT REFERENCES courses(id),
    score INT,
    PRIMARY KEY (student_id, course_id)
);

--  Insert  to students table
INSERT INTO students (name, age, grade, city, marks)
VALUES
('Aisha', 10, 5, 'Hyderabad', 92),
('Ravi', 11, 6, 'Chennai', 78),
('Meera', 10, 5, 'Hyderabad', 92),
('Arjun', 12, 7, 'Mumbai', 65),
('Sara', 11, 6, 'Delhi', NULL),
('Kabir', 12, 7, 'Chennai', 88),
('Zoya', 10, 5, 'Delhi', 71),
('Dev', 13, 8, 'Mumbai', 55);

--  Check student data
SELECT * FROM students;
-- insert to course table
INSERT INTO courses (course_name, teacher, max_seats)
VALUES
('Mathematics', 'Ramesh', 30),
('Science', 'Suresh', 25),
('English', 'Priya', 35),
('Computer Science', 'Anil', 20),
('Social Studies', 'Lakshmi', 30);
-- check course data
SELECT * FROM courses;
-- insert to enrollments table
INSERT INTO enrollments (student_id, course_id, score)
VALUES
(1, 1, 92),
(1, 2, 85),
(2, 1, 78),
(2, 3, 88),
(3, 2, 92),
(3, 4, 95),
(4, 1, 65),
(4, 5, 70),
(5, 3, 80),
(6, 2, 88),
(6, 4, 90),
(7, 3, 71),
(8, 4, 55),
(8, 5, 60);
--check enrollments table
SELECT * FROM enrollments;
-- 0.5 checking data
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;
-- 1.1 DISPLAY all students
SELECT * FROM students;
-- 1.2 SHOW only name & city older than 10
SELECT name, city 
FROM students
WHERE age > 10;
--1.3 GRADE 5 or 7
SELECT * 
FROM students
WHERE grade IN( 5 ,  7)
ORDER BY  name ASC;
-- 1.4 marks between 70 and 90
 SELECT * 
 FROM students
 WHERE marks BETWEEN 70 and 90;
-- 1.5 null marks
SELECT *
FROM students
WHERE marks IS NULL;
-- 1.6 marks not missing
SELECT *
FROM students
WHERE marks is NOT NULL;
-- 1.7 marks from highest to lowest
SELECT name, marksz
 FROM students
 ORDER BY marks DESC;
-- 1.8 first 3 students highest marks
SELECT *
FROM students
ORDER BY  marks DESC 
LIMIT 3;

--PART 2 ANSWERS

--2.1 add new column
ALTER TABLE students
ADD email VARCHAR(50);
--verify
SELECT * FROM students;
--2.2 rename a column
ALTER TABLE students
RENAME COLUMN email TO email_id;
-- 2.3 insert values
INSERT INTO students (id, name, age, grade, city, marks)
VALUES
(9, 'Anu', 11, 6, 'hyderabad', 85);
SELECT * FROM students;
--2.4 insert with invalid age
INSERT INTO students (id , name, age, grade, city, marks)
VALUES
(10, 'Rishi', -2, 4,'pune', 90);
-- 2.5 insert column without name
INSERT INTO students (id,  age, grade, city, marks)
VALUES
(10, 11, 6, 'hyderabad', 95);
SELECT * FROM students;
--2.6 add a column
ALTER TABLE students
ADD phone VARCHAR(15);
SELECT * FROM students;
-- 2.7 remove a column email_id
ALTER TABLE students
DROP email_id;

-- PART -3 ANSWERS

--3.1 average age of students
SELECT COUNT(*)
AS total_students,
AVG(age) AS average_age
FROM students;
--3.2 highest and lowest marks
SELECT MAX (marks) AS highest_marks,
       MIN (marks) AS lowest_marks
	   FROM students;
-- 3.3  run this query 
SELECT COUNT(*), COUNT(marks)
FROM students;
	   -- count(*) all students marks
	   --count(marks) it counts only not null students
-- 3.4 	 SORT THE RESULT
SELECT grade,  COUNT(*) AS 
total_students
FROM  students 
GROUP BY grade
ORDER BY grade ASC;
--3.5 average marks of city
SELECT city, ROUND(AVG(marks), 1) AS average_marks
FROM students
GROUP BY city
ORDER BY average_marks DESC;
-- 3.6 city with average marks
SELECT city, AVG(marks) AS
average_marks
FROM students
GROUP BY city
HAVING AVG(marks) > 75;
-- 3.7 ATLEAST 2 students grade
SELECT grade, COUNT(*) AS 
total_grade
FROM students
GROUP BY grade
HAVING COUNT(* )>= 2 ;
--3.8 count enrollments in course_id
SELECT course_id, COUNT(*) AS
enroll_courseid
FROM enrollments
GROUP BY course_id;
--3.9 highest score in enrollments table
SELECT course_id,  MAX(score) AS
highest_score
FROM enrollments
GROUP BY course_id
ORDER BY course_id ASC;
-- 3.10 COUNT STUDENTS AND WITH MARKS
SELECT city, COUNT(*) AS
 total_students,
 COUNT(MARKS) AS 
 student_with_marks
 FROM students
 GROUP BY city;

-- PART 4 -{JOINS}
-- 4.1
SELECT s.name, c.course_name, e.score
FROM students s
INNER JOIN enrollments e
ON s.id = e.student_id
INNER JOIN courses c
ON e.course_id = c.id;
--4.2
SELECT s.name, c.course_name
FROM students s
LEFT JOIN enrollments e
ON s.id = e.student_id
LEFT JOIN courses c
ON e.course_id = c.id;
--4.3
SELECT s.name
FROM students s
LEFT JOIN enrollments e
ON s.id = e.student_id
WHERE e.student_id IS NULL;
--4.4
SELECT c.course_name, COUNT(*) AS total_students
FROM courses c
LEFT JOIN enrollments e
ON c.id = e.course_id
GROUP BY c.id, c.course_name;
--4.5
SELECT s.name, COUNT(e.course_id) AS total_courses
FROM students s
LEFT JOIN enrollments e
ON s.id = e.student_id
GROUP BY s.id, s.name
ORDER BY total_courses DESC, s.name ASC;
--4.6
SELECT s.name, c.course_name, e.score
FROM students s
INNER JOIN enrollments e
ON s.id = e.student_id
INNER JOIN courses c
ON e.course_id = c.id
WHERE e.score >= 85
ORDER BY e.score DESC;
--4.7
SELECT c.course_name, ROUND(AVG(e.score), 1) AS average_score
FROM courses c
INNER JOIN enrollments e
ON c.id = e.course_id
GROUP BY c.id, c.course_name
ORDER BY average_score DESC;
--4.8
SELECT c.course_name, COUNT(e.student_id) AS total_students
FROM courses c
LEFT JOIN enrollments e
ON c.id = e.course_id
WHERE c.teacher = 'Ms. Rao'
GROUP BY c.id, c.course_name;
--4.9
SELECT a.name AS student1,
       b.name AS student2,
       a.city
FROM students a
INNER JOIN students b
ON a.city = b.city
AND a.id < b.id;
--4.10
SELECT *
FROM students
CROSS JOIN courses;

--part 5 SUBQUERIES
--5.1
SELECT marks from students
WHERE marks >(
    SELECT AVG(marks)
	FROM students
);
--5.2
SELECT  name, marks
FROM students
where marks=(
select MAX(marks)
FROM students

);
--5.3
SELECT name
FROM students
WHERE id IN (
    SELECT student_id
    FROM enrollments
    WHERE course_id IN (
        SELECT id
        FROM courses
        WHERE course_name = 'Art'
    )
);
--5.4
SELECT name
FROM students
WHERE id NOT IN (
    SELECT student_id
    FROM enrollments
    WHERE course_id IN (
        SELECT id
        FROM courses
        WHERE course_name = 'Math'
    )
);
--5.5
SELECT course_name
FROM courses
WHERE id NOT IN (
    SELECT course_id
    FROM enrollments
);
--5.6
SELECT s.name, e.course_id, e.score
FROM students s
JOIN enrollments e
ON s.id = e.student_id
WHERE e.score > (
    SELECT AVG(e2.score)
    FROM enrollments e2
    WHERE e2.course_id = e.course_id
);
--5.7
SELECT course_name, avg_score
FROM (
    SELECT c.course_name, AVG(e.score) AS avg_score
    FROM courses c
    JOIN enrollments e
    ON c.id = e.course_id
    GROUP BY c.id, c.course_name
) AS course_averages
ORDER BY avg_score DESC
LIMIT 1;
BEGIN;

UPDATE enrollments
SET score = score + 5
WHERE course_id IN (
    SELECT id
    FROM courses
    WHERE teacher = 'Mr. Das'
);
--5.8
SELECT *
FROM enrollments;

ROLLBACK;

SELECT *
FROM enrollments;

 -- part 6 CASE STATEMENTS & views
 -- 6.1
 SELECT name, marks,
       CASE
           WHEN marks IS NULL THEN 'No marks'
           WHEN marks >= 85 THEN 'Excellent'
           WHEN marks >= 70 THEN 'Good'
           ELSE 'Needs practice'
       END AS performance
FROM students;
--6.2
 SELECT UPPER(name) AS uppercase_name,
       LENGTH(name) AS name_length
FROM students;
--6.3
 SELECT name || ' from ' || city ||
       ' is ' || age || ' years old' AS student_details
FROM students;
--6.4
 CREATE VIEW top_scorers AS
SELECT s.name, c.course_name, e.score
FROM students s
INNER JOIN enrollments e
ON s.id = e.student_id
INNER JOIN courses c
ON c.id = e.course_id
WHERE e.score >= 85;
 DROP VIEW top_scorers;-- delete
 SELECT * FROM top_scorers;