//
//  MainItem.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/09/29.
//  Copyright © 2019 塙　詠斗. All rights reserved.
//



import RealmSwift
import Foundation
class MainItem: Object {
    
    @objc dynamic var Name:String = ""//名前//
    @objc dynamic var Number:Int = 0//個数//
    @objc dynamic var Expense = ""//費目//
    @objc dynamic var Nowmoney:Int = 0//財布残高//
    @objc dynamic var NowExpense:Int = 0//予算座布団//
    @objc dynamic var total:Int = 0//トータル//
    @objc dynamic var Day:Date = Date()//日時//
    @objc dynamic var  TIME :Date = Date()//TIME//
    
    
    
    
}
