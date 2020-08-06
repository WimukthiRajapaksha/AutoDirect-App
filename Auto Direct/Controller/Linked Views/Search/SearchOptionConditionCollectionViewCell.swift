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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
