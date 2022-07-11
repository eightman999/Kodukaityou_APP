//
//  FirebaseAPI.swift
//  PerfectFirebase-API
//
//  Created by Kento Katsumata on 2018/10/22.
//  Copyright © 2018 Kento Katsumata. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct FirebaseAPI {
    private var ref: DatabaseReference!
    private var handler:DatabaseHandle!
    
    init() {
        self.ref = Database.database().reference()
    }
    
    func uploadToFirebase(path:String, write:[String:Any]){
        ref.child(path).updateChildValues(write)
    }
    
    func readFromFirebase(path:String,completionHandler:@escaping (Any?)->Void){
        
        let path = ref.child(path)
        path.observeSingleEvent(of: .value) { (Snapshot) in
            if let data = Snapshot.value{
                completionHandler(data)
            }else{
                completionHandler("error")
            }
        }
    }
}
