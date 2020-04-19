//
//  HomeViewController.swift
//  Auto Direct
//
//  Created by User on 4/6/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var imgCar: UIImageView!
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        trendingCollectionView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setCardItems() {
        newVehiclesCategoryItem.imgItem.image = UIImage(named: "newVehicles")
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
