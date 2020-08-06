//
//  FormatterUtil.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 7/28/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation
import SwiftyJSON

class FormatterUtil {
    private var responseBool: Bool
    private var responseBody: JSON
    
    init(responseCode: Int, dataBody: Data?) {
        if (responseCode == 200) {
            if (dataBody != nil) {
                do {
                    responseBody = try JSON(data: dataBody!)
                } catch {
                    responseBody = JSON(["content", "nil"])
                }
            } else {
                responseBody = JSON(["content", "nil"])
            }
            responseBool = true
        } else {
            responseBool = false
            responseBody = JSON(["content", "nil"])
        }
    }
    
    public func getFormattedResponse() -> (Bool, JSON) {
        return (responseBool, responseBody)
    }
}
