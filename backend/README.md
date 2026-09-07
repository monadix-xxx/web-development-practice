# Backend

Приложение демонстрирует базовую структуру FastAPI без лишней инфраструктуры.

Endpoint'ы:

- `GET /` — проверка запуска приложения;
- `GET /health` — техническая проверка состояния;
- `GET /products` — список товаров;
- `GET /products/{product_id}` — один товар по идентификатору.

База данных намеренно не подключена: по заданию достаточно отдельно создать PostgreSQL-схему и отдельно запустить FastAPI с 1–2 endpoint'ами.

## Запуск как сервиса через Docker

Из корня репозитория:

```bash
docker compose up --build -d backend
```

Swagger UI: http://127.0.0.1:8000/docs

## Запуск через venv для выполнения требования практики

Python, FastAPI и Uvicorn не надо ставить в системный профиль:

```bash
nix develop ./nix/backend
cd backend
python -m venv --system-site-packages .venv
source .venv/bin/activate
python -m uvicorn main:app --reload
```

`--system-site-packages` нужен здесь намеренно: FastAPI и Uvicorn уже находятся в воспроизводимом Nix shell, а созданный `venv` получает к ним доступ без установки manylinux wheels через pip. Запуск через `python -m uvicorn` не зависит от того, попал ли CLI-скрипт Uvicorn в `PATH` самого venv.
