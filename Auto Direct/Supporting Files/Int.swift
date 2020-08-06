//
//  Int.swift
//  Auto Direct
//
//  Created by Wimukthi Rajapaksha on 8/4/20.
//  Copyright © 2020 autoDirect. All rights reserved.
//

import Foundation

extension Int {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
