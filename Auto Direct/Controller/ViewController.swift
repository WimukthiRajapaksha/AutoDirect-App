//
//  ViewController.swift
//  Auto Direct
//
//  Created by User on 5/8/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import SideMenuSwift
import ESTabBarController_swift

class ViewController: BaseViewController {
    private var vc: ESTabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.vc = ExampleProvider.customIrregularityStyle(delegate: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        NotificationCenter.default.addObserver(self, selector: #selector(onSelectInventory(_:)), name: .inventoryName, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    @objc func onSelectInventory(_ notification: Notification) {
        vc.selectedIndex = 1
    }
}
