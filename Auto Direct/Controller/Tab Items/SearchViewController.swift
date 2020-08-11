//
//  SearchViewController.swift
//  Auto Direct
//
//  Created by User on 4/6/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var collectionBrands: UICollectionView!
    @IBOutlet weak var collectionTrending: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var lblBrands: UILabel!
    @IBOutlet weak var lblTrending: UILabel!
    
    private var searchString: String
    private var selectedMake: String
    private var selectedTrending: VehicleModel?
    
    private var makeList: [String]
    private var trendingList: [VehicleModel?]
        
    required init?(coder aDecoder: NSCoder) {
        self.searchString = ""
        makeList = []
        trendingList = []
        selectedMake = ""
        selectedTrending = nil
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        searchBarBtn.image = UIImage(named: "condition")!.roundedImageWithBorder(width: 20, color: UIColor.green)
//        searchBarBtn.selectedImage = UIImage(named: "condition")!.roundedImageWithBorder(width: 20, color: UIColor.green)
        
        self.navigationItem.rightBarButtonItem  = setCloseButton()
        self.navigationItem.leftBarButtonItem = nil
                
        self.navigationItem.title = "Search Vehicles"
        
        collectionBrands.delegate = self
        collectionBrands.dataSource = self
        collectionBrands.accessibilityIdentifier = "brandsCollection"
        collectionTrending.delegate = self
        collectionTrending.dataSource = self
        collectionTrending.accessibilityIdentifier = "trendingCollection"
        searchBar.delegate = self
                
        searchBar.barTintColor = UIColor(rgb: 0x1b1f2a)
        
//        self.tabBarController?.tabBar.isHidden = true
        
        searchBar.searchTextField.textColor = UIColor.blue
        searchBar.searchTextField.backgroundColor = UIColor.white
        
//        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        
        selectedMake = ""
        selectedTrending = nil
        
        trendingList.removeAll()
        makeList.removeAll()
        super.domain.getTrendingVehicleModels { (boolResponse, jsonResponse) in
            print(boolResponse)
            print(jsonResponse)
            if boolResponse {
                for (_, item) in jsonResponse {
                    self.trendingList.append(VehicleModel(modelId: item["id"].intValue, modelName: item["trendingModel"].stringValue))
                }
                self.collectionTrending.reloadData()
            } else {
                self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
            }
        }
        
        super.domain.getAllMakes { (boolResponse, jsonResponse) in
            print(boolResponse)
            print(jsonResponse)
            if boolResponse {
                self.makeList = jsonResponse.arrayObject as! [String]
                let index = self.makeList.firstIndex(of: "")
                if index != nil {
                    self.makeList.remove(at: index!)
                }
                self.collectionBrands.reloadData()
            } else {
                self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView.accessibilityIdentifier == "trendingCollection") {
            return self.trendingList.count
        } else {
            return self.makeList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView.accessibilityIdentifier == "trendingCollection") {
            let cell = collectionTrending.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
            cell.lblText.text = self.trendingList[indexPath.row]?.getModelName()
            cell.isSelected = false
            return cell
        } else {
            let cell = collectionTrending.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
            cell.lblText.text = self.makeList[indexPath.row]
            cell.isSelected = false
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! SearchCollectionViewCell
        cell.isSelected = true
        
        if (collectionView.accessibilityIdentifier == "trendingCollection") {
            selectedTrending = trendingList[indexPath.row]
        } else {
            selectedMake = makeList[indexPath.row]
        }
        self.performSegue(withIdentifier: "searchResultSegue", sender: self)
        self.view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SearchCollectionViewCell
        cell.isSelected = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if (searchBar.text != nil && searchBar.text != "") {
            self.searchString = searchBar.text!
            self.performSegue(withIdentifier: "searchResultSegue", sender: self)
        } else {
            self.view!.makeToast("Vehicle name can't be empty.", duration: 3, position: .bottom, title: "Sorry!", completion: nil)
        }
        self.dismissKeyboard()
//        performSegue(withIdentifier: "searchResultSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "searchResultSegue") {
            self.hidesBottomBarWhenPushed = false
            let vehicleCategory = segue.destination as! InventoryViewController
//            vehicleCategory.setItemId(id: 5)
            vehicleCategory.fromTabSearch = true
            
            if (selectedTrending != nil) {
                var data = [VehicleModelInDetail?]()
                super.domain.getFindByModel(model: (selectedTrending?.getModelName())!) { (boolResponse, jsonResponse) in
                    print(boolResponse)
                    print(jsonResponse)
                    if boolResponse {
                        for (_, item) in jsonResponse {
                            data.append(VehicleModelInDetail(autoId: item["autoid"].intValue, id: item["autoid"].int, title: item["title"].stringValue, conditions: item["conditions"].stringValue, bodies: item["bodies"].stringValue, makes: item["makes"].stringValue, models: item["models"].stringValue, mileages: item["mileages"].stringValue, fuelTypes: item["fueltypes"].stringValue, engines: item["engines"].stringValue, years: item["years"].intValue, rentals: item["rentals"].stringValue, fuelConsumptions: item["fuelconsumptions"].stringValue, transmission: item["transmission"].stringValue, drives: item["drives"].stringValue, fuelEconomy: item["fueleconomy"].stringValue, exteriorColors: item["exteriorColors"].stringValue, interiorColors: item["interiorColors"].stringValue, availabilities: item["availabilities"].stringValue, additionalFeatures: item["additionalfeatures"].stringValue, prominentWords: item["prominentwords"].stringValue, quotation: item["quotation"].stringValue, price: item["price"].intValue, downPayment: item["downPayment"].stringValue, imageURL: item["imageURL"].stringValue, stockNumber: item["stockNumber"].stringValue, permalink: item["permalink"].stringValue, video: item["video"].stringValue))
                        }
                        vehicleCategory.setTableData(make: (self.selectedTrending?.getModelName())!, tableData: data)
                    } else {
                        self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
                        vehicleCategory.setTableData(error: jsonResponse["message"].stringValue)
                    }
                }
            } else if (selectedMake != "") {
                var data = [VehicleModelInDetail?]()
                super.domain.getFindByMake(make: selectedMake) { (boolResponse, jsonResponse) in
                    print(boolResponse)
                    print(jsonResponse)
                    if boolResponse {
                        for (_, item) in jsonResponse {
                            data.append(VehicleModelInDetail(autoId: item["autoid"].intValue, id: item["autoid"].int, title: item["title"].stringValue, conditions: item["conditions"].stringValue, bodies: item["bodies"].stringValue, makes: item["makes"].stringValue, models: item["models"].stringValue, mileages: item["mileages"].stringValue, fuelTypes: item["fueltypes"].stringValue, engines: item["engines"].stringValue, years: item["years"].intValue, rentals: item["rentals"].stringValue, fuelConsumptions: item["fuelconsumptions"].stringValue, transmission: item["transmission"].stringValue, drives: item["drives"].stringValue, fuelEconomy: item["fueleconomy"].stringValue, exteriorColors: item["exteriorColors"].stringValue, interiorColors: item["interiorColors"].stringValue, availabilities: item["availabilities"].stringValue, additionalFeatures: item["additionalfeatures"].stringValue, prominentWords: item["prominentwords"].stringValue, quotation: item["quotation"].stringValue, price: item["price"].intValue, downPayment: item["downPayment"].stringValue, imageURL: item["imageURL"].stringValue, stockNumber: item["stockNumber"].stringValue, permalink: item["permalink"].stringValue, video: item["video"].stringValue))
                        }
                        vehicleCategory.setTableData(make: self.selectedMake, tableData: data)
                    } else {
                        self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
                        vehicleCategory.setTableData(error: jsonResponse["message"].stringValue)
                    }
                }
            } else {
                super.domain.getTextSearch(text: searchString) { (boolResponse, jsonResponse) in
                    print(boolResponse)
                    print(jsonResponse)
                    if boolResponse {
                        var data = [VehicleModelInDetail?]()
                        for (_, item) in jsonResponse {
                            data.append(VehicleModelInDetail(autoId: item["autoid"].intValue, id: item["autoid"].int, title: item["title"].stringValue, conditions: item["conditions"].stringValue, bodies: item["bodies"].stringValue, makes: item["makes"].stringValue, models: item["models"].stringValue, mileages: item["mileages"].stringValue, fuelTypes: item["fueltypes"].stringValue, engines: item["engines"].stringValue, years: item["years"].intValue, rentals: item["rentals"].stringValue, fuelConsumptions: item["fuelconsumptions"].stringValue, transmission: item["transmission"].stringValue, drives: item["drives"].stringValue, fuelEconomy: item["fueleconomy"].stringValue, exteriorColors: item["exteriorColors"].stringValue, interiorColors: item["interiorColors"].stringValue, availabilities: item["availabilities"].stringValue, additionalFeatures: item["additionalfeatures"].stringValue, prominentWords: item["prominentwords"].stringValue, quotation: item["quotation"].stringValue, price: item["price"].intValue, downPayment: item["downPayment"].stringValue, imageURL: item["imageURL"].stringValue, stockNumber: item["stockNumber"].stringValue, permalink: item["permalink"].stringValue, video: item["video"].stringValue))
                        }
                        print(data.count)
                        print(self.searchString)
                        vehicleCategory.setTableData(make: self.searchString, tableData: data)
                    } else {
    //                    self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
                        vehicleCategory.setTableData(error: jsonResponse["message"].stringValue)
                    }
                }
            }
        }
    }
}

