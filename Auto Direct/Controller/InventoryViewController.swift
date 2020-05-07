//
//  InventoryViewController.swift
//  Auto Direct
//
//  Created by User on 4/6/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class InventoryViewController: BaseViewController {
    private let inventorySegue: String
    
    required init?(coder aDecoder: NSCoder) {
        inventorySegue = "inventorySegue"
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        self.performSegue(withIdentifier: inventorySegue, sender: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == inventorySegue) {
            let vehicleCategory = segue.destination as! VehicleCategoryViewController
            vehicleCategory.setItemId(id: 4)
        }
    }
}
