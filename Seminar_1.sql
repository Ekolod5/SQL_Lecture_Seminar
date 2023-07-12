CREATE DATABASE Seminar_1;
USE Seminar_1;

CREATE TABLE student
(
	id int not null auto_increment primary key,
    name varchar(45),
    course_name varchar(100),
    email varchar(20)
);

INSERT INTO student(name, course_name, email)
VALUES ("Mary", "Java", "mary@gmail.com"),
		("John", "Python", "john@gmail.com"),
		("Bob", "C#", "bob@gmail.com"),
        ("Anne", "Java", "anne@gmail.com");
        
SELECT * FROM student;

SELECT * FROM student
WHERE name = "Bob";

SELECT name, course_name FROM student;

SELECT name "имя", course_name FROM student;

SELECT s.name "имя", course_name FROM student s;

SELECT * FROM student
WHERE course_name LIKE "J%";

SELECT * FROM student
WHERE course_name LIKE "%A%";
