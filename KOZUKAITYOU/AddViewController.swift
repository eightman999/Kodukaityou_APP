//
//  AddViewController.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/07/26.
//  Copyright © 2019 塙　詠斗. All rights reserved.
//
// © eightman 2005-2025. Furin-lab All rights reserved.
// Operation: 入力された買い物情報を保存する画面

import UIKit
import RealmSwift
import CoreData
import Firebase

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    // MARK: - IBOutlet
    /// 費目選択用のピッカー
    @IBOutlet var pickerView: UIPickerView!
    /// 日付入力用のピッカー
    @IBOutlet var pickerView2: UIDatePicker!
    /// 購入した物の名称入力欄
    @IBOutlet var name: UITextField!
    /// 個数入力欄
    @IBOutlet var kosu: UITextField!
    /// 単価入力欄
    @IBOutlet var tanka: UITextField!
    /// 保存ボタン
    @IBOutlet var Save: UIButton!

    // MARK: - Realm
    /// Realmインスタンス
    let realm = try! Realm()

    // MARK: - 入力値保持用プロパティ
    /// リスト登録数
    var listcount: Int = 0
    /// 画面上部の日付入力用ピッカー
    var datePicker: UIDatePicker = UIDatePicker()
    /// 日付文字列
    var day: String = "0"
    /// 個数文字列
    var kosuu: String = "0"
    /// 小計文字列
    var goukeib: String = "0"
    /// 日
    var niti: Int = 0
    /// 月
    var tuki: Int = 0
    /// 年
    var tosi: Int = 0
    /// 金額計算用
    var kingaku: Int = 0
    /// 金額文字列
    var kingaku1: String = "0"
    /// 合計金額
    var goukei: Int = 0
    /// 単価
    var tanka1: Int = 0
    /// 残予算
    var exp: Int = 0
    /// 残予算登録先識別子
    var EXP: String = ""
    /// 選択された費目
    var himoku: String = "A費"
    /// 財布残高
    var saihu: Int = 0
    

    //---PickerView----設定-----↓
    /// PickerViewに表示する費目リスト
    let dataList = ["A費", "B費", "C費", "D費", "E費", "F費", "G費", "H費", "I費"]

    // MARK: - LifeCycle
    /// Firebase通信を行うヘルパー
    var firebaseAPI = FirebaseAPI()

    /// 画面表示後の初期設定
    override func viewDidLoad() {
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current

        // キーボードに表示する完了ボタン
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done1))
        toolbar.setItems([spacelItem, doneItem], animated: true)

        pickerView.delegate = self
        pickerView.dataSource = self
    }

    // MARK: - Picker Done Button
    /// 日付ピッカーの完了ボタンタップ時処理
    @objc func done1() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
    }

    // MARK: - TextField Done Button
    /// キーボードの完了ボタンタップ時処理（未使用）
    @objc func done() {
        let formatter = DateFormatter()
    }

    // MARK: - 保存処理
    /// 入力内容をRealmとFirebaseに保存
    @IBAction func saveWorld(_ sender: Any){
        // 入力チェック
        // 個数が未入力の場合は警告を表示
        if kosu.text?.isEmpty == true {
            let alert = UIAlertController(title: localized(japanese: "警告！", english: "Warning!"),
                                          message: localized(japanese: "個数が入力されていません！",
                                                                english: "Count is missing!"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        // 単価が未入力の場合は警告を表示
        }else if tanka.text?.isEmpty == true{
            let alert = UIAlertController(title: localized(japanese: "警告！", english: "Warning!"),
                                          message: localized(japanese: "単価が入力されていません！",
                                                                english: "Unit price is missing!"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        // 名称が未入力の場合は警告を表示
        }else if name.text?.isEmpty == true {
            let alert = UIAlertController(title: localized(japanese: "警告！", english: "Warning!"),
                                          message: localized(japanese: "名称が入力されていません！",
                                                                english: "Name is missing!"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }
        // 個数テキストを加工
        kosuu = kosu.text! + "個"

        // ==== 日付情報の生成 ====
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
        // 表示用フォーマット作成
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatString
        print(saihu)
        print(kingaku)
        dateFormatter.string(from: date!)
        
        print("処理１")
        // 金額計算
        kingaku = Int(kosu.text!)! * Int(tanka.text!)!
        // 現在の残高を取得し更新
        let results = realm.objects(MainItem.self)
        for dataa in results {
            let money = kingaku
            saihu = dataa.Nowmoney - money
        }

        // 各費目の残予算を更新
        let results2 = realm.objects(SUBItem.self)
        for data in results2{
            let himoku2 = himoku
            // 選択された費目ごとに残高を更新
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
                // Firebaseへデータを保存
        let USERID: String = String((Auth.auth().currentUser?.uid)!) + "/" + "出費" + "/" + String(listcount)
        firebaseAPI.uploadToFirebase(path: "\(USERID)", write: [
            "Name": name.text!,
            "Number": Int(kosu.text!)!,
            "Expense": himoku,
            "Nowmoney": saihu,
            "NowExpence": exp,
            "total": kingaku,
            "Day": date!.timeIntervalSinceReferenceDate,
            "TIME": Date().timeIntervalSinceReferenceDate
        ])
        let USERID2: String = String((Auth.auth().currentUser?.uid)!) + "/" + "EXP" + "/" + EXP
        firebaseAPI.uploadToFirebase(path: "\(USERID2)", write: [ "NowExpence":exp,"Day":date!.timeIntervalSinceReferenceDate,"TIME":Date().timeIntervalSinceReferenceDate])
          let USERID3: String = String((Auth.auth().currentUser?.uid)!) + "/" + "NOWMONEY" + "/" + "NM"
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
        let nitiji:String = "\n" + localized(japanese: "日時", english: "Date") + dateFormatter.string(from: date!)
        print("アラート")
        let title = localized(japanese: "登録したよ！", english: "Saved!")
        let message = localized(japanese: "登録されました！\n登録されたデータ\n", english: "Saved!\nSaved data\n") + names + tanka2 + kosuu2 + kei + nitiji
        let okText = "OK"
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
    // MARK: - UIPickerViewDelegate
    /// ピッカーの列数を返す
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    /// ピッカーの行数を返す
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }

    /// ピッカーに表示する文字列
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {

        return dataList[row]
    }
    /// ピッカーで行が選択された際の処理
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        himoku = dataList[row]
    }
    /// メモリ不足警告時に呼ばれる
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 画面タップでキーボードを閉じたい場合のサンプル実装
    // override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    //     self.view.endEditing(true)
    // }
    
    
    
    
    /*
     MARK: - Navigation
     
     In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     Get the new view controller using segue.destination.
     Pass the selected object to the new view controller.
     }
     */
}

