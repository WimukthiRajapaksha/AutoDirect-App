//
//  FirstModelDetailsTableViewCell.swift
//  Auto Direct
//
//  Created by User on 4/19/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import ImageSlideshow

class FirstModelDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var imgSlideShow: ImageSlideshow!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgSlideShow.setImageInputs([
            ImageSource(image: UIImage(named: "car-1")!),
            ImageSource(image: UIImage(named: "car-2")!),
            ImageSource(image: UIImage(named: "car-3")!),
            ImageSource(image: UIImage(named: "car-4")!),
            ImageSource(image: UIImage(named: "car-5")!),
            ImageSource(image: UIImage(named: "car-6")!),
            ImageSource(image: UIImage(named: "car-7")!),
            ImageSource(image: UIImage(named: "car-8")!),
            ImageSource(image: UIImage(named: "car-9")!),
            ImageSource(image: UIImage(named: "car-10")!),
            ImageSource(image: UIImage(named: "car-11")!),
            ImageSource(image: UIImage(named: "car-12")!),
            ImageSource(image: UIImage(named: "car-13")!),
            ImageSource(image: UIImage(named: "car-14")!)
        ])
        
        imgSlideShow.slideshowInterval = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func reserve(_ sender: Any) {
        print("----")
    }
    @IBAction func pcp(_ sender: Any) {
        print("====")
    }
    
}
