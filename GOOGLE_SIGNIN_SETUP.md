# Googleサインイン実装ガイド

このドキュメントでは、アプリにGoogleサインイン機能を追加するための手順を説明します。

## 実装済みの内容

以下の設定とコード実装は既に完了しています：

1. **Podfile**: GoogleSignIn SDKを追加
2. **Info.plist**: GoogleサインインのURL Schemeを設定
3. **AppDelegate**: GoogleSignInの初期化とURL処理を追加
4. **LoginViewController**: Googleサインイン機能を実装
5. **SignUpViewController**: Googleサインイン機能を実装

## 次に必要な手順

### 1. CocoaPodsの依存関係をインストール

ターミナルでプロジェクトディレクトリに移動し、以下のコマンドを実行してください：

```bash
cd /path/to/Kodukaityou_APP
pod install
```

### 2. Storyboardにボタンを追加

Xcodeで以下のStoryboardファイルを開いて、Googleサインインボタンを追加してください：

#### LoginViewControllerの場合 (Main.storyboard)

1. Main.storyboardを開く
2. Login View Controller Sceneを見つける
3. 新しいUIButtonを追加
4. ボタンのタイトルを「Googleでサインイン」に設定
5. ボタンのスタイルを設定（推奨：背景色を白、テキスト色を黒）
6. **重要**: ボタンをLoginViewControllerの`didTapGoogleSignIn`アクションに接続

#### SignUpViewControllerの場合 (Main.storyboard)

1. Main.storyboardを開く
2. Sign Up View Controller Sceneを見つける
3. 新しいUIButtonを追加
4. ボタンのタイトルを「Googleで登録」に設定
5. ボタンのスタイルを設定（推奨：背景色を白、テキスト色を黒）
6. **重要**: ボタンをSignUpViewControllerの`didTapGoogleSignUp`アクションに接続

### 3. Interface Builder (IB)での接続手順

1. StoryboardでボタンをControl+クリック（右クリック）
2. ViewControllerにドラッグ
3. 表示されるポップアップから該当するアクションを選択：
   - LoginViewController: `didTapGoogleSignIn:`
   - SignUpViewController: `didTapGoogleSignUp:`

### 4. Googleサインインボタンのデザイン（オプション）

より本格的なGoogleサインインボタンにしたい場合は、以下のようにカスタマイズできます：

```swift
// viewDidLoadに追加
private func setupGoogleSignInButton() {
    let button = GIDSignInButton() // Google提供のボタン
    button.frame = CGRect(x: 0, y: 0, width: 200, height: 48)
    button.center = view.center
    view.addSubview(button)

    // タップイベントを追加
    button.addTarget(self, action: #selector(didTapGoogleSignIn), for: .touchUpInside)
}
```

## 実装内容の説明

### LoginViewController

- `didTapGoogleSignIn(_:)`: Googleサインインボタンがタップされた時に呼ばれます
  1. GoogleSignInを開始
  2. IDトークンとアクセストークンを取得
  3. Firebase Authenticationで認証
  4. Realmデータベースをクリア
  5. メイン画面に遷移

### SignUpViewController

- `didTapGoogleSignUp(_:)`: Googleサインアップボタンがタップされた時に呼ばれます
  - LoginViewControllerと同じフローで、新規登録もサインインも同じように処理されます

## 既存のメール/パスワード認証について

既存のメール/パスワードによる認証機能は引き続き利用可能です。Googleサインインと並行して使用できます。

## トラブルシューティング

### エラー: "The operation couldn't be completed"

- GoogleService-Info.plistが正しく追加されているか確認
- Info.plistのCFBundleURLSchemesが正しく設定されているか確認
- pod installが正常に完了しているか確認

### エラー: "Client ID not found"

- FirebaseApp.configure()がAppDelegateで呼ばれているか確認
- GoogleService-Info.plistのCLIENT_IDが存在するか確認

### ボタンが反応しない

- Storyboardでボタンとアクションメソッドが正しく接続されているか確認
- @IBActionの前にあるアノテーションが正しいか確認

## 参考リンク

- [Firebase Authentication - Google Sign-In](https://firebase.google.com/docs/auth/ios/google-signin)
- [Google Sign-In for iOS](https://developers.google.com/identity/sign-in/ios)
