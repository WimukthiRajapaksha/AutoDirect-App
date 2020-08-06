//
//  SearchCollectionViewCell.swift
//  Auto Direct
//
//  Created by User on 4/26/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = containerView.frame.height/2
    }

    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? .green : .clear
            lblText.textColor = isSelected ? .black : .white
        }
    }
    
}
