//
//  SixthModelDetailsTableViewCell.swift
//  Auto Direct
//
//  Created by User on 4/19/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class SixthModelDetailsTableViewCell: UITableViewCell {
    @IBOutlet var viewMore: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewMore.layer.cornerRadius = 22
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
