//
//  FirstTableViewCell.swift
//  Auto Direct
//
//  Created by User on 4/20/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class FirstReserveTableViewCell: UITableViewCell {
    @IBOutlet weak var imgVehicle: UIImageView!
    @IBOutlet weak var lblModel: UILabel!
    @IBOutlet weak var lblDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        imgVehicle.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setData(imgUrl: String, title: String, type: String) {
        print(imgUrl)
//        self.imgVehicle.downloaded(from: imgUrl)
        
        AF.request(imgUrl).responseImage { (response) in
            if response.error == nil {
                self.imgVehicle.image = UIImage(data: response.data!)
            } else {
                self.imgVehicle.image = UIImage(named: "placeholder")
            }
        }
        
        self.lblModel.text = title
        self.lblDetail.text = type
    }

}
