//
//  ModelFeatureItem.swift
//  Auto Direct
//
//  Created by User on 4/19/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class ModelFeatureItem: UIView {
    @IBOutlet var cardView: UIView!
    @IBOutlet var imgItem: UIImageView!
    @IBOutlet var lblItemName: UILabel!
    @IBOutlet var lblItemFeature: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ModelFeatureItem", owner: self, options: nil)
        addSubview(cardView)
        
        imgItem.layer.cornerRadius = 25
        cardView.frame = self.bounds
        cardView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
