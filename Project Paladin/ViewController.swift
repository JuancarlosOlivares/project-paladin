/*
 Bluetooth connectivity and functionality was informed by following BluetoothLowEnergyIniOSSwift, located at https://github.com/BluetoothLowEnergyIniOSSwift.
 
 Some code from Chapter07, located at https://github.com/BluetoothLowEnergyIniOSSwift/Chapter07 was adapted to fit our purposes.
 */
import UIKit
import CoreBluetooth

class ViewController: UIViewController, CBCentralManagerDelegate, BlePeripheralDelegate {
    
    static let VU_THRESH:Int = -70
    static let LO_THRESH:Int = -60
    
    var vu:Sensor = Sensor(thresh:VU_THRESH)
    var lo:Sensor = Sensor(thresh:LO_THRESH)
    var defcon:Int = 0
    
    var connectedService:CBService!
    
    var connectedCharacteristic:CBCharacteristic!
    
    @IBOutlet weak var shield: UIImageView!
    @IBOutlet var status: UILabel!
    @IBOutlet var loSlider: UISlider!
    @IBOutlet var vuSlider: UISlider!
    @IBOutlet weak var loLabel: UILabel!
    @IBOutlet weak var vuLabel: UILabel!
    @IBOutlet var sBinder: UISwitch!
    
    var pollTimer: Timer!
    
    var centralManager:CBCentralManager!
    
    var vuPeriph:BlePeripheral!
    var loPeriph:BlePeripheral!
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central Manager updated: checking state")
        
        switch (central.state) {
        case .poweredOn:
            print("bluetooth on")
        default:
            print("bluetooth unavailable")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral, didConnect periph2: CBPeripheral) {
        print("Connected Peripheral: \(String(describing: peripheral.name))")
        
        if(peripheral == vuPeriph) {
            vuPeriph.connected(peripheral: peripheral)
        } else if(peripheral == loPeriph) {
            loPeriph.connected(peripheral: peripheral)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("failed to connect")
        print(error.debugDescription)
        
    }
   
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected Peripheral: \(String(describing: peripheral.name))")
        centralManager.connect(peripheral)
        //dismiss(animated: true, completion: nil)
    }
    
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
    
    func setLo(val:Int) {
        lo.dist = val
        loSlider.setValue(Float(val), animated: true)
        loLabel.text = String(val)
    }
    
    func setVu(val:Int) {
        vu.dist = val
        vuSlider.setValue(Float(val), animated: true)
        vuLabel.text = String(val)
    }
    
    func setVuPeripheral(peripheral: BlePeripheral){
        vuPeriph = peripheral
    }
    
    func setLoPeripheral(peripheral: BlePeripheral){
        loPeriph = peripheral
    }
    
    /*func moveLo(delta:Int) {
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
    
    func moveVu(delta:Int) {
        let newVal = vu.dist + delta
        
        switch newVal {
        case _ where newVal < 0:
            setVu(val:0)
        case _ where newVal > 1:
            setVu(val:1)
        default:
            setVu(val:newVal)
        }
    }*/
    
    @IBAction func updateLoSlider(_ sender: UISlider) {
        /*let delta = sender.value - lo.dist
        setLo(val:sender.value)
        
        if(sBinder.isOn) {
            moveVu(delta: delta)
        }
        
        updateState()*/
    }
    
    @IBAction func updateVuSlider(_ sender: UISlider) {
        /*let delta = sender.value - vu.dist
        setVu(val:sender.value)
        
        if(sBinder.isOn) {
            moveLo(delta: delta)
        }
        
        updateState()*/
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
        
        vuPeriph.delegate = self
        loPeriph.delegate = self
        centralManager.delegate = self
        centralManager.connect(vuPeriph.peripheral)
        centralManager.connect(loPeriph.peripheral)
        
        print("VU PERIPHERAL: " + vuPeriph.advertisedName + "\nLO PERIPHERAL: " + loPeriph.advertisedName)
        pollTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(ViewController.pollForData), userInfo: nil, repeats: true)
    }
    
    @objc func pollForData(){
        //print("TIMER FIRED")
        
        vuPeriph.peripheral.readRSSI()
        loPeriph.peripheral.readRSSI()
        
        setVu(val: vuPeriph.rssi.intValue)
        setLo(val: loPeriph.rssi.intValue)
        
        updateState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
