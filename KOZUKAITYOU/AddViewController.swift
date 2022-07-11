//
//  AddViewController.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/07/26.
//  Copyright © 2019 塙　詠斗. All rights reserved.
//

import UIKit
import RealmSwift
import CoreData
import Firebase

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var pickerView2:UIDatePicker!
    @IBOutlet var name: UITextField!
    @IBOutlet var kosu: UITextField!
    @IBOutlet var tanka: UITextField!
    @IBOutlet var Save: UIButton!
    
    let realm = try! Realm()
    
    var listcount:Int = 0
    var datePicker: UIDatePicker = UIDatePicker()
    var day: String = "0"
    var kosuu: String = "0"
    var goukeib: String = "0"
    var niti: Int = 0
    var tuki: Int = 0
    var tosi:Int = 0
    var kingaku: Int = 0
    var kingaku1: String = "0"
    var goukei: Int = 0
    var tanka1:Int = 0
    var exp :Int = 0
    var EXP:String = ""
    var himoku: String = "A費"
    var saihu: Int = 0
    

    //---PickerView----設定-----↓
    let dataList = ["A費", "B費","C費", "D費","E費", "F費", "G費","H費","I費"]
    //------viewDidLoad()---------↓
    var firebaseAPI = FirebaseAPI()
    override func viewDidLoad() {
    // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
              datePicker.timeZone = NSTimeZone.local
              datePicker.locale = Locale.current
      // 決定バーの生成
        
              let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
              let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
              let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done1))
              toolbar.setItems([spacelItem, doneItem], animated: true)
        
           
             pickerView.delegate = self
             pickerView.dataSource = self
             
            
    
          // Do any additional setup after loading the view.
    }
    @objc func done1() {
        // 日付のフォーマット
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"    }
     //========@IBAction========seveでーた=============↓↓
    @objc func done() {
        // 日付のフォーマット
        let formatter = DateFormatter()
       }
    @IBAction func saveWorld(_ sender: Any){
        //-------警告---------//
        // 文字列がカラだったら
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
        }
        kosuu = kosu.text! + "個"
        //====================今いつ？======================↓
        let calendar = Calendar(identifier: .gregorian)
        let pickerDate = datePicker.date
        var myDateComponents =  calendar.dateComponents([.year, .month, .day], from: pickerDate )
       print(myDateComponents.year)
        print(myDateComponents.month)
        print(myDateComponents.day)
        myDateComponents.timeZone = Calendar.current.timeZone
        print(myDateComponents)
          let date = Calendar.current.date(from: myDateComponents)
        guard let formatString = DateFormatter.dateFormat(fromTemplate: "YYMMdd", options: 0, locale: Locale.current) else { fatalError() }
        print(formatString)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatString
        print(saihu)
        print(kingaku)
        dateFormatter.string(from: date!)
        
        print("処理１")
    kingaku = Int(kosu.text!)! * Int(tanka.text!)!
        let results = realm.objects(MainItem.self)
        for dataa in results {
            let money = kingaku
            saihu = dataa.Nowmoney - money
        }
        let results2 = realm.objects(SUBItem.self)
        for data in results2{
            let himoku2 = himoku
            switch himoku2{
            case "A費":
                for data2 in results2 {
                    let money = kingaku
                    var a = data2.A2
                    exp = a - money
                    EXP = "A"
                }
            case "B費":
                for data2 in results2 {
                    let money = kingaku
                    var b = data2.B2
                    exp = b - money
                      EXP = "B"
                }
            case "C費":
                for data2 in results2 {
                    let money = kingaku
                    var c = data2.C2
                    exp = c - money
                      EXP = "C"
                }
            case "D費":
                for data2 in results2 {
                    let money = kingaku
                    var d = data2.D2
                    exp = d - money
                      EXP = "D"
                }
            case "E費":
                for data2 in results2 {
                    let money = kingaku
                    var e = data2.E2
                    exp = e - money
                      EXP = "E"
                }
            case "F費":
                for data2 in results2 {
                    let money = kingaku
                    var f = data2.F2
                    exp = f - money
                      EXP = "F"
                }
            case"G費":
                for data2 in results2 {
                    let money = kingaku
                    var g = data2.G2
                    exp = g - money
                      EXP = "G"
                }
            case "H費":
                for data2 in results2 {
                    let money = kingaku
                    var h = data2.H2
                    exp = h - money
                      EXP = "H"
                }
            case "I費":
                for data2 in results2 {
                    let money = kingaku
                    var I = data2.I2
                    exp = I - money
                      EXP = "I"
                }
            case "　":
                print("----------------error-------------------")
            default: // defaultは必須
                print("全部違ったよ")
                break
            }
        }
        //            mVC?.allData.append(Datedic)
        //        saveData.set(mVC?.allData, forKey: "WORD")
        let USERID:String = String((Auth.auth().currentUser?.uid)!) + "/" + "出費" + "/" + String(listcount)
        print(USERID)
        firebaseAPI.uploadToFirebase(path: "\(USERID)", write: ["Name" : name.text!,"Number":Int(kosu.text!)!,"Expense" : himoku,"Nowmoney":saihu,"NowExpence": exp,"total":kingaku,"Day":date!.timeIntervalSinceReferenceDate,"TIME":Date().timeIntervalSinceReferenceDate])
        let USERID2:String = String((Auth.auth().currentUser?.uid)!) + "/" + "EXP" + "/" + EXP
            print(USERID2)
        firebaseAPI.uploadToFirebase(path: "\(USERID2)", write: [ "NowExpence":exp,"Day":date!.timeIntervalSinceReferenceDate,"TIME":Date().timeIntervalSinceReferenceDate])
          let USERID3:String = String((Auth.auth().currentUser?.uid)!) + "/" + "NOWMONEY" + "/" + "NM"
                    print(USERID3)
                firebaseAPI.uploadToFirebase(path: "\(USERID3)", write: [ "Nowmoney":saihu,"Day":date!.timeIntervalSinceReferenceDate,"TIME":Date().timeIntervalSinceReferenceDate])
        let newItem = MainItem()
        newItem.Name = name.text!
        newItem.Number = Int(kosu.text!)!
        newItem.Expense = himoku
        newItem.Nowmoney = saihu
        newItem.NowExpense = exp
        newItem.total =  kingaku
        newItem.Day =  date!
        newItem.TIME = Date()
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
        let names :String = "名称" + String(name.text!) + "\n"
        let tanka2 :String = "単価" + String(tanka.text!) + "円\n"
        let kosuu2 :String = "個数" + kosuu + "\n"
        let kei :String = "小計" + goukeib
        let nitiji:String = "\n日時" + dateFormatter.string(from: date!)
  print("アラート")
        let title = "登録したよ！"
        let message = "登録されました！\n" + "登録されたデータ\n" + names + tanka2 + kosuu2 + kei + nitiji
       let okText = "ok"
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okayButton = UIAlertAction(title: okText, style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okayButton)
        
        present(alert, animated: true, completion: nil)
        
        
        
        self.name.text = ""
        self.kosu.text = ""
        self.tanka.text = ""
    
        self.view.endEditing(true)
        
        print("owari")
        
        
    }
    // UIPickerViewの列の数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // UIPickerViewの行数、リストの数
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }
    
    // UIPickerViewの最初の表示
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        
        return dataList[row]
    }
    // UIPickerViewのRowが選択された時の挙動
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        himoku = dataList[row]
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //
    //         self.view.endEditing(true)
    //     }
    
    
    
    
    /*
     MARK: - Navigation
     
     In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     Get the new view controller using segue.destination.
     Pass the selected object to the new view controller.
     }
     */
}

