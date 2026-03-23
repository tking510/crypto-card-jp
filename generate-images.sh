#!/bin/bash

# crypto-card.jp 画像生成スクリプト
# 19種類の画像を生成

SKILL_DIR="/opt/homebrew/lib/node_modules/openclaw/skills/openai-image-gen"
OUT_DIR="~/.openclaw/workspace/crypto-card-jp/public/images/generated"

mkdir -p "$OUT_DIR"

# 画像プロンプト配列
declare -a PROMPTS=(
  "Sleek modern crypto card with holographic bitcoin logo, floating above smartphone, glowing blue and purple neon lighting, futuristic tech aesthetic, clean product photography style, --ar 16:9 --style raw"
  
  "Person confidently holding crypto card at checkout counter, casual shopping scene, bright store lighting, modern retail environment, natural candid photography, --ar 16:9 --style raw"
  
  "Hand tapping crypto card on wireless payment terminal with green checkmark hologram appearing, instant payment concept, clean product shot, modern minimalist style, --ar 16:9 --style raw"
  
  "Bitcoin logo transforming into Japanese yen symbol through digital particles, financial exchange concept, blue and gold color scheme, clean tech illustration, --ar 16:9 --style raw"
  
  "Three different crypto cards (Bybit, BitFlyer, Coinbase style) arranged side by side in comparison layout, clean product photography, even studio lighting, professional commercial aesthetic, --ar 16:9 --style raw"
  
  "Laptop screen showing online shopping cart with crypto card payment option highlighted, e-commerce interface, modern web design aesthetic, bright natural desk lighting, --ar 16:9 --style raw"
  
  "Smartphone displaying crypto wallet app with rising chart graph, candlestick patterns visible, trader's desk setup, professional finance aesthetic, cool blue lighting, --ar 16:9 --style raw"
  
  "Person using crypto card at cafe counter, coffee shop ambiance, warm natural lighting, casual lifestyle photography, modern urban setting, --ar 16:9 --style raw"
  
  "Close-up of crypto card showing fee breakdown infographic overlay, 0% fee label prominent, clean educational style, professional finance illustration, --ar 16:9 --style raw"
  
  "Crypto card surrounded by floating Bitcoin, Ethereum, and USDT coin icons, digital asset ecosystem concept, blockchain network visualization, blue and purple gradient background, --ar 16:9 --style raw"
  
  "iPhone screen showing Wallet app with crypto card being added, clean iOS interface, hands holding phone in natural pose, modern tech lifestyle, bright natural lighting, --ar 16:9 --style raw"
  
  "USDT Tether coin with stable line graph behind it, showing zero volatility, blue and green color scheme, financial stability concept, clean infographic style, professional finance aesthetic, --ar 16:9 --style raw"
  
  "Podium with three crypto cards ranked 1st, 2nd, 3rd, percentage symbols (6%, 2%, 0%) floating above each, gold, silver, bronze color scheme, competitive ranking aesthetic, clean 3D illustration, --ar 16:9 --style raw"
  
  "Streaming service logos (generic representations of Netflix, Spotify, YouTube) on screen with crypto card in foreground, entertainment subscription concept, warm home theater lighting, modern lifestyle aesthetic, --ar 16:9 --style raw"
  
  "Shield icon protecting crypto card with lock symbols, digital security elements, blue and green color scheme, cybersecurity aesthetic, clean tech illustration style, trustworthy vibe, --ar 16:9 --style raw"
  
  "Side-by-side comparison: smartphone showing virtual card on left vs physical card on right, clean product comparison layout, modern tech aesthetic, balanced lighting, --ar 16:9 --style raw"
  
  "Calculator, tax documents, and crypto card on desk, Japanese yen bills visible, organized financial planning aesthetic, natural office lighting, professional accountant vibe, --ar 16:9 --style raw"
  
  "Friendly step-by-step guide illustration with numbered steps (1, 2, 3), beginner-friendly aesthetic, bright and welcoming colors, simple and approachable design, --ar 16:9 --style raw"
  
  "Three crypto cards arranged in comparison layout with checkmarks and X marks, clean comparison chart aesthetic, blue and white color scheme, professional infographic style, --ar 16:9 --style raw"
)

# 画像ファイル名
declare -a FILENAMES=(
  "hero-crypto-card"
  "shopping-scene"
  "contactless-payment"
  "btc-to-yen"
  "card-comparison"
  "online-shopping"
  "wallet-app-chart"
  "cafe-payment"
  "zero-fee-infographic"
  "crypto-ecosystem"
  "apple-wallet-add"
  "usdt-stable"
  "ranking-podium"
  "streaming-subscriptions"
  "security-shield"
  "virtual-vs-physical"
  "tax-guide"
  "beginner-steps"
  "comparison-checkmarks"
)

echo "🎨 crypto-card.jp画像生成開始"
echo "総数: ${#PROMPTS[@]}枚"
echo "出力先: $OUT_DIR"
echo ""

# 各プロンプトで画像生成
for i in "${!PROMPTS[@]}"; do
  INDEX=$((i + 1))
  PROMPT="${PROMPTS[$i]}"
  FILENAME="${FILENAMES[$i]}"
  
  echo "[$INDEX/${#PROMPTS[@]}] 生成中: $FILENAME"
  
  python3 "$SKILL_DIR/scripts/gen.py" \
    --prompt "$PROMPT" \
    --model gpt-image-1.5 \
    --size 1536x1024 \
    --quality high \
    --output-format webp \
    --out-dir "$OUT_DIR" \
    --count 1
  
  # 生成された画像をリネーム
  # (gen.pyが生成したファイル名から目的のファイル名に変更)
  LATEST_FILE=$(ls -t "$OUT_DIR"/*.webp 2>/dev/null | head -n1)
  if [ -f "$LATEST_FILE" ]; then
    mv "$LATEST_FILE" "$OUT_DIR/${FILENAME}.webp"
    echo "✅ 保存: ${FILENAME}.webp"
  else
    echo "❌ エラー: ${FILENAME}"
  fi
  
  echo ""
done

echo "🎉 完了！"
echo "📁 出力先: $OUT_DIR"
