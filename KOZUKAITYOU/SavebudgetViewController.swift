//
//  Save SavebudgetViewController.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/08/23.
//  Copyright © 2019 塙　詠斗. All rights reserved.
//

import UIKit
import RealmSwift
class SavebudgetViewController: UIViewController {
    //----------@IBOutlet-----------↓
    
    @IBOutlet var a:  UITextField!
    @IBOutlet var b: UITextField!
    @IBOutlet var c: UITextField!
    @IBOutlet var d: UITextField!
    @IBOutlet var e: UITextField!
    @IBOutlet var f: UITextField!
    @IBOutlet var g: UITextField!
    @IBOutlet var h: UITextField!
    @IBOutlet var i: UITextField!
    @IBOutlet var save: UIButton!
    public var realm: Realm!
    //---------------var-------------↓
    var saveday: Int = 0
    var checksaveday: Int = 0
    var alt:String = ""
    var alt1:String = ""
    var alt2:String = ""
    var alt3:String = ""
    var alt4:String = ""
    var alt5:String = ""
    var alt6:String = ""
    var alt7:String = ""
    var alt8:String = ""
    
    var kd: [Dictionary<String, Any>] = []
    let saveData = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func saveWorld(_ sender: Any){
        //---------===================isEmpty警告ーーーーーーーーーーーーーーーーーーーー
        if a.text?.isEmpty == true {
            let alert = UIAlertController(title: "警告！", message:"A費が入力されていません！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if b.text?.isEmpty == true{
            let alert = UIAlertController(title: "警告！", message:"B費が入力されていません！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if c.text?.isEmpty == true{
            let alert = UIAlertController(title: "警告！", message:"C費が入力されていません！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if d.text?.isEmpty == true{
            let alert = UIAlertController(title: "警告！", message:"D費が入力されていません！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if e.text?.isEmpty == true{
            let alert = UIAlertController(title: "警告！", message:"E費が入力されていません！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if f.text?.isEmpty == true{
            let alert = UIAlertController(title: "警告！", message:"F費が入力されていません！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if g.text?.isEmpty == true{
            let alert = UIAlertController(title: "警告！", message:"G費が入力されていません！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if h.text?.isEmpty == true{
            let alert = UIAlertController(title: "警告！", message:"H費が入力されていません！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if i.text?.isEmpty == true{
            let alert = UIAlertController(title: "警告！", message:"I費が入力されていません！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }
        
        //^-------^--------^--------^Realm書き込み---------------^-------^--------------
        
        let BUDItem = SUBItem()
        BUDItem.A1 = Int(a.text!)!
        BUDItem.B1 = Int(b.text!)!
        BUDItem.C1 = Int(c.text!)!
        BUDItem.D1 = Int(d.text!)!
        BUDItem.E1 = Int(e.text!)!
        BUDItem.F1 = Int(f.text!)!
        BUDItem.G1 = Int(g.text!)!
        BUDItem.H1 = Int(h.text!)!
        BUDItem.I1 = Int(i.text!)!
        
        BUDItem.A2 = Int(a.text!)!
        BUDItem.B2 = Int(b.text!)!
        BUDItem.C2 = Int(c.text!)!
        BUDItem.D2 = Int(d.text!)!
        BUDItem.E2 = Int(e.text!)!
        BUDItem.F2 = Int(f.text!)!
        BUDItem.G2 = Int(g.text!)!
        BUDItem.H2 = Int(h.text!)!
        BUDItem.I2 = Int(i.text!)!
        
        print("処理２")
        do{
            let realm = try Realm()
            try realm.write({ () -> Void in
                realm.add(BUDItem)
            })
            print("登録")
        }catch{
        }
        
        
        
        
        
        
        //------------------------set_data-----------------------------/
        alt = "\nA費　" + a.text!
        alt1 = "\nB費　" + b.text!
        alt2 = "\nC費　" + c.text!
        alt3 = "\nD費　" + d.text!
        alt4 = "\nE費　" + e.text!
        alt5 = "\nF費　" + f.text!
        alt6 = "\nG費　" + g.text!
        alt7 = "\nH費　" + h.text!
        alt8 = "\nI費　" + i.text!
        let alt11:String = alt + alt1 + alt2 + alt3 + alt4 + alt5 + alt6 + alt7 + alt8
        
        //-------------------------alert----------------------------//
        print("アラート")
        let title = "登録したよ！"
        let message = "登録されました！\n" + "登録されたデータ\n" + alt11
        
        let okText = "ok"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okayButton)
        
        present(alert, animated: true, completion: nil)
        
        //--------------ここまで-------------//
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
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


