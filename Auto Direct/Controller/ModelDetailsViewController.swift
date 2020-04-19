//
//  ModelDetailsViewController.swift
//  Auto Direct
//
//  Created by User on 4/14/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class ModelDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barRightBtn: UIBarButtonItem!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "call"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 22
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(self.handleButton), for: .touchUpInside)
        
        barRightBtn.customView = button
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func handleButton( sender : UIButton ) {
        // It would be nice is isEnabled worked...
        sender.alpha = sender.alpha == 1.0 ? 0.5 : 1.0
    }
    
    
    @IBAction func onBackTouch(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "FirstModelDetailsTableViewCell") as! FirstModelDetailsTableViewCell
        } else if (indexPath.row == 1) {
            cell = tableView.dequeueReusableCell(withIdentifier: "SecondModelDetailsTableViewCell") as! SecondModelDetailsTableViewCell
        } else if (indexPath.row == 2) {
            cell = tableView.dequeueReusableCell(withIdentifier: "ThirdModelDetailsTableViewCell") as! ThirdModelDetailsTableViewCell
        } else if (indexPath.row == 3) {
            cell = tableView.dequeueReusableCell(withIdentifier: "ForthModelDetailsTableViewCell") as! ForthModelDetailsTableViewCell
        } else if (indexPath.row == 4) {
            cell = tableView.dequeueReusableCell(withIdentifier: "FifthModelDetailsTableViewCell") as! FifthModelDetailsTableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "SixthModelDetailsTableViewCell") as! SixthModelDetailsTableViewCell
        }
        return cell
    }
}
