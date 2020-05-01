//
//  HomeViewController.swift
//  Auto Direct
//
//  Created by User on 4/6/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import ImageSlideshow

class HomeViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var lblTrending: UILabel!
    @IBOutlet var imgSlideShow: ImageSlideshow!
    @IBOutlet weak var newVehiclesCategoryItem: HomeCategoryItemView!
    @IBOutlet weak var preOwnedVehiclesCategoryItem: HomeCategoryItemView!
    @IBOutlet weak var readyToShipCategoryItem: HomeCategoryItemView!
    @IBOutlet weak var govPermitsCategoryItem: HomeCategoryItemView!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    
    private let trendingCollectionViewCell: String
    private let trendingItems: [String]
    
    required init?(coder aDecoder: NSCoder) {
        trendingCollectionViewCell = "TrendingCollectionViewCell"
        trendingItems = ["a", "b", "cccccccccccccc", "d", "e", "f", "g", "h", "i", "j", "k", "llllllllllll", "m", "n", "oooooooooooooooooo", "p", "qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq", "r"]
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        trendingCollectionView.allowsMultipleSelection = false
        trendingCollectionView.register(UINib(nibName: trendingCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: trendingCollectionViewCell)
        setCardItems()
        
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
        
        imgSlideShow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .customBottom(padding: 20))
        imgSlideShow.slideshowInterval = 2
        imgSlideShow.contentScaleMode = .scaleAspectFill
        
        let maskPathContainer = UIBezierPath(roundedRect: imgSlideShow.bounds,
                                             byRoundingCorners: [.bottomLeft, .bottomRight],
                    cornerRadii: CGSize(width: 30.0, height: 30.0))

        let shapeContainer = CAShapeLayer()
        shapeContainer.path = maskPathContainer.cgPath
        imgSlideShow.layer.mask = shapeContainer
//        let maskPath = UIBezierPath(roundedRect: lblTrending.bounds,
//                    byRoundingCorners: [.bottomLeft],
//                    cornerRadii: CGSize(width: 30.0, height: 30.0))
//
//        let shape = CAShapeLayer()
//        shape.path = maskPath.cgPath
//        lblTrending.layer.mask = shape
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        trendingCollectionView.reloadData()
//        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setCardItems() {
        
//        TODO - gradiant colors
        
        newVehiclesCategoryItem.imgItem.image = UIImage(named: "newVehicles")
//        newVehiclesCategoryItem.imgItem.addBlackGradientLayerInForeground(frame: newVehiclesCategoryItem.imgItem.bounds, colors:[UIColor(rgb: 0xc9da2e), UIColor(rgb: 0x21b258)])
        newVehiclesCategoryItem.lblItem.text = "New \nVehicles"
        let tapGestureRecognizerNewVehiclesCategory = UITapGestureRecognizer(target: self, action: #selector(viewTappedNewVehiclesCategory(tapGestureRecognizer:)))
        newVehiclesCategoryItem.isUserInteractionEnabled = true
        newVehiclesCategoryItem.addGestureRecognizer(tapGestureRecognizerNewVehiclesCategory)
        
        preOwnedVehiclesCategoryItem.imgItem.image = UIImage(named: "preOwnedVehicles")
        preOwnedVehiclesCategoryItem.lblItem.text = "Pre-Owned \nVehicles"
        let tapGestureRecognizerPerOwnedVehiclesCategory = UITapGestureRecognizer(target: self, action: #selector(viewTappedPreOwnedVehiclesCategory(tapGestureRecognizer:)))
        preOwnedVehiclesCategoryItem.isUserInteractionEnabled = true
        preOwnedVehiclesCategoryItem.addGestureRecognizer(tapGestureRecognizerPerOwnedVehiclesCategory)
        
        readyToShipCategoryItem.imgItem.image = UIImage(named: "readyToShip")
        readyToShipCategoryItem.lblItem.text = "Ready to \nShip"
        let tapGestureRecognizerReadyToShipCategory = UITapGestureRecognizer(target: self, action: #selector(viewTappedReadyToShipCategory(tapGestureRecognizer:)))
        readyToShipCategoryItem.isUserInteractionEnabled = true
        readyToShipCategoryItem.addGestureRecognizer(tapGestureRecognizerReadyToShipCategory)
        
        govPermitsCategoryItem.imgItem.image = UIImage(named: "govPermits")
        govPermitsCategoryItem.lblItem.text = "GOV \nPermits"
        let tapGestureRecognizerGovPermitsCategory = UITapGestureRecognizer(target: self, action: #selector(viewTappedGovPermitsCategory(tapGestureRecognizer:)))
        govPermitsCategoryItem.isUserInteractionEnabled = true
        govPermitsCategoryItem.addGestureRecognizer(tapGestureRecognizerGovPermitsCategory)
    }
    
    @objc func viewTappedNewVehiclesCategory(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "newVehiclesSegue", sender: self)
    }
    
    @objc func viewTappedPreOwnedVehiclesCategory(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "preOwnedVehiclesSegue", sender: self)
    }
    
    @objc func viewTappedReadyToShipCategory(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "readyToShipSegue", sender: self)
    }
    
    @objc func viewTappedGovPermitsCategory(tapGestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "govPermitsSegue", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trendingItems.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = trendingCollectionView.dequeueReusableCell(withReuseIdentifier: trendingCollectionViewCell, for: indexPath) as! TrendingCollectionViewCell
        cell.lblItemName.text = trendingItems[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselect \(indexPath.row)")
    }
}
