//
//  UIViewController.swift
//  Auto Direct
//
//  Created by User on 4/29/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    var topbarHeight: CGFloat {
        let window = UIApplication.shared.keyWindow
        let topPadding = window?.safeAreaInsets.top
        
        if #available(iOS 13.0, *) {
            return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
                (self.navigationController?.navigationBar.frame.height ?? 0.0) + topPadding!
        } else {
            let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0) + topPadding!
            return topBarHeight
        }
    }
}
