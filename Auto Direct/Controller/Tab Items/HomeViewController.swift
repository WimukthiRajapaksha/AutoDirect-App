//
//  HomeViewController.swift
//  Auto Direct
//
//  Created by User on 4/6/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import ImageSlideshow
import Toast_Swift

class HomeViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet var takeItView: UIView!
    @IBOutlet var stackTopItems: UIStackView!
    @IBOutlet var stackBottomItems: UIStackView!
    @IBOutlet var leftNavItem: UIBarButtonItem!
    @IBOutlet var viewItems: UIView!
    @IBOutlet var stackTrending: UIStackView!
    @IBOutlet var lblTrending: UILabel!
    @IBOutlet var imgSlideShow: ImageSlideshow!
    @IBOutlet weak var newVehiclesCategoryItem: HomeCategoryItemView!
    @IBOutlet weak var preOwnedVehiclesCategoryItem: HomeCategoryItemView!
    @IBOutlet weak var readyToShipCategoryItem: HomeCategoryItemView!
    @IBOutlet weak var govPermitsCategoryItem: HomeCategoryItemView!
    @IBOutlet weak var trendingCollectionView: UICollectionView!
    
    private let trendingCollectionViewCell: String
    private var trendingItems: [VehicleModel?]
    private var selectedTrendingItem: VehicleModel?
    
    required init?(coder aDecoder: NSCoder) {
        trendingCollectionViewCell = "TrendingCollectionViewCell"
//        trendingItems = ["NISSAN JUKE", "SUZUKI VITARA", "VOLKSWAGEN T-CROSS", "HONDA CIVIC", "TOYOTA RAIZER"]
        trendingItems = []
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trendingCollectionView.delegate = self
        trendingCollectionView.dataSource = self
        trendingCollectionView.allowsMultipleSelection = false
        trendingCollectionView.register(UINib(nibName: trendingCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: trendingCollectionViewCell)
        setCardItems()
        
//        navigationItem.rightBarButtonItem = setCallButton()
                
        imgSlideShow.setImageInputs([
            ImageSource(image: UIImage(named: "car-1")!),
            ImageSource(image: UIImage(named: "car-2")!),
            ImageSource(image: UIImage(named: "car-3")!),
            ImageSource(image: UIImage(named: "car-4")!),
            ImageSource(image: UIImage(named: "car-5")!),
            ImageSource(image: UIImage(named: "car-6")!),
            ImageSource(image: UIImage(named: "car-7")!)
        ])
        
        imgSlideShow.pageIndicatorPosition = PageIndicatorPosition(horizontal: .center, vertical: .customBottom(padding: 30))
        imgSlideShow.slideshowInterval = 2
        imgSlideShow.contentScaleMode = .scaleAspectFill
        
//        print(imgSlideShow.bounds)
//        print(imgSlideShow.frame)
//        print(view.bounds)
//        print(view.frame)
        
        let radi: CGFloat = 30
        let maskPathContainer = UIBezierPath()
        maskPathContainer.move(to: CGPoint(x: 0, y: 0))
        maskPathContainer.addLine(to: CGPoint(x: 0, y: imgSlideShow.frame.height-2*radi))
        maskPathContainer.addArc(withCenter: CGPoint(x: radi, y: imgSlideShow.frame.height-2*radi), radius: radi, startAngle: .pi, endAngle: .pi/2, clockwise: false)
        maskPathContainer.addLine(to: CGPoint(x: (view.frame.width - radi), y: imgSlideShow.frame.height-radi))
        maskPathContainer.addArc(withCenter: CGPoint(x: (view.frame.width - radi), y: (imgSlideShow.frame.height)), radius: radi, startAngle: .pi*3/2, endAngle: 0, clockwise: true)
        maskPathContainer.addLine(to: CGPoint(x: (view.frame.width), y: 0))
        maskPathContainer.close()

        let shapeContainer = CAShapeLayer()
        shapeContainer.path = maskPathContainer.cgPath
        imgSlideShow.layer.mask = shapeContainer
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        trendingItems.removeAll()
        super.domain.getTrendingVehicleModels { (boolResponse, jsonResponse) in
            print(boolResponse)
            print(jsonResponse)
            if boolResponse {
                for (_, item) in jsonResponse {
                    print(item["id"].intValue)
                    print(item["trendingModel"].stringValue)
                    self.trendingItems.append(VehicleModel(modelId: item["id"].intValue, modelName: item["trendingModel"].stringValue))
                }
            } else {
                self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
            }
            self.trendingCollectionView.reloadData()
            
        }
        
        trendingCollectionView.reloadData()
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
//            self.navigationItem.rightBarButtonItem.
//            self.tabBarItem.
        }, completion: nil)
        self.imgSlideShow.frame.origin.y -= 300
        UIView.animate(withDuration: 0.7, delay: 0.3, options: .curveEaseInOut, animations: {
//            self.imgSlideShow.center = self.view.center
            self.imgSlideShow.frame.origin.y += 300
        }, completion: nil)
        self.stackTrending.alpha = 0
        self.stackTrending.frame.origin.y -= 50
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseOut, animations: {
            self.stackTrending.frame.origin.y += 50
            self.stackTrending.alpha = 1
        }, completion: nil)
        
        viewItems.alpha = 0
//        self.newVehiclesCategoryItem.center = self.viewItems.center
        self.newVehiclesCategoryItem.alpha = 0
        
//        self.preOwnedVehiclesCategoryItem.center = self.viewItems.center
        self.preOwnedVehiclesCategoryItem.alpha = 0
        
//        self.readyToShipCategoryItem.center = self.viewItems.center
        self.readyToShipCategoryItem.alpha = 0
        
//        self.govPermitsCategoryItem.center = self.viewItems.center
        self.govPermitsCategoryItem.alpha = 0
        UIView.animate(withDuration: 0.2, delay: 1.25, options: .curveLinear, animations: {
            self.viewItems.alpha = 1
        }, completion: nil)
        
        self.newVehiclesCategoryItem.center.x += self.view.frame.width/4
        self.newVehiclesCategoryItem.center.y += self.view.frame.height/10
        self.newVehiclesCategoryItem.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.newVehiclesCategoryItem.isUserInteractionEnabled = false
        
        self.preOwnedVehiclesCategoryItem.center.x -= self.view.frame.width/4
        self.preOwnedVehiclesCategoryItem.center.y += self.view.frame.height/10
        self.preOwnedVehiclesCategoryItem.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.preOwnedVehiclesCategoryItem.isUserInteractionEnabled = false
        
        self.readyToShipCategoryItem.center.x += self.view.frame.width/4
        self.readyToShipCategoryItem.center.y -= self.view.frame.height/10
        self.readyToShipCategoryItem.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.readyToShipCategoryItem.isUserInteractionEnabled = false
        
        self.govPermitsCategoryItem.center.x -= self.view.frame.width/4
        self.govPermitsCategoryItem.center.y -= self.view.frame.height/10
        self.govPermitsCategoryItem.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.govPermitsCategoryItem.isUserInteractionEnabled = false

        UIView.animate(withDuration: 0.7, delay: 1.4, options: .curveEaseInOut, animations: {
            self.newVehiclesCategoryItem.center.x -= self.view.frame.width/4
            self.newVehiclesCategoryItem.center.y -= self.view.frame.height/10
            self.newVehiclesCategoryItem.alpha = 1
            self.newVehiclesCategoryItem.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.newVehiclesCategoryItem.isUserInteractionEnabled = true
            
            self.preOwnedVehiclesCategoryItem.center.x += self.view.frame.width/4
            self.preOwnedVehiclesCategoryItem.center.y -= self.view.frame.height/10
            self.preOwnedVehiclesCategoryItem.alpha = 1
            self.preOwnedVehiclesCategoryItem.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.preOwnedVehiclesCategoryItem.isUserInteractionEnabled = true
            
            self.readyToShipCategoryItem.center.x -= self.view.frame.width/4
            self.readyToShipCategoryItem.center.y += self.view.frame.height/10
            self.readyToShipCategoryItem.alpha = 1
            self.readyToShipCategoryItem.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.readyToShipCategoryItem.isUserInteractionEnabled = true
            
            self.govPermitsCategoryItem.center.x += self.view.frame.width/4
            self.govPermitsCategoryItem.center.y += self.view.frame.height/10
            self.govPermitsCategoryItem.alpha = 1
            self.govPermitsCategoryItem.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.govPermitsCategoryItem.isUserInteractionEnabled = true
        }, completion: nil)
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
        cell.lblItemName.text = trendingItems[indexPath.row]!.getModelName()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.bounds.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedTrendingItem = trendingItems[indexPath.row]
        print("select \(indexPath.row)")
        performSegue(withIdentifier: "trendingSegue", sender: self)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if (trendingItems[indexPath.row]!.getModelName() == selectedTrendingItem?.getModelName()) {
            selectedTrendingItem = nil
        }
        print("deselect \(indexPath.row)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVc = segue.destination as! VehicleCategoryViewController
        if (segue.identifier == "newVehiclesSegue") {
            destinationVc.setItemId(id: 0)
        } else if (segue.identifier == "preOwnedVehiclesSegue") {
            destinationVc.setItemId(id: 1)
        } else if (segue.identifier == "readyToShipSegue") {
            destinationVc.setItemId(id: 2)
        } else if (segue.identifier == "govPermitsSegue") {
            destinationVc.setItemId(id: 3)
        } else {
            destinationVc.setItemId(id: 10, trendingItemName: (selectedTrendingItem?.getModelName())!)
        }
    }
}
