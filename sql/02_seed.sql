INSERT INTO categories (name)
VALUES ('Периферия'), ('Аксессуары');

INSERT INTO products (category_id, name, description, price, in_stock)
VALUES
    (1, 'Клавиатура', 'Компактная механическая клавиатура', 5900.00, TRUE),
    (1, 'Мышь', 'Проводная мышь для рабочего места', 2900.00, TRUE),
    (2, 'USB-C хаб', 'Хаб с HDMI и USB-портами', 3500.00, FALSE);
