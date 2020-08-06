//
//  SearchOptionNewViewController.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/31/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import RangeSeekSlider
import SpringIndicator

protocol SearchOptionsResultDelegate {
    func searchOptionsResult(result: [VehicleModelInDetail?])
}

class SearchOptionNewViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, ConditionDelegate, MakeYearDelegate, ModelDelegate, PriceDelegate, SearchDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private let year: Int
    private let conditionList: [String]
    private var makeList: [String?]
    private var modelList: [String?]
    private var yearsList: [String?]!
    
    private var selectedCondition: String
    private var selectedMake: String
    private var selectedModel: String
    private var selectedYear: String
    private var selectedMinPrice: String
    private var selectedMaxPrice: String
    
    private let springIndicator: SpringIndicator
    private let viewIndicator: UIView
    
    var searchOptionsResultDelegate: SearchOptionsResultDelegate!
    private var searchResult: [VehicleModelInDetail?]
    
    required init?(coder: NSCoder) {
        year = Calendar.current.component(.year, from: Date())
        makeList = []
        modelList = []
        yearsList = []
        selectedCondition = ""
        selectedMake = ""
        selectedModel = ""
        selectedYear = ""
        selectedMinPrice = ""
        selectedMaxPrice = ""
        searchResult = []
        viewIndicator = UIView(frame: CGRect(x: UIScreen.main.bounds.width/2-30, y: UIScreen.main.bounds.height/3.7-30, width: 60, height: 60))
        springIndicator = SpringIndicator(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        conditionList = ["Budget Plus", "New|Unregistered", "Pre-Owned"]
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Option"
        
        viewIndicator.round(corners: .allCorners, radius: 30)
        viewIndicator.backgroundColor = .black
        springIndicator.lineColor = .green
        springIndicator.lineWidth = 0.5
        
        viewIndicator.addSubview(springIndicator)
        view.addSubview(viewIndicator)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.navigationItem.rightBarButtonItem  = setCloseButton()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        
        if (yearsList.count > 0) {
            yearsList.removeAll()
        }
        for y in 0...10 {
            yearsList.append("\(year-10+y)")
        }
        
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
                self.makeList = jsonResponse.arrayObject as! [String]
                let index = self.makeList.firstIndex(of: "")
                if index != nil {
                    self.makeList.remove(at: index!)
                }
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    private func withRedStar(lblString: String) -> NSMutableAttributedString {
        var starMutableString = NSMutableAttributedString()
        let balanceFontSize: CGFloat = 16
        let balanceFont = UIFont(name: "Helvetica Neue", size: balanceFontSize)
        let balanceAttr: [NSAttributedString.Key: Any] = [.font: balanceFont!]
        
        starMutableString = NSMutableAttributedString(string: lblString, attributes: balanceAttr)
        starMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location:lblString.count-1,length:1))
        
        return starMutableString
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstTableViewCell", for: indexPath) as! FirstTableViewCell
            cell.selectionStyle = .none
//            cell.lbl.text = "Condition"
            cell.lbl.attributedText = self.withRedStar(lblString: "Condition*")
            cell.setData(data: conditionList)
//            cell.setData(data: ["Bu", "Ne", "Pr"])
            cell.conditionDelegate = self
            return cell
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
            cell.lbl.attributedText = self.withRedStar(lblString: "Make*")
            cell.makeYearDelegate = self
//            cell.setData(data: ["Audi", "BMW", "Honda", "Jeep", "Mazda", "Benz", "MG", "Mini", "Nissan", "Peugeot", "Subaru", "Suzuki", "Toyota", "Volkswagen"])
            cell.setData(data: makeList as! [String], identifier: "makeCollectionView" )
            cell.selectionStyle = .none
            return cell
        } else if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
            cell.lbl.attributedText = self.withRedStar(lblString: "Model*")
//            cell.setData(data: modelList as! [String])
            cell.selectionStyle = .none
//            cell.modelDelegate = self
            cell.setData(data: modelList as! [String], identifier: "modelCollectionView")
            cell.makeYearDelegate = self
            return cell
        } else if (indexPath.row == 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondTableViewCell", for: indexPath) as! SecondTableViewCell
            cell.lbl.attributedText = self.withRedStar(lblString: "Year*")
            cell.makeYearDelegate = self
            cell.setData(data: yearsList as! [String], identifier: "yearCollectionView")
            cell.selectionStyle = .none
            return cell
        } else if (indexPath.row == 4) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForthTableViewCell", for: indexPath) as! ForthTableViewCell
            cell.lbl.text = "Price"
            cell.selectionStyle = .none
            cell.priceDelegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FifthTableViewCell", for: indexPath) as! FifthTableViewCell
            cell.selectionStyle = .none
            cell.searchDelegate = self
            return cell
        }
    }
    
    func selectedCondition(condition: Int) {
        self.selectedCondition = conditionList[condition]
        print(conditionList[condition])
    }
    
    func selectedMakeYear(makeModelYear: String, identifier: String) {
        print(makeModelYear)
        if (identifier == "makeCollectionView") {
            selectedMake = makeModelYear
            super.domain.getModelsByMake(make: makeModelYear) { (boolResponse, jsonResponse) in
                print(boolResponse)
                print(jsonResponse)
                if boolResponse {
                    self.modelList = jsonResponse.arrayObject as! [String]
                    let index = self.modelList.firstIndex(of: "")
                    if index != nil {
                        self.modelList.remove(at: index!)
                    }
                    if (self.modelList.count != 0) {
                        let indexPath = IndexPath(row: 2, section: 0)
    //                    let cell = self.tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell", indexPath: indexPath) as! ThirdTableViewCell
                        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ThirdTableViewCell", for: indexPath) as! ThirdTableViewCell
                        cell.setData(data: self.modelList as! [String])
                        self.tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                } else {
                    self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
                }
            }
        } else if (identifier == "modelCollectionView") {
            selectedModel = makeModelYear
        } else {
            selectedYear = makeModelYear
        }
    }
    
    func selectedModel(model: String) {
        self.selectedModel = model
    }
    
    func takenPrice(price: String, boolMin: Bool) {
        if boolMin {
            self.selectedMinPrice = price
        } else {
            self.selectedMaxPrice = price
        }
    }
    
    func search() {
        if (selectedCondition != "" && selectedMake != "" && selectedModel != "" && selectedYear != "" && selectedMinPrice != "" && selectedMaxPrice != "") {
//            self.view!.makeToast("\(selectedCondition) \(selectedMake) \(selectedModel) \(selectedYear) \(selectedMinPrice) \(selectedMaxPrice)", duration: 3, position: .bottom, title: "SEARCHING....") { (bool) in
//
//                self.navigationController?.popViewController(animated: true)
//            }
            
            springIndicator.start()
            viewIndicator.alpha = 0
            viewIndicator.frame.origin.y -= 40
            self.view.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
                self.viewIndicator.alpha = 1
                self.viewIndicator.frame.origin.y += 40
            }, completion: nil)
            let searchVehicles = SearchVehicles(condition: self.selectedCondition, make: self.selectedMake, model: self.selectedModel, year: self.selectedYear, minPrice: self.selectedMinPrice, maxPrice: self.selectedMaxPrice)
            super.domain.getSearch(searchDetails: searchVehicles) { (boolResponse, jsonResponse) in
                print(boolResponse)
                print(jsonResponse)
                
                if boolResponse {
                    for (_, item) in jsonResponse {
                        self.searchResult.append(VehicleModelInDetail(autoId: item["autoid"].intValue, id: item["autoid"].int, title: item["title"].stringValue, conditions: item["conditions"].stringValue, bodies: item["bodies"].stringValue, makes: item["makes"].stringValue, models: item["models"].stringValue, mileages: item["mileages"].stringValue, fuelTypes: item["fueltypes"].stringValue, engines: item["engines"].stringValue, years: item["years"].intValue, rentals: item["rentals"].stringValue, fuelConsumptions: item["fuelconsumptions"].stringValue, transmission: item["transmission"].stringValue, drives: item["drives"].stringValue, fuelEconomy: item["fueleconomy"].stringValue, exteriorColors: item["exteriorColors"].stringValue, interiorColors: item["interiorColors"].stringValue, availabilities: item["availabilities"].stringValue, additionalFeatures: item["additionalfeatures"].stringValue, prominentWords: item["prominentwords"].stringValue, quotation: item["quotation"].stringValue, price: item["price"].intValue, downPayment: item["downPayment"].stringValue, imageURL: item["imageURL"].stringValue, stockNumber: item["stockNumber"].stringValue))
                    }
                    self.searchOptionsResultDelegate.searchOptionsResult(result: self.searchResult)
                    self.navigationController?.popViewController(animated: true)
                } else {
                    self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
                }
                
                self.viewIndicator.alpha = 1
                UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                    self.viewIndicator.alpha = 0
                    self.viewIndicator.frame.origin.y -= 40
                    self.springIndicator.stop()
                }, completion: { (boolValue) in
                    self.view.isUserInteractionEnabled = true
                })
            }
        } else {
            self.view!.makeToast("Not all the conditions satisfied.", duration: 3, position: .bottom, title: "SORRY!")
        }
    }
}
