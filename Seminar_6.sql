-- Функции обязаны что-то возвращать, процедуры выполняются без возвращения.
-- Функции не могут производить такие операции как INSERT, UPDATE, DELETE, а хранимая процедура позволяет.
-- Транзакция - это последовательно завершенная последовательность, можно откатать все операции, нужно для согласованности данных.

/*
Создать две таблицы user shops колонки можно придумать самому.
Реализовать хп для покупки товаров в магазине.
*/

CREATE DATABASE Seminar_6;
USE Seminar_6;

CREATE TABLE users
(       
	id INT NOT NULL PRIMARY KEY,
	name VARCHAR(45), 
	total INT
);

INSERT INTO users (id, name, total)
VALUES
	(1, "Авдеев", 1000),
	(2, "Гущенко", 27000),
	(3, "Пчелкин", 32000),
	(4, "Питошин", 15000),
	(5, "Вебов", 45000),
	(6, "Шарпов", 30000),
	(7, "Шарпов", 40000),
	(8, "Питошин", 30000);

SELECT * FROM users;

CREATE TABLE shop
(       
	id INT NOT NULL PRIMARY KEY,
	name VARCHAR(45), 
	balance INT
);

INSERT INTO shop (id, name, balance)
VALUES
	(1, "Дикси", 100000),
	(2, "Пятерочка", 27000),
	(3, "Магнит", 32000);
    
SELECT * FROM shop;


-- DELIMITER $$ - создается область, в ней создается хранимка, работает как один запрос.
-- $$ границы области
DELIMITER $$
CREATE PROCEDURE Buy_product(userid INT)
BEGIN
	START TRANSACTION;
    
	SET @total_sum := (SELECT total FROM users WHERE id = userid);
    UPDATE users SET total = total - 500 WHERE id = userid;
    UPDATE shop SET balance = balance + 500 WHERE id = 2;
    
    IF @total_sum < 500 THEN
		ROLLBACK;  # Проверка, если сумма < 500, то мы откатываем изменения, которые были сделаны до этого.
	ELSE
		COMMIT;    # Если все ok, мы их комитим, т.е. они применяются.
	END IF;
    
END $$

-- Как вызвать хранимую процедуру
SELECT * FROM users WHERE id = 1;
SELECT * FROM shop WHERE id = 2;

CALL Buy_product(1);

SELECT * FROM users WHERE id = 1;
SELECT * FROM shop WHERE id = 2;


DELIMITER $$
ALTER PROCEDURE Buy_product(userid INT, cost INT)
BEGIN
	START TRANSACTION;
    
	SET @total_sum := (SELECT total FROM users WHERE id = userid);
    UPDATE users SET total = total - cost WHERE id = userid;
    UPDATE shop SET balance = balance + cost WHERE id = 2;
    
    IF @total_sum < cost THEN
		ROLLBACK;
	ELSE
		COMMIT;
	END IF;
    
END $$

SELECT * FROM users WHERE id = 2;
SELECT * FROM shop WHERE id = 2;
CALL Buy_produc(2, 13500);


-- Функция - на выходе число Фибоначчи:

DELIMITER $$
CREATE FUNCTION fibonacci(num INT)
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
	DECLARE fib1 INT DEFAULT 0;
    DECLARE fib2 INT DEFAULT 1;
    DECLARE fib3 INT DEFAULT 0;
    DECLARE str VARCHAR(255) DEFAULT "01";
    
    IF num = 1 THEN
		RETURN fib1;
	ELSEIF num = 2 THEN
		RETURN CONCAT(fib1, fib2);
	ELSE
		WHILE num > 2 DO
			SET fib3 = fib1 + fib2;
            SET fib1 = fib2;
            SET fib2 = fib3;
            SET num = num - 1;
            SET str = CONCAT(str, fib3);
		END WHILE;
		RETURN str;
    END IF;
END $$

SELECT fibonacci(5);
