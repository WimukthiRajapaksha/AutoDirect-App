//
//  VehicleCategoryTableViewCell.swift
//  Auto Direct
//
//  Created by User on 4/14/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import AlamofireImage
import Alamofire

class VehicleCategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var lblBrandName: UILabel!
    @IBOutlet weak var lblBrandDetail: UILabel!
    @IBOutlet weak var imgBrand: UIImageView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var viewFeature1: CarItemFeature!
    @IBOutlet weak var viewFeature2: CarItemFeature!
    @IBOutlet weak var viewFeature3: CarItemFeature!
    @IBOutlet weak var viewFeature4: CarItemFeature!
    @IBOutlet weak var viewFeature5: CarItemFeature!
    
    private var fuelType: String!
    private var engine: String!
    private var transmission: String!
    private var year: Int!
    private var type: String!
    
    public func setItemData(brandName: String, brandDetail: String, imageUrl: String, amount: String, fuelType: String, engine: String, transmission: String, year: String, type: String) {
        self.lblBrandDetail.text = brandDetail
        self.lblBrandName.text = brandName
        self.lblAmount.text = "LKR \(amount)"
//        let dom = Domain()
//        dom?.loadImage(url: imageUrl, completion: { (bool, jso) in
//            if bool {
//                self.imgBrand.image = UIImage(data: jso)
//            } else {
//                self.imgBrand.image = UIImage(named: "placeholder")
//            }
//
//        })
        self.imgBrand.image = UIImage(named: "placeholder")
        AF.request(imageUrl).responseImage { (response) in
            if response.error == nil {
                self.imgBrand.image = UIImage(data: response.data!)
            } else {
                self.imgBrand.image = UIImage(named: "placeholder")
            }
        }
        
//        self.imgBrand.af_setImage(withURL: URL(string: imageUrl)!)
//        self.imgBrand.downloaded(from: imageUrl)
//        self.imgBrand.load(url: URL(string: imageUrl)!)
//        self.imgBrand.downloadImage(from: URL(string: imageUrl)!)
        self.viewFeature1.lblFeature.text = fuelType
        self.viewFeature2.lblFeature.text = engine
        self.viewFeature3.lblFeature.text = transmission
        self.viewFeature4.lblFeature.text = year
        self.viewFeature5.lblFeature.text = type
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewFeature1.imgFeature.image = UIImage(named: "petrol")
        viewFeature1.lblFeature.text = "Petrol"
   //     viewFeature1.viewImage.backgroundColor = .clear
        
        viewFeature2.imgFeature.image = UIImage(named: "engine")
        viewFeature2.lblFeature.text = "1.3L"
   //     viewFeature2.viewImage.backgroundColor = .clear
        
        viewFeature3.imgFeature.image = UIImage(named: "transmission")
        viewFeature3.lblFeature.text = "Auto"
 //       viewFeature3.viewImage.backgroundColor = .clear
        
        viewFeature4.imgFeature.image = UIImage(named: "year")
        viewFeature4.lblFeature.text = "2019"
 //       viewFeature4.viewImage.backgroundColor = .clear
        
        viewFeature5.imgFeature.image = UIImage(named: "readyToShipSk")
        viewFeature5.lblFeature.text = "Ready to\nShip"
//        viewFeature5.viewImage.backgroundColor = .green
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
