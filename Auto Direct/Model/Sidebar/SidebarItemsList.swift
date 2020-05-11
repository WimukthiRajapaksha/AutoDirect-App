//
//  SidebarItemsList.swift
//  Auto Direct
//
//  Created by User on 4/15/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation

class SidebarItemsList {
    private var itemsList: [SidebarItemModel]
    
    init() {
        itemsList = [
            SidebarItemModel(itemHeader: "Main", subItems: ["1About Us": nil, "2What is PCP?": nil, "3Inventory": nil, "4Trade Your Vehicle": nil, "5Our Deliveries": nil]),
            SidebarItemModel(itemHeader: "Working Hours", subItems: ["1Monday to Friday": "9am to 7pm", "2Saturdat & Sunday / Holidays": "9am to 1.30pm"]),
            SidebarItemModel(itemHeader: "Contact Details", subItems:
                ["1Head Office": "207 Park Road, Colombo 5",
                 "2Hotline": "775687687 / 775697697",
                 "3Land Line": "117465465",
                 "4Email": "support@autodirect.lk",
                 "5Fax": "117465475",
                 "6WhatsApp": "0779033388",
                 "7Branch Office": "11 S De S.Jayasinghe Mw, Kalubowila"
                ])
        ]
    }
    
//    "Main"
//    "About Us"
//    "What is PCP?"
//    "Inventory"
//    "Trade Your Vehicle"
//    "Our Deliveries"
//
//    "Working Hours"
//    "Monday to Friday 9am to 7pm"
//    "Saturday & Sunday / Holidays 9am to 1.30pm"
//
//    "Contact Details"
//    "Head Office"
//    "207 Park Road, Colombo 5"
//    "Branch Office"
//    "11 S De S.Jayasinghe Mw, Kalubowila"
    
    public func getItemsList() -> [SidebarItemModel] {
        return itemsList
    }
}
