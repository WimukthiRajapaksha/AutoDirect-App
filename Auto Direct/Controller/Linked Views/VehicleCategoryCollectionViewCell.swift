//
//  VehicleCategoryCollectionViewCell.swift
//  Auto Direct
//
//  Created by User on 4/18/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class VehicleCategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblItemName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = containerView.frame.height/2.2
    }
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? UIColor(rgb: 0x63b946) : .clear
        }
    }

}
