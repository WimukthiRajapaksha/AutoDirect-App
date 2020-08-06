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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = super.backBarButton()
        navigationItem.leftBarButtonItem?.tag = 10
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        self.btnFindOutMore.layer.cornerRadius = self.btnFindOutMore.frame.height/2
        self.title = "What is PCP"
    }
    
    @IBAction func onFindOutMoreTouch(_ sender: Any) {
//        https://autodirect.lk/what-is-pcp/
        UIApplication.shared.open(URL(string: "https://autodirect.lk/what-is-pcp/")!)
    }
}
