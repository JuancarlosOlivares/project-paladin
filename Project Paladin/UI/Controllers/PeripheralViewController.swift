/*
 Bluetooth connectivity and functionality was informed by following BluetoothLowEnergyIniOSSwift, located at https://github.com/BluetoothLowEnergyIniOSSwift.
 
 Some code from Chapter07, located at https://github.com/BluetoothLowEnergyIniOSSwift/Chapter07 was adapted to fit our purposes.
 */
import UIKit
import CoreBluetooth
/**
 This view lists the GATT profile of a connected characteristic
 */
class PeripheralViewController: UIViewController, UITableViewDelegate, CBCentralManagerDelegate, BlePeripheralDelegate {
    
    // MARK: UI Elements
    weak var advertisedNameLabel: UILabel!
    weak var identifierLabel: UILabel!
    weak var rssiLabel: UILabel!
    weak var gattProfileTableView: UITableView!
    weak var gattTableView: UITableView!
    
    var pollTimer: Timer!
    
    // Central Manager
    var centralManager:CBCentralManager!
    
    // connected Peripheral
    var blePeripheral:BlePeripheral!
    
    //UIView loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Will connect to \(blePeripheral.peripheral.identifier.uuidString)")
        
        // Assign delegates
        blePeripheral.delegate = self
        centralManager.delegate = self
        centralManager.connect(blePeripheral.peripheral)
    }
    
   
    //RSSI discovered.  Update UI
    
    func blePeripheral(readRssi rssi: NSNumber, blePeripheral: BlePeripheral) {
        rssiLabel.text = rssi.stringValue
    }
   
    /**
     Peripheral connected.  Update UI
     */
    var rssiValue:Int?
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected Peripheral: \(String(describing: peripheral.name))")
        
        advertisedNameLabel.text = blePeripheral.advertisedName
        identifierLabel.text = blePeripheral.peripheral.identifier.uuidString
        
        blePeripheral.connected(peripheral: peripheral)
        rssiValue = (blePeripheral.rssi.intValue)
        print("current value or signal ", rssiValue!)
        
        pollTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PeripheralViewController.pollForData), userInfo: nil, repeats: true)
    }
    
    /**
     Connection to Peripheral failed.
     */
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        print("failed to connect")
        print(error.debugDescription)
    }
    
    /**
     Peripheral disconnected.  Leave UIView
     */
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected Peripheral: \(String(describing: peripheral.name))")
        dismiss(animated: true, completion: nil)
    }
    
    /**
     Bluetooth radio state changed.
     */
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("Central Manager updated: checking state")
        
        switch (central.state) {
        case .poweredOn:
            print("bluetooth on")
        default:
            print("bluetooth unavailable")
        }
    }
    
    
    @objc func pollForData(){
        blePeripheral.peripheral.readRSSI()
        print(blePeripheral.rssi.stringValue)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("leaving view - disconnecting from peripheral")
        
        if let indexPath = gattTableView.indexPathForSelectedRow {
            let selectedSection = indexPath.section
            let selectedRow = indexPath.row
            
            //  let characteristicViewController = segue.destination as! CharacteristicViewController
            
            if selectedSection < blePeripheral.gattProfile.count {
                _ = blePeripheral.gattProfile[selectedSection]
                
                if let characteristics = blePeripheral.gattProfile[selectedSection].characteristics {
                    
                    if selectedRow < characteristics.count {
                        // populate next UIView with necessary information
                        //  characteristicViewController.centralManager = centralManager
                        // characteristicViewController.blePeripheral = blePeripheral
                        // characteristicViewController.connectedService = service
                        // characteristicViewController.connectedCharacteristic = characteristics[selectedRow]
                    }
                    
                }
            }
            gattTableView.deselectRow(at: indexPath, animated: true)
            
        } else {
            if let peripheral = blePeripheral.peripheral {
                centralManager.cancelPeripheralConnection(peripheral)
            }
        }
    }
    
}


