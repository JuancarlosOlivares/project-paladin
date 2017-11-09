//
//  Sensor.swift
//  Project Paladin
//
//  Created by Juancarlos Olivares on 10/24/17.
//  Copyright © 2017 Olive Tree Ent. All rights reserved.
//

import Foundation

class Sensor/*: AppDelegate*/{
   
    
    //private var alert:Bool
    var thresh:Float
    var dist:Float
    //var slider = Slider()
    
    init() {
        dist = 0
        thresh = 0.5
    }
    
    init(thresh:Float) {
        dist = 0
        self.thresh = thresh
    }
    
    func isNear()-> Bool{
        return dist <= thresh
    }
    
    
    
    //func getMaxDistance()->Float{
    //    return thresh
    //}
    
   // func update(){
   //     dist = slider.val
   // }
    
}




 //private var minDistance:Double = 0

//}




//add bottom implementation in CareTaker
// private var range:Bool = false


//@override
//func isInRange()->Bool{
//    return range

