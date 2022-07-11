//
//  secondViewController.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/08/25.
//  Copyright © 2019 塙　詠斗. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {
    @IBOutlet var backtomenu: UIButton!
    
    @IBOutlet var a:  UILabel!
    @IBOutlet var b: UILabel!
    @IBOutlet var c: UILabel!
    @IBOutlet var d: UILabel!
    @IBOutlet var e: UILabel!
    @IBOutlet var f: UILabel!
    @IBOutlet var g: UILabel!
    @IBOutlet var h: UILabel!
    @IBOutlet var i: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func BTM(_ sender: Any){
        let storyboard: UIStoryboard = self.storyboard!
        let second = storyboard.instantiateViewController(withIdentifier: "mainmenu")
        self.present(second, animated: true, completion: nil)
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
