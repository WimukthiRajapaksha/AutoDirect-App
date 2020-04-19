//
//  SidebarSubItemMODEL.swift
//  Auto Direct
//
//  Created by User on 4/15/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation

class SidebarSubItemModel {
    private let subItemName: String
    private let subItemDescription: String?
    
    init(subItemName: String, subItemDescription: String?) {
        self.subItemName = subItemName
        self.subItemDescription = subItemDescription
    }
    
    public func getSubItemName() -> String {
        return subItemName
    }
    
    public func getSubItemDescription() -> String? {
        return self.subItemDescription
    }
}
