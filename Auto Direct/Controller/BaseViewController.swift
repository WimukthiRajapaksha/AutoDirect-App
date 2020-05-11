//
//  BaseViewController.swift
//  Auto Direct
//
//  Created by User on 4/24/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import SideMenuSwift
import Presentr

class BaseViewController: UIViewController {
    
    let presenter: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.fluid(percentage: 1)
        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: UIScreen.main.bounds.height/1.4))
        let customType = PresentationType.custom(width: width, height: height, center: center)

        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = .coverVertical
        customPresenter.dismissTransitionType = .coverVertical
        customPresenter.roundCorners = true
        customPresenter.backgroundColor = .black
        customPresenter.backgroundOpacity = 0.5
        customPresenter.dismissOnSwipe = true
        customPresenter.dismissOnSwipeDirection = .bottom
        customPresenter.cornerRadius = 20
        return customPresenter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        navigationItem.rightBarButtonItem = setCallButton()
        navigationItem.leftBarButtonItem = setLeftRevealSidebar()
        
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "CaviarDreams", size: 30)!]
        
        var descriptor = UIFontDescriptor(name: "SFCompactText", size: 18)
        descriptor = descriptor.addingAttributes([UIFontDescriptor.AttributeName.traits : [UIFontDescriptor.TraitKey.weight : UIFont.Weight.medium]])
        let font = UIFont(descriptor: descriptor, size: 18.0)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor(rgb: 0xffffff)]

        navigationController?.navigationBar.setGradientBackground(colors: [UIColor.black, UIColor.clear], startPoint: .topLeft, endPoint: .bottomLeft)

        
//        navigationController?.navigationBar.gradientToSuperView(width: view.bounds.width, height: self.topbarHeight, colors: [UIColor(rgb: 0x525252).cgColor, UIColor.clear.cgColor])
        
        self.view.backgroundColor = UIColor(rgb: 0x1b1f2a)
    }
    
    func setCallButton() -> UIBarButtonItem {
             
         let button = UIBarButtonItem(image: UIImage(named: "call"), style: .plain, target: self, action: #selector(onCallBtn(sender:)))
         button.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -30)
         button.tintColor = .white
         return button
     }
     
     @objc func onCallBtn( sender : UIBarButtonItem ) {
//         sender.alpha = sender.alpha == 1.0 ? 0.5 : 1.0

         let contactNumbersViewController = UIStoryboard(name: "Main", bundle:nil).instantiateViewController(withIdentifier: "ContactNumbersViewController") as! ContactNumbersViewController
         customPresentViewController(presenter, viewController: contactNumbersViewController, animated: true, completion: nil)
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
    
    @objc func onLeftBtn( sender : UIButton ) {
        sideMenuController?.revealMenu()
        print("clicked")
    }
    
    @objc func onBackBtn( sender : UIButton ) {
        if ((navigationController?.viewControllers.count)! > 1) {
            self.navigationController?.popViewController(animated: true)
        } else {
            tabBarController?.selectedIndex = 0
//            self.dismiss(animated: true, completion: nil)
//                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SideMenuController") as! SideMenuController
//    //            self.dismiss(animated: true, completion: nil)
//            vc.modalPresentationStyle = .fullScreen
//                self.navigationController?.present(vc, animated: true, completion: nil)
//
            
//            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
}
