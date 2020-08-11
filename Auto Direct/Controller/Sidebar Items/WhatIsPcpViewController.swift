//
//  WhatIsPcpViewController.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/28/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import WebKit

class WhatIsPcpViewController: BaseViewController {
    @IBOutlet weak var btnFindOutMore: UIButton!
    @IBOutlet weak var lblText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = super.backBarButton()
        navigationItem.leftBarButtonItem?.tag = 10
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        self.btnFindOutMore.layer.cornerRadius = self.btnFindOutMore.frame.height/2
        self.title = "What is PCP"
        
        self.setLineSpacingAndText()
    }
    
    private func setLineSpacingAndText() {
        let attributedString = NSMutableAttributedString(string: "What is PCP? A PCP is a form of car finance similar in principle to a Finance Lease (FL), but instead of paying off the entire value of the car in monthly installments, you are effectively only paying off the depreciation. In other words, you might be borrowing the same amount initially, but you are only repaying a portion of that borrowing. At the end of a PCP agreement, there is still a final value (often known as the balloon or the buyback price) outstanding. You have several options as to how to deal with this final amount, depending on whether or not you want to keep your car or change it.")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8
        let textAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: lblText.font!, NSAttributedString.Key.foregroundColor: UIColor.white]
        
        
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        attributedString.addAttributes(
        textAttributes,
        range: NSMakeRange(0, attributedString.length))
                
        self.lblText.attributedText = attributedString
        self.lblText.textAlignment = .justified
    }
    
    @IBAction func onFindOutMoreTouch(_ sender: Any) {
//        https://autodirect.lk/what-is-pcp/
        UIApplication.shared.open(URL(string: "https://autodirect.lk/what-is-pcp/")!)
    }
}
