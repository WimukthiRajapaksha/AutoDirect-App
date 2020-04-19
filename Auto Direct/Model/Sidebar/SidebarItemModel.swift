//
//  SidebarItemModel.swift
//  Auto Direct
//
//  Created by User on 4/15/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation

class SidebarItemModel {
    private var itemHeader: String
    private var itemSubItems: [SidebarSubItemModel]
    
    init(itemHeader: String, subItems: [String: String?]) {
        self.itemHeader = itemHeader
        itemSubItems = []
//        itemSubItems = [SidebarSubItemModel(subItemName: subItems.k, subItemDescription: String?)]
        for item in subItems {
            itemSubItems.append(SidebarSubItemModel(subItemName: item.key, subItemDescription: item.value))
        }
        print(itemSubItems)
    }
    
    public func getItemHeader() -> String {
        return self.itemHeader
    }
    
    public func getSubItems() -> [SidebarSubItemModel] {
        return self.itemSubItems
    }
}
