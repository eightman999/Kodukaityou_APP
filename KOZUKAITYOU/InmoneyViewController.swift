//
//  InmoneyViewController.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/08/23.
//  Copyright © 2019 塙　詠斗. All rights reserved.
//
// © eightman 2005-2025. Furin-lab All rights reserved.
// Operation: 入金額を入力し保存する画面

import UIKit
import RealmSwift

class InmoneyViewController: UIViewController {
    @IBOutlet var inmoney: UITextField!
    @IBOutlet var Tuki: UITextField!
    @IBOutlet var Niti: UITextField!
    @IBOutlet var Save: UIButton!

    var exp: Int = 0
    var niti: Int = 0
    var tuki: Int = 0
    var saihu: Int = 0
    let realm = try! Realm()
    var kd: [Dictionary<String, Any>] = []
    let saveData = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
    }

    @IBAction func PUSHSAVE(){
        if Tuki.text?.isEmpty == true {
            let alert = UIAlertController(title: localized(japanese: "警告！", english: "Warning!"),
                                          message: localized(japanese: "月が入力されていません！", english: "Month is missing!"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if Niti.text?.isEmpty == true {
            let alert = UIAlertController(title: localized(japanese: "警告！", english: "Warning!"),
                                          message: localized(japanese: "日付が入力されていません！", english: "Day is missing!"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }

        guard let nitiValue = Int(Niti.text ?? ""), let tukiValue = Int(Tuki.text ?? "") else {
            let alert = UIAlertController(title: localized(japanese: "警告！", english: "Warning!"),
                                          message: localized(japanese: "有効な数値を入力してください！", english: "Please enter valid numbers!"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }
        niti = nitiValue
        tuki = tukiValue

        if niti > 31 {
            let alert = UIAlertController(title: localized(japanese: "警告！", english: "Warning!"),
                                          message: localized(japanese: "日付が存在しません！", english: "Invalid day!"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if tuki > 12{
            let alert = UIAlertController(title: localized(japanese: "警告！", english: "Warning!"),
                                          message: localized(japanese: "そんな月はねえ！", english: "Invalid month!"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }

        var myDateComponents = DateComponents()
        myDateComponents.year = 2019
        myDateComponents.month = tuki
        myDateComponents.day = niti
        myDateComponents.timeZone = Calendar.current.timeZone

        guard let date = Calendar.current.date(from: myDateComponents) else {
            let alert = UIAlertController(title: localized(japanese: "警告！", english: "Warning!"),
                                          message: localized(japanese: "無効な日付です！", english: "Invalid date!"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }

        guard let formatString = DateFormatter.dateFormat(fromTemplate: "MMMdd", options: 0, locale: Locale.current) else {
            let alert = UIAlertController(title: localized(japanese: "エラー", english: "Error"),
                                          message: localized(japanese: "日付フォーマットエラー", english: "Date format error"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatString
        dateFormatter.string(from: date)

        guard let inmoneyValue = Int(inmoney.text ?? "") else {
            let alert = UIAlertController(title: localized(japanese: "警告！", english: "Warning!"),
                                          message: localized(japanese: "入金額に有効な数値を入力してください！", english: "Please enter a valid amount!"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }

        let results = realm.objects(MainItem.self)
        for dataa in results {
            let money = inmoneyValue
            saihu = dataa.Nowmoney + money
        }

        var bag: Int = 0
        for data in kd {
            bag = data["saihu"] as? Int ?? 0
        }
        saihu = bag + inmoneyValue

        // Realmのみに保存
        let newItem = MainItem()
        newItem.Name = "入金"
        newItem.Number = Int(1)
        newItem.Expense = "　"
        newItem.Nowmoney = saihu
        newItem.total = inmoneyValue
        newItem.Day = date

        do{
            let realm = try Realm()
            try realm.write({ () -> Void in
                realm.add(newItem)
            })
        }catch{
        }

        let alert = UIAlertController(
            title: "入金しましたよ！！",
            message: "入金されました！\n" + "金額" + String(inmoneyValue) + "円\n" + "日付" + dateFormatter.string(from: date),
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: {
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
}
