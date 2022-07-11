//
//  MonthViewController.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/11/18.
//  Copyright © 2019 塙　詠斗. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class MonthViewController: UIViewController{
    @IBOutlet var kurikosi:UILabel!
    @IBOutlet var nyuukin:UILabel!
    @IBOutlet var TMsiyougaku:UILabel!
    @IBOutlet var TMsiyougaku2:UILabel!
    @IBOutlet var matome:UILabel!
    var itemList: Results<MainItem>!
    var itemLists: [MainItem] = [MainItem]()
    let realm = try! Realm()
    var ATotal: Double = 0
    var BTotal: Double = 0
    var CTotal: Double = 0
    var DTotal: Double = 0
    var ETotal: Double = 0
    var FTotal: Double = 0
    var GTotal: Double = 0
    var HTotal: Double = 0
    var ITotal: Double = 0
    var Kurikosi:Int = 0
    var Nyuukin:Int = 0
    var TMMsiyougaku:Int = 0
    
    var Matome:Int = 0
    @IBOutlet weak var chartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        TMMsiyougaku = 0
        Matome = 0
        TMMsiyougaku = 0
        Nyuukin = 0
        Kurikosi = 0
        ATotal = 0
        BTotal = 0
        CTotal = 0
        DTotal = 0
        ETotal = 0
        FTotal = 0
        GTotal = 0
        HTotal = 0
        ITotal = 0
        super.viewWillAppear(animated)
        let results = realm.objects(MainItem.self)
        print(results)
        //dataが今月のもののみ適用する
    
        for data in results {
            let time = data.Day
            if Calendar.current.isDate(time, inSameMonthAs: Date()) {
                // お金の取得
                //A費ならAtotalに追加 -> Iまでやる
                let himoku = data.Expense
                if himoku ==  "　"{}else{
                    let money = data.total
                    TMMsiyougaku += money
                }
                switch himoku {
                case "A費":
                    let money = data.total
                    ATotal += Double(money)
                case "B費":
                    let money = data.total
                    BTotal += Double(money)
                case "C費":
                    let money = data.total
                    CTotal += Double(money)
                case "D費":
                    let money = data.total
                    DTotal += Double(money)
                case "E費":
                    let money = data.total
                    ETotal += Double(money)
                case "F費":
                    let money = data.total
                    FTotal += Double(money)
                case"G費":
                    let money = data.total
                    GTotal += Double(money)
                case "H費":
                    let money = data.total
                    HTotal += Double(money)
                case "I費":
                    let money = data.total
                    ITotal += Double(money)
                case "　":
                    let money = data.total
                    Nyuukin = Int(money)
                    
                default: // defaultは必須
                    print("全部違ったよ")
                    break
                }
                var rect = view.bounds
                rect.origin.y += 10
                rect.size.height -= 1
                
                
                let entries = [
                    PieChartDataEntry(value: ATotal, label: "A費"),
                    PieChartDataEntry(value: BTotal, label: "B費"),
                    PieChartDataEntry(value: CTotal, label: "C費"),
                    PieChartDataEntry(value: DTotal, label: "D費"),
                    PieChartDataEntry(value:ETotal, label: "E費"),
                    PieChartDataEntry(value: FTotal, label: "F費"),
                    PieChartDataEntry(value: GTotal, label: "G費"),
                    PieChartDataEntry(value: HTotal, label: "H費"),
                    PieChartDataEntry(value: ITotal, label: "I費")
                ]
                let set = PieChartDataSet(entries: entries, label: "今月の内訳")
                chartView.data = PieChartData(dataSet: set)
                view.addSubview(chartView)
                
                
            }
            
            Matome = (Kurikosi + Nyuukin) - TMMsiyougaku
            kurikosi.text! = String(Kurikosi)
            nyuukin.text! = String(Nyuukin)
            TMsiyougaku.text = String(TMMsiyougaku)
            TMsiyougaku2.text = String(TMMsiyougaku)
            matome.text = String(Matome)
        }
        
        
        
        //AからIをChartsに追加
        
    }
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */



