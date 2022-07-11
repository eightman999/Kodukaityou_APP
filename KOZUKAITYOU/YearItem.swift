//
//  YearItem.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2020/03/31.
//  Copyright © 2020 塙　詠斗. All rights reserved.
//

import Foundation
import RealmSwift
class YearItem: Object {
    @objc dynamic var Name:String = ""//名前//
    @objc dynamic var Number:Int = 0//個数//
    @objc dynamic var Expense = ""//費目//
    @objc dynamic var Nowmoney:Int = 0//財布残高//
    @objc dynamic var NowExpense:Int = 0//予算残高//
    @objc dynamic var total:Int = 0//トータル//
    @objc dynamic var Day:Date = Date()//日時//
    @objc dynamic var  TIME :Date = Date()//TIME//
    
    
    
    
}
