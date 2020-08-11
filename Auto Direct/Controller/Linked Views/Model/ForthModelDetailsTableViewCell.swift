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
import youtube_ios_player_helper

class ForthModelDetailsTableViewCell: UITableViewCell {
    @IBOutlet var viewVideoPlayer: UIView!
    @IBOutlet weak var ytPlayer: YTPlayerView!
    
    var player: AVPlayer!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func setPlayerLink(link: String) {
        self.ytPlayer.load(withVideoId: link)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
