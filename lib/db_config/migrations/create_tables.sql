
-- Использование базы данных Sales
USE Sales;

-- Создание таблицы "Товары"
CREATE TABLE product (
                          product_id INT PRIMARY KEY AUTO_INCREMENT,
                          name VARCHAR(255) NOT NULL,
                          price INT NOT NULL,
                          delivery VARCHAR(255)
);

-- Создание таблицы "Заказчики"
CREATE TABLE customer (
                           customer_id INT PRIMARY KEY AUTO_INCREMENT,
                           company_name VARCHAR(255) NOT NULL,
                           address VARCHAR(255),
                           email VARCHAR(255)
);

-- Создание таблицы "Сделки"
CREATE TABLE deal (
                      deal_id INT PRIMARY KEY AUTO_INCREMENT,
                      customer_id INT NOT NULL,
                      product_id INT NOT NULL,
                      quantity INT NOT NULL CHECK (quantity > 0),
                      purchase_date DATE NOT NULL,
                      FOREIGN KEY (customer_id) REFERENCES customer (customer_id),
                      FOREIGN KEY (product_id) REFERENCES product (product_id)
);

