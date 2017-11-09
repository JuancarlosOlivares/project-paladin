//
//  ViewController.swift
//  uiDesign
//
//  Created by Lili on 11/7/17.
//  Copyright © 2017 Lili. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    static let VU_THRESH:Float = 0.5
    static let LO_THRESH:Float = 0.4
    
    var vu:Sensor = Sensor(thresh:VU_THRESH)
    var lo:Sensor = Sensor(thresh:LO_THRESH)
    var armed:Bool = false
    //var vuDist:Float = 0
    //var loDist:Float = 0
    //var vuSlider:Slider = Slider() //VU Slider
    //var loSlider:Slider = Slider() //LO Slider
    
    /*/Getters
    func giveVuSlider()-> Slider{
        return vuSlider
    }
    
    func giveLoSlider()-> Slider{
        return loSlider
        
    }
    /*******/
 */
    
    @IBOutlet weak var shield: UIImageView!
    @IBOutlet var status: UILabel!
    
    
    //Setters
    func disarm() {
        armed = false
        shield.image = UIImage(named:"unarmed")
        status.text = "unarmed"
    }
    
    func arm() {
        armed = true
        shield.image = UIImage(named:"armed")
        status.text = "armed"
    }
    
    func alert() {
        shield.image = UIImage(named:"alert")
        status.text = "alert"
    }
    /*********/
    
    
    
    //LO Slider
    @IBOutlet weak var loLabel: UILabel!
    
    @IBAction func updateLoSlider(_ sender: UISlider) {
        //loLabel.text = String(sender.value)
         //loSlider.val = sender.value
        
        lo.dist = sender.value
        loLabel.text = String(lo.dist)
        
        updateState()
    }
    
    //VU Slider
    @IBOutlet weak var vuLabel: UILabel!
    
    @IBAction func updateVuSlider(_ sender: UISlider) {
        //vuLabel.text = String(sender.value)
         //vuSlider.val = sender.value
        
        vu.dist = sender.value
        vuLabel.text = String(vu.dist)
        
        updateState()
    }
    
    func updateState() {
        if (!armed) {
            if (lo.isNear() && vu.isNear()) {
                arm()
            }
            return
        }
        
        if (!vu.isNear()) {
            if lo.isNear(){
                disarm()
            } else {
                alert()
            }
            return
        }
    }
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

