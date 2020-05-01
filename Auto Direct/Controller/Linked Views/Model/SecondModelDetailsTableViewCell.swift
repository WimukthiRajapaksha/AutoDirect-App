//
//  SecondModelDetailsTableViewCell.swift
//  Auto Direct
//
//  Created by User on 4/19/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class SecondModelDetailsTableViewCell: UITableViewCell {
    @IBOutlet var oneOne: ModelFeatureItem!
    @IBOutlet var oneTwo: ModelFeatureItem!
    @IBOutlet var oneThree: ModelFeatureItem!
    @IBOutlet var oneFour: ModelFeatureItem!
    @IBOutlet var twoOne: ModelFeatureItem!
    @IBOutlet var twoTwo: ModelFeatureItem!
    @IBOutlet var twoThree: ModelFeatureItem!
    @IBOutlet var twoFour: ModelFeatureItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        oneOne.imgItem.image = UIImage(named: "condition")
        oneOne.lblItemName.text = "CONDITION"
        oneOne.lblItemFeature.text = "Brand New"
        oneTwo.imgItem.image = UIImage(named: "body")
        oneTwo.lblItemName.text = "BODY"
        oneTwo.lblItemFeature.text = "SUV"
        oneThree.imgItem.image = UIImage(named: "petrol")
        oneThree.lblItemName.text = "FUEL TYPE"
        oneThree.lblItemFeature.text = "Petrol"
        oneFour.imgItem.image = UIImage(named: "engine")
        oneFour.lblItemName.text = "ENGINE"
        oneFour.lblItemFeature.text = "1L"
        
        twoOne.imgItem.image = UIImage(named: "year")
        twoOne.lblItemName.text = "YEAR"
        twoOne.lblItemFeature.text = "2019"
        twoTwo.imgItem.image = UIImage(named: "transmission")
        twoTwo.lblItemName.text = "TRANSMISSION"
        twoTwo.lblItemFeature.text = "Auto"
        twoThree.imgItem.image = UIImage(named: "driveType")
        twoThree.lblItemName.text = "DRIVE"
        twoThree.lblItemFeature.text = "FWD"
        twoFour.imgItem.image = UIImage(named: "color")
        twoFour.lblItemName.text = "COLOR"
        twoFour.lblItemFeature.text = "White"
        twoFour.imgItem.backgroundColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
