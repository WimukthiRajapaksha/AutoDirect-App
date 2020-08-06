//
//  SearchVehicles.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 8/3/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation

class SearchVehicles {
    let condition: String
    let make: String
    let model: String
    let year: String
    let minPrice: String
    let maxPrice: String
    
    init(condition: String, make: String, model: String, year: String, minPrice: String, maxPrice: String) {
        self.condition = condition
        self.make = make
        self.model = model
        self.year = year
        self.minPrice = minPrice
        self.maxPrice = maxPrice
    }
}
