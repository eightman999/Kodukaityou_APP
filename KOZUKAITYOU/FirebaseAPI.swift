//
//  FirebaseAPI.swift
//  PerfectFirebase-API
//
//  Created by Kento Katsumata on 2018/10/22.
//  Copyright © 2018 Kento Katsumata. All rights reserved.
//
// © eightman 2005-2025. Furin-lab All rights reserved.
// Operation: Firebase Realtime Databaseへのアクセス処理

import Foundation
import FirebaseDatabase

/// Firebase Realtime Database への簡易アクセス用構造体
struct FirebaseAPI {
    /// ルート参照
    private var ref: DatabaseReference!
    /// ハンドラ保持用（未使用）
    private var handler: DatabaseHandle!
    
    /// インスタンス生成時に Database 参照を取得
    init() {
        self.ref = Database.database().reference()
    }
    
    /// 指定パスにデータを書き込む
    func uploadToFirebase(path: String, write: [String:Any]) {
        ref.child(path).updateChildValues(write)
    }
    
    /// 指定パスからデータを読み込む
    func readFromFirebase(path: String, completionHandler: @escaping (Any?) -> Void) {
        let path = ref.child(path)
        path.observeSingleEvent(of: .value) { snapshot in
            if let data = snapshot.value {
                completionHandler(data)
            } else {
                completionHandler("error")
            }
        }
    }
}
