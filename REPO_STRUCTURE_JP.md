# リポジトリ構成概要

このリポジトリは iOS 向け家計簿アプリ「Kodukaityou」のソースコードを含みます。主なディレクトリとファイルは次の通りです。

```
.
├── AGENTS.md
├── CLAUDE.md
├── GEMINI.md
├── KOZUKAITYOU/          # アプリ本体の Swift ソース
├── KOZUKAITYOU.xcodeproj # Xcode プロジェクト
├── KOZUKAITYOU.xcworkspace
├── KOZUKAITYOUTests/     # 単体テスト
├── KOZUKAITYOUUITests/   # UI テスト
├── Podfile               # CocoaPods 設定
├── Podfile.lock
├── Pods/                 # 依存ライブラリ
└── README.md
```

## KOZUKAITYOU ディレクトリ
Swift の ViewController などアプリのメインコードが配置されています。`Assets.xcassets` や Storyboard (`Base.lproj/ip6s.storyboard`) など UI に関するリソースも含みます。

## テスト
`KOZUKAITYOUTests` と `KOZUKAITYOUUITests` の 2 つのターゲットがあり、基本的なテストクラスが定義されています。

## 依存関係
`Podfile` では次のようなライブラリが使われています（一部抜粋）。

```
platform :ios, '17.0'
target 'KOZUKAITYOU' do
  use_frameworks!
  pod 'Charts'
  pod 'RealmSwift'
  pod 'TTTAttributedLabel'
  pod 'SVProgressHUD', :git => 'https://github.com/SVProgressHUD/SVProgressHUD.git'
  pod 'EAIntroView'
  pod 'OCMock'
  pod 'FirebaseUI'
  pod 'Firebase'
  pod 'YMTGetDeviceName'
  pod 'IQKeyboardManager'
  pod 'Firebase/Analytics'
end
```

## ドキュメント
`README.md` には環境構築手順（CocoaPods のインストールや `pod install` の実行、Xcode ワークスペースのオープン方法）が説明されています。また、Firebase 用の `GoogleService-Info.plist` が同梱されている旨が記載されています。

以上がリポジトリの概要です。
