-- Базовый SELECT
SELECT id, name, price, in_stock
FROM products
ORDER BY id;

-- SELECT с фильтрацией
SELECT name, price
FROM products
WHERE in_stock = TRUE
ORDER BY price DESC;

-- Запрос к двум связанным таблицам
SELECT p.name AS product_name,
       c.name AS category_name,
       p.price
FROM products AS p
JOIN categories AS c ON c.id = p.category_id
ORDER BY c.name, p.name;

-- Дополнительный INSERT для демонстрации изменения данных
INSERT INTO products (category_id, name, description, price)
VALUES (2, 'Подставка для ноутбука', 'Алюминиевая настольная подставка', 2400.00);
