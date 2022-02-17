//
//  MyTableViewCell.swift
//  dynamic_tableview_tutorial
//
//  Created by 김병엽 on 2022/02/17.
//

import Foundation
import UIKit

class MyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userProfileImg: UIImageView!
    
    @IBOutlet weak var userContentLabel: UILabel!
    
    // 쎌이 랜더링 될때
    override func awakeFromNib() {
        super.awakeFromNib()
        
        print("MyTableViewCell - awakeFromNib() called()")
        
        userProfileImg.layer.cornerRadius = userProfileImg.frame.height / 2
    }
    
}
