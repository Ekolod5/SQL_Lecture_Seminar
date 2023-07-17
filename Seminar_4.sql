CREATE DATABASE Seminar_4;
USE Seminar_4;

CREATE TABLE products
(
	product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	category_id INT NULL,
	product_name VARCHAR(100) NOT NULL
);

CREATE TABLE categories
(
	category_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	category_name VARCHAR(100) NOT NULL
);

INSERT INTO products(category_id, product_name)
VALUES 
	(1, "Системный блок"),
	(1, "Монитор"),
	(2, "Холодильник"),
	(2, "Телевизор"),
	(NULL, "Операционная система");
	
INSERT INTO categories (category_name)
VALUES 
	("Комплектующие компьютера"),
	("Бытовая техника"),
	("Мобильные устройства");

SELECT * FROM products;
SELECT * FROM categories;

SELECT * 
FROM products p JOIN categories c;

SELECT * 
FROM products p CROSS JOIN categories c;


-- Одно и то же
SELECT * 
FROM products p JOIN categories c ON c.category_id = p.category_id;

SELECT * 
FROM products p INNER JOIN categories c ON c.category_id = p.category_id;
--


SELECT * 
FROM products p LEFT JOIN categories c ON c.category_id = p.category_id;


SELECT * 
FROM products p RIGHT JOIN categories c ON c.category_id = p.category_id;


-- Используем эту конструкцию только когда совпадают столбцы
SELECT * 
FROM products p LEFT JOIN categories c USING (category_id);


SELECT p.category_id
FROM products p RIGHT JOIN categories c ON c.category_id = p.category_id;


-- Одно и то же
SELECT *
FROM products p JOIN categories c ON c.category_id = p.category_id
WHERE c.category_id = 1;

SELECT *
FROM products p JOIN categories c ON c.category_id = p.category_id
WHERE c.category_name = "Комплектующие компьютера";
--

SELECT * 
FROM products p INNER JOIN categories c USING (category_id);


-- UNION - Убирает дублирующие строки, оставляет уникальные
SELECT * 
FROM products p INNER JOIN categories c USING (category_id)
UNION 
SELECT * 
FROM products p LEFT JOIN categories c USING (category_id);

-- UNION ALL - Выводит абсолютно все с дубликатами
SELECT * 
FROM products p INNER JOIN categories c USING (category_id)
UNION ALL
SELECT * 
FROM products p LEFT JOIN categories c USING (category_id);


CREATE TEMPORARY TABLE tmp1 
SELECT *
FROM products p 
LEFT JOIN categories c USING (category_id);

SELECT * FROM tmp1;

--
-- Делает условие выборки, подзапрос, без JOIN
SELECT * FROM products p
WHERE EXISTS(SELECT * FROM categories c WHERE p.category_id = c.category_id);


SELECT * FROM products p
WHERE p.category_id IN (SELECT category_id FROM categories c);
--

-- Такой подзапрос не использовать, лучше использовать JOIN
SELECT p.product_id, (SELECT category_name FROM categories c WHERE p.category_id = c.category_id) FROM products p;
