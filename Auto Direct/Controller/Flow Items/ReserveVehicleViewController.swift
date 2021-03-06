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
    private var blurEffectViewTabbar: UIVisualEffectView?
    private var blurEffectView: UIVisualEffectView?
    
    private var selectedVehicleModel: VehicleModelInDetail!
    private var springStillShowing: Bool
    
    var count = 10
    var timer: Timer?
    
    let presenterPayment: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.fluid(percentage: 1)
        let center = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: UIScreen.main.bounds.height*1.6/3))
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
    
    required init?(coder aDecoder: NSCoder) {
        shownIndexes = []
        springStillShowing = false
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
        
//        let btnTime = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
//        btnTime.setTitle("8.42", for: .normal)
//        btnTime.contentEdgeInsets = UIEdgeInsets(top: 0,left: 8,bottom: 0,right: 8)
//        btnTime.tintColor = UIColor.white
//        btnTime.backgroundColor = UIColor.red
//        btnTime.layer.cornerRadius = 12
//        btnTime.layer.masksToBounds = true
//        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnTime)
        navigationItem.rightBarButtonItem = UIBarButtonItem()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurEffectView!.frame = self.view.bounds
        blurEffectView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let bounds = self.navigationController?.navigationBar.bounds
        blurEffectViewNavbar = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurEffectViewNavbar!.frame = bounds ?? CGRect.zero
        blurEffectViewNavbar!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let boundTabbar = self.tabBarController?.tabBar.bounds
        blurEffectViewTabbar = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blurEffectViewTabbar!.frame = boundTabbar ?? CGRect.zero
        blurEffectViewTabbar!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        navigationItem.leftBarButtonItem = backBarButton()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        view.addGestureRecognizer(UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        shownIndexes = []
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.springStillShowing {
            self.viewIndicator.alpha = 1
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                self.viewIndicator.alpha = 0
                self.viewIndicator.frame.origin.y -= 40
                self.springIndicator.stop()
            }, completion: { (boolValue) in
                self.view.isUserInteractionEnabled = true
                self.springStillShowing = false
            })
        }
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstReserveTableViewCell") as! FirstReserveTableViewCell
            cell.imgVehicle.layer.cornerRadius = 10
            cell.imgVehicle.layer.masksToBounds = true
            let imageList = selectedVehicleModel.getImageUrl().components(separatedBy: "|")
            cell.setData(imgUrl: imageList[0], title: selectedVehicleModel.getTitle(), type: selectedVehicleModel.getFuelTypes())
            return cell
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondReserveTableViewCell") as! SecondReserveTableViewCell
            cell.lblStockNo.text = selectedVehicleModel.getStockNumber()
            cell.lblAdvancedPaymentAmount.text = (selectedVehicleModel.getDownPayment() != "") ? selectedVehicleModel.getDownPayment() : "N/A"
            return cell
//        } else if (indexPath.row == 2) {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdReserveTableViewCell") as! ThirdReserveTableViewCell
//            return cell
//            TODO - if progressbar is needed, uncomment and return 5 for cell count
//        } else if (indexPath.row == 3) {
//            self.progressBarIndexPath = indexPath
//            let cell = tableView.dequeueReusableCell(withIdentifier: "ForthReserveTableViewCell") as! ForthReserveTableViewCell
//            return cell
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
//        TODO -  uncomment this if want to proceed with payment
//        let confirmPaymentViewController = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmPaymentViewController") as! ConfirmPaymentViewController
//        confirmPaymentViewController.delegate = self
//        customPresentViewController(presenterPayment, viewController: confirmPaymentViewController, animated: true, completion: nil)
//        let cellProgress = tableView.cellForRow(at: progressBarIndexPath!) as! ForthReserveTableViewCell
//        cellProgress.progressBarView.currentStep = 1
        let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! FifthReserveTableViewCell
//        print(cell.containerView.txtName.text)
//        print(cell.containerView.txtEmail.text)
//        print(cell.containerView.txtMobile.text)
        if (cell.containerView.txtName.text != "" && cell.containerView.txtEmail.text != "" && cell.containerView.txtMobile.text != "") {
            let urlString = "I would like to reserve \(self.selectedVehicleModel.getTitle()) \(self.selectedVehicleModel.getYears())\n\nStock No - \(self.selectedVehicleModel.getStockNumber())\nName - \(cell.containerView.txtName.text!)\nEmail -  \(cell.containerView.txtEmail.text!)\nContact - \(cell.containerView.txtMobile.text!)"
            let urlStringEncoded = urlString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
            let url  = NSURL(string: "https://wa.me/+94779033388?text=\(urlStringEncoded!)")

            if UIApplication.shared.canOpenURL(url! as URL) {
                UIApplication.shared.open(url! as URL, options: [:]) { (success) in
                    if success {
                        print("WhatsApp accessed successfully")
                    } else {
                        print("Error accessing WhatsApp")
                    }
                }
            } else {
                print("can't open whatsapp")
            }
            print("Send whatsapp")
        } else {
            self.view!.makeToast("Can't proceed. Please fill all the fields.", duration: 3, position: .bottom, title: "Sorry!", completion: nil)
        }
    }
    
    func confirmPaymentTouch(confirmPaymentViewController: ConfirmPaymentViewController) {
        let cellProgress = tableView.cellForRow(at: progressBarIndexPath!) as! ForthReserveTableViewCell
        cellProgress.progressBarView.currentStep = 2
        let cellBottom = tableView.cellForRow(at: bottomIndexPath!) as! FifthReserveTableViewCell
        cellBottom.containerView.personalDetailsView.isHidden = true
        
        view.addSubview(viewIndicator)
        view.addSubview(lblLoading)
        springIndicator.start()
        self.springStillShowing = true
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
            }, completion: { (bool) in
                self.springStillShowing = false
            })
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
        
//        TODO -  uncomment this if want to proceed with payment
//        self.tabBarController?.tabBar.isHidden = true
//        self.view.addSubview(blurEffectView!)
//        self.navigationController?.navigationBar.addSubview(blurEffectViewNavbar!)
//        self.tabBarController?.tabBar.addSubview(blurEffectViewTabbar!)
//
//        let cellProgress = tableView.cellForRow(at: progressBarIndexPath!) as! ForthReserveTableViewCell
//        cellProgress.progressBarView.currentStep = 3
//        let paymentStatusViewController = self.storyboard?.instantiateViewController(withIdentifier: "PaymentStatusViewController") as! PaymentStatusViewController
//        paymentStatusViewController.delegate = self
//        paymentStatusViewController.modalPresentationStyle = .overFullScreen
//        UIView.animate(withDuration: 0.1, delay: 3, options: .curveLinear, animations: {
//            self.present(paymentStatusViewController, animated: true, completion: nil)
//        }, completion: nil)
    }
    
    func paymentSuccess(paymentSuccess: Bool) {
        print(paymentSuccess)
        if paymentSuccess {
            self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "reservationSuccessSegue", sender: self)
//            self.tabBarController?.selectedIndex = 0
            self.blurEffectViewNavbar!.removeFromSuperview()
            self.blurEffectViewTabbar?.removeFromSuperview()
        }
    }
    
    public func setSelectedVehicleModel(vehicleModel: VehicleModelInDetail) {
        self.selectedVehicleModel = vehicleModel
    }
}







