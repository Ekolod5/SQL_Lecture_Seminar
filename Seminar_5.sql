CREATE DATABASE Seminar_5;
USE Seminar_5;

CREATE TABLE users
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	username VARCHAR(50),
	password VARCHAR(50),
    status VARCHAR(10)
);

INSERT INTO users(username, password, status)
VALUES 
	("admin", "7856", "Active"),
	("staff", "90802", "Active"),
	("manager", "35462", "Inactive");
    
SELECT * FROM users;

WITH cte_users AS (SELECT * FROM users)
SELECT * FROM cte_users;

-- Используя CTE, подсчитайте количество активных пользователей.
-- Задайте псевдоним результирующему окну.

-- С WHERE выберет сначала только status = "Active", а потом их сгруппирует. Выбираем до группировки.
WITH cte_users AS (SELECT COUNT(*) AS TOTAL FROM users WHERE status = "Active")
SELECT * FROM cte_users;

-- Выбираем после группировки.
WITH cte_users AS (SELECT COUNT(*) AS TOTAL FROM users GROUP BY status HAVING status = "Active")
SELECT * FROM cte_users;

WITH cte_users AS (SELECT COUNT(*) AS TOTAL FROM users GROUP BY status HAVING TOTAL>0)
SELECT * FROM cte_users;

WITH cte_users AS (SELECT COUNT(*) AS TOTAL FROM users GROUP BY status HAVING TOTAL>2)
SELECT * FROM cte_users;


-- Оконные функции.

CREATE TABLE BANKS
(
	id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	TB VARCHAR(10) NOT NULL,
	ID_CLIENT INT,
	ID_DOG INT,
	PROCENT_RATE INT,
	OSZ INT,
	RATING INT,
    SEGMENT VARCHAR(45)
);

INSERT INTO BANKS(TB, ID_CLIENT, ID_DOG, OSZ, PROCENT_RATE, RATING, SEGMENT)
VALUES 
	("A", 1, 111, 100, 6, 10, "SREDN"),
	("A", 1, 222, 150, 6, 10, "SREDN"),
 	("A", 2, 333, 50, 9, 15, "MMB"),
	("B", 1, 444, 200, 7, 10, "SREDN"),
	("B", 3, 555, 1000, 5, 16, "CIB"),
	("B", 4, 666, 500, 10, 20, "CIB"),
	("B", 4, 777, 10, 12, 17, "MMB"),
	("C", 5, 888, 20, 11, 21, "MMB"),
	("C", 5, 999, 200, 9, 13, "SREDN");

SELECT * FROM BANKS;

-- OSZ -  задолженность

SELECT TB, MAX(OSZ) FROM BANKS
GROUP BY TB;

-- Собрать дашборд, в котором содержится информация с максимальной задолженностью в каждом
-- банке, а также средний размер процентной ставки в каждом банке в зависимости от сегмента
-- и количество договоров всего по всем банкам.
-- Партиции - часть таблицы. Сгруппируем банки.

SELECT TB,
	ID_CLIENT,
	ID_DOG, 
    OSZ,
	PROCENT_RATE,
	RATING,
    SEGMENT, 
	MAX(OSZ) OVER (PARTITION BY TB) AS "MAX(OSZ)",
    AVG(PROCENT_RATE) OVER (PARTITION BY TB, SEGMENT) AS AVG_PROCENT_RATE,
    COUNT(ID_DOG) OVER () AS DOG_COUNT
FROM BANKS;

