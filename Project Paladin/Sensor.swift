//
//  Sensor.swift
//  Project Paladin
//
//  Created by Juancarlos Olivares on 10/24/17.
//  Copyright © 2017 Olive Tree Ent. All rights reserved.
//

import Foundation

class Sensor {
    var thresh:Float
    var dist:Float
    
    init() {
        dist = 0
        thresh = 0.5
    }
    
    init(thresh:Float) {
        dist = 0
        self.thresh = thresh
    }
    
    func isNear() -> Bool{
        return dist <= thresh
    }
}
