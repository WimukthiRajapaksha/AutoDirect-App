//
//  SuccessViewController.swift
//  Auto Direct
//
//  Created by User on 4/30/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class SuccessViewController: BaseViewController {
    @IBOutlet weak var imgSuccess: UIImageView!
    @IBOutlet weak var lblThank: UILabel!
    @IBOutlet weak var lblInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "close"), style: .plain, target: self, action: #selector(onCloseTouch))
        navigationItem.leftBarButtonItem = UIBarButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hidesBottomBarWhenPushed = true
        self.tabBarController?.tabBar.isHidden = false
        imgSuccess.alpha = 0
        lblThank.frame.origin.y += 50
        lblInfo.frame.origin.y += 50
        lblThank.alpha = 0
        lblInfo.alpha = 0
        imgSuccess.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 1.5, delay: 0, options: .curveEaseInOut, animations: {
            self.imgSuccess.alpha = 1
            self.lblInfo.frame.origin.y -= 50
            self.lblThank.frame.origin.y -= 50
            self.lblThank.alpha = 1
            self.lblInfo.alpha = 1
            self.imgSuccess.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: { firstSuccess in
            if firstSuccess {
                UIView.animate(withDuration: 0.2, delay: 0.01, options: .curveEaseInOut, animations: {
                    self.imgSuccess.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func onCloseTouch( sender : UIButton ) {
//        self.navigationController?.popToRootViewController(animated: true)
        let rootView = self.storyboard!.instantiateViewController(withIdentifier: "SideMenuController")
        rootView.modalPresentationStyle = .fullScreen
        self.present(rootView, animated: true, completion: nil)
    }
}
