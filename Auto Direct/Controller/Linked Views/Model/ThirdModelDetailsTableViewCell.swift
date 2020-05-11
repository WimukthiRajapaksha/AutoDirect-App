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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        whatsappView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onSendWhatsAppMessage)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func onSendWhatsAppMessage() {
        let urlString = "Hi! Please send me more details on XXXX model."
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
