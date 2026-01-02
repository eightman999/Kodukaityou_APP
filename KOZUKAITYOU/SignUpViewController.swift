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
import GoogleSignIn
import RealmSwift

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureGoogleSignIn()
    }

    private func configureGoogleSignIn() {
        // Configure Google Sign-In with client ID from GoogleService-Info.plist
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
    }

    // MARK: - Google Sign-In Action
    @IBAction func didTapGoogleSignUp(_ sender: UIButton) {
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

                self.showSuccessAlert()
            }
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
}
