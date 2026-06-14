//
//  SignUpViewController.swift
//  KOZUKAITYOU
//
// © eightman 2005-2025. Furin-lab All rights reserved.
// Operation: サインアップ画面（Firebase認証廃止により認証不要化）

import UIKit
import RealmSwift

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }

    @IBAction func didTapBackToLogin(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
