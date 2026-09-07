# Что остаётся сделать вручную перед сдачей

Исходники, SQL, Docker/Nix-окружения, FastAPI-приложение, frontend и локальная Git-история уже находятся в репозитории. Ниже только то, что привязано к вашему компьютеру или внешнему аккаунту и поэтому должно быть выполнено вами.

## 1. Linux — один компактный снимок

```bash
nix develop ./nix/linux -c bash scripts/linux-proof.sh
```

Сделайте один снимок терминала целиком. Вывод специально ограничен примерно восемью строками и одновременно подтверждает файловые операции и работу с процессами.

## 2. OverTheWire Bandit — только вводное задание

В условии нет числа уровней Bandit, которые требуется пройти. Минимальное буквальное подтверждение работы с тренажёром — пройти ввод `Level 0 -> Level 1`.

```bash
ssh bandit0@bandit.labs.overthewire.org -p 2220
# начальный пароль уровня 0: bandit0
cat readme
exit
ssh bandit1@bandit.labs.overthewire.org -p 2220
whoami
```

Сделайте снимок после входа как `bandit1`, где видны приглашение shell и `whoami`. Пароль следующего уровня в отчёт не помещайте.

## 3. PostgreSQL 18 — один снимок pgAdmin

```bash
docker compose --profile db-ui up --build -d
```

Откройте `http://127.0.0.1:5050/`, войдите как `student@example.com` / `practice_admin`, подключитесь к уже зарегистрированному серверу паролем `practice_password`.

Сделайте **один** снимок Query Tool так, чтобы слева в дереве были видны `categories` и `products`, а справа был результат следующего запроса:

```sql
SELECT version();

SELECT p.name, c.name AS category, p.price
FROM products AS p
JOIN categories AS c ON c.id = p.category_id
ORDER BY p.name;
```

Этот один снимок подтверждает подключение через pgAdmin, PostgreSQL 18, наличие двух таблиц и выполнение SQL/JOIN. Внешний ключ дополнительно виден в SQL-скрипте `sql/01_schema.sql`, поэтому отдельный снимок Constraints не нужен.

## 4. GitHub/GitLab — только создать пустой репозиторий и дать URL

Создайте пустой репозиторий на GitHub или GitLab. Затем:

```bash
git config --local user.name "Ваше Имя"
git config --local user.email "ваш_email@example.com"
nix develop ./nix/git -c bash scripts/git-local-demo.sh
git remote add origin <URL>
nix develop ./nix/git -c bash scripts/git-remote-demo.sh
```

В отчёте замените `ВСТАВИТЬ_URL_РЕПОЗИТОРИЯ` на URL. Отдельный снимок страницы репозитория не обязателен, если ссылка доступна преподавателю: в задании отдельно требуется именно ссылка, а команды и история уже приведены в отчёте.

## 5. Learn Git Branching — только минимально требуемая часть

Формулировка задания: «минимум базовый уровень + ветвления». Она не требует прохождения всего тренажёра и не называет `Introduction Sequence` целиком.

На `https://learngitbranching.js.org/` достаточно выполнить первые два упражнения:

1. **Introduction to Git Commits** — два раза `git commit`;
2. **Branching in Git** — `git checkout -b bugFix`.

После этого откройте окно выбора уровней и сделайте один снимок, где первые два упражнения отмечены выполненными. `merge`, `rebase`, `Ramping Up`, remote-разделы и остальные уровни для тренажёра не нужны; реальные branch/merge/push/pull уже выполняются в вашем репозитории отдельными заданиями.

## 6. Backend и frontend

Сервисы уже готовы:

```bash
docker compose up --build -d
```

- frontend: `http://127.0.0.1:8080/`
- FastAPI: `http://127.0.0.1:8000/docs`

В блоки B1 и F1 отчёта вставьте обычные снимки этих двух страниц. Никаких действий в интерфейсе не требуется.

Для формального пункта про `venv` один раз выполните:

```bash
nix develop ./nix/backend
cd backend
python -m venv --system-site-packages .venv
source .venv/bin/activate
python -c 'import fastapi, uvicorn; print("venv OK", fastapi.__version__, uvicorn.__version__)'
```

Отдельный снимок `venv` не нужен: в отчёте достаточно описания выполненной настройки окружения.
