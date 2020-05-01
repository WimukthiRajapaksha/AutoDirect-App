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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtView.isEditable = false
        txtView.dataDetectorTypes = .link
        txtView.text = "https://docs.google.com/document/d/1gmsKfFPpyUTI1QgKzm6CCrY54MdxpASBlTVlexWXscQ/edit"
        
        let link = URL(string:"https://docs.google.com/document/d/1gmsKfFPpyUTI1QgKzm6CCrY54MdxpASBlTVlexWXscQ/edit")!
        let request = URLRequest(url: link)
        webView.load(request)
    }
}
