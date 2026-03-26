#!/bin/bash

# LLMO最適化：構造化データ追加スクリプト
# crypto-card.jp

echo "🚀 構造化データ追加開始..."

PUBLIC_DIR="./public"

# Article Schema追加関数
add_article_schema() {
    local file=$1
    local title=$2
    local description=$3
    local date_published=$4
    
    # 既にArticle schemaがある場合はスキップ
    if grep -q '"@type": "Article"' "$file"; then
        echo "  ⏭️  $file - Article schema already exists"
        return
    fi
    
    # </head>の直前に挿入
    local article_schema="<script type=\"application/ld+json\">
{
  \"@context\": \"https://schema.org\",
  \"@type\": \"Article\",
  \"headline\": \"$title\",
  \"description\": \"$description\",
  \"author\": {
    \"@type\": \"Person\",
    \"name\": \"暗号資産アナリスト編集部\",
    \"url\": \"https://crypto-card.jp/author.html\"
  },
  \"publisher\": {
    \"@type\": \"Organization\",
    \"name\": \"crypto-card.jp\",
    \"logo\": {
      \"@type\": \"ImageObject\",
      \"url\": \"https://crypto-card.jp/images/logo.png\"
    }
  },
  \"datePublished\": \"$date_published\",
  \"dateModified\": \"2026-03-26\",
  \"mainEntityOfPage\": {
    \"@type\": \"WebPage\",
    \"@id\": \"https://crypto-card.jp/$(basename $file)\"
  }
}
</script>"
    
    # </head>の直前に追加
    sed -i '' "s|</head>|$article_schema\n</head>|" "$file"
    echo "  ✅ $file - Article schema added"
}

# BreadcrumbList Schema追加関数
add_breadcrumb_schema() {
    local file=$1
    local page_name=$2
    
    # 既にBreadcrumbListがある場合はスキップ
    if grep -q '"@type": "BreadcrumbList"' "$file"; then
        echo "  ⏭️  $file - Breadcrumb schema already exists"
        return
    fi
    
    local breadcrumb_schema="<script type=\"application/ld+json\">
{
  \"@context\": \"https://schema.org\",
  \"@type\": \"BreadcrumbList\",
  \"itemListElement\": [
    {
      \"@type\": \"ListItem\",
      \"position\": 1,
      \"name\": \"ホーム\",
      \"item\": \"https://crypto-card.jp/\"
    },
    {
      \"@type\": \"ListItem\",
      \"position\": 2,
      \"name\": \"$page_name\"
    }
  ]
}
</script>"
    
    sed -i '' "s|</head>|$breadcrumb_schema\n</head>|" "$file"
    echo "  ✅ $file - Breadcrumb schema added"
}

# Discover最適化メタタグ追加
add_discover_meta() {
    local file=$1
    
    # 既にmax-image-previewがある場合はスキップ
    if grep -q 'max-image-preview:large' "$file"; then
        echo "  ⏭️  $file - Discover meta already exists"
        return
    fi
    
    # <head>の直後に追加
    sed -i '' 's|<head>|<head>\n    <meta name="robots" content="max-image-preview:large, max-snippet:-1, max-video-preview:-1">|' "$file"
    echo "  ✅ $file - Discover meta added"
}

# メインページ（index.html）- すでに構造化データがあるので強化のみ
echo "📝 Processing index.html..."
add_discover_meta "$PUBLIC_DIR/index.html"

# レビューページ
echo "📝 Processing card review pages..."
add_article_schema "$PUBLIC_DIR/redotpay-review.html" "RedotPay（リドットペイ）徹底レビュー" "RedotPayの特徴、手数料、還元率を詳細解説" "2026-03-21"
add_breadcrumb_schema "$PUBLIC_DIR/redotpay-review.html" "RedotPayレビュー"
add_discover_meta "$PUBLIC_DIR/redotpay-review.html"

add_article_schema "$PUBLIC_DIR/tria-card-review.html" "Tria Card徹底レビュー" "最大6%還元のTria Cardの特徴と使い方" "2026-03-21"
add_breadcrumb_schema "$PUBLIC_DIR/tria-card-review.html" "Tria Cardレビュー"
add_discover_meta "$PUBLIC_DIR/tria-card-review.html"

add_article_schema "$PUBLIC_DIR/binance-card-review.html" "Binance Card徹底レビュー" "バイナンスカードの特徴と使い方ガイド" "2026-03-21"
add_breadcrumb_schema "$PUBLIC_DIR/binance-card-review.html" "Binance Cardレビュー"
add_discover_meta "$PUBLIC_DIR/binance-card-review.html"

add_article_schema "$PUBLIC_DIR/crypto-com-card-review.html" "Crypto.com Card徹底レビュー" "Crypto.comカードの還元率と特典解説" "2026-03-21"
add_breadcrumb_schema "$PUBLIC_DIR/crypto-com-card-review.html" "Crypto.com Cardレビュー"
add_discover_meta "$PUBLIC_DIR/crypto-com-card-review.html"

add_article_schema "$PUBLIC_DIR/nexo-card-review.html" "NEXO Card徹底レビュー" "NEXOカードの特徴と使い方完全ガイド" "2026-03-21"
add_breadcrumb_schema "$PUBLIC_DIR/nexo-card-review.html" "NEXO Cardレビュー"
add_discover_meta "$PUBLIC_DIR/nexo-card-review.html"

add_article_schema "$PUBLIC_DIR/wirex-card-review.html" "Wirex Card徹底レビュー" "Wirexカードの手数料と還元率解説" "2026-03-21"
add_breadcrumb_schema "$PUBLIC_DIR/wirex-card-review.html" "Wirex Cardレビュー"
add_discover_meta "$PUBLIC_DIR/wirex-card-review.html"

add_article_schema "$PUBLIC_DIR/bybit-card-review.html" "Bybit Card徹底レビュー" "Bybitカードの特徴と申し込み方法" "2026-03-21"
add_breadcrumb_schema "$PUBLIC_DIR/bybit-card-review.html" "Bybit Cardレビュー"
add_discover_meta "$PUBLIC_DIR/bybit-card-review.html"

add_article_schema "$PUBLIC_DIR/bitflyer-visa-review.html" "bitFlyer VISAプリペイドカード徹底レビュー" "国内最大手bitFlyerのカード詳細解説" "2026-03-21"
add_breadcrumb_schema "$PUBLIC_DIR/bitflyer-visa-review.html" "bitFlyer VISAレビュー"
add_discover_meta "$PUBLIC_DIR/bitflyer-visa-review.html"

# ガイドページ
echo "📝 Processing guide pages..."
add_article_schema "$PUBLIC_DIR/beginner-guide.html" "【初心者向け】仮想通貨カードの始め方完全ガイド" "ゼロから始める仮想通貨カード入門" "2026-03-21"
add_breadcrumb_schema "$PUBLIC_DIR/beginner-guide.html" "初心者ガイド"
add_discover_meta "$PUBLIC_DIR/beginner-guide.html"

add_article_schema "$PUBLIC_DIR/tax-guide.html" "仮想通貨カードの税金完全ガイド" "確定申告の方法と節税対策" "2026-03-21"
add_breadcrumb_schema "$PUBLIC_DIR/tax-guide.html" "税金ガイド"
add_discover_meta "$PUBLIC_DIR/tax-guide.html"

add_article_schema "$PUBLIC_DIR/security-guide.html" "仮想通貨カードのセキュリティ対策" "安全に使うための完全ガイド" "2026-03-21"
add_breadcrumb_schema "$PUBLIC_DIR/security-guide.html" "セキュリティガイド"
add_discover_meta "$PUBLIC_DIR/security-guide.html"

add_article_schema "$PUBLIC_DIR/business-crypto-card-guide.html" "法人向け仮想通貨カード活用ガイド" "ビジネスで使える最適なカード選び" "2026-03-21"
add_breadcrumb_schema "$PUBLIC_DIR/business-crypto-card-guide.html" "法人向けガイド"
add_discover_meta "$PUBLIC_DIR/business-crypto-card-guide.html"

add_article_schema "$PUBLIC_DIR/student-guide.html" "学生におすすめの仮想通貨カード" "審査なしで作れるカード完全ガイド" "2026-03-21"
add_breadcrumb_schema "$PUBLIC_DIR/student-guide.html" "学生向けガイド"
add_discover_meta "$PUBLIC_DIR/student-guide.html"

add_article_schema "$PUBLIC_DIR/overseas-travel-guide.html" "海外旅行で使える仮想通貨カード" "手数料最安で外貨決済する方法" "2026-03-21"
add_breadcrumb_schema "$PUBLIC_DIR/overseas-travel-guide.html" "海外旅行ガイド"
add_discover_meta "$PUBLIC_DIR/overseas-travel-guide.html"

# 比較ページ
echo "📝 Processing comparison pages..."
add_discover_meta "$PUBLIC_DIR/comparison.html"
add_discover_meta "$PUBLIC_DIR/cashback-ranking.html"
add_discover_meta "$PUBLIC_DIR/fee-comparison.html"

# その他重要ページ
echo "📝 Processing other pages..."
for file in "$PUBLIC_DIR"/*.html; do
    if [ -f "$file" ]; then
        add_discover_meta "$file"
    fi
done

echo ""
echo "✨ 構造化データ追加完了！"
echo "📊 次のコマンドで確認:"
echo "   grep -l 'max-image-preview:large' public/*.html | wc -l"
