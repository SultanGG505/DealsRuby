
-- Использование базы данных Sales
USE Sales;

-- Создание таблицы "Товары"
CREATE TABLE product (
                          product_id INT PRIMARY KEY,
                          name VARCHAR(255),
                          price DECIMAL(10,2),
                          delivery VARCHAR(255)
);

-- Создание таблицы "Заказчики"
CREATE TABLE customer (
                           customer_id INT PRIMARY KEY,
                           company_name VARCHAR(255),
                           address VARCHAR(255),
                           email VARCHAR(255)
);

-- Создание таблицы "Сделки"
CREATE TABLE deal (
                       deal_id INT PRIMARY KEY,
                       customer_id INT,
                       product_id INT,
                       quantity INT,
                       purchase_date DATE,
                       FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
                       FOREIGN KEY (product_id) REFERENCES product (product_id)
);
