//
//  SecondTableViewCell.swift
//  Auto Direct
//
//  Created by User on 4/20/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class SecondReserveTableViewCell: UITableViewCell {
    @IBOutlet weak var lblAdvancedPaymentAmount: UILabel!
    @IBOutlet weak var lblStockNo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
