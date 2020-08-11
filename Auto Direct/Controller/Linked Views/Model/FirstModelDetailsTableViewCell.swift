//
//  FirstModelDetailsTableViewCell.swift
//  Auto Direct
//
//  Created by User on 4/19/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import ImageSlideshow
import Alamofire
import AlamofireImage

class FirstModelDetailsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imgSlideShow: ImageSlideshow!
    @IBOutlet var btnPcp: UIButton!
    @IBOutlet var btnReserve: UIButton!
    @IBOutlet var paymentInfoView: UIView!
    @IBOutlet weak var lblMonthlyPayment: UILabel!
    @IBOutlet weak var lblDownPayment: UILabel!
    let radi: CGFloat
    var imageSource: [ImageSource]
    private var imageLinks: [String?]
    
    required init?(coder aDecoder: NSCoder) {
        radi = 30
        imageLinks = []
        imageSource = [ImageSource(image: UIImage())]
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgSlideShow.slideshowInterval = 2
        imgSlideShow.preload = ImagePreload.fixed(offset: 0)
                
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setSlideShowImages(imageLinks: [String]) {
        self.imageLinks = imageLinks
        self.collectionView.reloadData()
//        imageSource.removeAll()
//        for item in imageLinks {
//            if let url = URL(string: item) {
//                print(url)
//                if let data = try? Data(contentsOf: url) {
//                    print(data)
//                    imageSource.append(ImageSource(image: UIImage(data: data)!))
//                }
//            }
//        }
//        imgSlideShow.setImageInputs(imageSource)
        
        
//        imgSlideShow.setImageInputs([
//            ImageSource(image: UIImage(named: "car-1")!),
//            ImageSource(image: UIImage(named: "car-2")!),
//            ImageSource(image: UIImage(named: "car-3")!),
//            ImageSource(image: UIImage(named: "car-4")!),
//            ImageSource(image: UIImage(named: "car-5")!),
//            ImageSource(image: UIImage(named: "car-6")!),
//            ImageSource(image: UIImage(named: "car-7")!),
//            ImageSource(image: UIImage(named: "car-8")!),
//            ImageSource(image: UIImage(named: "car-9")!),
//            ImageSource(image: UIImage(named: "car-10")!),
//            ImageSource(image: UIImage(named: "car-11")!),
//            ImageSource(image: UIImage(named: "car-12")!),
//            ImageSource(image: UIImage(named: "car-13")!),
//            ImageSource(image: UIImage(named: "car-14")!)
//        ])
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
        maskPathContainerSlideShow.addLine(to: CGPoint(x: 5, y: collectionView.frame.height-radi))
        maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: radi+5, y: collectionView.frame.height-radi), radius: radi, startAngle: .pi, endAngle: .pi/2, clockwise: false)
        maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width+5 - radi), y: collectionView.frame.height))
        maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: (UIScreen.main.bounds.width+5 - radi), y: (collectionView.frame.height - radi)), radius: radi, startAngle: .pi/2, endAngle: 0, clockwise: false)
        maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width+5), y: 0))
        maskPathContainerSlideShow.close()

        let shapeContainerSlideShow = CAShapeLayer()
        shapeContainerSlideShow.path = maskPathContainerSlideShow.cgPath
        collectionView.layer.mask = shapeContainerSlideShow
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
        maskPathContainerSlideShow.addLine(to: CGPoint(x: 0, y: collectionView.frame.height-radi))
        maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: radi, y: collectionView.frame.height-radi), radius: radi, startAngle: .pi, endAngle: .pi/2, clockwise: false)
        maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width - radi), y: collectionView.frame.height))
        maskPathContainerSlideShow.addArc(withCenter: CGPoint(x: (UIScreen.main.bounds.width - radi), y: (collectionView.frame.height - radi)), radius: radi, startAngle: .pi/2, endAngle: 0, clockwise: false)
        maskPathContainerSlideShow.addLine(to: CGPoint(x: (UIScreen.main.bounds.width), y: 0))
        maskPathContainerSlideShow.close()

        let shapeContainerSlideShow = CAShapeLayer()
        shapeContainerSlideShow.path = maskPathContainerSlideShow.cgPath
        collectionView.layer.mask = shapeContainerSlideShow
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(imageLinks.count)
//        return 10
        return self.imageLinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageSliderCollectionViewCell", for: indexPath) as! ImageSliderCollectionViewCell
//        print(imageLinks[indexPath.row]!)
        
        cell.imgView.contentMode = .scaleAspectFill
        
//        cell.imgView.downloaded(from: self.imageLinks[indexPath.row]!)
        
        AF.request(self.imageLinks[indexPath.row]!).responseImage { (response) in
            if response.error == nil {
                cell.imgView.image = UIImage(data: response.data!)
            } else {
                cell.imgView.image = UIImage(named: "placeholder")
            }
        }
        
//        cell.imgView.image = UIImage(named: "car-\(indexPath.row+1)")
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: UIScreen.main.bounds.size.width, height: collectionView.frame.size.height)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    }
    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if (scrollView == self.collectionView) {
//            var currentCellOffset = self.collectionView.contentOffset
//            currentCellOffset.x += self.collectionView.frame.size.width / 2
//            var indexPath = self.collectionView.indexPathForItem(at: currentCellOffset)
//
//            self.collectionView.scrollToItem(at: indexPath!, at: .centeredVertically, animated: true)
//
////            self.collectionView.scrollToItemAtIndexPath:indexPath
////            atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
////                    animated:YES
//
//        }
//    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 2.5
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let frameSize = collectionView.frame.size
        return CGSize(width: frameSize.width - 2.5, height: frameSize.height)
//        return CGSize(width: self.containerView.frame.width, height: collectionView.frame.size.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 1.250, bottom: 0, right: 1.250)
    }
    
    
}
