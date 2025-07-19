//
//  SUBItem.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/11/15.
//  Copyright © 2019 塙　詠斗. All rights reserved.
//
// © eightman 2005-2025. Furin-lab All rights reserved.
// Operation: 各費目の予算を保持するRealmモデル

import UIKit
import RealmSwift
import Foundation

/// 各費目ごとの予算を保存するRealmモデル
class SUBItem: Object {
    /// A費の予算
    @objc dynamic var A1: Int = 0
    /// B費の予算
    @objc dynamic var B1: Int = 0
    /// C費の予算
    @objc dynamic var C1: Int = 0
    /// D費の予算
    @objc dynamic var D1: Int = 0
    /// E費の予算
    @objc dynamic var E1: Int = 0
    /// F費の予算
    @objc dynamic var F1: Int = 0
    /// G費の予算
    @objc dynamic var G1: Int = 0
    /// H費の予算
    @objc dynamic var H1: Int = 0
    /// I費の予算
    @objc dynamic var I1: Int = 0

    /// A費の残額
    @objc dynamic var A2: Int = 0
    /// B費の残額
    @objc dynamic var B2: Int = 0
    /// C費の残額
    @objc dynamic var C2: Int = 0
    /// D費の残額
    @objc dynamic var D2: Int = 0
    /// E費の残額
    @objc dynamic var E2: Int = 0
    /// F費の残額
    @objc dynamic var F2: Int = 0
    /// G費の残額
    @objc dynamic var G2: Int = 0
    /// H費の残額
    @objc dynamic var H2: Int = 0
    /// I費の残額
    @objc dynamic var I2: Int = 0
    
    
    
}
