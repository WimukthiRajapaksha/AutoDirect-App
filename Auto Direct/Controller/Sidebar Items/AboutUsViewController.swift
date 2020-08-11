//
//  AboutUsViewController.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/28/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import WebKit

class AboutUsViewController: BaseViewController {
    @IBOutlet weak var btnFindOutMore: UIButton!
    @IBOutlet weak var lblText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = super.backBarButton()
        navigationItem.leftBarButtonItem?.tag = 10
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        self.btnFindOutMore.layer.cornerRadius = self.btnFindOutMore.frame.height/2
        self.title = "About Us"
        
        
        self.setLineSpacingAndText()
        
    }
    
    private func setLineSpacingAndText() {
        let attributedString = NSMutableAttributedString(string: "We at autodirect.lk | Auto Capital Investments Private Limited (ACI), offer you unsurpassed and unique financing solutions to purchase quality vehicles at the lowest competitive price, by means of dealing direct with the seller and eliminating the middle-man. Incorporating the ability to purchase anything and everything online today, Autodirect.lk; a virtual car sale managed by ACI brings you the prospect of purchasing your dream vehicle – direct from the Country of Origin – at the click of a mouse and without a middle-man or the pointless additional costs associated with elaborate and costly showrooms.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: lblText.font!, NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        attributedString.addAttributes(
        textAttributes,
        range: NSMakeRange(0, attributedString.length))
                
        self.lblText.attributedText = attributedString
        self.lblText.textAlignment = .justified
    }
    
    @IBAction func onFindOutMoreTouch(_ sender: Any) {
//        https://autodirect.lk/about-us/
        UIApplication.shared.open(URL(string: "https://autodirect.lk/about-us/")!)
    }
}
