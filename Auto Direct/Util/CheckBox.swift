//
//  CheckBox.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/31/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation
import UIKit

class CheckBox: UILabel {
    var isChecked: Bool = false {
        didSet {
            if isChecked == true {
                let moneyImage = UIImage(named: "radio-button-checked")!
                let moneyIcon = NSTextAttachment()
                moneyIcon.image = moneyImage
                let moneyIconString = NSAttributedString(attachment: moneyIcon)

                let balanceFontSize: CGFloat = 16
                let balanceFont = UIFont(name: "Helvetica Neue", size: balanceFontSize)

                let balanceAttr: [NSAttributedString.Key: Any] = [.font: balanceFont!, .baselineOffset: (moneyImage.size.height - balanceFontSize) / 2 - balanceFont!.descender / 2 + 1]

                let balanceString = NSMutableAttributedString(string: self.text!, attributes: balanceAttr)
                balanceString.insert(moneyIconString, at: 0)
                
                print(self.text)
                self.attributedText = balanceString
            } else {
                let moneyImage = UIImage(named: "radio-button-unchecked")!
                let moneyIcon = NSTextAttachment()
                moneyIcon.image = moneyImage
                let moneyIconString = NSAttributedString(attachment: moneyIcon)

                let balanceFontSize: CGFloat = 16
                let balanceFont = UIFont(name: "Helvetica Neue", size: balanceFontSize)

                let balanceAttr: [NSAttributedString.Key: Any] = [.font: balanceFont!, .baselineOffset: (moneyImage.size.height - balanceFontSize) / 2 - balanceFont!.descender / 2 + 1]
                
                print(self.text)

                let balanceString = NSMutableAttributedString(string: self.text!, attributes: balanceAttr)
                balanceString.insert(moneyIconString, at: 0)
                
                self.attributedText = balanceString
            }
        }
    }

    override func awakeFromNib() {
        self.isChecked = false
    }
}
