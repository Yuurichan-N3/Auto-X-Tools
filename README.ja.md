# Auto‑X‑Tools

Puppeteer を用いた、ターミナルだけで動くヘッドレスの **X（Twitter）自動化**ツールキットです。`X1.json`、`X2.json`… のようにアカウントごとの Cookie ファイルを使い、**いいね**・**リポスト（リツイート）**・**フォロー／フォロー解除**・**投稿（Tweet）**・\*\*返信（Reply）\*\*に対応します。既定のフローは **DOM 操作のみ** で、Bearer/API トークンは不要です。

```
╔══════════════════════════════════════════════╗
║      X DOM BOT - Multi-Account Actions       ║
║  Like • Retweet • Follow • Unfollow • Reply  ║
║  Developed by: https://t.me/sentineldiscus   ║
╚══════════════════════════════════════════════╝
```

> **リポジトリ:** `Yuurichan-N3/Auto-X-Tools`
> **作者:** @Yuurichan-N3
> **ライセンス:** UNLICENSED / Proprietary（`LICENSE.txt` を参照）
> **動作環境:** Node.js ≥ 20、Puppeteer ^21.6.1

---

## ✨ 特長

* **ヘッドレスのみ**（Chrome ウィンドウは表示されません）。ターミナル実行に最適です。
* **マルチアカウント**：`./X/X1.json`、`X2.json`… を自動検出して処理します。
* **シンプルなターゲットリスト**：`.txt` に 1 行 1 件で記述するだけ。
* **待機時間・1アカウントあたり上限** を設定可能で、動作を人間らしく調整できます。
* **DNS フォールバック**：`x.com` と `twitter.com` の両方で自動的に試行します。
* **カラー表示のログ + バナー** で、成功（緑）／失敗（赤）／情報（黄）が一目でわかります。

> 履歴には **DOM クリックのみ** と **簡易 API** の両方の実装例が含まれています。現在の `bot.js` は **DOM 操作** を採用しており、Bearer トークンは不要です。もし将来 API 風フローに切り替える場合は、有効な `ct0` Cookie と完全に解放されたアカウントが必要になります。

---

## 📦 フォルダ構成

```
.
├─ bot.js                 # メインスクリプト（DOM 操作）
├─ konfiguration.json     # 機能トグル・待機時間など
├─ like.txt               # ツイート URL（1 行 1 件）
├─ retweet.txt            # ツイート URL（1 行 1 件）
├─ unfollow.txt           # プロフィール URL（1 行 1 件）
├─ follow.txt             # プロフィール URL（1 行 1 件）
├─ tweets.txt             # 投稿テキスト（1 行 1 件）
├─ replies.txt            # <tweet_url>|<reply text>
├─ X/                     # Cookie ファイル：X1.json, X2.json, ...
├─ scripts/               # 補助スクリプト（bash 等）
└─ docs/                  # 追加ドキュメント（FAQ・図・バナーなど）
```

---

## 🔧 動作要件

* Node.js **20 以上**（推奨：最新 LTS）
* `npm i` で以下が導入されます：

  * `puppeteer@^21.6.1`
  * `chalk@^5.3.0`

---

## ⚙️ 設定（`konfiguration.json`）

最小例：

```json
{
  "like": true,
  "retweet": true,
  "follow": false,
  "unfollow": false,
  "tweet": false,
  "reply": false,
  "delayMin": 8,
  "delayMax": 18,
  "cooldownBetweenAccounts": 15,
  "perAccount": 5,
  "emulateMobile": false,
  "userAgent": "",
  "autoCreateTargetFiles": true,
  "maxRetries": 3
}
```

**メモ**

* `perAccount`：1 回の実行で、1 アカウントあたりに許可する合計アクション数です（有効な機能の合計）。
* `emulateMobile`：`true` にすると、投稿ダイアログ（Composer）が表示されやすくなる場合があります。
* `userAgent`：未指定なら、デスクトップ／モバイル用の既定 UA を使用します。
* `maxRetries`：DOM の再試行回数です。描画が遅い環境で上げると安定します。

---

## 🎯 ターゲットファイル

* `like.txt` / `retweet.txt`：**ツイート URL**（例：`https://x.com/user/status/1234567890123456789`）
* `follow.txt` / `unfollow.txt`：**プロフィール URL**（例：`https://x.com/username`）
* `tweets.txt`：**投稿テキスト** を 1 行 1 件（280 文字以内を推奨）
* `replies.txt`：`https://x.com/user/status/ID|返信テキスト`

> ファイルは必須ではありません。`konfiguration.json` で有効化された機能のみ読み込み、空ファイルは無視します。

---

## 🍪 クッキーファイル（`./X/X1.json`, `X2.json`, …）

受け付ける形式：

```json
// 1) 配列のみ
[
  { "name": "auth_token", "value": "...", "domain": ".x.com", "path": "/" },
  { "name": "ct0",        "value": "...", "domain": ".x.com", "path": "/" }
]

// 2) Chrome エクスポート形式
{ "cookies": [ { "name": "auth_token", ... }, { "name": "ct0", ... } ] }
```

**ヒント**

* 先頭の BOM（`\uFEFF`）は自動で除去します。Cookie 形状も Puppeteer 用に自動変換します。
* DOM モードでは **Bearer トークンは不要** です。将来的に API 風の処理に切り替える場合は、`ct0` が必要で、アカウントが制限解除されている必要があります。

---

## 🚀 実行方法

```bash
npm i
node bot.js
# または
npm start
# （bin を有効化していれば）
./bin/xdom
```

出力には、以下が表示されます：

* `./X` 内で検出されたアカウント数
* 機能ごとのターゲット件数
* アカウントごとのアクション結果（成功＝緑、失敗＝赤、情報＝黄）

---

## 🧪 簡易動作確認（Smoke Test）

```bash
# デモ用ターゲットを少量投入（複数回実行しても安全）
bash scripts/seed-targets.sh

# 実行
node bot.js
```

---

## 🛠️ トラブルシューティング

**「not logged in — cookies invalid/expired」**
`auth_token` が無効または期限切れの可能性があります。Cookie を再取得してください。

**「tweet not rendered / button not found」**
UI の描画が終わっていない可能性があります。本ツールは自動でリトライとスクロールを行います。改善しない場合は `emulateMobile: true` にするか、`maxRetries` を増やしてください。

**「compose UI error / reply editor not found」**
アカウントが制限中、または電話認証等が必要な場合に発生します。通常のブラウザで **手動投稿** を試し、投稿できない場合は先に解除・認証を行ってください。

**DNS フォールバック**
`x.com` で失敗した場合、`twitter.com` でも試行し、Cookie をミラーします。

**BOM / JSON パースエラー**
Cookie ファイルが UTF‑8 で保存されているか確認してください（本ツールは先頭 BOM を自動除去します）。

---

## 🧱 制限事項

* X は UI を頻繁に A/B テストします。セレクタが変更されると影響を受ける可能性があります。本ツールはフォールバックとリトライを備えますが、UI 変更で動かなくなる場合があります。
* 多数アカウントで攻撃的に実行すると、レート制限やセキュリティチェックにかかる恐れがあります。自己責任でご利用ください。

---

## 🙌 クレジット

* **Puppeteer**・**Chalk** を利用しています。
* バナーと CLI ログのスタイルを同梱しています。
* Developed by: **[https://t.me/sentineldiscus](https://t.me/sentineldiscus)**

---

## 📜 ライセンス

**UNLICENSED / Proprietary** です。詳細は `LICENSE.txt` をご覧ください。コードの再配布・公開は許可されていません。第三者ライブラリは各ライセンスに従います。

---

## 📮 連絡先・更新情報

* Issue / 要望：GitHub — `Yuurichan-N3/Auto-X-Tools`
* アナウンス・サポート：**Telegram** — [https://t.me/sentineldiscus](https://t.me/sentineldiscus)

---

## 📜 ライセンス（補足）

このスクリプトは学習およびテスト目的で配布されています。使用に関する責任は開発者にはありません。

最新のアップデートについては、**Telegram**グループに参加: [こちらをクリック](https://t.me/sentineldiscus)。

---

## 💡 免責事項

このボットの使用はユーザーの責任です。スクリプトの誤用について、開発者は責任を負いません。
