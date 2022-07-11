//
//  SETViewController.swift
//  KOZUKAITYOU
//
//  Created by 塙詠斗 on 2019/12/27.
//  Copyright © 2019 塙　詠斗. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SETViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func logout(){
        authUI.signOut()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
