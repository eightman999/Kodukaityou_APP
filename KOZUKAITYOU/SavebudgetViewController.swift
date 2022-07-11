//
//  Save SavebudgetViewController.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/08/23.
//  Copyright © 2019 塙　詠斗. All rights reserved.
//

import UIKit

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
    //---------------var-------------↓
    var saveday: Int = 0
    var checksaveday: Int = 0
    
    var budget: [Dictionary<String, Any>] = []
    let saveData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if saveData.array(forKey: "budget") != nil {
            budget = saveData.array(forKey: "budget") as! [Dictionary<String,Any>]
        }
//        for data in budget {
//            let SD = data["SAVE-DAY"] as! Date
//            print(getIntervalDays(date: SD))
//            if getIntervalDays(date: SD) < 1{
//                let alert = UIAlertController(title: "警告！", message:"一年経たないと予算は変えられません！", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
//                present(alert, animated: true, completion: nil)
//                self.view.endEditing(true)
//                let storyboard: UIStoryboard = self.storyboard!
//                let second = storyboard.instantiateViewController(withIdentifier: "second")
//                self.present(second, animated: true, completion: nil)
//                return
//            }else{
//                return
//            }
        //}
       

        // Do any additional setup after loading the view.
    }
    
    func getIntervalDays(date:Date?,anotherDay:Date? = nil) -> Double {
        
        var retInterval:Double!
        
        if anotherDay == nil {
            retInterval = date?.timeIntervalSinceNow
        } else {
            retInterval = date?.timeIntervalSince(anotherDay!)
        }
        
        let ret = retInterval/(86400 * 365)
        
        return floor(ret)  // nねん
    }
    @IBAction func saveWorld(){
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
        
    
       
        
        for data in budget {
            let SD = data["SAVE-DAY"] as! Date
               print(getIntervalDays(date: SD))
            if getIntervalDays(date: SD) < 1{
                let alert = UIAlertController(title: "警告！", message:"一年経たないと予算は変えられません！", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
                self.view.endEditing(true)
                return
            }
        }
        

        let Datedics: [String: Any] = [
            "budget-A":a.text!,
            "budget-B":b.text!,
            "budget-C":c.text!,
            "budget-D":d.text!,
            "budget-E":e.text!,
            "budget-F":f.text!,
            "budget-G":g.text!,
            "budget-H":h.text!,
            "budget-I":i.text!,
            "SAVE-DAY":Date()]
        
        budget.append(Datedics)
        saveData.set(budget, forKey: "budget")
        print("予算は", budget)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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


