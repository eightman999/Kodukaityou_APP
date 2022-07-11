//
//  ListTableViewCell.swift
//  KOZUKAITYOU
//
//  Created by 塙　詠斗 on 2019/11/09.
//  Copyright © 2019 塙　詠斗. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    //----------@IBOutlet-----------
    
    @IBOutlet var day: UILabel!//
    @IBOutlet var kingaku: UILabel!//
    @IBOutlet var kosuu: UILabel!//
    @IBOutlet var himokuzandaka: UILabel!
    @IBOutlet var himoku: UILabel!//
    @IBOutlet var name: UILabel!//
    @IBOutlet var saihu: UILabel!//
    //ーーーーーDictionary呼び出しーーーーーー
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
