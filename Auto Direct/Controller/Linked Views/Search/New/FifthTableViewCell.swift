//
//  FifthTableViewCell.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/31/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

protocol SearchDelegate {
    func search()
}

class FifthTableViewCell: UITableViewCell {
    @IBOutlet weak var btn: UIButton!
    
    var searchDelegate: SearchDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(btn.bounds.height)
        btn.layer.cornerRadius = btn.frame.size.height/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onTouch(_ sender: Any) {
        searchDelegate.search()
    }
    

}
