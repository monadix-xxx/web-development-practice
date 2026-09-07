-- Выполнять от имени администратора PostgreSQL.
-- Пароль замените на собственный перед выполнением.
CREATE ROLE practice_user WITH LOGIN PASSWORD 'CHANGE_ME';
CREATE DATABASE practice_db OWNER practice_user;
