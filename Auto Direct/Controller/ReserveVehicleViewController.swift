//
//  ReserveVehicleViewController.swift
//  Auto Direct
//
//  Created by User on 4/14/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import Presentr

class ReserveVehicleViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, ConfirmPaymentDelegate {
    @IBOutlet var tableView: UITableView!
    //    @IBOutlet var btnTime: UIBarButtonItem!
    
    private var bottomIndexPath: IndexPath?
    private var progressBarIndexPath: IndexPath?
    private var isPresenting = false
    
    let presenter: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.fluid(percentage: 1)
        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: UIScreen.main.bounds.height*1.6/3))
        let customType = PresentationType.custom(width: width, height: height, center: center)

        let customPresenter = Presentr(presentationType: customType)
        customPresenter.transitionType = .coverVertical
        customPresenter.dismissTransitionType = .coverVertical
        customPresenter.roundCorners = true
        customPresenter.backgroundColor = .gray
        customPresenter.backgroundOpacity = 0.5
        customPresenter.dismissOnSwipe = true
        customPresenter.dismissOnSwipeDirection = .bottom
        customPresenter.cornerRadius = 20
        return customPresenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btnTime = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
        btnTime.setTitle("8.42", for: .normal)
        btnTime.contentEdgeInsets = UIEdgeInsets(top: 0,left: 8,bottom: 0,right: 8)
        btnTime.tintColor = UIColor.white
        btnTime.backgroundColor = UIColor.red
        btnTime.layer.cornerRadius = 12
        btnTime.layer.masksToBounds = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnTime)
        
        tableView.delegate = self
        tableView.dataSource = self
//        ConfirmPaymentViewController().delega
        
        navigationItem.leftBarButtonItem = backBarButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstReserveTableViewCell") as! FirstReserveTableViewCell
            return cell
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondReserveTableViewCell") as! SecondReserveTableViewCell
            return cell
        } else if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdReserveTableViewCell") as! ThirdReserveTableViewCell
            return cell
        } else if (indexPath.row == 3) {
            self.progressBarIndexPath = indexPath
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForthReserveTableViewCell") as! ForthReserveTableViewCell
            return cell
        } else {
            self.bottomIndexPath = indexPath
            let cell = tableView.dequeueReusableCell(withIdentifier: "FifthReserveTableViewCell") as! FifthReserveTableViewCell
            
            cell.containerView.btnNext.addTarget(self, action: #selector(onNextTouch(_:)), for: .touchUpInside)
            cell.containerView.btnSubmit.addTarget(self, action: #selector(onSubmitTouch(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    @objc func onNextTouch(_ sender:UITapGestureRecognizer) {        
        let confirmPaymentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmPaymentViewController") as! ConfirmPaymentViewController
        confirmPaymentViewController.delegate = self
        customPresentViewController(presenter, viewController: confirmPaymentViewController, animated: true, completion: nil)
        
        let cellProgress = tableView.cellForRow(at: progressBarIndexPath!) as! ForthReserveTableViewCell
        cellProgress.progressBarView.currentStep = 1
    }
    
    func confirmPaymentTouch(confirmPaymentViewController: ConfirmPaymentViewController) {
        let cellBottom = tableView.cellForRow(at: bottomIndexPath!) as! FifthReserveTableViewCell
        cellBottom.containerView.personalDetailsView.isHidden = true
        cellBottom.containerView.paymentDetailsView.isHidden = false
        
        let cellProgress = tableView.cellForRow(at: progressBarIndexPath!) as! ForthReserveTableViewCell
        cellProgress.progressBarView.currentStep = 2
    }
    
    @objc func onSubmitTouch(_ sender:UITapGestureRecognizer) {
        let cellProgress = tableView.cellForRow(at: progressBarIndexPath!) as! ForthReserveTableViewCell
        cellProgress.progressBarView.currentStep = 3
        self.performSegue(withIdentifier: "reservationSuccessSegue", sender: self)
    }
}
