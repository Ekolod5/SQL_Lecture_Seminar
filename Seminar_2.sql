-- 1.
CREATE DATABASE Seminar_2;
USE Seminar_2;

CREATE TABLE movies
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    title CHAR(100) NOT NULL,
    year YEAR NOT NULL,
    running_time_min INT NOT NULL,
    storyline TEXT
);

INSERT movies(title, year, running_time_min, storyline)
VALUES ("Harry Potter and the Philosophers Stone", 2001, 152, "An orphaned boy enrolls in a school of wizardry"),
		("Harry Potter and the Chamber of Secrets", 2002, 162, "An ancient prophecy seems to be coming true"),
		("The Green Mile", 1999, 188, "Death Row guards at a penitentiary, in the 1930s, have a moral dilema with their job"),
        ("Forrest Gump", 1994, 142, "The presidencies of Kennedy and Johnson, the Vietnam War, the Watergate scandal");

RENAME TABLE movies TO cinema;

ALTER TABLE cinema ADD language VARCHAR(50) NULL;

SELECT * FROM cinema;

CREATE TABLE authors
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT authors(name)
VALUES ("Joanne Rowling", "John Doe", "Stephen King");

ALTER TABLE cinema ADD author_id INT NULL;
SELECT * FROM cinema;

UPDATE cinema SET author_id = 1 WHERE id = 1;
SELECT * FROM cinema;

UPDATE cinema SET author_id = 4 WHERE id = 1;
SELECT * FROM cinema;

UPDATE cinema SET author_id = 1 WHERE id = 1;
SELECT * FROM cinema;

ALTER TABLE cinema ADD FOREIGN KEY (author_id) REFERENCES authors(id);
SELECT * FROM cinema;

UPDATE cinema SET author_id = 2 WHERE id > 0;
SELECT * FROM cinema;

-- ALTER TABLE cinema DROP CONSTRAINT cinema

-- 2. 
/* В зависимости от поля "grade", установите еще один столбец с именем class в зависимости от значений класса.
A++ - DISTINCTION, A+ - FIRST CLASS, A - SECOND CLASS, B+ - SECOND CLASS, C+ - THIRD CLASS, ALL OTHERS - FAIL*/

CREATE TABLE studentMarks
(
	stud_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    total_marks INT,
    grade VARCHAR(5)
);

INSERT INTO studentMarks(total_marks, grade)
VALUES 
(450, "A"),
(480, "A+"),
(490, "A++"),
(440, "B+"),
(400, "C+"),
(380, "C"),
(250, "D"),
(200, "E"),
(100, "F"),
(150, "F"),
(220, "E");

SELECT 
	total_marks,
    grade,
    CASE grade
		WHEN "A++" THEN "DISTINCTION"
  		WHEN "A+" THEN "FIRST CLASS"
		WHEN "A" OR "B+" THEN "SECOND CLASS"
		WHEN "C+" THEN "THIRD CLASS"
		ELSE "FALE"
	END class
FROM studentMarks;

SELECT 
	total_marks,
    grade,
    CASE grade
		WHEN "A++" THEN "DISTINCTION"
  		WHEN "A+" THEN "FIRST CLASS"
		WHEN "A" OR "B+" THEN "SECOND CLASS"
		WHEN "C+" THEN "THIRD CLASS"
		ELSE "FALE"
	END class,
    "1,2,3"
FROM studentMarks;

SELECT 
	total_marks,
    grade,
    CASE
		WHEN total_marks >= 450 THEN "DISTINCTION"
  		WHEN total_marks >= 400 AND total_marks < 450 THEN "FIRST CLASS"
		WHEN total_marks >= 350 AND total_marks < 400 THEN "SECOND CLASS"
		WHEN total_marks >= 300 AND total_marks < 350 THEN "THIRD CLASS"
		ELSE "FALE"
	END class
FROM studentMarks;

SELECT 
	total_marks,
    grade,
    CASE
		WHEN total_marks >= 450 THEN "DISTINCTION"
  		WHEN total_marks BETWEEN 400 AND 450 THEN "FIRST CLASS"
		WHEN total_marks BETWEEN 350 AND 400 THEN "SECOND CLASS"
		WHEN total_marks BETWEEN 300 AND 350 THEN "THIRD CLASS"
		ELSE "FALE"
	END class
FROM studentMarks;

SELECT total_marks, grade, 
IF (total_marks > 400, "GREAT", "GOOD") data1
FROM studentMarks;
