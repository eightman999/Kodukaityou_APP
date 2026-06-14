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

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{

    // MARK: - IBOutlet
    @IBOutlet var pickerView: UIPickerView!
    @IBOutlet var pickerView2: UIDatePicker!
    @IBOutlet var name: UITextField!
    @IBOutlet var kosu: UITextField!
    @IBOutlet var tanka: UITextField!
    @IBOutlet var Save: UIButton!

    // MARK: - Realm
    let realm = try! Realm()

    // MARK: - 入力値保持用プロパティ
    var listcount: Int = 0
    var datePicker: UIDatePicker = UIDatePicker()
    var day: String = "0"
    var kosuu: String = "0"
    var goukeib: String = "0"
    var niti: Int = 0
    var tuki: Int = 0
    var tosi: Int = 0
    var kingaku: Int = 0
    var kingaku1: String = "0"
    var goukei: Int = 0
    var tanka1: Int = 0
    var exp: Int = 0
    var EXP: String = ""
    var himoku: String = "A費"
    var saihu: Int = 0

    let dataList = ["A費", "B費", "C費", "D費", "E費", "F費", "G費", "H費", "I費"]

    // MARK: - LifeCycle
    override func viewDidLoad() {
        datePicker.datePickerMode = UIDatePicker.Mode.date
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current

        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done1))
        toolbar.setItems([spacelItem, doneItem], animated: true)

        pickerView.delegate = self
        pickerView.dataSource = self

        applyModernUIStyles()
    }

    private func applyModernUIStyles() {
        applyModernStyleToTextField(name)
        applyModernStyleToTextField(kosu)
        applyModernStyleToTextField(tanka)
        applyPrimaryStyleToButton(Save)
        view.backgroundColor = .systemBackground
    }

    private func applyModernStyleToTextField(_ textField: UITextField?) {
        guard let textField = textField else { return }
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray4.cgColor
        textField.backgroundColor = .systemBackground
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: textField.frame.height))
        textField.rightViewMode = .always
        textField.font = .systemFont(ofSize: 16)
    }

    private func applyPrimaryStyleToButton(_ button: UIButton?) {
        guard let button = button else { return }
        button.layer.cornerRadius = 12
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.shadowOpacity = 0.1
        button.clipsToBounds = false
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
    }

    @objc func done1() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
    }

    @objc func done() {
        let formatter = DateFormatter()
    }

    // MARK: - 保存処理
    @IBAction func saveWorld(_ sender: Any){
        if kosu.text?.isEmpty == true {
            let alert = UIAlertController(title: localized(japanese: "警告！", english: "Warning!"),
                                          message: localized(japanese: "個数が入力されていません！", english: "Count is missing!"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if tanka.text?.isEmpty == true{
            let alert = UIAlertController(title: localized(japanese: "警告！", english: "Warning!"),
                                          message: localized(japanese: "単価が入力されていません！", english: "Unit price is missing!"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }else if name.text?.isEmpty == true {
            let alert = UIAlertController(title: localized(japanese: "警告！", english: "Warning!"),
                                          message: localized(japanese: "名称が入力されていません！", english: "Name is missing!"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }

        guard let kosuValue = Int(kosu.text ?? ""), let tankaValue = Int(tanka.text ?? "") else {
            let alert = UIAlertController(title: localized(japanese: "警告！", english: "Warning!"),
                                          message: localized(japanese: "個数と単価に有効な数値を入力してください！", english: "Please enter valid numbers for count and price!"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }

        kosuu = (kosu.text ?? "") + "個"

        let calendar = Calendar(identifier: .gregorian)
        let pickerDate = datePicker.date
        var myDateComponents = calendar.dateComponents([.year, .month, .day], from: pickerDate)
        myDateComponents.timeZone = Calendar.current.timeZone

        guard let date = Calendar.current.date(from: myDateComponents) else {
            let alert = UIAlertController(title: localized(japanese: "エラー", english: "Error"),
                                          message: localized(japanese: "無効な日付です", english: "Invalid date"),
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            self.view.endEditing(true)
            return
        }

        guard let formatString = DateFormatter.dateFormat(fromTemplate: "YYMMdd", options: 0, locale: Locale.current) else {
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

        kingaku = kosuValue * tankaValue

        let results = realm.objects(MainItem.self)
        for dataa in results {
            let money = kingaku
            saihu = dataa.Nowmoney - money
        }

        let results2 = realm.objects(SUBItem.self)
        for _ in results2{
            let himoku2 = himoku
            switch himoku2{
            case "A費":
                for data2 in results2 {
                    exp = data2.A2 - kingaku
                    EXP = "A"
                }
            case "B費":
                for data2 in results2 {
                    exp = data2.B2 - kingaku
                    EXP = "B"
                }
            case "C費":
                for data2 in results2 {
                    exp = data2.C2 - kingaku
                    EXP = "C"
                }
            case "D費":
                for data2 in results2 {
                    exp = data2.D2 - kingaku
                    EXP = "D"
                }
            case "E費":
                for data2 in results2 {
                    exp = data2.E2 - kingaku
                    EXP = "E"
                }
            case "F費":
                for data2 in results2 {
                    exp = data2.F2 - kingaku
                    EXP = "F"
                }
            case"G費":
                for data2 in results2 {
                    exp = data2.G2 - kingaku
                    EXP = "G"
                }
            case "H費":
                for data2 in results2 {
                    exp = data2.H2 - kingaku
                    EXP = "H"
                }
            case "I費":
                for data2 in results2 {
                    exp = data2.I2 - kingaku
                    EXP = "I"
                }
            case "　":
                print("----------------error-------------------")
            default:
                print("全部違ったよ")
                break
            }
        }

        // Realmのみに保存
        let newItem = MainItem()
        newItem.Name = name.text ?? ""
        newItem.Number = kosuValue
        newItem.Expense = himoku
        newItem.Nowmoney = saihu
        newItem.NowExpense = exp
        newItem.total = kingaku
        newItem.Day = date
        newItem.TIME = Date()

        do{
            let realm = try Realm()
            try realm.write({ () -> Void in
                realm.add(newItem)
            })
        }catch{
        }

        let names: String = "名称" + (name.text ?? "") + "\n"
        let tanka2: String = "単価" + String(tankaValue) + "円\n"
        let kosuu2: String = "個数" + kosuu + "\n"
        let kei: String = "小計" + goukeib
        let nitiji: String = "\n" + localized(japanese: "日時", english: "Date") + dateFormatter.string(from: date)

        let title = localized(japanese: "登録したよ！", english: "Saved!")
        let message = localized(japanese: "登録されました！\n登録されたデータ\n", english: "Saved!\nSaved data\n") + names + tanka2 + kosuu2 + kei + nitiji
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okayButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okayButton)
        present(alert, animated: true, completion: nil)

        self.name.text = ""
        self.kosu.text = ""
        self.tanka.text = ""
        self.view.endEditing(true)
    }

    // MARK: - UIPickerViewDelegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataList[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        himoku = dataList[row]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
