//
//  SearchOptionConditionCollectionViewCell.swift
//  Auto Direct
//
//  Created by User on 4/27/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import DLRadioButton

class SearchOptionConditionCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnRadio: DLRadioButton!
    @IBOutlet weak var lbl: CheckBox!
    @IBOutlet weak var lblCondition: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = containerView.frame.height/2.0
    }
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? UIColor(rgb: 0x63b946) : .clear
            lbl.textColor = isSelected ? .white : .white
        }
    }
}
