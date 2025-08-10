#!/usr/bin/env bash
set -euo pipefail
for f in like.txt retweet.txt follow.txt unfollow.txt tweets.txt replies.txt; do
  [ -f "$f" ] || continue
  tmp="$(mktemp)"; shuf "$f" > "$tmp" && mv "$tmp" "$f"
  echo "[shuffle] $f"
done
