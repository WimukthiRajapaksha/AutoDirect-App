//
//  ExampleBackgroundContentView.swift
//  Auto Direct
//
//  Created by User on 5/8/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

// deletable

import Foundation
import UIKit

class ExampleBackgroundContentView: ExampleBasicContentView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initColors()
    }
    
    private func initColors() {
        textColor = .green// UIColor(rgb: 0x6f7587)
        highlightTextColor = UIColor(rgb: 0xffffff)
        iconColor = .blue // UIColor(rgb: 0x6f7587)
        highlightIconColor = UIColor(rgb: 0xffffff)
        backdropColor = UIColor(rgb: 0x161923)
        highlightBackdropColor = UIColor(rgb: 0x161923)
    }
    
    public convenience init(specialWithAutoImplies implies: Bool) {
        self.init(frame: CGRect.zero)
//        textColor = .green// UIColor(rgb: 0x6f7587)
//        highlightTextColor = UIColor(rgb: 0xffffff)
//        iconColor = . blue // UIColor(rgb: 0x6f7587)
//        highlightIconColor = UIColor(rgb: 0xffffff)
//        backdropColor = UIColor(rgb: 0x161923)
//        highlightBackdropColor = UIColor(rgb: 0x161923)
        initColors()
        if implies {
            let timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(ExampleBackgroundContentView.playImpliesAnimation(_:)), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        }
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc internal func playImpliesAnimation(_ sender: AnyObject?) {
        if self.selected == true || self.highlighted == true {
            return
        }
        let view = self.imageView
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.15, 0.8, 1.15]
        impliesAnimation.duration = 0.3
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        impliesAnimation.isRemovedOnCompletion = true
        view.layer.add(impliesAnimation, forKey: nil)
    }
}
