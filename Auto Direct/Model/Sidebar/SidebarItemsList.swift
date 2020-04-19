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
            SidebarItemModel(itemHeader: "Main", subItems: ["About Us": nil, "What is PCP?": nil, "Inventory": nil, "Trade Your Vehicle": nil, "Our Deliveries": nil]),
            SidebarItemModel(itemHeader: "Working Hours", subItems: ["Monday to Friday": "9am to 7pm"]),
            SidebarItemModel(itemHeader: "Contact Details", subItems: ["Head Office": "207 Park Road, Colombo 5", "Branch Office": "11 S De S.Jayasinghe Mw, Kalubowila"])
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
