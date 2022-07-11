////
////  SignUpViewController.swift
////  KOZUKAITYOU
////
////  Created by 塙　詠斗 on 2019/11/12.
////  Copyright © 2019 塙　詠斗. All rights reserved.
////
//
//import UIKit
//import FirebaseAuth
//
//class SignUpViewController: UIViewController {
//
//    @IBOutlet weak var emailField: UITextField!
//    @IBOutlet weak var passwordField: UITextField!
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//
//
//
//
//        // Do any additional setup after loading the view.
//    }
//
//    @IBAction func didTapSignUp(_ sender: UIButton) {
//        let email = emailField.text
//        let password = passwordField.text
//        Auth.auth().createUser(withEmail: email!, password: password!, completion: { (user, error) in
//            if let error = error {
//                if let errCode = AuthErrorCode(rawValue: error._code){
//                    switch errCode {
//                    //AuthErrorCodeに関しては公式のドキュメントみてください
//                    case .invalidEmail:
//                        let alert = UIAlertController(
//                            title: "Enter a valid email.",
//
//                            message:
//                            "有効なメールアドレスを入力してください。",
//
//                            preferredStyle: .alert
//
//                        )
//                        alert.addAction(UIAlertAction(
//                            title: "OK",
//                            style: .default,
//                            handler: nil
//
//                        ))
//                    // 有効なメールアドレスを入力してください。
//                    case .emailAlreadyInUse:
//                        let alert = UIAlertController(
//                            title: "Enter a valid email.",
//
//                            message:
//                            "そのメールアドレスは使用されています。",
//
//                            preferredStyle: .alert
//
//                        )
//                        alert.addAction(UIAlertAction(
//                            title: "OK",
//                            style: .default,
//                            handler: nil
//
//                        ))
//                        // メールアドレス。
//
//
//                    default:
//                        self.showAlert("Error: \(error.localizedDescription)")              }
//                }
//                return
//            }
//            self.signIn()
//        })
//    }
//
//    @IBAction func didTapBackToLogin(_ sender: UIButton) {
//        self.dismiss(animated: true, completion: {})
//    }
//
//    func showAlert(_ message: String) {
//        let alertController = UIAlertController(title: "小遣い帳をつけよう！", message: message, preferredStyle: UIAlertController.Style.alert)
//        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
//        self.present(alertController, animated: true, completion: nil)
//    }
//
//    func signIn() {
//        performSegue(withIdentifier: "SignInFromSignUp", sender: nil)
//    }
//
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//
//        return true
//
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//
//
//
//}
