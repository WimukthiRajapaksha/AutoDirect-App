//
//  ExampleIrregularityBasicContentView.swift
//  Auto Direct
//
//  Created by User on 5/8/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation
import UIKit

class ExampleIrregularityBasicContentView: ExampleBouncesContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textColor = UIColor(rgb: 0x6f7587)
        highlightTextColor = UIColor(rgb: 0xffffff)
        iconColor = UIColor(rgb: 0x6f7587)
        highlightIconColor = UIColor(rgb: 0xffffff)
        backdropColor = UIColor(rgb: 0x161923)
        highlightBackdropColor = UIColor(rgb: 0x161923)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
