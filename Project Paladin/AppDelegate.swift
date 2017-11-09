//
//  AppDelegate.swift
//  Project Paladin
//
//  Created by Juancarlos Olivares on 10/3/17.
//  Copyright © 2017 Olive Tree Ent. All rights reserved.
//

import UIKit
import CoreBluetooth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
      
        /*let vc = ViewController()
        let vu = Vu(vc: vc)
        let lo = Lo(vc: vc)
        var armed:Bool=false
       
        func arm(){
            armed = true
        }
        
        func disarm(){
            armed = false
        }
        
        func pollSensorData(){
           lo.update()
           vu.update()
        }
        
        func alert(){
            
        }
      //  display()
        
        while (true) {
            //insert sample rate control thread here
            pollSensorData()
            
            if (!armed) {
                if (lo.isNear() && vu.isNear()) {
                    vc.setArmed()
                    arm()
                }
                continue
            }
            
            if (!vu.isNear()) {
                if lo.isNear(){
                    vc.setUnarmed()
                    disarm()
                } else {
                    vc.setAlert()
                    
                }
                continue
               
            }
        }
 
        */
    return true
 
    }
   
    func applicationWillResignActive(_ application: UIApplication) {
      
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

/*
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    
    func sum(num: Int, nom: Int) -> Int {
        print(greet(person: "name"))
        return num + nom
    }
    
    func greet(person: String) -> String {
        return "Hello, " + person + "!"
    }
    
    print(sum(num: 2,nom: 4))
    return true
}
 */

/*  var window: UIWindow?
 var BtOn = bluetoothStatus.poweredOn(5)
 var BtOff = bluetoothStatus.poweredOff(4)
 
 
 enum bluetoothStatus{
 case poweredOn(Int)
 case poweredOff(Int)
 }
 
 init(delegate: CBCentralManagerDelegate?,
 queue: DispatchQueue?,
 options: [String : Any]? = nil){
 let CBCentralManagerOptionShowPowerAlertKey: String  //alerts user if bt is off to turn it on
 }
 
 
 func display(){
 let newLoDistance:Float=4
 let newVuDistance:Float=5
 let x = Lo()
 let y = Sensor()
 let z = Vu()
 print("Maximum Threshhold: ", y.getMaxDistance())
 print("current Lo distance: ", x.getDistance())
 x.setDistance(newDistance: newLoDistance)
 print("new Lo distance: ", x.getDistance())
 print("current Vu distance: ", z.getDistance())
 z.setDistance(newDistance: newVuDistance)
 print("new Vu distance: ", z.getDistance())
 
 print("Maximum Threshhold: ", y.getMaxDistance())
 print("current Lo distance: ", x.getDistance())
 x.setDistance(newDistance: newLoDistance)
 print("new Lo distance: ", x.getDistance())
 print("current Vu distance: ", z.getDistance())
 z.setDistance(newDistance: newVuDistance)
 print("new Vu distance: ", z.getDistance())
 }
 
 
 
 */


