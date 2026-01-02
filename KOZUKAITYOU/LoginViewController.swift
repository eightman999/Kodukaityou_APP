////
////  LoginViewController.swift
////  KOZUKAITYOU
////
////  Created by 塙　詠斗 on 2019/11/12.
////  Copyright © 2019 塙　詠斗. All rights reserved.
////
// © eightman 2005-2025. Furin-lab All rights reserved.
// Operation: ログイン機能実装予定のファイル
//

import UIKit
import FirebaseAuth
import RealmSwift
import GoogleSignIn

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        applyModernUIStyles()
        configureGoogleSignIn()
    }

    private func applyModernUIStyles() {
        // Apply modern styles to text fields
        emailField?.applyModernStyle()
        emailField?.placeholder = "メールアドレス"

        passwordField?.applyModernStyle()
        passwordField?.placeholder = "パスワード"
        passwordField?.isSecureTextEntry = true

        // Update view background
        view.backgroundColor = .systemBackground
    }

    private func configureGoogleSignIn() {
        // Configure Google Sign-In with client ID from GoogleService-Info.plist
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if let _ = Auth.auth().currentUser {
            // Already logged in
        }
    }

    // MARK: - Google Sign-In Action
    @IBAction func didTapGoogleSignIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            guard let self = self else { return }

            if let error = error {
                self.showAlert("Googleサインインに失敗しました: \(error.localizedDescription)")
                return
            }

            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                self.showAlert("Googleサインインに失敗しました")
                return
            }

            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)

            // Firebase Authenticationに認証情報を渡す
            Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                guard let self = self else { return }

                if let error = error {
                    self.showAlert("認証に失敗しました: \(error.localizedDescription)")
                    return
                }

                // Realmインスタンスの生成と全データの削除
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.deleteAll()
                    }
                } catch {
                    print("Realm error: \(error)")
                }

                let alert = UIAlertController(title: "", message: "ログインしました！", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK!", style: .default) { _ in
                    self.view.endEditing(true)
                    self.signIn()
                })
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

    @IBAction private func didTapSignIn(_ sender: UIButton) {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            showAlert("メールアドレスとパスワードを入力してください")
            return
        }

        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let self = self else { return }

            if let error = error {
                if let errCode = AuthErrorCode.Code(rawValue: error._code) {
                    switch errCode {
                    case .userNotFound:
                        self.showAlert("ユーザーアカウントが見つかりません。新規登録してください")
                    case .wrongPassword:
                        self.showAlert("メールアドレスまたはパスワードが正しくありません")
                    case .invalidEmail:
                        self.showAlert("有効なメールアドレスを入力してください")
                    default:
                        self.showAlert("エラー: \(error.localizedDescription)")
                    }
                }
                return
            }

            guard authResult != nil else {
                assertionFailure("user and error are nil")
                return
            }

            let alert = UIAlertController(title: "", message: "ログインしました！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default) { _ in
                self.view.endEditing(true)

                // Realmインスタンスの生成と全データの削除
                do {
                    let realm = try Realm()
                    try realm.write {
                        realm.deleteAll()
                    }
                } catch {
                    print("Realm error: \(error)")
                }

                self.signIn()
            })
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func didRequestPasswordReset(_ sender: UIButton) {
        let prompt = UIAlertController(title: "小遣い帳をつけよう！", message: "メールアドレスを入力してください:", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            guard let self = self,
                  let userInput = prompt.textFields?.first?.text,
                  !userInput.isEmpty else {
                return
            }

            Auth.auth().sendPasswordReset(withEmail: userInput) { error in
                if let error = error {
                    if let errCode = AuthErrorCode.Code(rawValue: error._code) {
                        switch errCode {
                        case .userNotFound:
                            DispatchQueue.main.async {
                                self.showAlert("ユーザーアカウントが見つかりません。新規登録してください")
                            }
                        default:
                            DispatchQueue.main.async {
                                self.showAlert("エラー: \(error.localizedDescription)")
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.showAlert("パスワードリセット用のメールを送信しました。")
                    }
                }
            }
        }

        prompt.addTextField { textField in
            textField.placeholder = "email@example.com"
            textField.keyboardType = .emailAddress
        }
        prompt.addAction(okAction)
        prompt.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        present(prompt, animated: true, completion: nil)
    }

    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "小遣い帳をつけよう！", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    func signIn() {
        performSegue(withIdentifier: "SignInFromLogin", sender: nil)
    }

    @IBAction func didTapBackToLogin(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
