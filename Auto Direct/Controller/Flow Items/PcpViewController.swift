//
//  PcpViewController.swift
//  Auto Direct
//
//  Created by User on 4/28/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import UIKit
import WebKit

class PcpViewController: BaseViewController {
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var webView: WKWebView!
    
    private var webLink: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtView.isEditable = false
        txtView.dataDetectorTypes = .link
        txtView.backgroundColor = .white
        txtView.tintColor = .black
        txtView.text = self.webLink
        let link = URL(string: self.webLink)!
        let request = URLRequest(url: link)
        webView.load(request)
        
        txtView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapTextView)))
    }
    
    public func setPcp(pcpLink: String) {
        self.webLink = pcpLink
    }
    
    @objc func tapTextView() {
        self.dismiss(animated: true, completion: nil)
    }
}
