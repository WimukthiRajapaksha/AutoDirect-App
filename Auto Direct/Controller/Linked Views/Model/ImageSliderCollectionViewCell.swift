//
//  ImageSliderCollectionViewCell.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 8/1/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class ImageSliderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    
    let radi: CGFloat = 30.0
    
    override func awakeFromNib() {
        self.contentView.layer.cornerRadius = radi
//        if UIDevice().userInterfaceIdiom == .phone {
//            switch UIScreen.main.nativeBounds.height {
//                case 1136:
//                    print("iPhone 5 or 5S or 5C")
//                    self.moderatedMask()
//                case 1334:
//                    print("iPhone 6/6S/7/8")
//                    self.moderatedMask()
//                case 1920:
//                    print("iPhone 6+/6S+/7+")
//                    self.moderatedMask()
//                case 2208:
//                    print("iPhone 8+")
//                    self.defaultMask()
//                case 2436:
//                    print("iPhone X/XS/11 Pro")
//                    self.moderatedMask()
//                case 2688:
//                    print("iPhone XS Max/11 Pro Max")
//                    self.defaultMask()
//                case 1792:
//                    print("iPhone XR/ 11 ")
//                    self.defaultMask()
//                default:
//                    print("Unknown")
//                    self.defaultMask()
//            }
//        }
    }
    
    private func moderatedMask() {
    //        let maskPathContainerSlideShow = UIBezierPath()
    //        maskPathContainerSlideShow.move(to: CGPoint(x: 5, y: 0))
    //        maskPathContainerSlideShow.addLine(to: CGPoint(x: 5, y: imgSlideShow.frame.height-radi))
    //        maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: radi+5, y: imgSlideShow.frame.height-radi), radius: radi, startAngle: .pi, endAngle: .pi/2, clockwise: false)
    //        maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width+5 - radi), y: imgSlideShow.frame.height))
    //        maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: (UIScreen.main.bounds.width+5 - radi), y: (imgSlideShow.frame.height - radi)), radius: radi, startAngle: .pi/2, endAngle: 0, clockwise: false)
    //        maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width+5), y: 0))
    //        maskPathContainerSlideShow.close()
    //
    //        let shapeContainerSlideShow = CAShapeLayer()
    //        shapeContainerSlideShow.path = maskPathContainerSlideShow.cgPath
    //        imgSlideShow.layer.mask = shapeContainerSlideShow
            
            let maskPathContainerSlideShow = UIBezierPath()
            maskPathContainerSlideShow.move(to: CGPoint(x: 5, y: 0))
            maskPathContainerSlideShow.addLine(to: CGPoint(x: 5, y: self.frame.height-radi))
            maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: radi+5, y: self.frame.height-radi), radius: radi, startAngle: .pi, endAngle: .pi/2, clockwise: false)
            maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width+5 - radi), y: self.frame.height))
            maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: (UIScreen.main.bounds.width+5 - radi), y: (self.frame.height - radi)), radius: radi, startAngle: .pi/2, endAngle: 0, clockwise: false)
            maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width+5), y: 0))
            maskPathContainerSlideShow.close()

            let shapeContainerSlideShow = CAShapeLayer()
            shapeContainerSlideShow.path = maskPathContainerSlideShow.cgPath
            self.layer.mask = shapeContainerSlideShow
        }
        
        private func defaultMask() {
    //        let maskPathContainerSlideShow = UIBezierPath()
    //        maskPathContainerSlideShow.move(to: CGPoint(x: 0, y: 0))
    //        maskPathContainerSlideShow.addLine(to: CGPoint(x: 0, y: imgSlideShow.frame.height-radi))
    //        maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: radi, y: imgSlideShow.frame.height-radi), radius: radi, startAngle: .pi, endAngle: .pi/2, clockwise: false)
    //        maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width - radi), y: imgSlideShow.frame.height))
    //        maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: (UIScreen.main.bounds.width - radi), y: (imgSlideShow.frame.height - radi)), radius: radi, startAngle: .pi/2, endAngle: 0, clockwise: false)
    //        maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width), y: 0))
    //        maskPathContainerSlideShow.close()
    //
    //        let shapeContainerSlideShow = CAShapeLayer()
    //        shapeContainerSlideShow.path = maskPathContainerSlideShow.cgPath
    //        imgSlideShow.layer.mask = shapeContainerSlideShow
            
            let maskPathContainerSlideShow = UIBezierPath()
            maskPathContainerSlideShow.move(to: CGPoint(x: 0, y: 0))
            maskPathContainerSlideShow.addLine(to: CGPoint(x: 0, y: self.frame.height-radi))
            maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: radi, y: self.frame.height-radi), radius: radi, startAngle: .pi, endAngle: .pi/2, clockwise: false)
            maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width - radi), y: self.frame.height))
            maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: (UIScreen.main.bounds.width - radi), y: (self.frame.height - radi)), radius: radi, startAngle: .pi/2, endAngle: 0, clockwise: false)
            maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width), y: 0))
            maskPathContainerSlideShow.close()

            let shapeContainerSlideShow = CAShapeLayer()
            shapeContainerSlideShow.path = maskPathContainerSlideShow.cgPath
            self.layer.mask = shapeContainerSlideShow
        }
}
