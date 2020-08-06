//
//  YearCollectionViewCell.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/31/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class YearCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        containerView.layer.cornerRadius = containerView.frame.height/2.0
    }
    
    override var isSelected: Bool {
        didSet {
//            containerView.backgroundColor = isSelected ? UIColor(rgb: 0x63b946) : .clear
//            lblYear.textColor = isSelected ? .white : .white
        }
    }
}
