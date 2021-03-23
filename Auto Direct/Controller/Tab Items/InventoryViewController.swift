//
//  InventoryViewController.swift
//  Auto Direct
//
//  Created by User on 4/6/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import SpringIndicator
import Shimmer

class InventoryViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource, SearchOptionsResultDelegate {
//    @IBOutlet var shimming: FBShimmeringView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vehicleCategoryCollectionView: UICollectionView!
    @IBOutlet weak var viewSearchDetails: UIView!
    @IBOutlet weak var lblSearchResultCount: UILabel!
    @IBOutlet weak var viewSearchResults: UIView!
    @IBOutlet weak var btnSearchOption: UIButton!
    @IBOutlet weak var btnNewestFirst: UIButton!
    @IBOutlet weak var viewNoVehiclesAvailable: UIView!
    
    private let vehicleCategoryTableViewCell: String
    private let vehicleCategoryCollectionViewCell: String
    private let brandsList: [String]
    private var shownIndexes: [IndexPath]
    private var fromSearch: Bool
    private var itemId: Int
    private let springIndicator: SpringIndicator
    private let viewIndicator: UIView
    private var tableData: [VehicleModelInDetail?]
    private var allTableData: [VehicleModelInDetail?]
    private var make: String
    private var selectedvehicleDetails: VehicleModelInDetail!
    var fromTabSearch: Bool
//    private var shimmeringView: FBShimmeringView?
    
    private var springStillShowing: Bool
    
    required init?(coder aDecoder: NSCoder) {
        itemId = 0
        fromSearch = false
        fromTabSearch = false
        shownIndexes = []
        make = ""
        viewIndicator = UIView(frame: CGRect(x: UIScreen.main.bounds.width/2-30, y: UIScreen.main.bounds.height/3.7-30, width: 60, height: 60))
        springIndicator = SpringIndicator(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        vehicleCategoryTableViewCell = "VehicleCategoryTableViewCell"
        vehicleCategoryCollectionViewCell = "VehicleCategoryCollectionViewCell"
        brandsList = ["All", "Audi", "BMW", "Honda", "Jeep", "Mazda", "Benz", "MG", "Mini", "Nissan", "Peugeot", "Subaru", "Suzuki", "Toyota", "Volkswagen"]
        tableData = []
        allTableData = []
        self.springStillShowing = false
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
        
//        shimming.isShimmering = true
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: vehicleCategoryTableViewCell, bundle: nil), forCellReuseIdentifier: vehicleCategoryTableViewCell)
        tableView.tableFooterView = UIView()
        
        viewSearchResultsShowHide(hide: true)
        
        vehicleCategoryCollectionView.delegate = self
        vehicleCategoryCollectionView.dataSource = self
        vehicleCategoryCollectionView.register(UINib(nibName: vehicleCategoryCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: vehicleCategoryCollectionViewCell)
        vehicleCategoryCollectionView.isHidden = true

        if ((navigationController?.viewControllers.count)! >= 2) && (navigationController?.viewControllers[(navigationController?.viewControllers.count)!-2] is SearchViewController) {
            navigationItem.leftBarButtonItem = backBarButton()
            self.title = "Search"
        } else {
            navigationItem.leftBarButtonItem = setLeftRevealSidebar()
            self.title = "INVENTORY"
        }
        
        
        tableView.gradient(width: UIScreen.main.bounds.width, height: 30, colors: [UIColor(rgb: 0x0b0f0f).cgColor, UIColor(rgb: 0x1b1f2a).cgColor])
        
        btnNewestFirst.layer.cornerRadius = btnNewestFirst.frame.height/2
        btnSearchOption.layer.cornerRadius = btnSearchOption.frame.height/2
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shownIndexes = []
        springIndicator.start()
        viewIndicator.alpha = 0
        viewIndicator.frame.origin.y -= 40
        self.view.isUserInteractionEnabled = false
        self.springStillShowing = true
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveLinear, animations: {
            self.viewIndicator.alpha = 1
            self.viewIndicator.frame.origin.y += 40
        }, completion: nil)
        print(fromSearch)
        print(fromTabSearch)
        self.tableView.setContentOffset(.zero, animated: true)
        if !fromSearch && !fromTabSearch {
//            self.tableData = self.allTableData
//            self.tableView.reloadData()
//            self.viewSearchResults.isHidden = false
//            if self.tableData.count > 0 {
//                self.lblSearchResultCount.text = (self.tableData.count == 1) ? "\(self.tableData.count) Vehicle Available" : "\(self.tableData.count) Vehicles Available"
//            } else {
//                self.lblSearchResultCount.text = "0 Vehicles Available"
//            }
//
//            self.viewIndicator.alpha = 1
//            self.viewSearchResults.isHidden = false
//            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
//                self.viewIndicator.alpha = 0
//                self.viewIndicator.frame.origin.y -= 40
//                self.springIndicator.stop()
//            }, completion: { (boolVal) in
//                self.view.isUserInteractionEnabled = true
//            })
//
            
            if (allTableData.count == 0) {
                super.domain.getAllVehicles { (boolResponse, jsonResponse) in
                    print(boolResponse)
                    print(jsonResponse)
                    if boolResponse {
                        for (_, item) in jsonResponse {
                            self.allTableData.append(VehicleModelInDetail(autoId: item["autoid"].intValue, id: item["autoid"].int, title: item["title"].stringValue, conditions: item["conditions"].stringValue, bodies: item["bodies"].stringValue, makes: item["makes"].stringValue, models: item["models"].stringValue, mileages: item["mileages"].stringValue, fuelTypes: item["fueltypes"].stringValue, engines: item["engines"].stringValue, years: item["years"].intValue, rentals: item["rentals"].stringValue, fuelConsumptions: item["fuelconsumptions"].stringValue, transmission: item["transmission"].stringValue, drives: item["drives"].stringValue, fuelEconomy: item["fueleconomy"].stringValue, exteriorColors: item["exteriorColors"].stringValue, interiorColors: item["interiorColors"].stringValue, availabilities: item["availabilities"].stringValue, additionalFeatures: item["additionalfeatures"].stringValue, prominentWords: item["prominentwords"].stringValue, quotation: item["quotation"].stringValue, price: item["price"].intValue, downPayment: item["downPayment"].stringValue, imageURL: item["imageURL"].stringValue, stockNumber: item["stockNumber"].stringValue, permalink: item["permalink"].stringValue, video: item["video"].stringValue))
                        }
                        print(self.fromSearch)
                        print(self.fromTabSearch)
                        
                        self.tableData = self.allTableData
                        if (self.tableData.count == 0) {
                            self.viewNoVehiclesAvailable.isHidden = false
                        } else {
                            self.viewNoVehiclesAvailable.isHidden = true
                        }
                        self.viewSearchResults.isHidden = false
                        if self.tableData.count > 0 {
                            self.viewSearchResults.isHidden = false
                            self.lblSearchResultCount.text = (self.tableData.count == 1) ? "\(self.tableData.count) Vehicle Available" : "\(self.tableData.count) Vehicles Available"
                        } else {
                            self.viewSearchResults.isHidden = true
                        }
                        self.tableView.reloadData()
                        
                    } else {
                        self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
                        self.viewSearchResults.isHidden = true
                    }
                    self.tableView.reloadData()
                    self.viewIndicator.alpha = 1
                    UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                        self.viewIndicator.alpha = 0
                        self.viewIndicator.frame.origin.y -= 40
                        self.springIndicator.stop()
                    }, completion: { (boolVal) in
                        self.view.isUserInteractionEnabled = true
                        self.springStillShowing = false
                    })
                }
            } else {
                self.tableData = self.allTableData
                if (self.tableData.count == 0) {
                    self.viewNoVehiclesAvailable.isHidden = false
                } else {
                    self.viewNoVehiclesAvailable.isHidden = true
                }
//                self.viewSearchResults.isHidden = false
                if self.tableData.count > 0 {
                    self.viewSearchResults.isHidden = false
                    self.lblSearchResultCount.text = (self.tableData.count == 1) ? "\(self.tableData.count) Vehicle Available" : "\(self.tableData.count) Vehicles Available"
                } else {
                    self.viewSearchResults.isHidden = true
//                    self.lblSearchResultCount.text = "0 Vehicles Available"
                }
                
                self.tableView.reloadData()
                self.viewIndicator.alpha = 1
                UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                    self.viewIndicator.alpha = 0
                    self.viewIndicator.frame.origin.y -= 40
                    self.springIndicator.stop()
                }, completion: { (boolVal) in
                    self.view.isUserInteractionEnabled = true
                    self.springStillShowing = false
                })
            }
        } else if (!fromTabSearch && fromSearch) {
            fromSearch = !fromSearch
            if (self.tableData.count == 0) {
                self.viewNoVehiclesAvailable.isHidden = false
            } else {
                self.viewNoVehiclesAvailable.isHidden = true
            }
            if tableData.count > 0 {
                self.viewSearchResults.isHidden = false
                self.lblSearchResultCount.text = (tableData.count == 1) ? "\(tableData.count) \(tableData[0]?.getMakes() ?? "") \(tableData[0]?.getModels() ?? "") Vehicle Available" : "\(tableData.count) \(tableData[0]?.getMakes() ?? "") \(tableData[0]?.getModels() ?? "") Vehicles Available"
            } else {
                self.viewSearchResults.isHidden = true
//                self.lblSearchResultCount.text = "0 Vehicles Available"
            }
            self.viewIndicator.alpha = 1
//            self.viewSearchResults.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.viewIndicator.alpha = 0
                self.viewIndicator.frame.origin.y -= 40
                self.springIndicator.stop()
            }, completion: { (boolVal) in
                self.view.isUserInteractionEnabled = true
                self.springStillShowing = false
            })
        } else {
//            fromTabSearch = !fromTabSearch
//            if (self.tableData.count == 0) {
//                self.viewNoVehiclesAvailable.isHidden = false
//            } else {
//                self.viewNoVehiclesAvailable.isHidden = true
//            }
            if tableData.count > 0 {
                print(tableData[0])
                self.viewSearchResults.isHidden = false
                self.lblSearchResultCount.text = (tableData.count == 1) ? "\(tableData.count) \(tableData[0]?.getMakes() ?? "") \(tableData[0]?.getModels() ?? "") Vehicle Available" : "\(tableData.count) \(tableData[0]?.getMakes() ?? "") \(tableData[0]?.getModels() ?? "") Vehicles Available"
            } else {
                self.viewSearchResults.isHidden = true
//                self.lblSearchResultCount.text = "0 Vehicles Available"
            }
            self.viewIndicator.alpha = 1
//            self.viewSearchResults.isHidden = false
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear, animations: {
                self.viewIndicator.alpha = 0
                self.viewIndicator.frame.origin.y -= 40
                self.springIndicator.stop()
            }, completion: { (boolVal) in
                self.view.isUserInteractionEnabled = true
                self.springStillShowing = false
            })
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        springIndicator.stop()
//        viewIndicator.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.springStillShowing {
            self.viewIndicator.alpha = 1
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                self.viewIndicator.alpha = 0
                self.viewIndicator.frame.origin.y -= 40
                self.springIndicator.stop()
            }, completion: { (boolValue) in
                self.view.isUserInteractionEnabled = true
                self.springStillShowing = false
            })
        }
    }
    
    private func viewSearchResultsShowHide(hide: Bool, make: String = "", resultCount: Int = 0) {
        self.viewSearchResults.isHidden = hide
        if !hide {
            print(make)
            if (make != "") {
                self.lblSearchResultCount.text = (resultCount == 1) ? "\(resultCount) \(make) Vehicle Available" : "\(resultCount) \(make) Vehicles Available"
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let viewHeader = UIView()
        viewHeader.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30)
        return viewHeader
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
//        if (tableData.count > 0) {
//        self.viewSearchResultsShowHide(hide: false, make: make, resultCount: tableData.count)
//        }
        print(tableData.count)
        return tableData.count
//        }
//        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
//        if tableData.count > indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: vehicleCategoryTableViewCell, for: indexPath) as! VehicleCategoryTableViewCell
            let imageList = tableData[indexPath.row]?.getImageUrl().components(separatedBy: "|")
            cell.setItemData(
                brandName: ((tableData[indexPath.row]?.getTitle())! != "") ? (tableData[indexPath.row]?.getTitle())! : "N/A",
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
    //        cell.imgBrand.image = UIImage(named: "car-\(indexPath.row+1)")
            return cell
//        } else {
//            return UITableViewCell()
//        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedvehicleDetails = tableData[indexPath.row]
        performSegue(withIdentifier: "itemDescriptionSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if !shownIndexes.contains(indexPath) {
//            shownIndexes.append(indexPath)
//            tableView.isUserInteractionEnabled = true
//            let cellItem = cell as! VehicleCategoryTableViewCell
//            cellItem.alpha = 0
//            UIView.animate(withDuration: 1, delay: (0.5*Double(indexPath.row)), options: .curveLinear, animations: {
//                cellItem.alpha = 1
//            }, completion: nil)
//        }
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
    
    @IBAction func onSearchOptionTouch(_ sender: Any) {
        self.tableView.setContentOffset(.zero, animated: true)
        performSegue(withIdentifier: "searchOptionsSegue", sender: self)
    }
    
    @IBAction func onNewestFirstTouch(_ sender: Any) {
        print("newest first")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "searchOptionsSegue") {
            let vc = segue.destination as! SearchOptionNewViewController
            vc.searchOptionsResultDelegate = self
//            vc.searchOptionsDelegate = self
        } else if (segue.identifier == "itemDescriptionSegue") {
            let vc = segue.destination as! ModelDetailsViewController
            vc.setSelectedVehicleModel(vehicleModel: selectedvehicleDetails)
        }
    }
    
    public func setTableData(make: String = "", tableData: [VehicleModelInDetail?] = [], error: String = "") {
        if (error == "") {
            self.viewSearchResultsShowHide(hide: false, make: make, resultCount: tableData.count)
            self.tableData = tableData
            if (self.tableData.count == 0) {
                self.viewNoVehiclesAvailable.isHidden = false
                self.viewSearchResults.isHidden = true
            } else {
                self.viewNoVehiclesAvailable.isHidden = true
                self.viewSearchResults.isHidden = false
            }
            print(tableData.count)
            self.tableView.reloadData()
        } else {
            print(error)
            self.view!.makeToast(error, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
        }
    }
    
    func searchOptions(condition: Int, make: String, model: String, year: String, minPrice: String, maxPrice: String) {
        print(condition)
        print(make)
        print(model)
        print(year)
        print(minPrice)
        print(maxPrice)
        viewSearchResultsShowHide(hide: false, make: make, resultCount: 3)
    }
    
    public func setItemId(id: Int) {
        self.itemId = id
    }
    
    func searchOptionsResult(result: [VehicleModelInDetail?]) {
        self.tableData = result
        if (self.tableData.count == 0) {
            self.viewNoVehiclesAvailable.isHidden = false
            self.viewSearchResults.isHidden = true
        } else {
            self.viewNoVehiclesAvailable.isHidden = true
            self.viewSearchResults.isHidden = false
        }
        fromSearch = true
        self.tableView.reloadData()
    }
}
