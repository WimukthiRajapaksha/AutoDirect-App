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
//    @IBOutlet weak var viewSearchDetails: UIView!
//    @IBOutlet weak var viewSearchOption: UIView!
//    @IBOutlet weak var viewNewestFirst: UIView!
//    @IBOutlet weak var lblSearchResultCount: UILabel!
    
    private let vehicleCategoryTableViewCell: String
    private let vehicleCategoryCollectionViewCell: String
    private var brandsList: [String]
    private var shownIndexes: [IndexPath]
    private var fromSearch: Bool
    private var itemId: Int
    private let springIndicator: SpringIndicator
    private let viewIndicator: UIView
//    private var shimmeringView: FBShimmeringView?
    private var firstTimeLoadingIndecator: Bool
    private var tableData: [VehicleModelInDetail?]
    private var previouslySelectedModel: String
    private var selectedVehicleModel: VehicleModelInDetail?
    private var trendingModel: String?
    
    
    required init?(coder aDecoder: NSCoder) {
        itemId = 0
        fromSearch = false
        firstTimeLoadingIndecator = true
        shownIndexes = []
        tableData = []
        previouslySelectedModel = ""
        viewIndicator = UIView(frame: CGRect(x: UIScreen.main.bounds.width/2-30, y: UIScreen.main.bounds.height/3.7-30, width: 60, height: 60))
        springIndicator = SpringIndicator(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        vehicleCategoryTableViewCell = "VehicleCategoryTableViewCell"
        vehicleCategoryCollectionViewCell = "VehicleCategoryCollectionViewCell"
        brandsList = []
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTimeLoadingIndecator = true
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
//        viewSearchOption.layer.cornerRadius = viewSearchOption.frame.height / 2.0
//        viewNewestFirst.layer.cornerRadius = viewNewestFirst.frame.height / 2.0
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: vehicleCategoryTableViewCell, bundle: nil), forCellReuseIdentifier: vehicleCategoryTableViewCell)
        tableView.tableFooterView = UIView()
        
        vehicleCategoryCollectionView.delegate = self
        vehicleCategoryCollectionView.dataSource = self
        vehicleCategoryCollectionView.register(UINib(nibName: vehicleCategoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: vehicleCategoryCollectionViewCell)
        
//        viewSearchOption.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.searchOption(_:))))
//        viewSearchOption.isUserInteractionEnabled = true
        
//        viewNewestFirst.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.newestFirst(_:))))
//        viewNewestFirst.isUserInteractionEnabled = true
        navigationItem.leftBarButtonItem = backBarButton()
        
        tableView.gradient(width: UIScreen.main.bounds.width, height: 30, colors: [UIColor(rgb: 0x0b0f0f).cgColor, UIColor(rgb: 0x1b1f2a).cgColor])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        firstTimeLoadingIndecator = false
        selectedVehicleModel = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shownIndexes = []
        selectedVehicleModel = nil
        self.brandsList.removeAll()
        
        springIndicator.start()
        viewIndicator.alpha = 0
        viewIndicator.frame.origin.y -= 40
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.viewIndicator.alpha = 1
            self.viewIndicator.frame.origin.y += 40
        }, completion: nil)
        
        
        super.domain.getAllMakes { (boolResponse, jsonResponse) in
            print(boolResponse)
            print(jsonResponse)
            if boolResponse {
                self.brandsList = jsonResponse.arrayObject as! [String]
                let index = self.brandsList.firstIndex(of: "")
                if index != nil {
                    self.brandsList.remove(at: index!)
                }
//                if (self.brandsList[0] == "") {
//                    self.brandsList[0] = "All"
//                }
            } else {
                self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
            }
            self.vehicleCategoryCollectionView.reloadData()
        }
        
        var condition = ""
        if (self.itemId == 0) {
            self.title = "New Vehicles"
            condition = "new"
        } else if (self.itemId == 1) {
            self.title = "Pre-Owned Vehicles"
            condition = "pre-owned"
        } else if (self.itemId == 2) {
            self.title = "Ready to Ship"
            condition = "ready to ship"
        } else if (self.itemId == 3) {
            self.title = "GOV Permits"
            condition = "gov permits"
        } else if (self.itemId == 10) {
            self.title = ""
        } else {
            self.title = "Search"
        }
        if (self.itemId == 0 || self.itemId == 1 || self.itemId == 2 || self.itemId == 3) {
            super.domain.getFindByCondition(condition: condition) { (boolResponse, jsonResponse) in
                print(boolResponse)
                print(jsonResponse)
                if boolResponse {
                    for (_, item) in jsonResponse {
                        self.tableData.append(VehicleModelInDetail(autoId: item["autoid"].intValue, id: item["autoid"].int, title: item["title"].stringValue, conditions: item["conditions"].stringValue, bodies: item["bodies"].stringValue, makes: item["makes"].stringValue, models: item["models"].stringValue, mileages: item["mileages"].stringValue, fuelTypes: item["fueltypes"].stringValue, engines: item["engines"].stringValue, years: item["years"].intValue, rentals: item["rentals"].stringValue, fuelConsumptions: item["fuelconsumptions"].stringValue, transmission: item["transmission"].stringValue, drives: item["drives"].stringValue, fuelEconomy: item["fueleconomy"].stringValue, exteriorColors: item["exteriorColors"].stringValue, interiorColors: item["interiorColors"].stringValue, availabilities: item["availabilities"].stringValue, additionalFeatures: item["additionalfeatures"].stringValue, prominentWords: item["prominentwords"].stringValue, quotation: item["quotation"].stringValue, price: item["price"].intValue, downPayment: item["downPayment"].stringValue, imageURL: item["imageURL"].stringValue, stockNumber: item["stockNumber"].stringValue))
                    }
                    print(self.tableData.count)
                } else {
                    self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
                }
                self.tableView.reloadData()
                
                self.viewIndicator.alpha = 1
                UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                    self.viewIndicator.alpha = 0
                    self.viewIndicator.frame.origin.y -= 40
                    self.springIndicator.stop()
                }, completion: { (boolValue) in
                    self.view.isUserInteractionEnabled = true
                })
            }
        } else if (self.itemId == 10) {
            super.domain.getFindByModel(model: trendingModel!) { (boolResponse, jsonResponse) in
                print(boolResponse)
                print(jsonResponse)
                if boolResponse {
                    for (_, item) in jsonResponse {
                        self.tableData.append(VehicleModelInDetail(autoId: item["autoid"].intValue, id: item["autoid"].int, title: item["title"].stringValue, conditions: item["conditions"].stringValue, bodies: item["bodies"].stringValue, makes: item["makes"].stringValue, models: item["models"].stringValue, mileages: item["mileages"].stringValue, fuelTypes: item["fueltypes"].stringValue, engines: item["engines"].stringValue, years: item["years"].intValue, rentals: item["rentals"].stringValue, fuelConsumptions: item["fuelconsumptions"].stringValue, transmission: item["transmission"].stringValue, drives: item["drives"].stringValue, fuelEconomy: item["fueleconomy"].stringValue, exteriorColors: item["exteriorColors"].stringValue, interiorColors: item["interiorColors"].stringValue, availabilities: item["availabilities"].stringValue, additionalFeatures: item["additionalfeatures"].stringValue, prominentWords: item["prominentwords"].stringValue, quotation: item["quotation"].stringValue, price: item["price"].intValue, downPayment: item["downPayment"].stringValue, imageURL: item["imageURL"].stringValue, stockNumber: item["stockNumber"].stringValue))
                    }
                    print(self.tableData.count)
                } else {
                    self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
                }
                self.tableView.reloadData()
                
                self.viewIndicator.alpha = 1
                UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                    self.viewIndicator.alpha = 0
                    self.viewIndicator.frame.origin.y -= 40
                    self.springIndicator.stop()
                }, completion: { (boolValue) in
                    self.view.isUserInteractionEnabled = true
                })
            }
        }
        
//        springIndicator.start()
//        viewIndicator.alpha = 0
//        viewIndicator.frame.origin.y -= 40
//        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
//            self.viewIndicator.alpha = 1
//            self.viewIndicator.frame.origin.y += 40
//        }, completion: nil)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        springIndicator.stop()
//        viewIndicator.isHidden = true
        
//        viewIndicator.alpha = 1
//        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
//            self.viewIndicator.alpha = 0
//            self.viewIndicator.frame.origin.y -= 40
//            self.springIndicator.stop()
//        }, completion: nil)
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
//
//    @IBAction func onBackTouch(_ sender: Any) {
//        self.navigationController?.popViewController(animated:true)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: vehicleCategoryTableViewCell, for: indexPath) as! VehicleCategoryTableViewCell
        let imageList = tableData[indexPath.row]?.getImageUrl().components(separatedBy: "|")
        cell.setItemData(
            brandName: (tableData[indexPath.row]?.getTitle())!,
            brandDetail: "????",
            imageUrl: imageList![0],
            amount: ((tableData[indexPath.row]?.getPrice())! != 0) ? "\((tableData[indexPath.row]?.getPrice())!.withCommas())" : "N/A",
            fuelType: ((tableData[indexPath.row]?.getFuelTypes())! != "") ? (tableData[indexPath.row]?.getFuelTypes())! : "N/A",
            engine: ((tableData[indexPath.row]?.getEngines())! != "") ? (tableData[indexPath.row]?.getEngines())! : "N/A",
            transmission: ((tableData[indexPath.row]?.getTransmission())! != "") ? (tableData[indexPath.row]?.getTransmission())! : "N/A",
            year: ((tableData[indexPath.row]?.getYears())! != 0) ? "\((tableData[indexPath.row]?.getYears())!)" : "N/A",
            type: ((tableData[indexPath.row]?.getConditions())! != "") ? (tableData[indexPath.row]?.getConditions())! : "N/A")
//        cell.imgBrand.image = UIImage(named: "car-\(indexPath.row+1)")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVehicleModel = tableData[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView()
        viewHeader.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30)
        return viewHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return brandsList.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        containerView.backgroundColor = isSelected ? UIColor(rgb: 0x63b946) : .clear
        let cell = vehicleCategoryCollectionView.dequeueReusableCell(withReuseIdentifier: vehicleCategoryCollectionViewCell, for: indexPath) as! VehicleCategoryCollectionViewCell
        if (itemId != 10) {
//            if (indexPath.row == 0 && firstTimeLoadingIndecator) {
//                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
//                cell.containerView.backgroundColor = UIColor(rgb: 0x63b946)
//                firstTimeLoadingIndecator = false
//            } else
            if (previouslySelectedModel == brandsList[indexPath.row]) {
                collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
                cell.containerView.backgroundColor = UIColor(rgb: 0x63b946)
            }
        }
        cell.lblItemName.text = brandsList[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        tableView.setContentOffset(.zero, animated: true)
        if (tableData.count > 0) {
            tableView.setContentOffset(.zero, animated: true)
//            tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
        }
        previouslySelectedModel = brandsList[indexPath.row]
        print("select \(indexPath.row)")
//        let cell = collectionView.cellForItem(at: indexPath) as! VehicleCategoryCollectionViewCell
//        cell.containerView.backgroundColor = UIColor(rgb: 0x63b946)
        
        
        
        springIndicator.start()
        viewIndicator.alpha = 0
        viewIndicator.frame.origin.y -= 40
        self.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.viewIndicator.alpha = 1
            self.viewIndicator.frame.origin.y += 40
        }, completion: nil)
        
        
        
        super.domain.getFindByMake(make: brandsList[indexPath.row]) { (boolResponse, jsonResponse) in
            print(boolResponse)
            print(jsonResponse)
            self.tableData.removeAll()
            if boolResponse {
                for (_, item) in jsonResponse {
                    self.tableData.append(VehicleModelInDetail(autoId: item["autoid"].intValue, id: item["autoid"].int, title: item["title"].stringValue, conditions: item["conditions"].stringValue, bodies: item["bodies"].stringValue, makes: item["makes"].stringValue, models: item["models"].stringValue, mileages: item["mileages"].stringValue, fuelTypes: item["fueltypes"].stringValue, engines: item["engines"].stringValue, years: item["years"].intValue, rentals: item["rentals"].stringValue, fuelConsumptions: item["fuelconsumptions"].stringValue, transmission: item["transmission"].stringValue, drives: item["drives"].stringValue, fuelEconomy: item["fueleconomy"].stringValue, exteriorColors: item["exteriorColors"].stringValue, interiorColors: item["interiorColors"].stringValue, availabilities: item["availabilities"].stringValue, additionalFeatures: item["additionalfeatures"].stringValue, prominentWords: item["prominentwords"].stringValue, quotation: item["quotation"].stringValue, price: item["price"].intValue, downPayment: item["downPayment"].stringValue, imageURL: item["imageURL"].stringValue, stockNumber: item["stockNumber"].stringValue))
                }
                print(self.tableData.count)
            } else {
                self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
            }
//            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
            self.tableView.reloadData()
//            self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
            
            self.viewIndicator.alpha = 1
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                self.viewIndicator.alpha = 0
                self.viewIndicator.frame.origin.y -= 40
                self.springIndicator.stop()
            }, completion: { (boolValue) in
                self.view.isUserInteractionEnabled = true
            })
            
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("deselect \(indexPath.row)")
//        let cell = collectionView.cellForItem(at: indexPath) as! VehicleCategoryCollectionViewCell
//        cell.containerView.backgroundColor = .clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "itemDescriptionSegue") {
            let vc = segue.destination as! ModelDetailsViewController
            vc.setSelectedVehicleModel(vehicleModel: selectedVehicleModel!)
        }
    }
    
    public func setItemId(id: Int, trendingItemName: String = "") {
        self.itemId = id
        trendingModel = trendingItemName
    }
}

