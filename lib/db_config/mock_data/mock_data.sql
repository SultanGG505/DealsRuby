USE Sales;


-- Заполнение таблицы "Товары"
INSERT INTO Product (product_id, name, price, delivery)
VALUES (1, 'Product 1', 10.99, 'In Stock'),
       (2, 'Product 2', 19.99, 'Out of Stock'),
       (3, 'Product 3', 5.99, 'In Stock');

-- Заполнение таблицы "Заказчики"
INSERT INTO Customer (customer_id, company_name, address, email)
VALUES (1, 'Company 1300', 'Address 1', 'email1@example.com'),
       (2, 'Company 2', 'Address 2', 'email2@example.com'),
       (3, 'Company 3', 'Address 3', 'email3@example.com');

-- Заполнение таблицы "Сделки"
INSERT INTO Deal (deal_id, customer_id, product_id, quantity, purchase_date)
VALUES (1, 1, 1, 5, '2023-01-01'),
       (2, 2, 1, 2, '2023-02-15'),
       (3, 2, 3, 10, '2023-03-10'),
       (4, 3, 2, 3, '2023-04-20');
