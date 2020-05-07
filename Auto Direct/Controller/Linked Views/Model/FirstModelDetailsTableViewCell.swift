//
//  FirstModelDetailsTableViewCell.swift
//  Auto Direct
//
//  Created by User on 4/19/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import ImageSlideshow

class FirstModelDetailsTableViewCell: UITableViewCell {
    @IBOutlet var containerView: UIView! //242834
    @IBOutlet weak var imgSlideShow: ImageSlideshow!
    @IBOutlet var btnPcp: UIButton!
    @IBOutlet var btnReserve: UIButton!
    @IBOutlet var paymentInfoView: UIView!
    let radi: CGFloat
    
    required init?(coder aDecoder: NSCoder) {
        radi = 30
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgSlideShow.setImageInputs([
            ImageSource(image: UIImage(named: "car-1")!),
            ImageSource(image: UIImage(named: "car-2")!),
            ImageSource(image: UIImage(named: "car-3")!),
            ImageSource(image: UIImage(named: "car-4")!),
            ImageSource(image: UIImage(named: "car-5")!),
            ImageSource(image: UIImage(named: "car-6")!),
            ImageSource(image: UIImage(named: "car-7")!),
            ImageSource(image: UIImage(named: "car-8")!),
            ImageSource(image: UIImage(named: "car-9")!),
            ImageSource(image: UIImage(named: "car-10")!),
            ImageSource(image: UIImage(named: "car-11")!),
            ImageSource(image: UIImage(named: "car-12")!),
            ImageSource(image: UIImage(named: "car-13")!),
            ImageSource(image: UIImage(named: "car-14")!)
        ])
        
        imgSlideShow.slideshowInterval = 2
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1136:
                    print("iPhone 5 or 5S or 5C")
                    self.moderatedMask()
                case 1334:
                    print("iPhone 6/6S/7/8")
                    self.moderatedMask()
                case 1920:
                    print("iPhone 6+/6S+/7+")
                    self.moderatedMask()
                case 2208:
                    print("iPhone 8+")
                    self.defaultMask()
                case 2436:
                    print("iPhone X/XS/11 Pro")
                    self.moderatedMask()
                case 2688:
                    print("iPhone XS Max/11 Pro Max")
                    self.defaultMask()
                case 1792:
                    print("iPhone XR/ 11 ")
                    self.defaultMask()
                default:
                    print("Unknown")
                    self.defaultMask()
            }
        }
        
        
        
//        let maskPathContainerPayment = UIBezierPath()
//        maskPathContainerPayment.move(to: CGPoint(x: 0, y: paymentInfoView.frame.origin.y))
//        maskPathContainerPayment.addLine(to: CGPoint(x: 0, y: paymentInfoView.frame.origin.y + paymentInfoView.frame.height-radi))
//        maskPathContainerPayment.addArc(withCenter: CGPoint(x: radi, y: (paymentInfoView.frame.origin.y + paymentInfoView.frame.height-radi)), radius: radi, startAngle: .pi, endAngle: .pi/2, clockwise: false)
//        maskPathContainerPayment.addLine(to: CGPoint(x: (self.containerView.frame.width - radi), y: (paymentInfoView.frame.origin.y + paymentInfoView.frame.height)))
//        maskPathContainerPayment.addArc(withCenter: CGPoint(x: (self.containerView.frame.width - radi), y: (paymentInfoView.frame.origin.y + paymentInfoView.frame.height - radi)), radius: radi, startAngle: .pi/2, endAngle: 0, clockwise: false)
//        maskPathContainerPayment.addLine(to: CGPoint(x: (self.containerView.frame.width), y: paymentInfoView.frame.origin.y))
//        maskPathContainerPayment.close()
        
        
        
        
        
// here
        let maskPathContainerPayment = UIBezierPath()
        maskPathContainerPayment.move(to: CGPoint(x: 0, y: 0))
        maskPathContainerPayment.addLine(to: CGPoint(x: 0, y: (containerView.frame.height*2.47/3-radi)))
        maskPathContainerPayment.addArc(withCenter: CGPoint(x: radi, y: (containerView.frame.height*2.47/3-radi)), radius: radi, startAngle: .pi, endAngle: .pi/2, clockwise: false)
        maskPathContainerPayment.addLine(to: CGPoint(x: (UIScreen.main.bounds.width - radi), y: (containerView.frame.height*2.47/3)))
        maskPathContainerPayment.addArc(withCenter: CGPoint(x: (UIScreen.main.bounds.width - radi), y: (containerView.frame.height*2.47/3 - radi)), radius: radi, startAngle: .pi/2, endAngle: 0, clockwise: false)
        maskPathContainerPayment.addLine(to: CGPoint(x: UIScreen.main.bounds.width, y: 0))
        maskPathContainerPayment.close()

        print(paymentInfoView.frame)
        print(paymentInfoView.frame.origin.y)
        let shapeContainerPayment = CAShapeLayer()
        shapeContainerPayment.path = maskPathContainerPayment.cgPath
//        shapeContainerPayment.backgroundColor = UIColor.yellow.cgColor
        containerView.layer.mask = shapeContainerPayment
//        containerView.backgroundColor = .lightGray
        
        
        
        
        
//        let maskPathContainerPayment = UIBezierPath()
//        maskPathContainerPayment.move(to: CGPoint(x: 0, y: 0))
//        maskPathContainerPayment.addLine(to: CGPoint(x: containerView.layer.frame.width/2, y: containerView.layer.frame.height))
////        maskPathContainerPayment.addArc(withCenter: CGPoint(x: radi, y: (containerView.frame.height-radi)), radius: radi, startAngle: .pi, endAngle: .pi/2, clockwise: false)
//        maskPathContainerPayment.addLine(to: CGPoint(x: (self.frame.width), y: 0))
////        maskPathContainerPayment.addArc(withCenter: CGPoint(x: (self.containerView.frame.width - radi), y: (containerView.frame.height - radi)), radius: radi, startAngle: .pi/2, endAngle: 0, clockwise: false)
////        maskPathContainerPayment.addLine(to: CGPoint(x: (self.containerView.frame.width), y: 0))
//        maskPathContainerPayment.close()
//
//        print(paymentInfoView.frame)
//        print(paymentInfoView.frame.origin.y)
//        let shapeContainerPayment = CAShapeLayer()
//        shapeContainerPayment.path = maskPathContainerPayment.cgPath
////        shapeContainerPayment.backgroundColor = UIColor.yellow.cgColor
//        containerView.layer.mask = shapeContainerPayment
//        containerView.backgroundColor = .lightGray
        
        
        
        
        
        
        btnPcp.layer.cornerRadius = 30
        btnReserve.layer.cornerRadius = 30
        

//        let maskPath = UIBezierPath(roundedRect: imgSlideShow.bounds,
//                                    byRoundingCorners: [.bottomLeft, .bottomRight],
//                    cornerRadii: CGSize(width: 20.0, height: 20.0))

//        let shape = CAShapeLayer()
//        shape.path = maskPath.cgPath
//        imgSlideShow.layer.mask = shape
        
//        let maskPathContainer = UIBezierPath(roundedRect: stack.bounds,
//                    byRoundingCorners: [.bottomLeft, .bottomRight],
//                    cornerRadii: CGSize(width: 30.0, height: 30.0))
//
//        let shapeContainer = CAShapeLayer()
//        shapeContainer.path = maskPathContainer.cgPath
//        stack.layer.mask = shapeContainer
        
//        containerView.layer.cornerRadius = 30
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func moderatedMask() {
        let maskPathContainerSlideShow = UIBezierPath()
        maskPathContainerSlideShow.move(to: CGPoint(x: 5, y: 0))
        maskPathContainerSlideShow.addLine(to: CGPoint(x: 5, y: imgSlideShow.frame.height-radi))
        maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: radi+5, y: imgSlideShow.frame.height-radi), radius: radi, startAngle: .pi, endAngle: .pi/2, clockwise: false)
        maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width+5 - radi), y: imgSlideShow.frame.height))
        maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: (UIScreen.main.bounds.width+5 - radi), y: (imgSlideShow.frame.height - radi)), radius: radi, startAngle: .pi/2, endAngle: 0, clockwise: false)
        maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width+5), y: 0))
        maskPathContainerSlideShow.close()

        let shapeContainerSlideShow = CAShapeLayer()
        shapeContainerSlideShow.path = maskPathContainerSlideShow.cgPath
        imgSlideShow.layer.mask = shapeContainerSlideShow
    }
    
    private func defaultMask() {
        let maskPathContainerSlideShow = UIBezierPath()
        maskPathContainerSlideShow.move(to: CGPoint(x: 0, y: 0))
        maskPathContainerSlideShow.addLine(to: CGPoint(x: 0, y: imgSlideShow.frame.height-radi))
        maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: radi, y: imgSlideShow.frame.height-radi), radius: radi, startAngle: .pi, endAngle: .pi/2, clockwise: false)
        maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width - radi), y: imgSlideShow.frame.height))
        maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: (UIScreen.main.bounds.width - radi), y: (imgSlideShow.frame.height - radi)), radius: radi, startAngle: .pi/2, endAngle: 0, clockwise: false)
        maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width), y: 0))
        maskPathContainerSlideShow.close()

        let shapeContainerSlideShow = CAShapeLayer()
        shapeContainerSlideShow.path = maskPathContainerSlideShow.cgPath
        imgSlideShow.layer.mask = shapeContainerSlideShow
    }
}
