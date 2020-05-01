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

class ModelDetailsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var barRightBtn: UIBarButtonItem!
    
    var player: AVPlayer!
    var playerViewController: AVPlayerViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.contentInsetAdjustmentBehavior = .never
        
        navigationItem.leftBarButtonItem = backBarButton()
        navigationItem.rightBarButtonItem = setShareButton()
    }
    
//    @objc func handleButton( sender : UIButton ) {
//        // It would be nice is isEnabled worked...
//        sender.alpha = sender.alpha == 1.0 ? 0.5 : 1.0
//    }
    
    
    @IBAction func onBackTouch(_ sender: Any) {
        self.navigationController?.popViewController(animated:true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
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
            return cell
        } else if (indexPath.row == 3) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ForthModelDetailsTableViewCell") as! ForthModelDetailsTableViewCell
            
            
            let videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4")
            self.player = AVPlayer(url: videoURL!)
            self.playerViewController = AVPlayerViewController()
            playerViewController.player = self.player
            playerViewController.view.frame = cell.contentView.frame
            playerViewController.player?.pause()
            cell.addSubview(playerViewController.view)
//            cell.addSubview(playerViewController.view)
            cell.backgroundColor = UIColor.green
            
            print(playerViewController.player?.error)
            print(playerViewController.player?.reasonForWaitingToPlay)
            print(playerViewController.player?.description)
//            print(playerViewController.player.)
            
//            self.player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 600), queue: DispatchQueue.main) {
//                [weak self] time in
//
//                if self?.player.currentItem?.status == AVPlayerItem.Status.readyToPlay {
//
//                    if (self?.player.currentItem?.isPlaybackLikelyToKeepUp) != nil {
//                        print("---")
//                        //do what ever you want with isPlaybackLikelyToKeepUp value, for example, show or hide a activity indicator.
//                    } else {
//                        print("==")
//                    }
//                } else {
//                    print("\\\\\\\\")
//                }
//            }
            
//            viewVideoPlayer.addSubview(playerViewController.view)
            
            

//        playerViewController.view.frame = viewVideoPlayer.frame
//        self.addSubview(playerViewController.view)
//        viewVideoPlayer.addSubview(playerViewController.view)
            
            return cell
            
        } else if (indexPath.row == 4) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FifthModelDetailsTableViewCell") as! FifthModelDetailsTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SixthModelDetailsTableViewCell") as! SixthModelDetailsTableViewCell
            
            let gestureMore = UITapGestureRecognizer(target: self, action: #selector(moreDetails(tapGestureRecognizer:)))
            cell.viewMore.addGestureRecognizer(gestureMore)
            return cell
        }
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 3 {
            return 200
        } else {
            return UITableView.automaticDimension
        }
    }
}
