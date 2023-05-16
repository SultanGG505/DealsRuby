USE sales;

-- Создание таблицы "Товары"
CREATE TABLE Products (
                          product_id INT PRIMARY KEY,
                          name VARCHAR(255),
                          price DECIMAL(10, 2),
                          delivery BOOLEAN
);

-- Создание таблицы "Заказчики"
CREATE TABLE Customers (
                           customer_id INT PRIMARY KEY,
                           name VARCHAR(255)
);

-- Создание таблицы "Сделки"
CREATE TABLE Deals (
                       deal_id INT PRIMARY KEY,
                       customer_id INT,
                       product_id INT,
                       quantity INT,
                       purchase_date DATE,
                       FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
                       FOREIGN KEY (product_id) REFERENCES Products(product_id)
);