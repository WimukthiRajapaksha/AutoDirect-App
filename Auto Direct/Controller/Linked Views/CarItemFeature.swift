//
//  CarItemFeature.swift
//  Auto Direct
//
//  Created by User on 4/14/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class CarItemFeature: UIView {
    @IBOutlet weak var viewImage: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet weak var imgFeature: UIImageView!
    @IBOutlet weak var lblFeature: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CarItemFeature", owner: self, options: nil)
        addSubview(cardView)
        cardView.frame = self.bounds
        cardView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
                
    //    viewImage.layer.borderWidth = 1
    //    viewImage.layer.masksToBounds = false
//        imgFeature.backgroundColor = .gray
 //       viewImage.layer.cornerRadius = viewImage.frame.size.width/6.5
//        viewImage.clipsToBounds = true
    }
}
