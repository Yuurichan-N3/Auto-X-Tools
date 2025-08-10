#!/usr/bin/env bash
set -euo pipefail
green(){ tput setaf 2; echo -n "$*"; tput sgr0; }
yellow(){ tput setaf 3; echo -n "$*"; tput sgr0; }
red(){ tput setaf 1; echo -n "$*"; tput sgr0; }

acc=$(ls -1 ./X 2>/dev/null | grep -Ei '^X[0-9]+\.json$' | wc -l | tr -d ' ')
like=$( [ -f like.txt ] && wc -l < like.txt || echo 0 )
rt=$( [ -f retweet.txt ] && wc -l < retweet.txt || echo 0 )
fol=$( [ -f follow.txt ] && wc -l < follow.txt || echo 0 )
unf=$( [ -f unfollow.txt ] && wc -l < unfollow.txt || echo 0 )
tw=$( [ -f tweets.txt ] && wc -l < tweets.txt || echo 0 )
rep=$( [ -f replies.txt ] && wc -l < replies.txt || echo 0 )

echo "[health]"
echo "  accounts in ./X  : $(yellow $acc)"
echo "  targets -> like=$(yellow $like) retweet=$(yellow $rt) follow=$(yellow $fol) unfollow=$(yellow $unf) tweet=$(yellow $tw) reply=$(yellow $rep)"

[ "$acc" -gt 0 ] && echo "  status: $(green OK)" || { echo "  status: $(red 'NO ACCOUNTS')"; exit 1; }
