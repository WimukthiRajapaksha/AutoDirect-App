//
//  ForthTableViewCell.swift
//  Auto Direct
//
//  Created by User on 4/20/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import StepIndicator

class ForthReserveTableViewCell: UITableViewCell {
    @IBOutlet var progressBarView: StepIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
