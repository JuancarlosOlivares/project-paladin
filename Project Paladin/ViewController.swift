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
    var defcon:Int = 0
    
    @IBOutlet weak var shield: UIImageView!
    @IBOutlet var status: UILabel!
    @IBOutlet var loSlider: UISlider!
    @IBOutlet var vuSlider: UISlider!
    @IBOutlet weak var loLabel: UILabel!
    @IBOutlet weak var vuLabel: UILabel!
    @IBOutlet var sBinder: UISwitch!
    
    func disarm() {
        defcon = 0
        shield.image = UIImage(named:"unarmed")
        status.text = "unarmed"
    }
    
    func arm() {
        defcon = 1
        shield.image = UIImage(named:"armed")
        status.text = "armed"
    }
    
    func alert() {
        defcon = 2
        shield.image = UIImage(named:"alert")
        status.text = "alert"
        createAlert(title: "ALERT", message: "You may have left your loved one in your vehicle!")
    }
    
    func setLo(val:Float) {
        lo.dist = val
        loSlider.setValue(val, animated: true)
        loLabel.text = String(val)
    }
    
    func setVu(val:Float) {
        vu.dist = val
        vuSlider.setValue(val, animated: true)
        vuLabel.text = String(val)
    }
    
    func moveLo(delta:Float) {
        let newVal = lo.dist + delta
        
        switch newVal {
        case _ where newVal < 0:
            setLo(val:0)
        case _ where newVal > 1:
            setLo(val:1)
        default:
            setLo(val:newVal)
        }
    }
    
    func moveVu(delta:Float) {
        let newVal = vu.dist + delta
        
        switch newVal {
        case _ where newVal < 0:
            setVu(val:0)
        case _ where newVal > 1:
            setVu(val:1)
        default:
            setVu(val:newVal)
        }
    }
    
    @IBAction func updateLoSlider(_ sender: UISlider) {
        let delta = sender.value - lo.dist
        setLo(val:sender.value)
        
        if(sBinder.isOn) {
            moveVu(delta: delta)
        }
        
        updateState()
    }
    
    @IBAction func updateVuSlider(_ sender: UISlider) {
        let delta = sender.value - vu.dist
        setVu(val:sender.value)
        
        if(sBinder.isOn) {
            moveLo(delta: delta)
        }
        
        updateState()
    }

    func updateState() {
        switch defcon {
            case 0:
                if (lo.isNear() && vu.isNear()) {
                    arm()
                }
            case 1:
                if (!vu.isNear()) {
                    if lo.isNear() {
                        disarm()
                    } else {
                        alert()
                    }
                }
            case 2:
                if (lo.isNear()) {
                    disarm()
                }
        default:
            print("Invalid DEFCON state.")
        }
    }
    
    func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,
                                      handler: {(action) in alert.dismiss(animated: true, completion: nil)}))
        
        self.present(alert, animated: true, completion: nil)
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
