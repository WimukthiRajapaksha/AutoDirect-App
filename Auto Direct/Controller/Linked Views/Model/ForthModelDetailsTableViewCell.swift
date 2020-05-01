//
//  ForthModelDetailsTableViewCell.swift
//  Auto Direct
//
//  Created by User on 4/19/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class ForthModelDetailsTableViewCell: UITableViewCell {
    @IBOutlet var viewVideoPlayer: UIView!
    
    var player: AVPlayer!

    override func awakeFromNib() {
        super.awakeFromNib()
        
//        let videoURL = URL(string: "http://techslides.com/demos/sample-videos/small.mp4")
//        player = AVPlayer(url: videoURL!)
        
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.viewVideoPlayer.bounds
//        playerLayer.backgroundColor = UIColor.blue.cgColor
//        viewVideoPlayer.layer.addSublayer(playerLayer)
//        player.play()
        
//        let videoURL = URL(string: "http://techslides.com/demos/sample-videos/small.mp4")
//        player = AVPlayer(url: videoURL!)
//        let playerViewController = AVPlayerViewController()
//        playerViewController.player = player
//        playerViewController.view.frame = viewVideoPlayer.frame
//        self.addSubview(playerViewController.view)
//        viewVideoPlayer.addSubview(playerViewController.view)
        
//        let videoURL = URL(string: "http://techslides.com/demos/sample-videos/small.mp4")
//        player = AVPlayer(url: videoURL!)
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = self.contentView.bounds
//        self.contentView.layer.addSublayer(playerLayer)
//        player.play()
//        self.viewVideoPlayer.adds
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
