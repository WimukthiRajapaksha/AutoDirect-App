//
//  InventoryViewController.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/28/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import WebKit

class InventorySidebarViewController: BaseViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Inventory"
        webView.load(URLRequest(url: URL(string: "https://autodirect.lk/inventory/")!))
        navigationItem.leftBarButtonItem = super.backBarButton()
        navigationItem.leftBarButtonItem?.tag = 10
        navigationItem.rightBarButtonItem = UIBarButtonItem()
    }
    
}
