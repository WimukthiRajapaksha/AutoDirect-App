//
//  CallUsViewController.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 8/4/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class CallUsViewController: BaseViewController {
    @IBOutlet weak var btnCallFirst: UIButton!
    @IBOutlet weak var btnCallSecond: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCallFirst.layer.cornerRadius = 10
        btnCallSecond.layer.cornerRadius = 10
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        self.title = "CALL US"
    }
    
    @IBAction func onCallTouch(_ sender: UIButton) {
        let number = sender.titleLabel?.text?.components(separatedBy: .whitespaces).joined()
        if let phoneCallURL = URL(string: "telprompt://\(number!)") {
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
