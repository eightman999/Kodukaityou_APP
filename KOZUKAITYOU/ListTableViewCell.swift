//
//  ListTableViewCell.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/07/26.
//  Copyright © 2019 Sunlight.library All rights reserved.
//

import UIKit
import CoreData
class ListTableViewCell: UITableViewCell {
    //----------@IBOutlet--------------------↓
    
    @IBOutlet var day: UILabel!
    @IBOutlet var kingaku: UILabel!
    @IBOutlet var kosuu: UILabel!
    @IBOutlet var himokuzandaka: UILabel!
    @IBOutlet var himoku: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var saihu: UILabel!
    //ーーーーーDictionary呼び出しーーーーーー↓
    var kd: [Dictionary<String, String>] = []
    let saveData = UserDefaults.standard
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//----------------------------------------------------------------
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
