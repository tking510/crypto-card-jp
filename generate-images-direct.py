#!/usr/bin/env python3
"""
crypto-card.jp 画像生成スクリプト
OpenAI Images API直接呼び出し版
"""

import os
import json
import time
from pathlib import Path
import urllib.request
import urllib.error

# 設定
API_KEY = os.environ.get("OPENAI_API_KEY")
if not API_KEY:
    print("❌ エラー: OPENAI_API_KEY環境変数が設定されていません")
    exit(1)

OUT_DIR = Path.home() / ".openclaw/workspace/crypto-card-jp/public/images/generated"
OUT_DIR.mkdir(parents=True, exist_ok=True)

# 画像プロンプト
PROMPTS = [
    {
        "name": "hero-crypto-card",
        "prompt": "Sleek modern crypto card with holographic bitcoin logo, floating above smartphone, glowing blue and purple neon lighting, futuristic tech aesthetic, clean product photography style"
    },
    {
        "name": "shopping-scene",
        "prompt": "Person confidently holding crypto card at checkout counter, casual shopping scene, bright store lighting, modern retail environment, natural candid photography"
    },
    {
        "name": "contactless-payment",
        "prompt": "Hand tapping crypto card on wireless payment terminal with green checkmark hologram appearing, instant payment concept, clean product shot, modern minimalist style"
    },
    {
        "name": "btc-to-yen",
        "prompt": "Bitcoin logo transforming into Japanese yen symbol through digital particles, financial exchange concept, blue and gold color scheme, clean tech illustration"
    },
    {
        "name": "card-comparison",
        "prompt": "Three different crypto cards arranged side by side in comparison layout, clean product photography, even studio lighting, professional commercial aesthetic"
    },
    {
        "name": "online-shopping",
        "prompt": "Laptop screen showing online shopping cart with crypto card payment option highlighted, e-commerce interface, modern web design aesthetic, bright natural desk lighting"
    },
    {
        "name": "wallet-app-chart",
        "prompt": "Smartphone displaying crypto wallet app with rising chart graph, candlestick patterns visible, trader's desk setup, professional finance aesthetic, cool blue lighting"
    },
    {
        "name": "cafe-payment",
        "prompt": "Person using crypto card at cafe counter, coffee shop ambiance, warm natural lighting, casual lifestyle photography, modern urban setting"
    },
    {
        "name": "zero-fee-infographic",
        "prompt": "Close-up of crypto card showing fee breakdown infographic overlay, 0% fee label prominent, clean educational style, professional finance illustration"
    },
    {
        "name": "crypto-ecosystem",
        "prompt": "Crypto card surrounded by floating Bitcoin, Ethereum, and USDT coin icons, digital asset ecosystem concept, blockchain network visualization, blue and purple gradient background"
    },
    {
        "name": "apple-wallet-add",
        "prompt": "iPhone screen showing Wallet app with crypto card being added, clean iOS interface, hands holding phone in natural pose, modern tech lifestyle, bright natural lighting"
    },
    {
        "name": "usdt-stable",
        "prompt": "USDT Tether coin with stable line graph behind it, showing zero volatility, blue and green color scheme, financial stability concept, clean infographic style, professional finance aesthetic"
    },
    {
        "name": "ranking-podium",
        "prompt": "Podium with three crypto cards ranked 1st, 2nd, 3rd, percentage symbols (6%, 2%, 0%) floating above each, gold, silver, bronze color scheme, competitive ranking aesthetic, clean 3D illustration"
    },
    {
        "name": "streaming-subscriptions",
        "prompt": "Streaming service logos on screen with crypto card in foreground, entertainment subscription concept, warm home theater lighting, modern lifestyle aesthetic"
    },
    {
        "name": "security-shield",
        "prompt": "Shield icon protecting crypto card with lock symbols, digital security elements, blue and green color scheme, cybersecurity aesthetic, clean tech illustration style, trustworthy vibe"
    },
    {
        "name": "virtual-vs-physical",
        "prompt": "Side-by-side comparison: smartphone showing virtual card on left vs physical card on right, clean product comparison layout, modern tech aesthetic, balanced lighting"
    },
    {
        "name": "tax-guide",
        "prompt": "Calculator, tax documents, and crypto card on desk, Japanese yen bills visible, organized financial planning aesthetic, natural office lighting, professional accountant vibe"
    },
    {
        "name": "beginner-steps",
        "prompt": "Friendly step-by-step guide illustration with numbered steps (1, 2, 3), beginner-friendly aesthetic, bright and welcoming colors, simple and approachable design"
    },
    {
        "name": "comparison-checkmarks",
        "prompt": "Three crypto cards arranged in comparison layout with checkmarks and X marks, clean comparison chart aesthetic, blue and white color scheme, professional infographic style"
    }
]

def generate_image(prompt_text, filename):
    """OpenAI Images APIで画像生成"""
    url = "https://api.openai.com/v1/images/generations"
    
    data = json.dumps({
        "model": "dall-e-3",
        "prompt": prompt_text,
        "n": 1,
        "size": "1792x1024",  # 16:9に近いサイズ
        "quality": "hd",
        "style": "natural"
    }).encode('utf-8')
    
    headers = {
        "Authorization": f"Bearer {API_KEY}",
        "Content-Type": "application/json"
    }
    
    req = urllib.request.Request(url, data=data, headers=headers)
    
    try:
        with urllib.request.urlopen(req) as response:
            result = json.loads(response.read().decode('utf-8'))
            
            if 'data' in result and len(result['data']) > 0:
                image_url = result['data'][0]['url']
                
                # 画像をダウンロード
                image_data = urllib.request.urlopen(image_url).read()
                
                # 保存
                output_path = OUT_DIR / f"{filename}.png"
                with open(output_path, 'wb') as f:
                    f.write(image_data)
                
                return True, str(output_path)
            else:
                return False, "APIレスポンスに画像URLがありません"
                
    except urllib.error.HTTPError as e:
        error_body = e.read().decode('utf-8')
        return False, f"HTTPエラー {e.code}: {error_body}"
    except Exception as e:
        return False, f"エラー: {str(e)}"

def main():
    print("🎨 crypto-card.jp画像生成開始")
    print(f"総数: {len(PROMPTS)}枚")
    print(f"出力先: {OUT_DIR}")
    print("")
    
    success_count = 0
    failed_list = []
    
    for i, item in enumerate(PROMPTS, 1):
        name = item['name']
        prompt = item['prompt']
        
        print(f"[{i}/{len(PROMPTS)}] 生成中: {name}")
        
        success, result = generate_image(prompt, name)
        
        if success:
            print(f"✅ 保存: {name}.png")
            success_count += 1
        else:
            print(f"❌ エラー: {name}")
            print(f"   理由: {result}")
            failed_list.append(name)
        
        print("")
        
        # API制限対策（1分あたり5リクエスト制限の場合）
        if i < len(PROMPTS):
            print("⏳ 15秒待機中...")
            time.sleep(15)
    
    print("🎉 完了！")
    print(f"成功: {success_count}/{len(PROMPTS)}枚")
    
    if failed_list:
        print(f"\n❌ 失敗した画像:")
        for name in failed_list:
            print(f"  - {name}")
    
    print(f"\n📁 出力先: {OUT_DIR}")

if __name__ == "__main__":
    main()
