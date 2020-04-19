//
//  SidebarItemTableViewCell.swift
//  Auto Direct
//
//  Created by User on 4/5/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class SidebarItemTableViewCell: UITableViewCell {
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
