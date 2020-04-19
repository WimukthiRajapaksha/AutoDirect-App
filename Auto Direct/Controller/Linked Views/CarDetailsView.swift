//
//  CarDetailsView.swift
//  Auto Direct
//
//  Created by User on 4/14/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class CarDetailsView: UIView {
    @IBOutlet var cardView: UIView!
    @IBOutlet weak var lblCarName: UILabel!
    @IBOutlet weak var lblCarDescription: UILabel!
    @IBOutlet weak var imgCar: UIImageView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var viewFeature1: CarItemFeature!
    @IBOutlet weak var viewFeature2: CarItemFeature!
    @IBOutlet weak var viewFeature3: CarItemFeature!
    @IBOutlet weak var viewFeature4: CarItemFeature!
    @IBOutlet weak var viewFeature5: CarItemFeature!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        cardView.backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        cardView.backgroundColor = .blue
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CarDetailsView", owner: self, options: nil)
        addSubview(cardView)
        cardView.frame = self.bounds
        cardView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        viewFeature1.imgFeature.backgroundColor = .gray
        viewFeature2.imgFeature.backgroundColor = .gray
        viewFeature3.imgFeature.backgroundColor = .gray
        viewFeature4.imgFeature.backgroundColor = .gray
        viewFeature5.imgFeature.backgroundColor = .green
    }
}
