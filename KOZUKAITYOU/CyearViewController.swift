//
//  CyearViewController.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2020/04/06.
//  Copyright © 2020 塙　詠斗. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class CyearViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //----------@IBOutlet-----------
    @IBOutlet var week: UILabel!
    @IBOutlet var month: UILabel!
    @IBOutlet var switch_month: UIButton!
    @IBOutlet var switch_years: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var itemList: Results<MainItem>!
    var itemLists: [MainItem] = [MainItem]()
    let realm = try! Realm()
    var token: NotificationToken!
    //    var kd: [Dictionary<String, Any>] = []
    //    let saveData = UserDefaults.standard
    var k__week: Int = 0//前週比
    var k__month: Int = 0//前月比
    var ch1: Bool = false//週切り替え判定
    var ch2: Bool = false//月切り替え判定
    var keisan1: String = ""//計算用変数１
    var keisan2: UInt16 = 0//計算用変数２
    var calendar = Calendar(identifier: .gregorian)//カレンダー呼び出し
    var thisMonthMoney: Int = 0 // 今月の出費
    var thisWeeksMoney: Int = 0//今週の出費
    var WeekP:Double = 0.0
    var MonthP:Double = 0.0
    var lastMonthmoney:Int = 0
    var lastWeekmoney:Int = 0
    var First_time:Int = 0
    var check: Date = Date()
    var C:Bool = true
    //=============================初回チェック用============↓
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //  @objc dynamic var Name = ""//名前//
    //@objc dynamic var Number:Int = 0//個数//
    //@objc dynamic var Expense = ""//費目//
    //@objc dynamic var Nowmoney:Int = 0//財布残高//
    //@objc dynamic var NowExpense:Int = 0//予算座布団//
    //@objc dynamic var total:Int = 0//トータル//
    //@objc dynamic var Day = ""//日時//
    //@objc dynamic var  TIME :Date = Date()//TIME//
    
    //======================週の出費/月の出費/初回チェック/設定===========↓
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "ListTableViewCell2", bundle: nil), forCellReuseIdentifier: "ListTableViewCell2")
        
        //-----------テキスト設定-------------↓
        month.text = "\(thisMonthMoney)" + "円"
        week.text = "\(thisWeeksMoney)" + "円"
        
        // Do any additional setup after loading the view.
        //---TBV----
        
        tableView.delegate = self
        tableView.dataSource = self
        do{
            itemList = realm.objects(MainItem.self).sorted(byKeyPath: "Day", ascending: false)
            
        } catch{
        }
        tableView.reloadData()
        // tableViewにカスタムセルを登録
        tableView.register(UINib(nibName: "ListTableViewCell2", bundle: nil), forCellReuseIdentifier: "ListTableViewCell2")
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell2", for: indexPath ) as! ListTableViewCell
        let dateFormatter = DateFormatter()
        guard let formatString = DateFormatter.dateFormat(fromTemplate: "MMM", options: 0, locale: Locale.current) else { fatalError() }
        dateFormatter.dateFormat = formatString
        // カスタムセル内のプロパティ設定
        cell.name.text = itemList[indexPath.row].Name
        cell.day.text = dateFormatter.string(from: (itemList[indexPath.row].Day))
        cell.kingaku.text = String(itemList[indexPath.row].total)
        cell.kosuu.text = String(itemList[indexPath.row].Number)
        cell.himoku.text = itemList[indexPath.row].Expense
        cell.saihu.text = String(itemList[indexPath.row].Nowmoney)
        cell.himokuzandaka.text = String(itemList[indexPath.row].NowExpense)
        return cell
    }
    
    //========================viewWillAppear====================↓
    override func viewWillAppear(_ animated: Bool) {
        thisMonthMoney = 0
        thisWeeksMoney = 0
        lastWeekmoney = 0
        lastMonthmoney = 0
        
        super.viewWillAppear(animated)
        let results = realm.objects(MainItem.self)
        print(results)
        
        tableView.reloadData()
        
        for data in results {
            let himoku = data.Expense
            let time = data.Day
            if himoku ==  "　"{}else{
                if Calendar.current.isDate(time, inSameMonthAs: Date()) {
                    // お金の取得
                    let money = data.total
                    thisMonthMoney += money
                }
            }
        }
        //        ----------------------Week-----------------↓
        for data2 in results {
            let himoku = data2.Expense
            let  time2 = data2.Day
            if himoku ==  "　"{}else{
                if Calendar.current.isDate(time2, inSameWeekAs: Date()){
                    //お金の取得2
                    let money = data2.total
                    thisWeeksMoney += money
                    
                }
            }
        }
        for dataa in results {
            let time = dataa.Day
            let himoku = dataa.Expense
            if himoku ==  "　"{}else{
                if Calendar.current.isMonth(time, inSameMonthAs: Date()) {
                    // お金の取得
                    let money = dataa.total
                    lastMonthmoney += money
                    k__month = thisMonthMoney - lastMonthmoney
                    MonthP = Double(thisMonthMoney / lastMonthmoney  * -100)
                    print(lastMonthmoney)
                } else {
                    k__month = thisMonthMoney
                    MonthP = 1000
                }
            }
        }
        //        ----------------------Week-----------------↓
        for dataa2 in results {
            let  time2 = dataa2.Day
            let himoku = dataa2.Expense
            if himoku ==  "　"{}else{
                if Calendar.current.isweek(time2, inSameWeekAs: Date()){
                    //お金の取得2
                    let money = dataa2.total
                    lastWeekmoney += money
                    k__week = thisWeeksMoney -  lastWeekmoney
                    WeekP = Double(thisWeeksMoney / lastWeekmoney * -100)
                    print(lastWeekmoney)
                }else{
                    k__week = thisWeeksMoney
                    WeekP = 1000
                    
                    
                }
                pushM()
                pushY()
            }
        }
        print("リロードデータ！")
    }
    
    
    //===============@IBAction====週・切り替え=========↓
    @IBAction func pushM(){
        if ch1 == false{
            
            let str = "\(k__week)" + "円        "  +  "\(WeekP)"  + "%"
            
            switch_month.setTitle("前週比", for: .normal)
            week.text = str
            ch1 = true
        }else{
            
            switch_month.setTitle("今週の出費", for: .normal)
            week.text = "\(thisWeeksMoney)" + "円"
            
            ch1 = false
        }
    }
    
    //==========@IBAction====月・切り替え=====↓
    @IBAction func pushY(){
        if ch2 == false{
            
            let str2 = "\(k__month)" + "円        "  +  "\(MonthP)"  + "%"
            switch_years.setTitle("前月比", for: .normal)
            month.text = str2
            
            ch2 = true
        }else{
            
            switch_years.setTitle("今月の出費", for: .normal)
            month.text = "\(thisMonthMoney)" + "円"
            
            ch2 = false
        }
        //   print("kdは",allData)
        
        tableView.reloadData()
        print("リロードデータ！")
        
    }
}
