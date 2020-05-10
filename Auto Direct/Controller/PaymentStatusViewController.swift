//
//  PaymentStatusViewController.swift
//  Auto Direct
//
//  Created by User on 5/7/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

protocol PaymentSuccessDelegate {
    func paymentSuccess(paymentSuccess: Bool)
}

class PaymentStatusViewController: BaseViewController {
    @IBOutlet weak var viewFirst: UIView!
    @IBOutlet weak var viewSecond: UIView!
    @IBOutlet weak var viewThird: UIView!
    @IBOutlet weak var lblPaymentStatus: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
    var delegate: PaymentSuccessDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0.7
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewContainer.isHidden = false
//        let initialCenter = viewSecond.center
//        viewFirst.center = viewSecond.center
//        viewThird.center = viewSecond.center
        viewFirst.rotate(angle: 45.0)
        viewSecond.rotate(angle: 45.0)
        viewThird.rotate(angle: 45.0)
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
            impliesAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
            impliesAnimation.duration = 1
            impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
            self.viewSecond.layer.add(impliesAnimation, forKey: nil)
        }, completion: nil)
//        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
//            self.viewFirst.center = CGPoint(x: initialCenter.x - 25, y: initialCenter.y)
//            self.viewThird.center = CGPoint(x: initialCenter.x + 25, y: initialCenter.y)
//            self.viewSecond.rotate(angle: 50.0)
//            self.viewSecond.center = CGPoint(x: initialCenter.x, y: initialCenter.y + 25)
//        }, completion: { finishFirst in
//            if finishFirst {
//                UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
//                    self.viewFirst.center = CGPoint(x: initialCenter.x - 20, y: initialCenter.y)
//                    self.viewThird.center = CGPoint(x: initialCenter.x + 20, y: initialCenter.y)
//                    self.viewSecond.rotate(angle: -5.0)
//                    self.viewSecond.center = CGPoint(x: initialCenter.x, y: initialCenter.y + 20)
//                }, completion: { finishSecond in
//                    if finishSecond {
//                        UIView.animate(withDuration: 0.1, delay: 0.2, options: .curveLinear, animations: {
//                            self.viewSecond.rotate(angle: -45.0)
//                        }, completion: { finishThird in
//                            if finishThird {
//                                UIView.animate(withDuration: 0.1, delay: 0.3, options: .curveLinear, animations: {
//                                    self.viewFirst.rotate(angle: 45.0)
//                                }, completion: { finishForth in
//                                    if finishForth {
//                                        UIView.animate(withDuration: 0.1, delay: 0.4, options: .curveLinear, animations: {
//                                            self.viewThird.rotate(angle: -45.0)
//                                        }, completion: { finishFifth in
//                                            if finishFifth {
//                                                UIView.animate(withDuration: 0.1, delay: 0.5, options: .curveLinear, animations: {
//                                                    self.lblPaymentStatus.text = "Payment Approved..."
//                                                    self.viewSecond.rotate(angle: -45.0)
//                                                }, completion: { finishSixth in
//                                                    if finishSixth {
//                                                        UIView.animate(withDuration: 0.1, delay: 0.6, options: .curveLinear, animations: {
//                                                            self.viewSecond.center = initialCenter
//                                                        }, completion: {finishSeventh in
////                                                            self.dismiss(animated: true, completion: nil)
//                                                            self.delegate?.paymentSuccess(paymentSuccess: true)
//                                                        })
//                                                    }
//                                                })
//                                            }
//                                        })
//                                    }
//                                })
//                            }
//                        })
//                    }
//                })
//            }
//        })
    }
}
