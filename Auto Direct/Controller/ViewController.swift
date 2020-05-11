//
//  ViewController.swift
//  Auto Direct
//
//  Created by User on 5/8/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let vc = ExampleProvider.customIrregularityStyle(delegate: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
}
