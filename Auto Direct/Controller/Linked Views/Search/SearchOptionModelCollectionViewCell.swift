//
//  SearchOptionModelCollectionViewCell.swift
//  Auto Direct
//
//  Created by User on 4/27/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import DLRadioButton

class SearchOptionModelCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnRadio: DLRadioButton!
//    @IBOutlet weak var btnRadioNew: UIButton!
    @IBOutlet weak var lblRadio: CheckBox!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    override var isSelected: Bool {
//        didSet {
//            containerView.backgroundColor = isSelected ? UIColor(rgb: 0x63b946) : .clear
//            lblRadio.textColor = isSelected ? .white : .white
////            btnRadioNew.backgroundColor = .green
//        }
//    }
}
