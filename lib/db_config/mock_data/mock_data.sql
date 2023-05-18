USE Sales;


-- Заполнение таблицы "Товары"
INSERT INTO product (name, price, delivery)
VALUES
    ('iPhone 12', 999, NULL),
    ('Samsung Galaxy S21', 899, '+'),
    ('MacBook Pro', 1999, NULL),
    ('Dell XPS 15', 1599, '+'),
    ('Sony PlayStation 5', 499, '+'),
    ('Nintendo Switch', 299, NULL),
    ('Bose QuietComfort 35 II', 349, '+'),
    ('Fitbit Versa 3', 199, NULL),
    ('Canon EOS Rebel T7i', 799, '+'),
    ('GoPro Hero 9', 449, NULL);



-- Заполнение таблицы "Заказчики"
INSERT INTO customer (company_name, address, email)
VALUES
    ('ABC Company', NULL, 'john@example.com'),
    ('XYZ Corporation', NULL, NULL),
    ('Global Enterprises', '789 Oak St, Anycity, USA', NULL),
    ('Local Industries', '321 Pine St, Othertown, USA', 'my_email-123@example.com'),
    ('Tech Solutions', NULL, 'test.user@example.com'),
    ('Innovative Inc', '987 Cedar St, Anycity, USA', NULL),
    ('Dynamic Co', '741 Birch St, Othertown, USA', 'support@company.com'),
    ('Prime Systems', NULL, 'sales_department@example.org'),
    ('Global Tech', '369 Spruce St, Anycity, USA', NULL),
    ('Local Innovations', '951 Pine St, Othertown, USA', 'customer.service@example.com');



-- Заполнение таблицы "Сделки"
INSERT INTO deal (customer_id, product_id, quantity, purchase_date)
VALUES
    (1, 1, 5, '2023-01-01'),
    (1, 2, 2, '2023-01-02'),
    (2, 3, 8, '2023-01-03'),
    (2, 4, 3, '2023-01-04'),
    (3, 5, 4, '2023-01-05'),
    (3, 6, 7, '2023-01-06'),
    (4, 7, 6, '2023-01-07'),
    (4, 8, 1, '2023-01-08'),
    (5, 9, 3, '2023-01-09'),
    (5, 10, 5, '2023-01-10');

