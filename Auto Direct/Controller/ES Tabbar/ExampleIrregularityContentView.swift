//
//  ExampleIrregularityContentView.swift
//  Auto Direct
//
//  Created by User on 5/8/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation
import UIKit
import ESTabBarController_swift

class ExampleIrregularityContentView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let gradient = CAGradientLayer()
//        gradient.frame =  CGRect(origin: .zero, size: self.imageView.frame.size)// imageView.bounds
//        gradient.colors = [UIColor(rgb: 0xc9da2e).cgColor, UIColor(rgb: 0x21b258).cgColor]
//        gradient.locations = [0.0 , 1.0]
//        gradient.startPoint = CGPoint(x: 0.5, y: 0)
//        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        
//        imageView.layer.backgroundColor = UIColor(rgb: 0x21b258).cgColor
//        imageView.layer.addSublayer(gradient)
        
//        imageView.gradient(width: imageView.frame.width, height: imageView.frame.height, colors: [UIColor(rgb: 0xc9da2e).cgColor, UIColor(rgb: 0x21b258).cgColor])
//        self.imageView.layer.addSublayer(gradient)
//        self.imageView.backgroundColor = UIColor.init(red: 23/255.0, green: 149/255.0, blue: 158/255.0, alpha: 1.0)
//        self.imageView.layer.borderWidth = 1.0
//        self.imageView.layer.borderColor = UIColor.init(white: 235 / 255.0, alpha: 1.0).cgColor
        self.insets = UIEdgeInsets.init(top: -50, left: 0, bottom: 0, right: 0)
        self.imageView.transform = CGAffineTransform(rotationAngle: .pi/4)
//        self.imageView.layer.transform = CGAffineTransform(rotationAngle: -.pi/4)
        self.superview?.bringSubviewToFront(self)
//        self.superview?.transform = CGAffineTransform(rotationAngle: -.pi/4)

//        textColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
//        highlightTextColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
//        iconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
//        highlightIconColor = UIColor.init(white: 255.0 / 255.0, alpha: 1.0)
//        backdropColor = .clear
//        highlightBackdropColor = .clear
        print(imageView.bounds)
        
        textColor = UIColor(rgb: 0x6f7587)
        highlightTextColor = UIColor(rgb: 0xffffff)
        iconColor = .white
        highlightIconColor = .black
        backdropColor = .clear // UIColor(rgb: 0x161923)
        highlightBackdropColor = .clear // UIColor(rgb: 0x161923)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let p = CGPoint.init(x: point.x - imageView.frame.origin.x, y: point.y - imageView.frame.origin.y)
        return sqrt(pow(imageView.bounds.size.width / 2.0 - p.x, 2) + pow(imageView.bounds.size.height / 2.0 - p.y, 2)) < imageView.bounds.size.width / 2.0
    }
    
    override func updateLayout() {
        super.updateLayout()
        self.imageView.sizeToFit()
        var t = CGAffineTransform.identity
        t = t.rotated(by: .pi/4)
        t = t.scaledBy(x: 1.12, y: 1.12)
        self.imageView.transform = t
        
        let gradient = CAGradientLayer()
        gradient.isOpaque = true
        print(imageView.bounds)
        gradient.cornerRadius = 15
        gradient.frame = imageView.bounds
        gradient.contents = imageView.image?.cgImage
//        gradient.colors = [, ]
        gradient.colors = [UIColor(rgb: 0x21b258).cgColor, UIColor(rgb: 0xc9da2e).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        imageView.layer.addSublayer(gradient)
        
//        [UIColor(rgb: 0xc9da2e), UIColor(rgb: 0x21b258)]
        
        imageView.layer.shadowColor = UIColor(rgb: 0x0d1222).cgColor
        imageView.layer.shadowOpacity = 0.6
        self.imageView.layer.cornerRadius = 15
        
        print(imageView.frame)
//        self.imageView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        self.imageView.center = CGPoint.init(x: self.bounds.size.width / 2.0, y: self.bounds.size.height / 2.0)
    }
    
    public override func selectAnimation(animated: Bool, completion: (() -> ())?) {
        let view = UIView.init(frame: CGRect.init(origin: CGPoint.zero, size: CGSize(width: 2.0, height: 2.0)))
        view.layer.cornerRadius = 1.0
        view.layer.opacity = 0.5
        view.backgroundColor = UIColor.init(red: 10/255.0, green: 66/255.0, blue: 91/255.0, alpha: 1.0)
        view.transform = CGAffineTransform(rotationAngle: -.pi/4)
        self.addSubview(view)
        playMaskAnimation(animateView: view, target: self.imageView, completion: {
            [weak view] in
            view?.removeFromSuperview()
            completion?()
        })
    }
    
    public override func reselectAnimation(animated: Bool, completion: (() -> ())?) {
        completion?()
    }
    
    public override func deselectAnimation(animated: Bool, completion: (() -> ())?) {
        completion?()
    }
    
    public override func highlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("small", context: nil)
        UIView.setAnimationDuration(0.2)
        let transform = self.imageView.transform.scaledBy(x: 0.9, y: 0.9)
        self.imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    public override func dehighlightAnimation(animated: Bool, completion: (() -> ())?) {
        UIView.beginAnimations("big", context: nil)
        UIView.setAnimationDuration(0.2)
        var transform = CGAffineTransform.identity
        transform = transform.rotated(by: .pi/4)
        transform = transform.scaledBy(x: 1.12, y: 1.12)
        self.imageView.transform = transform
        UIView.commitAnimations()
        completion?()
    }
    
    private func playMaskAnimation(animateView view: UIView, target: UIView, completion: (() -> ())?) {
        view.center = CGPoint.init(x: target.frame.origin.x + target.frame.size.width / 2.0, y: target.frame.origin.y + target.frame.size.height / 2.0)
        
//        let scale = POPBasicAnimation.init(propertyNamed: kPOPLayerScaleXY)
//        scale?.fromValue = NSValue.init(cgSize: CGSize.init(width: 1.0, height: 1.0))
//        scale?.toValue = NSValue.init(cgSize: CGSize.init(width: 36.0, height: 36.0))
//        scale?.beginTime = CACurrentMediaTime()
//        scale?.duration = 0.3
//        scale?.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
//        scale?.removedOnCompletion = true
//
//        let alpha = POPBasicAnimation.init(propertyNamed: kPOPLayerOpacity)
//        alpha?.fromValue = 0.6
//        alpha?.toValue = 0.6
//        alpha?.beginTime = CACurrentMediaTime()
//        alpha?.duration = 0.25
//        alpha?.timingFunction = CAMediaTimingFunction.init(name: CAMediaTimingFunctionName.easeOut)
//        alpha?.removedOnCompletion = true
//
//        view.layer.pop_add(scale, forKey: "scale")
//        view.layer.pop_add(alpha, forKey: "alpha")
//
//        scale?.completionBlock = ({ animation, finished in
//            completion?()
//        })
    }

}
