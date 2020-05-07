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
    
    private let webLink: String
    
    required init?(coder aDecoder: NSCoder) {
        self.webLink = "https://docs.google.com/document/d/1gmsKfFPpyUTI1QgKzm6CCrY54MdxpASBlTVlexWXscQ/edit"
        super.init(coder: aDecoder)
    }
    
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
    }
}
