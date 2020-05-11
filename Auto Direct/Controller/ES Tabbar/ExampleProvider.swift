//
//  ExampleProvider.swift
//  Auto Direct
//
//  Created by User on 5/8/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation
import ESTabBarController_swift

enum ExampleProvider {
    static func customIrregularityStyle(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
        tabBarController.tabBar.backgroundColor = UIColor(rgb: 0x06070A)
//        tabBarController.tabBar.barTintColor = color
//        tabBarController.tabBar.tintColor = color
//        tabBarController.tabBar.alpha = 1

//        tabBarController.shouldHijackHandler = {
//            tabbarController, viewController, index in
//            if index == 2 {
//                true
//            }
//            return false
//        }
//
//        tabBarController.didHijackHandler = {
//            [weak tabBarController] tabbarController, viewController, index in
//
//            DispatchQueue.main.asyncAfter(deadline: .now()) {
//                print(tabBarController?.tabBarItem.tag)
//                viewController.modalPresentationStyle = .overCurrentContext
//                tabbarController.present(viewController, animated: true, completion: nil)
////                let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
////                let takePhotoAction = UIAlertAction(title: "Take a photo", style: .default, handler: nil)
////                alertController.addAction(takePhotoAction)
////                let selectFromAlbumAction = UIAlertAction(title: "Select from album", style: .default, handler: nil)
////                alertController.addAction(selectFromAlbumAction)
////                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
////                alertController.addAction(cancelAction)
////                tabBarController?.present(alertController, animated: true, completion: nil)
//            }
//        }

        let v1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! UINavigationController
        let v2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InventoryViewController") as! UINavigationController
        let v3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! UINavigationController
//            let v3 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "first") as! ExtraFirstViewController
        let v4 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QRPayViewController") as! UINavigationController
        let v5 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UpdatesViewController") as! UINavigationController

        v1.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "HOME", image: UIImage(named: "home"), selectedImage: UIImage(named: "home"), tag: 0)
        v2.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "INVENTORY", image: UIImage(named: "inventory"), selectedImage: UIImage(named: "inventory"), tag: 1)
        v3.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: nil, image: UIImage(named: "search")?.rotate(radians: -.pi/4), selectedImage: UIImage(named: "search")?.rotate(radians: -.pi/4), tag: 2)
//        v3.tabBarItem = ESTabBarItem.init(ExampleIrregularityContentView(), title: nil, image: UIImage(named: "search"), selectedImage: UIImage(named: "search"), tag: 2)
        v4.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "QR PAY", image: UIImage(named: "qrPay"), selectedImage: UIImage(named: "qrPay"), tag: 3)
        v5.tabBarItem = ESTabBarItem.init(ExampleIrregularityBasicContentView(), title: "UPDATES", image: UIImage(named: "updates"), selectedImage: UIImage(named: "updates"), tag: 4)

        tabBarController.viewControllers = [v1, v2, v3, v4, v5]
        return tabBarController
    }
}
