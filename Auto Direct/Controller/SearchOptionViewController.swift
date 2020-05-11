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

class SearchOptionViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, RangeSeekSliderDelegate {

    @IBOutlet weak var collectionCondition: UICollectionView!
    @IBOutlet weak var collectionMake: UICollectionView!
    @IBOutlet weak var collectionModel: UICollectionView!
    @IBOutlet weak var collectionYear: UICollectionView!
    @IBOutlet weak var slider: RangeSeekSlider!
    @IBOutlet weak var btnReset: UIButton!
    
    var radioBtnCondition: [DLRadioButton]
    var radioBtnModel: [DLRadioButton]
    
    let conditionList = ["Budget Plus", "New/Unregistered", "Pre-Owned"]
    let makeList = ["Audi", "BMW", "Honda", "Jeep", "Mazda", "Benz", "MG", "Mini", "Nissan", "Peugeot", "Subaru", "Suzuki", "Toyota", "Volkswagen"]
    let modelList = ["All", "Q7", "A6", "A3", "Q5", "Q3", "A3", "All", "Q7", "A6", "A3", "Q5", "Q3", "A3"]
    let yearList = [2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020]
    
    required init?(coder: NSCoder) {
        radioBtnModel = []
        radioBtnCondition = []
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
        
        collectionYear.delegate = self
        collectionYear.dataSource = self
        collectionYear.accessibilityIdentifier = "yearCollection"
        
        btnReset.layer.cornerRadius = btnReset.frame.size.height/2
        
        self.navigationItem.rightBarButtonItem  = setCloseButton()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem()
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
        print(collectionView.accessibilityIdentifier)
        if (collectionView.accessibilityIdentifier == "makeCollection") {
            let cell = collectionMake.dequeueReusableCell(withReuseIdentifier: "SearchOptionMakeCollectionViewCell", for: indexPath) as! SearchOptionMakeCollectionViewCell
            cell.lblMake.text = makeList[indexPath.row]
            return cell
        } else if (collectionView.accessibilityIdentifier == "conditionCollection") {
            let cell = collectionCondition.dequeueReusableCell(withReuseIdentifier: "SearchOptionConditionCollectionViewCell", for: indexPath) as! SearchOptionConditionCollectionViewCell
            print(indexPath.section)
//            if indexPath.section == 0 {
//                cell.btnRadio.setTitle(conditionList[indexPath.row], for: .normal)
//            } else {
//                cell.btnRadio.setTitle(conditionList[2], for: .normal)
//            }
            cell.btnRadio.setTitle(conditionList[indexPath.row], for: .normal)
            radioBtnCondition.append(cell.btnRadio)
            if radioBtnCondition.count > 1 {
                radioBtnCondition[0].otherButtons = Array(radioBtnCondition[1...])
            }
            radioBtnCondition[0].isSelected = true
//            setTitle(conditionList[indexPath.row], for: .normal)
            return cell
        } else if (collectionView.accessibilityIdentifier == "modelCollection") {
            let cell = collectionModel.dequeueReusableCell(withReuseIdentifier: "SearchOptionModelCollectionViewCell", for: indexPath) as! SearchOptionModelCollectionViewCell
            cell.btnRadio.setTitle(modelList[indexPath.row], for: .normal)
            radioBtnModel.append(cell.btnRadio)
            if radioBtnModel.count > 1 {
                radioBtnModel[0].otherButtons = Array(radioBtnModel[1...])
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
            return CGSize(width: 60, height: 30)
        } else {
            return CGSize(width: 100, height: collectionView.bounds.size.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView.accessibilityIdentifier == "modelCollection") {

            let cell = collectionModel.dequeueReusableCell(withReuseIdentifier: "SearchOptionModelCollectionViewCell", for: indexPath) as! SearchOptionModelCollectionViewCell
            cell.btnRadio.isSelected = true
//            collectionModel.reloadData()
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
        return "Rs.\(formattedNumber!).00"
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: Float(minValue)))
        return "Rs.\(formattedNumber!).00"
    }
}
