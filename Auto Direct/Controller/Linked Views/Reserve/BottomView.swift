//
//  BottomView.swift
//  Auto Direct
//
//  Created by User on 4/30/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class BottomView: UIView {
    @IBOutlet var cardView: UIView!
    @IBOutlet weak var personalDetailsView: UIView!
    @IBOutlet weak var paymentDetailsView: UIView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnSubmit: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("BottomView", owner: self, options: nil)
        btnNext.layer.cornerRadius = btnNext.bounds.height/2
        btnSubmit.layer.cornerRadius = btnSubmit.bounds.height/2
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
//        self.cardView.addGestureRecognizer(tapGesture)
        
        
        addSubview(cardView)
        cardView.frame = self.bounds
        cardView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
//    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
//        self.resignFirstResponder()
//    }
    
//    @IBAction func btnNextTouch(_ sender: Any) {
//        self.personalDetailsView.isHidden = true
//        self.paymentDetailsView.isHidden = false
//    }
//
//    @IBAction func btnSubmitTouch(_ sender: Any) {
//        print("Success..")
//    }
    
}
