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
    
    init(modelId: Int, modelName: String) {
        self.modelId = modelId
        self.modelName = modelName
    }
    
    public func getModelId() -> Int {
        return self.modelId
    }
    
    public func getModelName() -> String {
        return self.modelName
    }
}
