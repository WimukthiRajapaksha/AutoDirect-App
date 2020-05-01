//
//  TabBarViewController.swift
//  Auto Direct
//
//  Created by User on 4/5/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import SideMenuSwift

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = UIColor(rgb: 0x353b4a).cgColor
        
  //      UITabBar.appearance().shadowImage = UIImage.colorForNavBar(color: .red)
//        let font = UIFont(name: "SF Compact Text", size: 11).
        
        var descriptor = UIFontDescriptor(name: "SFCompactText", size: 11)
        descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight : UIFont.Weight.light]])
        let font = UIFont(descriptor: descriptor, size: 11.0)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x6f7587)], for: .normal)
        
        // selected colors
        UITabBar.appearance().tintColor = UIColor(rgb: 0x63b946)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.strokeColor: UIColor(rgb: 0x63b946)], for: .normal)

        
//        UITabBarItem.appearance().set([NSAttributedString.Key.foregroundColor: UIColor(rgb: 0x6f7587)], for: .normal)
        
//        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.green.cgColor], for:.normal)
    }
}
