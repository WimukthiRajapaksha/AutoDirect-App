//
//  HomeCategoryItemView.swift
//  Auto Direct
//
//  Created by User on 4/13/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class HomeCategoryItemView: UIView {
    @IBOutlet var cardView: UIView!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItem: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("HomeCategoryItemView", owner: self, options: nil)
        addSubview(cardView)
        cardView.frame = self.bounds
        cardView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

}
