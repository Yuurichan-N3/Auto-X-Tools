import fs from 'fs';
const files=['like.txt','retweet.txt','follow.txt','tweets.txt','replies.txt'];
for (const f of files) console.log(fs.existsSync(f)?`[ok] ${f}`:`[miss] ${f}`);
