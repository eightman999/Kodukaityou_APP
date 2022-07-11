//
//  mainViewController.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/07/26.
//  Copyright © 2019 Sunlight.library. All rights reserved.
//

import UIKit
import Charts
import RealmSwift
class mainViewController: UIViewController, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    //----------@IBOutlet-----------
    @IBOutlet var week: UILabel!
    @IBOutlet var month: UILabel!
    @IBOutlet var switch_month: UIButton!
    @IBOutlet var switch_years: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var chartView: PieChartView!
    var realm: Realm!
   
    var token: NotificationToken!


    
    
    var kd: [Dictionary<String, Any>] = []
    let saveData = UserDefaults.standard
    var k__week: Int = 0//前週比
    var k__month: Int = 0//前月比
    var ch1: Bool = false//週切り替え判定
    var ch2: Bool = false//月切り替え判定
    var keisan1: String = ""//計算用変数１
    var keisan2: UInt16 = 0//計算用変数２
    var calendar = Calendar(identifier: .gregorian)//カレンダー呼び出し
    var thisMonthMoney: Int = 0 // 今月の出費
    var thisWeeksMoney: Int = 0//今週の出費
    var First_time:Int = 0
    var check: Date = Date()
//=============================初回チェック用============↓
    func getDateBeforeOrAfterSomeWeek(week:Double) -> Date {
        
        let now = Date()
        var resultDate:Date
        
        if week > 0 {
            resultDate = Date(timeInterval: 604800*week, since: now as Date)
        } else {
            resultDate = Date(timeInterval: -604800*fabs(week), since: now as Date)
        }
        
        return resultDate
        
    }
//======================週の出費/月の出費/初回チェック/設定===========↓
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //---------------設定-----------------------↓
        tableView.dataSource = self
        if saveData.array(forKey: "WORD") != nil {
            kd = saveData.array(forKey: "WORD") as! [Dictionary<String,Any>]
            kd.reverse()
        }
        tableView.reloadData()
        //-----------------month---------------------↓
        for data in kd {
            let time = data["TIME"] as! Date
            
            
            if Calendar.current.isDate(time, inSameMonthAs: Date()){
                // お金の取得
                let money = Int((data["kingaku"] as! String).prefix((data["kingaku"] as! String).count - 1))
                thisMonthMoney += money!
                
        //---------------Charts-----------------
             super.viewDidLoad()
                     
                     var rect = view.bounds
                     rect.origin.y += 20
                     rect.size.height -= 20
                     let entries = [
                         PieChartDataEntry(value: 10, label: "A"),
                         PieChartDataEntry(value: 20, label: "B"),
                         PieChartDataEntry(value: 30, label: "C"),
                         PieChartDataEntry(value: 40, label: "D"),
                         PieChartDataEntry(value: 50, label: "E")
                     ]
                let set = PieChartDataSet(entries: entries, label: "Data")
                     chartView.data = PieChartData(dataSet: set)
                     view.addSubview(chartView)
            }
        }
        //----------------------Week-----------------↓
        for data2 in kd {
            let  time2 = data2["TIME"] as! Date
            if Calendar.current.isDate(time2, inSameWeekAs: Date()){
                //お金の取得2
                let money = Int((data2["kingaku"] as! String).prefix((data2["kingaku"] as! String).count - 1))
                thisWeeksMoney += money!
                
            }
       
        }
        //------------------Firsttime?--------------------------↓
//        for data3 in kd {
//            //let Datedic: [String: Any] = ["First_time?":First_time]
//            First_time = data3["First_time?"] as! Int
//        }
//        
//        print(First_time)
//        
//        
//        if First_time == nil{
//           check = (getDateBeforeOrAfterSomeWeek(week: -200)) // 200週間前
//            let Datedic: [String: Any] = ["SAVE-DAY":check]
//            First_time + 100
//            let Datedic: [String: Any] = ["First_time?":First_time]
//
//        }
        
        //-----------テキスト設定-------------↓
        month.text = "\(thisMonthMoney)"
        week.text = "\(thisWeeksMoney)"
        
        // Do any additional setup after loading the view.
        
        //-------K'odukaityou-D'ata中身確認-------------↓
        print("kdは",kd)
    }
 //========================viewWillAppear====================↓
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        print("リロードデータ！")
        
    }
    
    //===============@IBAction====週・切り替え=========↓
    @IBAction func pushM(){
        if ch1 == false{
            
        let str = "\(k__week)"
            
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
            
        let str2 = "\(k__month)"
        switch_years.setTitle("前月比", for: .normal)
        month.text = str2
            
            ch2 = true
        }else{
            
            switch_years.setTitle("今月の出費", for: .normal)
            month.text = "\(thisMonthMoney)" + "円"
            
            ch2 = false
        }
    
    }
    //_____________________tableView_________↓
   
    
    override func awakeFromNib() {
      super.awakeFromNib()

      // RealmのTodoリストを取得し，更新を監視
      realm = try! Realm()
      mainItem = realm.objects(MainItem.self)
      token = mainItem.observe { [weak self] _ in
        self?.reload()
      }
    }

    func reload() {
      tableView.reloadData()
    }
}

//-----------extention-----------Date/Calendar!-------------↓
extension Date {
    
    //・・・・・・・・・TIMEZONE->localeにする・・・・・・・・↓
    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        calendar.locale   = .current
        return calendar
    }
}

extension Calendar {
    
    //==================月の判定用設定-------------------↓
    func isDate(_ date1:Date, inSameMonthAs date2:Date) -> Bool {
        return isDate(date1, equalTo: date2, toGranularity: .month)
    }
    
    //===================週の判定用設定-------------------↓
    func isDate(_ date1:Date, inSameWeekAs date2:Date) -> Bool {
        return isDate(date1, equalTo: date2, toGranularity: .weekOfYear)
    }
}
//=====================charts-------^^
   

