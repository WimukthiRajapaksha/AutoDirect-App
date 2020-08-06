//
//  ThirdModelDetailsTableViewCell.swift
//  Auto Direct
//
//  Created by User on 4/19/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit

class ThirdModelDetailsTableViewCell: UITableViewCell {
    @IBOutlet var whatsappView: UIView!
    @IBOutlet weak var lblStockNumber: UILabel!
    @IBOutlet weak var lblSendInquire: UILabel!
    
    private var make: String!
    private var model: String!
    private var year: String!
    private var stockNumber: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.lblSendInquire.text = "Send Inquire on\nWhatsapp"
        whatsappView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSendWhatsAppMessage)))
    }
    
    public func setModelDetailsForWhatsAppInquiry(make: String, model: String, year: String, stockNumber: String) {
        self.make = make
        self.model = model
        self.year = year
        self.stockNumber = stockNumber
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func onSendWhatsAppMessage() {
        let urlString = "I would like to make an inquire on \(self.make!) \(self.model!) \(self.year!)\nStock No - \(self.stockNumber!)"
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
    }

}
