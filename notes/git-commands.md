# Git: минимальная практическая демонстрация

Настройте имя и e-mail **только в этом репозитории**:

```bash
git config --local user.name "Ваше Имя"
git config --local user.email "ваш_email@example.com"
```

Реальное создание ветки, commit и merge можно выполнить одной командой:

```bash
nix develop ./nix/git -c bash scripts/git-local-demo.sh
```

После создания пустого GitHub/GitLab-репозитория добавьте `origin` и выполните реальный push/pull:

```bash
git remote add origin <URL>
nix develop ./nix/git -c bash scripts/git-remote-demo.sh
```

Второй скрипт сам:

1. отправляет локальную историю в `origin`;
2. делает временный второй clone;
3. создаёт в нём новый commit и push;
4. выполняет `git pull --ff-only` в исходном репозитории.

Таким образом, push и pull действительно выполняются, но не требуется вручную редактировать README через веб-интерфейс.
