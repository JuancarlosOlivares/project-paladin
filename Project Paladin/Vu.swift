//
//  Vu.swift
//  Project Paladin
//  Class that is responsible for keeping track of distance of VU from CareTaker
//
//  Created by Juancarlos Olivares on 10/24/17.
//  Copyright © 2017 Olive Tree Ent. All rights reserved.
//

import Foundation

class Vu: Sensor {
    override init() {
        super.init()
        thresh = ViewController.VU_THRESH
    }
    
    /*private var currentDistance:Float=0
    var CBAdvertisementDataTxPowerLevelKey: String?
    override init() {
        currentDistance = 0
    //    thresh = 0.5
        //slider = ViewController.giveVuSlider()
    }
    init(vc:ViewController){
        super.init()
        currentDistance = 0
        thresh = 0.5
        //slider = ViewController.giveVuSlider()

    }
    
    func getDistance()->Float{
        return currentDistance
    }
    
    func setDistance(newDistance:Float){
        currentDistance = newDistance
    } */
}
