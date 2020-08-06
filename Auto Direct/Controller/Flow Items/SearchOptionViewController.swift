//
//  SearchOptionViewController.swift
//  Auto Direct
//
//  Created by User on 4/27/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import RangeSeekSlider
import DLRadioButton

//protocol SearchOptionsDelegate {
//    func searchOptions(condition: Int, make: String, model: String, year: String, minPrice: String, maxPrice: String)
//}

class SearchOptionViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, RangeSeekSliderDelegate {

    @IBOutlet weak var collectionCondition: UICollectionView!
    @IBOutlet weak var collectionMake: UICollectionView!
    @IBOutlet weak var collectionModel: UICollectionView!
    @IBOutlet weak var collectionYear: UICollectionView!
    @IBOutlet weak var slider: RangeSeekSlider!
    @IBOutlet weak var btnReset: UIButton!
    
    var radioBtnCondition: [DLRadioButton]
    var radioBtnModel: [DLRadioButton]
//    var searchOptionsDelegate: SearchOptionsDelegate!
    
    let conditionList = ["Budget Plus", "New/Unregistered", "Pre-Owned"]
    var makeList: [String?]
    var modelList: [String?]
    let yearList = [2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020]
    var selectedIndex = [Int]()
    
    private var selectedCondition: Int
    private var selectedMake: String
    private var selectedModel: String
    private var selectedYear: String
    private var selectedMinPrice: String
    private var selectedMaxPrice: String
    
    required init?(coder: NSCoder) {
        radioBtnModel = []
        radioBtnCondition = []
        makeList = []
        modelList = []
        selectedCondition = 0
        selectedMake = ""
        selectedModel = ""
        selectedYear = ""
        selectedMinPrice = ""
        selectedMaxPrice = ""
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slider.delegate = self
        
        collectionMake.delegate = self
        collectionMake.dataSource = self
        collectionMake.accessibilityIdentifier = "makeCollection"
        
        collectionModel.delegate = self
        collectionModel.dataSource = self
        collectionModel.accessibilityIdentifier = "modelCollection"
        
        collectionCondition.delegate = self
        collectionCondition.dataSource = self
        collectionCondition.accessibilityIdentifier = "conditionCollection"
        
//        if let flowLayout = collectionModel?.collectionViewLayout as? UICollectionViewFlowLayout {
//            flowLayout.estimatedItemSize = CGSize(width: UICollectionViewFlowLayout.automaticSize.width, height: 30)
////            UICollectionViewFlowLayout.automaticSize
//        }
        
        collectionYear.delegate = self
        collectionYear.dataSource = self
        collectionYear.accessibilityIdentifier = "yearCollection"
        
        btnReset.layer.cornerRadius = btnReset.frame.size.height/2
        
        self.navigationItem.rightBarButtonItem  = setCloseButton()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
        
        super.domain.getAllMakes { (boolResponse, jsonResponse) in
            if boolResponse {
                self.makeList = jsonResponse.arrayObject as! [String]
                let index = self.makeList.firstIndex(of: "")
                if (index != nil) {
                    self.makeList.remove(at: index!)
                }
            } else {
                self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
            }
            self.collectionMake.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(collectionView.accessibilityIdentifier)
        if (collectionView.accessibilityIdentifier == "conditionCollection") {
//            return section == 0 ? 2 : 1
            return 3
        } else if (collectionView.accessibilityIdentifier == "makeCollection") {
            return makeList.count
        } else if (collectionView.accessibilityIdentifier == "modelCollection") {
            return modelList.count
        } else if (collectionView.accessibilityIdentifier == "yearCollection") {
            return yearList.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView.accessibilityIdentifier == "makeCollection") {
            let cell = collectionMake.dequeueReusableCell(withReuseIdentifier: "SearchOptionMakeCollectionViewCell", for: indexPath) as! SearchOptionMakeCollectionViewCell
            cell.lblMake.text = makeList[indexPath.row]
            radioBtnModel.removeAll()
            return cell
        } else if (collectionView.accessibilityIdentifier == "conditionCollection") {
            let cell = collectionCondition.dequeueReusableCell(withReuseIdentifier: "SearchOptionConditionCollectionViewCell", for: indexPath) as! SearchOptionConditionCollectionViewCell
            print(indexPath.section)
//            if indexPath.section == 0 {
//                cell.btnRadio.setTitle(conditionList[indexPath.row], for: .normal)
//            } else {
//                cell.btnRadio.setTitle(conditionList[2], for: .normal)
//            }
//            cell.btnRadio.setTitle(conditionList[indexPath.row], for: .normal)
            cell.lbl.text = conditionList[indexPath.row]
            cell.lbl.isChecked = false
//            radioBtnCondition.append(cell.btnRadio)
//            if radioBtnCondition.count > 1 {
//                radioBtnCondition[0].otherButtons = Array(radioBtnCondition[1...])
//            }
//            radioBtnCondition[0].isSelected = true
//            setTitle(conditionList[indexPath.row], for: .normal)
            return cell
        } else if (collectionView.accessibilityIdentifier == "modelCollection") {
            let cell = collectionModel.dequeueReusableCell(withReuseIdentifier: "SearchOptionModelCollectionViewCell", for: indexPath) as! SearchOptionModelCollectionViewCell
//            cell.btnRadioNew.setTitle(modelList[indexPath.row], for: .normal)
//            cell.lblRadio.text = modelList[indexPath.row]
//            cell.btnRadio.setTitle(modelList[indexPath.row], for: .normal)
//
//            if (indexPath.row == 0) {
//                radioBtnModel.append(cell.btnRadio)
////            } else if (indexPath.row == 1 || indexPath.row == 2) {
////                radioBtnModel[0].otherButtons.append(cell.btnRadio)
//            } else {
////                radioBtnModel[0].otherButtons.contains()
//                if !(radioBtnModel[0].otherButtons.contains(cell.btnRadio)) {
//                    radioBtnModel[0].otherButtons.append(cell.btnRadio)
//                }
//            }
//            print(radioBtnModel[0].otherButtons.count)
//            if (indexPath.row == 0 && selectedIndex.count == 0) {
////                radioBtnModel.append(cell.btnRadio)
//                cell.btnRadio.isSelected = true
//                cell.lblRadio.isChecked = true
//            } else if (selectedIndex.contains(indexPath.row)) {
//                cell.btnRadio.isSelected = true
//                cell.lblRadio.isChecked = true
//            } else {
//                cell.btnRadio.isSelected = false
//                cell.lblRadio.isChecked = false
//            }
//
////            cell.btnRadio.isSelected = false
//////            radioBtnModel.append(cell.btnRadio)
////            if (indexPath.row != 0) {
////                radioBtnModel[0].otherButtons.append(cell.btnRadio)
////            }
////            if radioBtnModel.count > 1 {
////                radioBtnModel[0].otherButtons = Array(radioBtnModel[1...])
////            }
//
////            radioBtnModel[0].isSelected = true
//
//            if selectedIndex.contains(indexPath.row) {
//                cell.lblRadio.isChecked = true
//            } else {
//                cell.lblRadio.isChecked = false
//            }
            
            cell.lblRadio.text = modelList[indexPath.row]
            if selectedIndex.contains(indexPath.row) {
                cell.lblRadio.isChecked = true
            } else if (indexPath.row == 0) {
                cell.lblRadio.isChecked = true
            } else {
                cell.lblRadio.isChecked = false
            }
            return cell
        } else {
            let cell = collectionYear.dequeueReusableCell(withReuseIdentifier: "SearchOptionYearCollectionViewCell", for: indexPath) as! SearchOptionYearCollectionViewCell
            cell.lblYear.text = "\(yearList[indexPath.row])"
            return cell
        }
    }
    
//    colle
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (collectionView.accessibilityIdentifier == "conditionCollection") {
            if indexPath.row == 1 {
                return CGSize(width: collectionView.bounds.width/2, height: 20)
            } else {
                return CGSize(width: collectionView.bounds.width/2.5, height: 20)
            }
            
        } else if (collectionView.accessibilityIdentifier == "modelCollection") {
//            print(modelList[indexPath.row]!.count)
//            if (modelList[indexPath.row]!.count > 20) {
//                return CGSize(width: 270, height: 30)
//            } else if (modelList[indexPath.row]!.count > 15) {
//                return CGSize(width: 200, height: 30)
//            } else if (modelList[indexPath.row]!.count > 10) {
//                return CGSize(width: 180, height: 30)
//            } else if (modelList[indexPath.row]!.count > 5) {
//                return CGSize(width: 120, height: 30)
//            } else {
//                return CGSize(width: 75, height: 30)
//            }
            return CGSize(width: 100, height: collectionView.bounds.size.height)
//            return UICollectionViewFlowLayout.automaticSize
        } else {
            return CGSize(width: 100, height: collectionView.bounds.size.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView.accessibilityIdentifier == "makeCollection") {
            self.selectedIndex.removeAll()
            self.radioBtnModel.removeAll()
            super.domain.getModelsByMake(make: makeList[indexPath.row]!) { (boolResponse, jsonResponse) in
                print(boolResponse)
                print(jsonResponse)
                if boolResponse {
                    self.modelList = jsonResponse.arrayObject as! [String]
                    let index = self.modelList.firstIndex(of: "")
                    if (index != nil) {
                        self.modelList.remove(at: index!)
                    }
                } else {
                    self.view!.makeToast(jsonResponse["message"].stringValue, duration: 3, position: .bottom, title: "Sorry!", completion: nil)
                }
                self.collectionModel.reloadData()
            }
            selectedMake = makeList[indexPath.row]!
        } else if (collectionView.accessibilityIdentifier == "modelCollection") {
            selectedIndex.removeAll()
            selectedIndex.append(indexPath.row)
            let cell = collectionModel.dequeueReusableCell(withReuseIdentifier: "SearchOptionModelCollectionViewCell", for: indexPath) as! SearchOptionModelCollectionViewCell
//            selectedIndex.removeAll()
//            selectedIndex.append(indexPath.row)
//            cell.lblRadio.isChecked = true
////            cell.btnRadio.isSelected = true
//            selectedModel = modelList[indexPath.row]!
//            collectionModel.reloadData()
            
            
            
            cell.lblRadio.isChecked = true
            
            
            
            
            
        } else if (collectionView.accessibilityIdentifier == "yearCollection") {
            selectedYear = "\(yearList[indexPath.row])"
        } else {
            let cell = collectionCondition.dequeueReusableCell(withReuseIdentifier: "SearchOptionConditionCollectionViewCell", for: indexPath) as! SearchOptionConditionCollectionViewCell
            cell.lbl.isChecked = true
            selectedCondition = indexPath.row
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        if !(selectedIndex.contains(indexPath.row)) {
//            let cell = collectionModel.dequeueReusableCell(withReuseIdentifier: "SearchOptionModelCollectionViewCell", for: indexPath) as! SearchOptionModelCollectionViewCell
////            cell.btnRadio.isSelected = false
////            cell.lblRadio.isChecked = false
//            cell.lblRadio.isChecked = false
//        }
        
        
        if (collectionView.accessibilityIdentifier == "modelCollection") {
            guard let cell = collectionModel.dequeueReusableCell(withReuseIdentifier: "SearchOptionModelCollectionViewCell", for: indexPath) as? SearchOptionModelCollectionViewCell else {
                return
            }
            cell.lblRadio.isChecked = false
        } else if (collectionView.accessibilityIdentifier == "conditionCollection") {
            guard let cell = collectionModel.dequeueReusableCell(withReuseIdentifier: "SearchOptionConditionCollectionViewCell", for: indexPath) as? SearchOptionConditionCollectionViewCell else {
                return
            }
            cell.lbl.isChecked = false
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (collectionView.accessibilityIdentifier == "makeCollection") {
            return 1
        } else if (collectionView.accessibilityIdentifier == "modelCollection") {
            return 1
        } else if (collectionView.accessibilityIdentifier == "yearCollection") {
            return 1
        } else {
            return 1
        }
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue maxValue: CGFloat) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: Float(maxValue)))
        selectedMaxPrice = "\(maxValue)"
        return "Rs.\(formattedNumber!).00"
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: Float(minValue)))
        selectedMinPrice = "\(minValue)"
        return "Rs.\(formattedNumber!).00"
    }
    
    @IBAction func onResetTouch(_ sender: Any) {
//        searchOptionsDelegate.searchOptions(condition: selectedCondition, make: selectedMake, model: selectedModel, year: selectedYear, minPrice: selectedMinPrice, maxPrice: selectedMaxPrice)
        self.navigationController?.popViewController(animated: true)
    }
}
