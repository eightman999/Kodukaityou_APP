//
//  MainItem.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/09/29.
//  Copyright © 2019 塙　詠斗. All rights reserved.
//
// © eightman 2005-2025. Furin-lab All rights reserved.
// Operation: 出費を表すRealmモデル



import RealmSwift
import Foundation

/// 1件の出費情報を表すRealmモデル
class MainItem: Object {
    /// 名称
    @objc dynamic var Name: String = ""
    /// 個数
    @objc dynamic var Number: Int = 0
    /// 費目
    @objc dynamic var Expense = ""
    /// 入力後の財布残高
    @objc dynamic var Nowmoney: Int = 0
    /// 入力後の残予算
    @objc dynamic var NowExpense: Int = 0
    /// 小計
    @objc dynamic var total: Int = 0
    /// 日時
    @objc dynamic var Day: Date = Date()
    /// 登録時刻
    @objc dynamic var TIME: Date = Date()
    /// 年
    @objc dynamic var year: Int = 0
    
    
    
    
}
