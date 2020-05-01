//
//  SuccessViewController.swift
//  Auto Direct
//
//  Created by User on 4/30/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class SuccessViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(onCloseTouch))
        navigationItem.leftBarButtonItem = UIBarButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func onCloseTouch( sender : UIButton ) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
