//
//  TendingCollectionViewCell.swift
//  Auto Direct
//
//  Created by User on 4/18/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblItemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.borderColor = UIColor(rgb: 0x63b946).cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = containerView.frame.size.height/3.0
    }
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? UIColor(rgb: 0x63b946) : .clear
            lblItemName.textColor = isSelected ? .black : UIColor(rgb: 0x63b946)
        }
    }

}
