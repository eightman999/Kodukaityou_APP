//
//  AddViewController.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/07/26.
//  Copyright © 2019 塙　詠斗. All rights reserved.
//

import UIKit
import CoreData
class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{

    
    weak var iMVC = InmoneyViewController()
    
    
    @IBOutlet var pickerView: UIPickerView!    
    @IBOutlet var name: UITextField!
    @IBOutlet var kosu: UITextField!
    @IBOutlet var tanka: UITextField!
    @IBOutlet var Tuki: UITextField!
    @IBOutlet var Niti: UITextField!
    @IBOutlet var Save: UIButton!
    var day: String = "0"
    var kosuu: String = "0"
    var goukeib: String = "0"
    var niti: Int = 0
    var tuki: Int = 0
    var kingaku: Int = 0
    var kingaku1: String = "0"
    var goukei: Int = 0
    var namebox: String = "0"
    var himoku: String = "A費"
    var saihu: Int = 0
    var allData: [Dictionary<String, Any>] = []
//    var saveData = UserDefaults.standard
    //---PickerView----設定-----↓
    let saveData = UserDefaults.standard
     let dataList = ["A費",
                     "B費",
                     "C費",
                     "D費",
                     "E費",
                     "F費",
                     "G費",
                     "H費",
                     "I費"]
    
    //------viewDidLoad()---------↓
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if saveData.array(forKey: "SAVE") != nil {
            allData = saveData.array(forKey: "SAVE") as! [Dictionary<String,Any>]
        }
        pickerView.delegate = self
        pickerView.dataSource = self
        
       

        // Do any additional setup after loading the view.
    }
   
 
    
//========@IBAction========seveでーた=============↓↓
    @IBAction func saveWorld(){
     
        // 〜ーーーーーーー文字列がカラだったらーーーーーーーーーーーーー↓
        if kosu.text?.isEmpty == true {
            let alert = UIAlertController(title: "警告！", message:"個数が入力されていません！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if tanka.text?.isEmpty == true{
            let alert = UIAlertController(title: "警告！", message:"単価が入力されていません！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if name.text?.isEmpty == true {
            let alert = UIAlertController(title: "警告！", message:"名称が入力されていません！", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
            
        }else if Tuki.text?.isEmpty == true {
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
        kosuu = kosu.text! + "個"
        niti = Int(Niti.text!)!
        tuki = Int(Tuki.text!)!
        if niti > 31 {
            let alert = UIAlertController(title: "警告！", message:"日付が存在しません！", preferredStyle: .alert)
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
        //====================今いつ？======================↓
        var myDateComponents = DateComponents()
        myDateComponents.year = 2019
        myDateComponents.month = Int(Tuki.text!)!
        myDateComponents.day = Int(Niti.text!)!
        myDateComponents.timeZone = Calendar.current.timeZone
        print(myDateComponents)
        
        let date = Calendar.current.date(from: myDateComponents)
        print(date!)
        
        guard let formatString = DateFormatter.dateFormat(fromTemplate: "MMMdd", options: 0, locale: Locale.current) else { fatalError() }
        print(formatString)
        
       let dateFormatter = DateFormatter()
//        //-------------計算---------------↓
//        //-----変数bagを定義↓
//        var bag: Int = 0
//        //---bagにOutmoneyのsaihuの中身を入れる---↓
//        for data in Outmoney {
//            bag = data["saihu"] as! Int
//        }
//        //-------足し合わせる------↓
//
        dateFormatter.dateFormat = formatString
        
        dateFormatter.string(from: date!)
        
        
        kingaku = Int(kosu.text!)! * Int(tanka.text!)!
        //saihu = bag + kingaku
        goukeib = String(kingaku) + "円"
        namebox = name.text!
        let Datedic: [String: Any] = [
            "saihu":saihu,
            "name": name.text!,
            "kosuu": kosuu,
            "kingaku": goukeib,
            "day": dateFormatter.string(from: date!),
            "TIME": date as Any,
            "himoku": himoku,
            "goukei": goukeib,
            ]
        allData.append(Datedic)
        saveData.set(allData, forKey: "SAVE")
        //--------Alert"登録しました！"---------------↓
        let alert = UIAlertController(
            title: "登録しましたよ！！",
            
            message:
            "登録されました！\n" + "登録されたデータ\n" + "名称" + namebox + "\n" + "単価" + tanka.text! + "円\n" + "個数" + kosuu + "\n" + "小計" + goukeib + "\n日時" + dateFormatter.string(from: date!),
            
            preferredStyle: .alert
            
        )
        alert.addAction(UIAlertAction(
            title: "OK",
            style: .default,
            handler: nil
        
        ))
        present(alert, animated:  true, completion: {
            self.name.text = ""
            self.kosu.text = ""
            self.tanka.text = ""
            self.Tuki.text = ""
            self.Niti.text = ""
            self.view.endEditing(true)
        })
      
      
        
    }
    // -----------------UIPickerViewの列の数--------------------↓
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // ------------UIPickerViewの行数、リストの数---------------↓
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    //----------- UIPickerViewの最初の表示-----------------------↓
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return dataList[row]
    }
    //------------ UIPickerViewのRowが選択された時の挙動----------↓
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        himoku = dataList[row]
    }
    

 //-------------キーボード解除コード-------------------------------↓
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
