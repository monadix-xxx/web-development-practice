#!/usr/bin/env bash
set -euo pipefail

root="$(git rev-parse --show-toplevel)"
cd "$root"

origin="$(git remote get-url origin 2>/dev/null || true)"
if [[ -z "$origin" ]]; then
  echo 'Add your empty GitHub/GitLab repository first:' >&2
  echo '  git remote add origin <URL>' >&2
  exit 1
fi

name="$(git config --local user.name || git config user.name || true)"
email="$(git config --local user.email || git config user.email || true)"
if [[ -z "$name" || -z "$email" ]]; then
  echo 'Set user.name and user.email before running this script.' >&2
  exit 1
fi

git push -u origin main
git push origin --all

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

git clone --branch main "$origin" "$tmp/second-copy" >/dev/null
cd "$tmp/second-copy"
git config user.name "$name"
git config user.email "$email"
printf 'Remote pull demonstration %s.\n' "$(date -Iseconds)" >> remote-pull-demo.txt
git add remote-pull-demo.txt
git commit -m 'Add remote pull demonstration' >/dev/null
git push origin main >/dev/null

cd "$root"
git pull --ff-only
printf '\nRemote: %s\n' "$origin"
printf 'Latest commits after real push/pull:\n'
git log --oneline --decorate -4
