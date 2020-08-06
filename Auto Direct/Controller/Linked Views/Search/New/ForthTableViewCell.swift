//
//  ForthTableViewCell.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/31/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import RangeSeekSlider

protocol PriceDelegate {
    func takenPrice(price: String, boolMin: Bool)
}

class ForthTableViewCell: UITableViewCell, RangeSeekSliderDelegate {
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var slider: RangeSeekSlider!
    
    var priceDelegate: PriceDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        slider.delegate = self
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMaxValue maxValue: CGFloat) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: Float(maxValue)))
//        selectedMaxPrice = "\(maxValue)"
        priceDelegate.takenPrice(price: "\(Int(maxValue))", boolMin: false)
        return "Rs.\(formattedNumber!).00"
    }
    
    func rangeSeekSlider(_ slider: RangeSeekSlider, stringForMinValue minValue: CGFloat) -> String? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value: Float(minValue)))
        priceDelegate.takenPrice(price: "\(Int(minValue))", boolMin: true)
//        selectedMinPrice = "\(minValue)"
        return "Rs.\(formattedNumber!).00"
    }

}
