//
//  InmoneyViewController.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/08/23.
//  Copyright © 2019 塙　詠斗. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase
class InmoneyViewController: UIViewController {
    //----------@IBOutlet-----------↓
      var firebaseAPI = FirebaseAPI()
    @IBOutlet var inmoney: UITextField!
    @IBOutlet var Tuki: UITextField!
    @IBOutlet var Niti: UITextField!
    @IBOutlet var Save: UIButton!
    
    //---------------var-------------↓
    var exp:Int = 0
    var niti: Int = 0
    var tuki: Int = 0
    var saihu: Int = 0
    let realm = try! Realm()
    //-------Dictonary呼び出し-------↓
    var kd: [Dictionary<String, Any>] = []
    let saveData = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    @IBAction func PUSHSAVE(){
        //-------入力確認・警告----------------↓
        if Tuki.text?.isEmpty == true {
            let alert = UIAlertController(title: "警告！", message:"月が入力されていません！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if Niti.text?.isEmpty == true {
            let alert = UIAlertController(title: "警告！", message:"日付が入力されていません！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }
        //---------日時特殊処理・警告-----------↓
        niti = Int(Niti.text!)!
        tuki = Int(Tuki.text!)!
        if niti > 31 {
            let alert = UIAlertController(title: "警告！", message:"日付が存在しません！",   preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if tuki > 12{
            let alert = UIAlertController(title: "警告！", message:"そんな月はねえ！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }
        
        //---------Date関連の何か？(作者にもわからない)-------↓
        var myDateComponents = DateComponents()
        myDateComponents.year = 2019
        myDateComponents.month = Int(Tuki.text!)!
        myDateComponents.day = Int(Niti.text!)!
        myDateComponents.timeZone = Calendar.current.timeZone
        
        print(myDateComponents)
        
        let date = Calendar.current.date(from: myDateComponents)
        
        print(date!)
        
        guard let formatString = DateFormatter.dateFormat(fromTemplate: "MMMdd", options: 0, locale: Locale.current) else { fatalError() }
        
        //print(formatString)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatString
        
        dateFormatter.string(from: date!)
        let results = realm.objects(MainItem.self)
        for dataa in results {
            let money = Int(inmoney.text!)!
            saihu = dataa.Nowmoney + money
        }
        
        
        //-------------計算---------------↓
        var bag: Int = 0
        
        for data in kd {
            bag = data["saihu"] as! Int
        }
        saihu = bag + Int(inmoney.text!)!
        //-----------登録処理！-----------↓
        let USERIDA:String = String((Auth.auth().currentUser?.uid)!) + "/"
        let USERID:String = USERIDA + "入金" + "/" + UUID().uuidString
              print(USERID)
        firebaseAPI.uploadToFirebase(path: "\(USERID)", write: ["Name" : "入金","Number":Int(1),"Expense" : "　","Nowmoney":saihu,"total":Int(inmoney.text!)!,"Day":date!.timeIntervalSinceReferenceDate,"TIME":Date().timeIntervalSinceReferenceDate])
        let newItem = MainItem()
        newItem.Name = "入金"
        newItem.Number = Int(1)
        newItem.Expense = "　"
        newItem.Nowmoney = saihu
        
        newItem.total = Int(inmoney.text!)!
        newItem.Day = date!
        print("処理２")
        print(Date())
        print("処理２")
        do{
            let realm = try Realm()
            try realm.write({ () -> Void in
                realm.add(newItem)
            })
            print("登録")
        }catch{
        }
        
        //------------入金報告！----------↓
        
        let alert = UIAlertController(
            title: "入金しましたよ！！",
            
            message:
            "入金されました！\n" + "金額" + inmoney.text! + "円\n" +  "日付" + dateFormatter.string(from: date!),
            
            preferredStyle: .alert
            
        )
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
            
        ))
        //=============リセット=============↓
        
        present(alert, animated:  true, completion: {
            self.Tuki.text = ""
            self.Niti.text = ""
            self.view.endEditing(true)
        })
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
}
