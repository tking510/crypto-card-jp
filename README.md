# crypto-card.jp

仮想通貨カード（クリプトカード）の比較・ランキングサイト

## 🎯 サイト概要

crypto-card.jpは、仮想通貨デビットカードを徹底比較するSEO特化型の情報サイトです。
手数料、還元率、対応通貨などを分かりやすく比較し、ユーザーに最適なカードを提案します。

## ✨ 主な機能

- **ランキング形式の比較**: TOP3カードを詳細に紹介
- **徹底比較表**: 全カードのスペックを一覧表示
- **選び方ガイド**: 手数料、還元率、信頼性など観点別に解説
- **FAQ**: よくある質問をまとめて回答
- **レスポンシブデザイン**: PC・スマホ両対応

## 🛠 技術スタック

- **HTML5**: セマンティックマークアップ
- **CSS3**: カスタムプロパティ、Flexbox、Grid
- **JavaScript**: バニラJS（フレームワーク不使用）
- **ホスティング**: Cloudflare Pages
- **ドメイン**: crypto-card.jp (Cloudflare管理)

## 📁 ディレクトリ構造

```
crypto-card-jp/
├── public/
│   ├── index.html          # メインページ
│   ├── css/
│   │   └── style.css       # スタイルシート
│   ├── js/
│   │   └── main.js         # JavaScript
│   └── images/             # 画像ファイル
├── README.md
└── .gitignore
```

## 🚀 デプロイ方法

### 1. GitHubにプッシュ

```bash
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/[your-username]/crypto-card-jp.git
git push -u origin main
```

### 2. Cloudflare Pages で設定

1. Cloudflare ダッシュボードにログイン
2. Pages > Create a project
3. GitHub リポジトリを選択: `crypto-card-jp`
4. ビルド設定:
   - Build command: (空欄)
   - Build output directory: `/public`
5. デプロイ

### 3. カスタムドメイン設定

1. Pages > crypto-card-jp > Custom domains
2. `crypto-card.jp` を追加
3. DNS設定を確認（自動設定される）

## 📊 SEO対策

### 実装済み

- ✅ セマンティックHTML（`<article>`, `<section>`, `<header>`など）
- ✅ メタタグ（description, keywords）
- ✅ OGPタグ（SNSシェア対応）
- ✅ モバイルフレンドリー
- ✅ 構造化データ（後日追加予定）
- ✅ 高速ロード（Cloudflare CDN）

### 今後の施策

- [ ] 構造化データ（JSON-LD）追加
- [ ] Google Search Console 登録
- [ ] サイトマップ作成
- [ ] robots.txt 設定
- [ ] パンくずリスト実装
- [ ] 詳細ページ追加（各カードごと）
- [ ] ブログ記事追加

## 🎨 デザインコンセプト

### カラースキーム

- **メインカラー**: 青系（#0066CC）- 信頼感
- **アクセント**: グリーン（#00D084）- 仮想通貨イメージ
- **背景**: ホワイト（#FFFFFF）- クリーン

### 参考サイト

- 価格.com - 比較表のレイアウト
- CoinPost - 記事カード形式
- GMOコイン - 信頼感のあるデザイン

## 📈 コンテンツ戦略

### 現在のコンテンツ

1. **メインページ**:
   - ランキングTOP3
   - 全カード比較表
   - 選び方ガイド
   - FAQ

### 追加予定のコンテンツ

1. **詳細ページ**:
   - 各カードの詳細レビュー
   - メリット・デメリット
   - 申し込み方法
   
2. **ガイド記事**:
   - 仮想通貨カードの使い方
   - 手数料の比較方法
   - 税金の扱い方
   
3. **比較記事**:
   - RedotPay vs Tria Card
   - 国内カード vs 海外カード
   - 手数料最安カードランキング

## 🔧 メンテナンス

### 定期更新

- [ ] カード情報の最新化（月1回）
- [ ] 手数料・還元率の確認（月1回）
- [ ] 新規カード追加（随時）
- [ ] FAQ更新（随時）

## 📞 お問い合わせ

サイトに関するお問い合わせ: [準備中]

## 📝 ライセンス

© 2026 crypto-card.jp All Rights Reserved.

---

**Last Updated**: 2026-03-21
