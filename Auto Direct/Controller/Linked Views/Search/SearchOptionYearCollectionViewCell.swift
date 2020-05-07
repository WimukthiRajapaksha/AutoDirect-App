//
//  SearchOptionYearCollectionViewCell.swift
//  Auto Direct
//
//  Created by User on 4/27/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class SearchOptionYearCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()        
        containerView.layer.cornerRadius = containerView.frame.height/2.0
    }
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? UIColor(rgb: 0x63b946) : .clear
            lblYear.textColor = isSelected ? .white : .white
        }
    }
}
