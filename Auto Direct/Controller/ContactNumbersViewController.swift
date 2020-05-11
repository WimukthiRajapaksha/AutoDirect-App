//
//  ContactNumbersViewController.swift
//  Auto Direct
//
//  Created by User on 5/10/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class ContactNumbersViewController: UIViewController {
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var firstContactNumberView: UIView!
    @IBOutlet weak var secondContactNumberView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstContactNumberView.layer.cornerRadius = 10
        secondContactNumberView.layer.cornerRadius = 10
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapBackground(_:))))
        firstContactNumberView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapContactNumber(_:))))
        secondContactNumberView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapContactNumber(_:))))
    }
    
    @objc func tapBackground(_ sender: UITapGestureRecognizer) {
        print("background")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tapContactNumber(_ sender: UITapGestureRecognizer) {
        print("contact number")
        print(sender.view?.tag)
        if sender.view?.tag == 0 {
            callNumber(phoneNumber: "+94775687687")
        } else {
            callNumber(phoneNumber: "+94775697697")
        }
    }
    
    private func callNumber(phoneNumber:String) {
        if let phoneCallURL = URL(string: "telprompt://\(phoneNumber)") {
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                if #available(iOS 10.0, *) {
                    application.open(phoneCallURL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                     application.openURL(phoneCallURL as URL)
                }
            }
        }
    }
}
