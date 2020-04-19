//
//  SidebarItemTableViewHeaderCell.swift
//  Auto Direct
//
//  Created by User on 4/15/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class SidebarItemTableViewHeaderCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblHeader: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
