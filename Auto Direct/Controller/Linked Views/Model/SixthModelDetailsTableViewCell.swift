//
//  SixthModelDetailsTableViewCell.swift
//  Auto Direct
//
//  Created by User on 4/19/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class SixthModelDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var btnMore: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnMore.layer.borderWidth = 1
        btnMore.layer.borderColor = UIColor(rgb: 0x464B57).cgColor
        btnMore.layer.cornerRadius = 25
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
