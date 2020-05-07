//
//  ReserveVehicleViewController.swift
//  Auto Direct
//
//  Created by User on 4/14/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import Presentr
import SpringIndicator

class ReserveVehicleViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, ConfirmPaymentDelegate, PaymentSuccessDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    private var bottomIndexPath: IndexPath?
    private var progressBarIndexPath: IndexPath?
    private var isPresenting = false
    private var shownIndexes: [IndexPath]
    private let springIndicator: SpringIndicator
    private let viewIndicator: UIView
    private let lblLoading: UILabel
    private var blurEffectViewNavbar: UIVisualEffectView?
    private var blurEffectView: UIVisualEffectView?
    
    var count = 10
    var timer: Timer?
    
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
    
    required init?(coder aDecoder: NSCoder) {
        shownIndexes = []
        viewIndicator = UIView(frame: CGRect(x: UIScreen.main.bounds.width/2-30, y: UIScreen.main.bounds.height*2/3-30, width: 60, height: 60))
        springIndicator = SpringIndicator(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        lblLoading = UILabel(frame: CGRect(x: UIScreen.main.bounds.width/2-60, y: UIScreen.main.bounds.height*2/3+40, width: 120, height: 30))
        lblLoading.text = "LOADING IPG..."
        lblLoading.font = lblLoading.font.withSize(13)
        lblLoading.textAlignment = .center
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewIndicator.round(corners: .allCorners, radius: 30)
        viewIndicator.backgroundColor = .black
        springIndicator.lineColor = .green
        springIndicator.lineWidth = 0.5
        viewIndicator.addSubview(springIndicator)
        
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
        
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurEffectView!.frame = self.view.bounds
        blurEffectView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let bounds = self.navigationController?.navigationBar.bounds
        blurEffectViewNavbar = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurEffectViewNavbar!.frame = bounds ?? CGRect.zero
        blurEffectViewNavbar!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        navigationItem.leftBarButtonItem = backBarButton()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        shownIndexes = []
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
            cell.imgVehicle.layer.cornerRadius = 10
            cell.imgVehicle.layer.masksToBounds = true
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !shownIndexes.contains(indexPath) {
            shownIndexes.append(indexPath)
            if (indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2) {
                cell.alpha = 0
                cell.layer.frame.origin.y -= 100
                UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                    cell.alpha = 1
                    cell.layer.frame.origin.y += 100
                }, completion: nil)
            } else if (indexPath.row == 3) {
                cell.alpha = 0
                UIView.animate(withDuration: 2, delay: 0.5, options: .curveLinear, animations: {
                    cell.alpha = 1
                }, completion: nil)
            } else {
                cell.alpha = 0
                UIView.animate(withDuration: 1, delay: 1.0, options: .curveLinear, animations: {
                    cell.alpha = 1
                }, completion: nil)
            }
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
        let cellProgress = tableView.cellForRow(at: progressBarIndexPath!) as! ForthReserveTableViewCell
        cellProgress.progressBarView.currentStep = 2
        let cellBottom = tableView.cellForRow(at: bottomIndexPath!) as! FifthReserveTableViewCell
        cellBottom.containerView.personalDetailsView.isHidden = true
        
        view.addSubview(viewIndicator)
        view.addSubview(lblLoading)
        springIndicator.start()
        viewIndicator.alpha = 0
        lblLoading.alpha = 0
        viewIndicator.frame.origin.y += 100
        lblLoading.frame.origin.y += 100
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.viewIndicator.alpha = 1
            self.lblLoading.alpha = 1
            self.viewIndicator.frame.origin.y -= 100
            self.lblLoading.frame.origin.y -= 100
        }, completion: nil)
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
        count -= 1
        if(count == 0) {
            viewIndicator.alpha = 1
            lblLoading.alpha = 1
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                self.viewIndicator.alpha = 0
                self.viewIndicator.frame.origin.y += 100
                self.springIndicator.stop()
                self.lblLoading.alpha = 0
                self.lblLoading.frame.origin.y += 100
            }, completion: nil)
            timer = nil
            let cellBottom = tableView.cellForRow(at: bottomIndexPath!) as! FifthReserveTableViewCell
            cellBottom.containerView.paymentDetailsView.alpha = 0
            cellBottom.containerView.paymentDetailsView.isHidden = false
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                cellBottom.containerView.paymentDetailsView.alpha = 1
            }, completion: nil)
        }
    }
    
    @objc func onSubmitTouch(_ sender:UITapGestureRecognizer) {
        self.view.addSubview(blurEffectView!)
        self.navigationController?.navigationBar.addSubview(blurEffectViewNavbar!)
                
        let cellProgress = tableView.cellForRow(at: progressBarIndexPath!) as! ForthReserveTableViewCell
        cellProgress.progressBarView.currentStep = 3
        let paymentStatusViewController = self.storyboard?.instantiateViewController(identifier: "PaymentStatusViewController") as! PaymentStatusViewController
        paymentStatusViewController.delegate = self
        paymentStatusViewController.modalPresentationStyle = .overCurrentContext
        UIView.animate(withDuration: 0.1, delay: 3, options: .curveLinear, animations: {
//            self.performSegue(withIdentifier: "reservationSuccessSegue", sender: self)
            
            self.present(paymentStatusViewController, animated: true) {
//                self.performSegue(withIdentifier: "reservationSuccessSegue", sender: self)
                print("Done")
            }
        }, completion: nil)
    }
    
    func paymentSuccess(paymentSuccess: Bool) {
        print(paymentSuccess)
        if paymentSuccess {
//            self.dismiss(animated: true) {
            self.performSegue(withIdentifier: "reservationSuccessSegue", sender: self)
            
            self.dismiss(animated: true)
            self.blurEffectViewNavbar!.removeFromSuperview()
//            }
        }
    }
}







