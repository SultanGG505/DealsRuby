USE Sales;


-- Заполнение таблицы "Товары"
INSERT INTO Product (name, price, delivery)
VALUES ('Product 1', 10.99, 'In Stock'),
       ('Product 2', 19.99, 'Out of Stock'),
       ('Product 3', 5.99, 'In Stock');

-- Заполнение таблицы "Заказчики"
INSERT INTO Customer (company_name, address, email)
VALUES ('Company 1300', 'Address 1', 'email1@example.com'),
       ('Company 2', 'Address 2', 'email2@example.com'),
       ('Company 3', 'Address 3', 'email3@example.com');

-- Заполнение таблицы "Сделки"
INSERT INTO Deal (customer_id, product_id, quantity, purchase_date)
VALUES (1, 1, 5, '2023-01-01'),
       (2, 1, 2, '2023-02-15'),
       (2, 3, 10, '2023-03-10'),
       (3, 2, 3, '2023-04-20');
