//
//  ModelDetailsViewController.swift
//  Auto Direct
//
//  Created by User on 4/14/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import ImageSlideshow
import SpringIndicator

class ModelDetailsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, AVPlayerViewControllerDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barRightBtn: UIBarButtonItem!
    
    var shownIndexes: [IndexPath]
    var player: AVPlayer!
    var playerViewController: AVPlayerViewController!
    private var playerFullScreenShown: Bool
    private let springIndicator: SpringIndicator
    private let viewIndicator: UIView
    
    required init?(coder aDecoder: NSCoder) {
        shownIndexes = []
        viewIndicator = UIView(frame: CGRect(x: UIScreen.main.bounds.width/2-30, y: UIScreen.main.bounds.height/3-30, width: 60, height: 60))
        springIndicator = SpringIndicator(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        playerFullScreenShown = false
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewIndicator.round(corners: .allCorners, radius: 30)
        viewIndicator.backgroundColor = .black
        springIndicator.lineColor = .green
        springIndicator.lineWidth = 0.5
        viewIndicator.addSubview(springIndicator)
        view.addSubview(viewIndicator)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInsetAdjustmentBehavior = .never
        
        navigationItem.leftBarButtonItem = backBarButton()
        navigationItem.rightBarButtonItem = setShareButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !playerFullScreenShown {
            shownIndexes = []
        }
        playerFullScreenShown = false
        
        springIndicator.start()
        viewIndicator.alpha = 0
        viewIndicator.frame.origin.y -= 40
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
            self.viewIndicator.alpha = 1
            self.viewIndicator.frame.origin.y += 40
        }, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewIndicator.alpha = 1
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.viewIndicator.alpha = 0
            self.viewIndicator.frame.origin.y -= 40
            self.springIndicator.stop()
        }, completion: nil)
    }
    
    func setShareButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(image: UIImage(named: "share"), style: .plain, target: self, action: #selector(self.onShareBtn))
        button.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -30)
        button.tintColor = .white
        return button
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 30.0
//    }
//    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.backgroundColor = .clear
//        return view
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstModelDetailsTableViewCell") as! FirstModelDetailsTableViewCell
            cell.btnPcp.addTarget(self, action: #selector(self.onPcpTouch), for: .touchUpInside)
            return cell
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondModelDetailsTableViewCell") as! SecondModelDetailsTableViewCell
            return cell
        } else if (indexPath.row == 2) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdModelDetailsTableViewCell") as! ThirdModelDetailsTableViewCell
            cell.whatsappView.layer.cornerRadius = 29.5
            return cell
        } else if (indexPath.row == 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForthModelDetailsTableViewCell") as! ForthModelDetailsTableViewCell
            let videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")
            self.player = AVPlayer(url: videoURL!)
            self.playerViewController = AVPlayerViewController()
            playerViewController.player = self.player
//            playerViewController.view.frame = CGRect(x: cell.contentView.frame.origin.x, y: cell.contentView.frame.origin.y + 20, width: cell.contentView.frame.width, height: cell.contentView.frame.height)
            playerViewController.view.frame = cell.viewVideoPlayer.frame
            playerViewController.player?.pause()
            self.playerViewController.delegate = self
            cell.addSubview(playerViewController.view)
            return cell
        } else if (indexPath.row == 4) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FifthModelDetailsTableViewCell") as! FifthModelDetailsTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SixthModelDetailsTableViewCell") as! SixthModelDetailsTableViewCell
//            let gestureMore = UITapGestureRecognizer(target: self, action: #selector(moreDetails(tapGestureRecognizer:)))
//            cell.btnMore.addGestureRecognizer(gestureMore)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (!shownIndexes.contains(indexPath)) {
            shownIndexes.append(indexPath)
            if (indexPath.row == 0) {
                let cellFirst = cell as! FirstModelDetailsTableViewCell
                cellFirst.imgSlideShow.alpha = 0
                cellFirst.paymentInfoView.alpha = 0
                UIView.animate(withDuration: 2, delay: 0, options: .curveEaseInOut, animations: {
                    cellFirst.alpha = 1
                    cellFirst.imgSlideShow.alpha = 1
                }, completion: nil)
                UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseInOut, animations: {
                    cellFirst.paymentInfoView.alpha = 1
                }, completion: nil)
            } else if (indexPath.row == 1) {
                cell.alpha = 0
                UIView.animate(withDuration: 1, delay: 1.3, options: .curveEaseInOut, animations: {
                    cell.alpha = 1
                }, completion: nil)
            } else if (indexPath.row == 2) {
                cell.alpha = 0
                UIView.animate(withDuration: 1, delay: 1.3, options: .curveEaseInOut, animations: {
                    cell.alpha = 1
                }, completion: nil)
            } else if (indexPath.row == 3) {
                cell.alpha = 0
                UIView.animate(withDuration: 1, delay: 1.3, options: .curveEaseInOut, animations: {
                    cell.alpha = 1
                }, completion: nil)
            } else if (indexPath.row == 4) {
                cell.alpha = 0
                UIView.animate(withDuration: 1, delay: 1.3, options: .curveEaseInOut, animations: {
                    cell.alpha = 1
                }, completion: nil)
            } else {
                cell.alpha = 0
                UIView.animate(withDuration: 1, delay: 1.3, options: .curveEaseInOut, animations: {
                    cell.alpha = 1
                }, completion: nil)
            }
        }
    }
    
    @objc func onShareBtn( sender : UIButton ) {
//        sender.alpha = sender.alpha == 1.0 ? 0.5 : 1.0
//        print("clicked")
        let websiteUrl : NSURL = NSURL(string: "https://autodirect.lk")!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [websiteUrl], applicationActivities: nil)
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func moreDetails(tapGestureRecognizer: UITapGestureRecognizer){
        let websiteUrl : NSURL = NSURL(string: "https://autodirect.lk")!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [websiteUrl], applicationActivities: nil)
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.up
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        self.present(activityViewController, animated: true, completion: nil)
    }
    

    @IBAction func btnReserve(_ sender: Any) {
        performSegue(withIdentifier: "reserveVehicleSegue", sender: self)
    }
    
    @objc func onPcpTouch(_ sender: UIButton) {
        self.performSegue(withIdentifier: "pcpSegue", sender: self)
    }
    
    func playerViewController(_ playerViewController: AVPlayerViewController, willBeginFullScreenPresentationWithAnimationCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        self.playerFullScreenShown = true
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.row == 3 {
//            return 200
//        } else {
//            return UITableView.automaticDimension
//        }
//    }
}














