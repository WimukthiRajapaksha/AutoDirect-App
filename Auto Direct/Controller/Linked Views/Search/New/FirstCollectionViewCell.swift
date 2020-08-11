//
//  FirstCollectionViewCell.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/31/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lbl: CheckBox!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblItem: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = containerView.frame.size.height/2
    }
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? UIColor(rgb: 0x63b946) : .clear
            lblItem.textColor = isSelected ? .white : .white
        }
    }
}
