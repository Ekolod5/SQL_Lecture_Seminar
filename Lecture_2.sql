-- Создание базы данных
CREATE DATABASE Lecture_2;

-- Просмотр созданных баз данных:
SHOW DATABASES;

-- Подключение к конкретной БД:
USE Lecture_2;

CREATE TABLE Products
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(30) NOT NULL,
    Manufacturer VARCHAR(20) NOT NULL,
    ProductCount INT DEFAULT 0,
    Price DECIMAL
);

INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price)
VALUES
	("iPhone X", "Apple", 3, 76000),
    ("iPhone 8", "Apple", 2, 51000),
    ("Galaxy S9", "Samsung", 2, 56000),
    ("Galaxy S8", "Samsung", 1, 41000),
    ("P20 Pro", "Huawei", 5, 36000);
    
SELECT * FROM Products;

/*
1. Основные типы данных: числовые
INT - целочисленные значения от −2147483648 до 2147483647, 4 байта.
DECIMAL - хранит числа с заданной точностью.
BOOL - 0 или 1. Однозначный ответ на однозначный вопрос — false или true.

2. Основные типы данных: символьные
VARCHAR(N) - N определяет максимально возможную длину строки.
TEXT - подходит для хранения большого объема текста до 65 KB, например, целой статьи.

3. Основные типы данных: дата и время
DATE - только дата. Диапазон от 1000-01-01 по 9999-12-31.
TIME - только время — часы, минуты, секунды — «hh:mm:ss». Память хранения — 3 байта.
DATETIME - соединяет оба предыдущих типа — дату и время. Использует 8 байтов памяти.
TIMESTAMP - хранит дату и время начиная с 1970 года. 

4. Основные типы данных: бинарные
BLOB - до 65 КБ бинарных данных
LARGEBLOB - до 4 ГБ. 
*/ 

-- Первичный ключ - primary key (pk)
CREATE TABLE Customers
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
	Age INT,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Phone VARCHAR(20) NOT NULL UNIQUE
);

-- Внешний ключ - foreign key (fk)
CREATE TABLE Orders
(
    Id INT AUTO_INCREMENT PRIMARY KEY,
	CustomerId INT,
    CreatedAt Date,
    FOREIGN KEY (CustomerId) REFERENCES Customers (Id)
);


# Арифметические операции:
-- 1. Сложение
SELECT 3+5;
-- 2. Вычитанте
SELECT 3-5;
-- 3. Умножение
SELECT 3*5;
-- 4. Деление
SELECT 3/5;
-- Деление на ноль дает NULL
SELECT 102/0;


/*
Логические операторы:
AND - операция логического И. Она объединяет два выражения. Синтаксис: выражение1 AND выражение2.
OR - операция логического ИЛИ. Она также объединяет два выражения: выражение1 OR выражение2.
NOT - операция логического отрицания. Если выражение в этой операции ложно, то общее условие истинно: NOT выражение.
*/

-- Логические операторы: “AND”
SELECT * FROM Products
WHERE Manufacturer = "Samsung" AND Price > 50000;

-- Логические операторы: “OR”
SELECT * FROM Products
WHERE Manufacturer = "Samsung" OR Price > 50000;

-- Логические операторы: “NOT”
SELECT * FROM Products
WHERE NOT Manufacturer = "Samsung";

-- Приоритет операций (Сперва операция NOT -> AND -> OR выполняется последней)
SELECT * FROM Products
WHERE Manufacturer = "Samsung" OR NOT Price > 30000 AND ProductCount > 2;

-- Переопределить приоритет операций (Наибольший приоритет то, что в скобках. Сперва операция AND -> NOT -> OR выполняется последней)
SELECT * FROM Products
WHERE Manufacturer = "Samsung" OR NOT (Price > 30000 AND ProductCount > 2);


-- Оператор CASE. Проверка условия.
SELECT ProductName, ProductCount,
CASE 
WHEN ProductCount = 1
		THEN "Товар заканчивается"
	WHEN ProductCount = 2
		THEN "Мало товара"
	WHEN ProductCount = 3
		THEN "Есть в наличии"
	ELSE "Много товара"
END AS Category
FROM Products;


-- Оператор IF. IF(условие, значение_1, значение_2).
SELECT ProductName, Manufacturer, 
	IF(ProductCount > 3, "Много товара", "Мало товара")
FROM Products;


/*
Запросы изменения данных:
INSERT - вставка новых данных в таблицу
UPDATE - обновление данных из таблицы
DELETE - удаление данных
*/

/*
-- 1. Запросы изменения данных: INSERT.
Данный оператор имеет 2 основные формы:
a. INSERT INTO таблица(перечень_полей) VALUES(перечень_значений) – вставка в таблицу новой строки значения полей которой формируются из перечисленных значений
b. INSERT INTO таблица(перечень_полей) SELECT перечень_значений FROM … – вставка в таблицу новых строк, значения которых формируются из значений строк возвращенных запросом.
*/

-- 2. Запросы изменения данных: UPDATE. 
-- Например, увеличим у всех товаров цену на 3000:
UPDATE Products
SET Price = Price + 3000;
SELECT * FROM Products;

-- 3. Запросы изменения данных: DELETE. 
-- Например, удалим строки, у которых производитель - "Huawei":
DELETE FROM Products
WHERE Manufacturer = "Huawei";
SELECT * FROM Products;

-- 4. Запросы изменения данных: IN.
-- Вывести все столбцы у которых производитель - "Apple", "Samsung":
SELECT * FROM Products
WHERE Manufacturer IN ("Apple", "Samsung");

-- Вывести все столбцы у которых производитель не - "Apple", "Samsung":
SELECT * FROM Products
WHERE NOT Manufacturer IN ("Apple", "Samsung");

