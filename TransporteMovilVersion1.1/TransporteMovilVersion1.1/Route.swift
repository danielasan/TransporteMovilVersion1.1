//
//  Route.swift
//  TransporteMovilVersion1.1
//
//  Created by SSiOS on 5/14/19.
//  Copyright © 2019 SSiOS. All rights reserved.
//

import Foundation
import UIKit


class Route{
    
    var name: String
    var color: UIColor
    var baseOne: String
    var baseTwo: String
    var schedule: String
    var rate: Double
    
    init(name: String, color: UIColor, baseOne: String, baseTwo: String, schedule: String, rate: Double) {
        self.name = name
        self.color = color
        self.baseOne = baseOne
        self.baseTwo = baseTwo
        self.schedule = schedule
        self.rate = rate
        
    }
}
