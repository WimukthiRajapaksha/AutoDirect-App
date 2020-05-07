//
//  BaseViewController.swift
//  Auto Direct
//
//  Created by User on 4/24/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import SideMenuSwift

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        navigationItem.rightBarButtonItem = setCallButton()
        navigationItem.leftBarButtonItem = setLeftRevealSidebar()
        
 //       self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "CaviarDreams", size: 30)!]
        
        var descriptor = UIFontDescriptor(name: "SFCompactText", size: 18)
        descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight : UIFont.Weight.medium]])
        let font = UIFont(descriptor: descriptor, size: 18.0)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xffffff)]
                
        navigationController?.navigationBar.setGradientBackground(colors: [UIColor.black, UIColor.clear], startPoint: .topLeft, endPoint: .bottomLeft)

        
//        navigationController?.navigationBar.gradientToSuperView(width: view.bounds.width, height: self.topbarHeight, colors: [UIColor(rgb: 0x525252).cgColor, UIColor.clear.cgColor])
        
        self.view.backgroundColor = UIColor(rgb: 0x1b1f2a)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
//        navigationItem.setRightBarButtonItems([setCallButton()], animated: true)
//        navigationItem.setLeftBarButtonItems([setLeftRevealSidebar()], animated: true)
    }
    
    func setLeftRevealSidebar() -> UIBarButtonItem {
        let button = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(self.onLeftBtn))
        button.tintColor = .white
        return button
    }
    
    func setCallButton() -> UIBarButtonItem {
        
        let button = UIBarButtonItem(image: UIImage(named: "call"), style: .plain, target: nil, action: #selector(self.onRightBtn))
        button.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -30)
        button.tintColor = .white
        return button
    }
    
    func setShareButton() -> UIBarButtonItem {
        
        let button = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: nil, action: #selector(self.onRightBtn))
        button.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -30)
        button.tintColor = .white
        return button
    }
    
    func setCloseButton() -> UIBarButtonItem {
        let back = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(self.onBackBtn))
        back.imageInsets = UIEdgeInsets(top: 5, left: -5, bottom: -5, right: 0)
        back.width = 10.0
        back.tintColor = .white
        return back
    }
    
    func backBarButton() -> UIBarButtonItem {
        let back = UIBarButtonItem(image: UIImage(named: "backArrow"), style: .plain, target: self, action: #selector(self.onBackBtn))
        back.imageInsets = UIEdgeInsets(top: 5, left: -5, bottom: -5, right: 0)
        back.width = 10.0
        back.tintColor = .white
        return back
    }
    
    @objc func onRightBtn( sender : UIButton ) {
        sender.alpha = sender.alpha == 1.0 ? 0.5 : 1.0
        print("clicked")
    }
    
    @objc func onLeftBtn( sender : UIButton ) {
        sideMenuController?.revealMenu()
        print("clicked")
    }
    
    @objc func onBackBtn( sender : UIButton ) {
        if ((navigationController?.viewControllers.count)! > 1) {
            self.navigationController?.popViewController(animated: true)
        } else {
            tabBarController?.selectedIndex = 0
        }
    }
    
}
