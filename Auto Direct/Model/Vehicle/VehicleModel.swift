//
//  VehicleModel.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/28/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation

class VehicleModel {
    private var modelId: Int
    private var modelName: String
    private var make: String
    
    init(modelId: Int, make: String, modelName: String) {
        self.modelId = modelId
        self.make = make
        self.modelName = modelName
    }
    
    public func getModelId() -> Int {
        return self.modelId
    }
    
    public func getMake() -> String {
        return self.make
    }
    
    public func getModelName() -> String {
        return self.modelName
    }
}
