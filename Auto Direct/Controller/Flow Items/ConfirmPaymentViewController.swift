//
//  ConfirmPaymentViewController.swift
//  Auto Direct
//
//  Created by User on 4/30/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

protocol ConfirmPaymentDelegate {
    func confirmPaymentTouch(confirmPaymentViewController: ConfirmPaymentViewController)
}

class ConfirmPaymentViewController: BaseViewController {
    @IBOutlet weak var btnConfirmPayment: UIButton!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblOtherCharges: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblCarType: UILabel!
    @IBOutlet weak var lblCarDetail: UILabel!
    
    var delegate: ConfirmPaymentDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnConfirmPayment.layer.cornerRadius = self.btnConfirmPayment.bounds.height / 2
    }
    
    @IBAction func onConfirmTouch(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.confirmPaymentTouch(confirmPaymentViewController: self)
    }
}
