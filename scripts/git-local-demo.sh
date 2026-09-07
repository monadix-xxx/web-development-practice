#!/usr/bin/env bash
set -euo pipefail

root="$(git rev-parse --show-toplevel)"
cd "$root"

if ! git config --local user.name >/dev/null || ! git config --local user.email >/dev/null; then
  echo 'Set repository-local identity first:' >&2
  echo '  git config --local user.name "Your Name"' >&2
  echo '  git config --local user.email "you@example.com"' >&2
  exit 1
fi

branch="practice/git-demo"
file="evidence/git-demo.txt"

if git show-ref --verify --quiet "refs/heads/$branch"; then
  echo "Branch $branch already exists; the demo has already been run."
else
  git switch -c "$branch"
  mkdir -p evidence
  printf 'Git branch demonstration.\n' > "$file"
  git add "$file"
  git commit -m 'Demonstrate Git branch workflow'
  git switch main
  git merge --no-ff "$branch" -m 'Merge Git branch demonstration'
fi

printf '\nCompact history:\n'
git log --oneline --graph --decorate --all -8
