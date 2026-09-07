#!/usr/bin/env bash
set -euo pipefail

work="${TMPDIR:-/tmp}/edu-practice-linux-proof"
rm -rf "$work"
mkdir -p "$work"
cd "$work"

. /etc/os-release
printf 'OS: %s\n' "${PRETTY_NAME:-Linux}"
printf 'PWD: %s\n' "$PWD"

printf 'alpha\nbeta\ngamma\n' > data.txt
cp data.txt copy.txt
mv copy.txt renamed.txt
printf 'FILES: %s\n' "$(find . -maxdepth 1 -type f -printf '%f\n' | sort | paste -sd ', ' -)"
printf 'GREP beta: %s\n' "$(grep 'beta' data.txt)"
printf 'LINES data.txt: %s\n' "$(wc -l < data.txt | tr -d ' ')"

sleep 300 &
pid=$!
printf 'PROCESS before kill: '
ps -p "$pid" -o pid=,stat=,comm=
kill "$pid"
wait "$pid" 2>/dev/null || true
if ps -p "$pid" >/dev/null 2>&1; then
  printf 'PROCESS after kill: still running\n'
else
  printf 'PROCESS after kill: stopped\n'
fi
