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
        
        containerView.layer.borderColor = UIColor.green.cgColor
        containerView.layer.borderWidth = 3
        containerView.layer.cornerRadius = containerView.frame.height/2.6
    }
    
    override var isSelected: Bool {
        didSet {
            containerView.backgroundColor = isSelected ? .green : .clear
            lblItemName.textColor = isSelected ? .black : .green
        }
    }

}
