//
//  TabBarViewController.swift
//  Auto Direct
//
//  Created by User on 4/5/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import SideMenuSwift

class TabBarViewController: UITabBarController {
    @IBOutlet weak var barButtonRight: UIBarButtonItem!
    @IBOutlet weak var barButtonLeft: UIBarButtonItem!
    @IBOutlet var homeTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage(named: "call"), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        button.contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 22
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(self.handleButton), for: .touchUpInside)
        
        barButtonRight.customView = button
        
        var searchTab : UITabBarItem = self.homeTabBar.items?[2] as! UITabBarItem
        searchTab.imageInsets = UIEdgeInsets(top: -40, left: 0, bottom: 0, right: 0)
        searchTab.standardAppearance?.backgroundColor = .green
        searchTab.badgeColor = .blue
        searchTab.standardAppearance?.selectionIndicatorTintColor = .red

    }
    
    @objc func handleButton( sender : UIButton ) {
        print("clicked")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    @IBAction func onBarButtonLeftTouch(_ sender: Any) {
        sideMenuController?.revealMenu()
    }
    
}
