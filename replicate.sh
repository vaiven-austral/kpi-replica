#!/usr/bin/env bash
# Copies the `data` branch of the KPI platform into this repository, only
# forward. If upstream rewrites or deletes it, this fails and the copy here
# keeps the old history: that is the point of a replica the owner of the
# central repository cannot touch.
set -euo pipefail
upstream=${UPSTREAM:-https://github.com/lab4-kpis/kpis.git}

git fetch -q origin data:data 2>/dev/null || echo "No local copy yet."
if ! git ls-remote -q --exit-code --heads "$upstream" data >/dev/null; then
  if git rev-parse -q --verify refs/heads/data >/dev/null; then
    echo "::error::The data branch disappeared upstream. The copy here is intact."
    exit 1
  fi
  echo "Upstream has no data branch yet."
  exit 0
fi
# No '+': a non-fast-forward update (rewritten history) is refused.
git fetch -q --no-tags "$upstream" data:data || {
  echo "::error::Upstream data is not a fast-forward of the copy here: history was rewritten."
  exit 1
}
git push -q origin data
echo "Replica at $(git rev-parse --short data), $(git ls-tree --name-only -r data -- data | wc -l | tr -d ' ') days."
