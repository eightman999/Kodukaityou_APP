# KOZUKAITYOU (おこづかい帳)

iOS 向けのオフラインおこづかい帳アプリ。支出・収入の記録、月別グラフ、年間費目別集計をすべて端末内で完結する。

## 動作環境

| 項目 | 値 |
|---|---|
| iOS | 17.0 以上 |
| Xcode | 15.4 以上 |
| Swift | 5 |
| アーキテクチャ | UIKit + Storyboard (MVC) |

## セットアップ

```bash
# リポジトリをクローン
git clone <repository-url>
cd Kodukaityou_APP

# CocoaPods で依存を取得
pod install

# ワークスペースを開く（.xcodeproj ではなく .xcworkspace）
open KOZUKAITYOU.xcworkspace
```

> **注意**: `KOZUKAITYOU.xcodeproj` ではなく `KOZUKAITYOU.xcworkspace` を開くこと。
> CocoaPods の依存が解決されず、ビルドエラーになる。

## ビルド (CLI)

```bash
xcodebuild \
  -workspace KOZUKAITYOU.xcworkspace \
  -scheme KOZUKAITYOU \
  -sdk iphonesimulator \
  -arch arm64 \
  -configuration Debug \
  build
```

## 依存ライブラリ

| ライブラリ | 用途 |
|---|---|
| **RealmSwift** | ローカルデータベース (支出・収入・予算) |
| **DGCharts** | 月別・年間の円グラフ表示 |
| **IQKeyboardManagerSwift** | キーボード表示時の自動スクロール |

ネットワーク通信を行うライブラリは含まない。

## プロジェクト構成

```
KOZUKAITYOU/
├── AppDelegate.swift          # アプリ起動・IQKeyboard 初期化
├── Localization.swift         # 日英切り替えヘルパー
├── UIExtension.swift          # UI ユーティリティ
│
├── モデル (Realm)
│   ├── MainItem.swift         # 出費レコード
│   ├── SUBItem.swift          # 費目別予算
│   └── YearItem.swift         # 年間データ
│
├── 画面 (ViewController)
│   ├── mainViewController.swift       # ホーム
│   ├── AddViewController.swift        # 出費入力
│   ├── InmoneyViewController.swift    # 収入入力
│   ├── SavebudgetViewController.swift # 予算設定
│   ├── MonthViewController.swift      # 月間グラフ
│   ├── yearViewContoller.swift        # 年間集計
│   ├── A~IyearViewController.swift    # 費目別年間詳細 (9画面)
│   ├── inputViewController.swift      # 入力補助
│   ├── suksViewController.swift       # 一覧表示
│   ├── LoginViewController.swift      # ログイン (認証廃止済み)
│   ├── SignUpViewController.swift     # サインアップ (認証廃止済み)
│   └── SETViewController.swift        # 設定
│
├── Storyboard
│   ├── Main.storyboard        # メイン画面遷移
│   ├── SE.storyboard          # 設定系画面
│   └── LaunchScreen.storyboard
│
└── ListTableViewCell.swift / .xib  # カスタムセル
```

## 設計方針

- **完全オフライン** — ネットワーク通信は一切不要。Firebase は廃止済み。
- **Realm 一本** — すべてのデータは Realm に保存。CoreData のモデルファイルは残存するが未使用。
- **日英対応** — `localized(japanese:english:)` で端末の言語設定に応じて切り替え。

## ライセンス

Copyright &copy; eightman 2005-2025. Furin-lab All rights reserved.
