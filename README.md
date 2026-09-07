# Учебная практика — Web Development

Готовый минимальный проект для итогового отчёта: Linux/Git, PostgreSQL 18, FastAPI и HTML/CSS.

## Запуск сервисов

На хосте нужны только Docker daemon, Docker Compose, Nix с flakes, браузер и редактор.

```bash
docker compose up --build -d
```

После запуска:

- frontend — http://127.0.0.1:8080/
- FastAPI Swagger UI — http://127.0.0.1:8000/docs
- PostgreSQL — `127.0.0.1:5432`, БД `practice_db`, пользователь `practice_user`, пароль `practice_password`

pgAdmin запускается только при необходимости:

```bash
docker compose --profile db-ui up -d pgadmin
```

- pgAdmin — http://127.0.0.1:5050/
- login — `student@example.com`
- password — `practice_admin`
- пароль PostgreSQL при подключении — `practice_password`

Остановить всё:

```bash
docker compose down
```

Сбросить данные PostgreSQL и заново применить SQL-инициализацию:

```bash
docker compose down -v
docker compose up --build -d
```

## Nix shell без системной установки пакетов

```bash
nix develop ./nix/linux
nix develop ./nix/git
nix develop ./nix/postgresql
nix develop ./nix/backend
nix develop ./nix/frontend
```

Это не dev containers: Nix только временно добавляет CLI-программы в `PATH`. Docker используется только для сервисов.

## Компактные проверки

Linux-файлы + процессы, весь вывод помещается в один терминал:

```bash
nix develop ./nix/linux -c bash scripts/linux-proof.sh
```

Git branch/commit/merge:

```bash
git config --local user.name "Ваше Имя"
git config --local user.email "ваш_email@example.com"
nix develop ./nix/git -c bash scripts/git-local-demo.sh
```

После создания пустого GitHub/GitLab-репозитория реальный push + pull:

```bash
git remote add origin <URL>
nix develop ./nix/git -c bash scripts/git-remote-demo.sh
```

Все действия, которые нельзя сделать вместо владельца внешнего аккаунта, сведены к минимуму и перечислены в `MANUAL.md`.

## Структура

- `backend/` — FastAPI-приложение и Dockerfile;
- `frontend/` — HTML/CSS-страница и Dockerfile;
- `sql/` — PostgreSQL 18, схема, данные и запросы;
- `pgadmin/` — предварительная регистрация PostgreSQL в pgAdmin;
- `nix/` — воспроизводимые CLI-окружения;
- `scripts/` — короткие воспроизводимые демонстрации Linux и Git;
- `notes/` — пояснения к командам;
- `MANUAL.md` — только неизбежные ручные действия для финальной сдачи.
