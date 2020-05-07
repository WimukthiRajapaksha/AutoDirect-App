//
//  VehicleCategoryViewController.swift
//  Auto Direct
//
//  Created by User on 4/13/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import Shimmer
import SpringIndicator

class VehicleCategoryViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var shimming: FBShimmeringView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vehicleCategoryCollectionView: UICollectionView!
    @IBOutlet weak var viewSearchDetails: UIView!
    @IBOutlet weak var viewSearchOption: UIView!
    @IBOutlet weak var viewNewestFirst: UIView!
    @IBOutlet weak var lblSearchResultCount: UILabel!
    
    private let vehicleCategoryTableViewCell: String
    private let vehicleCategoryCollectionViewCell: String
    private let brandsList: [String]
    private var shownIndexes: [IndexPath]
    private var fromSearch: Bool
    private var itemId: Int
    private let springIndicator: SpringIndicator
    private let viewIndicator: UIView
//    private var shimmeringView: FBShimmeringView?
    
    required init?(coder aDecoder: NSCoder) {
        itemId = 0
        fromSearch = false
        shownIndexes = []
        viewIndicator = UIView(frame: CGRect(x: UIScreen.main.bounds.width/2-30, y: UIScreen.main.bounds.height/3.7-30, width: 60, height: 60))
        springIndicator = SpringIndicator(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        vehicleCategoryTableViewCell = "VehicleCategoryTableViewCell"
        vehicleCategoryCollectionViewCell = "VehicleCategoryCollectionViewCell"
        brandsList = ["All", "Audi", "BMW", "Honda", "Jeep", "Mazda", "Benz", "MG", "Mini", "Nissan", "Peugeot", "Subaru", "Suzuki", "Toyota", "Volkswagen"]
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        shimmeringView = FBShimmeringView(frame: self.view.bounds)
//        self.view.addSubview(shimmeringView!)
//        shimmeringView?.contentView = self.tableView
//        indicator.center = viewIndicator.center
        viewIndicator.round(corners: .allCorners, radius: 30)
        viewIndicator.backgroundColor = .black
        springIndicator.lineColor = .green
        springIndicator.lineWidth = 0.5
        
        viewIndicator.addSubview(springIndicator)
        view.addSubview(viewIndicator)
        
        shimming.isShimmering = true
        viewSearchOption.layer.cornerRadius = viewSearchOption.frame.height / 2.0
        viewNewestFirst.layer.cornerRadius = viewNewestFirst.frame.height / 2.0
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: vehicleCategoryTableViewCell, bundle: nil), forCellReuseIdentifier: vehicleCategoryTableViewCell)
        
        vehicleCategoryCollectionView.delegate = self
        vehicleCategoryCollectionView.dataSource = self
        vehicleCategoryCollectionView.register(UINib(nibName: vehicleCategoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: vehicleCategoryCollectionViewCell)
        
        viewSearchOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.searchOption(_:))))
        viewSearchOption.isUserInteractionEnabled = true
        
        viewNewestFirst.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.newestFirst(_:))))
        viewNewestFirst.isUserInteractionEnabled = true
        navigationItem.leftBarButtonItem = backBarButton()
        
        tableView.gradient(width: UIScreen.main.bounds.width, height: 30, colors: [UIColor(rgb: 0x0b0f0f).cgColor, UIColor(rgb: 0x1b1f2a).cgColor])
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView()
        viewHeader.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30)
        return viewHeader
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shownIndexes = []

        if (self.itemId == 0) {
            self.title = "New Vehicles"
        } else if (self.itemId == 1) {
            self.title = "Pre-Owned Vehicles"
        } else if (self.itemId == 2) {
            self.title = "Ready to Ship"
        } else if (self.itemId == 3) {
            self.title = "GOV Permits"
        } else if (self.itemId == 4) {
            navigationItem.leftBarButtonItem = UIBarButtonItem()
            self.vehicleCategoryCollectionView.isHidden = true
            self.viewSearchDetails.isHidden = false
            self.title = "Inventory"
        } else {
            self.title = "Search"
        }
        
        springIndicator.start()
        viewIndicator.alpha = 0
        viewIndicator.frame.origin.y -= 40
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.viewIndicator.alpha = 1
            self.viewIndicator.frame.origin.y += 40
        }, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        springIndicator.stop()
//        viewIndicator.isHidden = true
        
        viewIndicator.alpha = 1
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.viewIndicator.alpha = 0
            self.viewIndicator.frame.origin.y -= 40
            self.springIndicator.stop()
        }, completion: nil)
    }
    
    @objc func searchOption(_ gestureRecognizer: UITapGestureRecognizer) {
        performSegue(withIdentifier: "searchOptionsSegue", sender: self)
    }
    
    @objc func newestFirst(_ gestureRecognizer: UITapGestureRecognizer) {
        print("newest first")
    }
    
//    private func loadCardDetails() {
//        viewCarDetails.viewFeature1.imgFeature.image = UIImage(named: "petrol")
//        viewCarDetails.viewFeature1.lblFeature.text = "Petrol"
//        print(viewCarDetails.viewFeature1.bounds.width)
//
//        viewCarDetails.viewFeature2.imgFeature.image = UIImage(named: "engine")
//        viewCarDetails.viewFeature2.lblFeature.text = "1.3L"
//
//        viewCarDetails.viewFeature3.imgFeature.image = UIImage(named: "transmission")
//        viewCarDetails.viewFeature3.lblFeature.text = "Auto"
//
//        viewCarDetails.viewFeature4.imgFeature.image = UIImage(named: "year")
//        viewCarDetails.viewFeature4.lblFeature.text = "2019"
//
//        viewCarDetails.viewFeature5.imgFeature.image = UIImage(named: "readyToShipSk")
//        viewCarDetails.viewFeature5.lblFeature.text = "Ready to\nShip"
//    }
    
//    @objc func handleButton( sender : UIButton ) {
//        // It would be nice is isEnabled worked...
//        sender.alpha = sender.alpha == 1.0 ? 0.5 : 1.0
//    }
    
    @IBAction func onBackTouch(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: vehicleCategoryTableViewCell, for: indexPath) as! VehicleCategoryTableViewCell
        cell.imgBrand.image = UIImage(named: "car-\(indexPath.row+1)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "itemDescriptionSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !shownIndexes.contains(indexPath) {
            shownIndexes.append(indexPath)
            tableView.isUserInteractionEnabled = true
            let cellItem = cell as! VehicleCategoryTableViewCell
            cellItem.alpha = 0
            UIView.animate(withDuration: 1, delay: (0.5*Double(indexPath.row)), options: .curveLinear, animations: {
                cellItem.alpha = 1
            }, completion: nil)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandsList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = vehicleCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: vehicleCategoryCollectionViewCell, for: indexPath) as! VehicleCategoryCollectionViewCell
        cell.lblItemName.text = brandsList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select \(indexPath.row)")
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselect \(indexPath.row)")
    }
    
    public func setItemId(id: Int) {
        self.itemId = id
    }
}
