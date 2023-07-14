CREATE DATABASE Seminar_3;
USE Seminar_3;

CREATE TABLE emploies
(
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NULL,
    surname VARCHAR(100) NULL,
    speciality VARCHAR(100) NULL,
    seniority INT NULL,
    salary INT NULL,
    age INT NULL
);

INSERT INTO emploies (name, surname, speciality, seniority, salary, age)
VALUES
	("Вася", "Васькин", "начальник", 40, 100000, 60),
    ("Петя", "Петькин", "начальник", 8, 70000, 30),
    ("Катя", "Катькина", "инженер", 2, 70000, 25),
    ("Саша", "Сашкин", "инженер", 12, 50000, 35),
    ("Иван", "Иванов", "рабочий", 40, 30000, 59);

SELECT * FROM emploies;

-- Сортировка по возрасту по возрастанию.
SELECT * FROM emploies
ORDER BY age;

-- Сортировка по возрасту по убыванию.
SELECT * FROM emploies
ORDER BY age DESC;

-- Добавляем верхние строчки снова:
INSERT INTO emploies (name, surname, speciality, seniority, salary, age)
VALUES
	("Вася", "Васькин", "начальник", 40, 100000, 60),
    ("Петя", "Петькин", "начальник", 8, 70000, 30),
    ("Катя", "Катькина", "инженер", 2, 70000, 25),
    ("Саша", "Сашкин", "инженер", 12, 50000, 35),
    ("Иван", "Иванов", "рабочий", 40, 30000, 59);
    
SELECT * FROM emploies;
    
-- Вывести только уникальные значения.
-- DISTINCT * - выведет все уникальные строчки, выведет всю таблицу снова, потому что id разный:
SELECT DISTINCT * FROM emploies;

-- Без дубликата имена:
SELECT DISTINCT name FROM emploies;

SELECT DISTINCT name, surname, speciality, seniority, salary, age FROM emploies;

-- Получить из таблицы первые две строки:
SELECT * FROM emploies
LIMIT 2;

-- Пропускает первые две строчки и выводит с третьей строчки:
SELECT * FROM emploies
LIMIT 2, 3;

-- Агрегатные функции:
-- Средняя зарплата:
SELECT AVG(salary) FROM emploies;

-- Вывести количество строк:
SELECT COUNT(*) FROM emploies;

SELECT COUNT(salary) FROM emploies;

SELECT MAX(salary) FROM emploies;

SELECT MIN(salary) FROM emploies;

SELECT SUM(salary) FROM emploies;

-- Группировка:
SELECT age FROM emploies
GROUP BY age;

-- Сперва сгруппировал GROUP BY, потом посчитал количество:
SELECT age, COUNT(age) FROM emploies
GROUP BY age;

SELECT age, COUNT(age) AS age_count FROM emploies
GROUP BY age;

-- Можно без AS:
SELECT age, COUNT(age) age_count FROM emploies
GROUP BY age;

INSERT INTO emploies(name, surname, speciality, seniority, salary, age)
VALUES ("Маша", "Машкина", "начальник", 40, 100000, 90);

SELECT age, COUNT(age) age_count FROM emploies
GROUP BY age
HAVING age_count = 1;

SELECT age, COUNT(age) age_count FROM emploies
GROUP BY age
HAVING age_count = 2;
