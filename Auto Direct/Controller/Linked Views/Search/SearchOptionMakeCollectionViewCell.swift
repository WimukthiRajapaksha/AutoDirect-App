//
//  SearchOptionMakeCollectionViewCell.swift
//  Auto Direct
//
//  Created by User on 4/27/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class SearchOptionMakeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblMake: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = containerView.frame.height/2.0
    }
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? UIColor(rgb: 0x63b946) : .clear
            lblMake.textColor = isSelected ? .white : .white
        }
    }
}
