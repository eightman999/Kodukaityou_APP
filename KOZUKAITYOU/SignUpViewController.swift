////
////  SignUpViewController.swift
////  KOZUKAITYOU
////
////  Created by 塙　詠斗 on 2019/11/12.
////  Copyright © 2019 塙　詠斗. All rights reserved.
////
// © eightman 2005-2025. Furin-lab All rights reserved.
// Operation: サインアップ機能実装予定のファイル
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func didTapSignUp(_ sender: UIButton) {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            showAlert("メールアドレスとパスワードを入力してください")
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { [weak self] (authResult, error) in
            guard let self = self else { return }

            if let error = error {
                if let errCode = AuthErrorCode.Code(rawValue: error._code) {
                    switch errCode {
                    case .invalidEmail:
                        self.showAlert("有効なメールアドレスを入力してください。")
                    case .emailAlreadyInUse:
                        self.showAlert("そのメールアドレスは既に使用されています。")
                    case .weakPassword:
                        self.showAlert("パスワードは6文字以上で入力してください。")
                    default:
                        self.showAlert("エラー: \(error.localizedDescription)")
                    }
                }
                return
            }

            // 登録成功
            self.showSuccessAlert()
        }
    }

    @IBAction func didTapBackToLogin(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "小遣い帳をつけよう！", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    func showSuccessAlert() {
        let alertController = UIAlertController(title: "登録完了", message: "アカウントの作成が完了しました！", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.signIn()
        })
        self.present(alertController, animated: true, completion: nil)
    }

    func signIn() {
        performSegue(withIdentifier: "SignInFromSignUp", sender: nil)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

// MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
