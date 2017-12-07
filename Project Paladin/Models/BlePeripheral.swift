/*
 Bluetooth connectivity and functionality was informed by following BluetoothLowEnergyIniOSSwift, located at https://github.com/BluetoothLowEnergyIniOSSwift.
 
 Some code from Chapter07, located at https://github.com/BluetoothLowEnergyIniOSSwift/Chapter07 was adapted to fit our purposes.
 */
import UIKit
import CoreBluetooth


/**
 BlePeripheral Handles communication with a Bluetooth Low Energy Peripheral
 */
class BlePeripheral: NSObject, CBPeripheralDelegate {
    
    // MARK: Peripheral properties
    
    // delegate
    var delegate:BlePeripheralDelegate?
    
    // connected Peripheral
    var peripheral:CBPeripheral!
    
    // advertised name
    var advertisedName:String!
    
    // RSSI
    var rssi:NSNumber!
    
    // GATT profile tree
    var gattProfile = [CBService]()
    
    
    /**
     Initialize BlePeripheral with a corresponding Peripheral
     
     - Parameters:
     - delegate: The BlePeripheralDelegate
     - peripheral: The discovered Peripheral
     */
    init(delegate: BlePeripheralDelegate?, peripheral: CBPeripheral) {
        super.init()
        self.peripheral = peripheral
        self.peripheral.delegate = self
        self.delegate = delegate
    }
    
    
    /**
     Notify the BlePeripheral that the peripheral has been connected
     
     - Parameters:
     - peripheral: The discovered Peripheral
     */
    func connected(peripheral: CBPeripheral) {
        self.peripheral = peripheral
        self.peripheral.delegate = self
        
        // check for services and the RSSI
        self.peripheral.readRSSI()
        self.peripheral.discoverServices(nil)
    }
    
    
    /**
     Get a broadcast name from an advertisementData packet.  This may be different than the actual broadcast name
     */
    static func getNameFromAdvertisementData(advertisementData: [String : Any]) -> String? {
        // grab thekCBAdvDataLocalName from the advertisementData to see if there's an alternate broadcast name
        if advertisementData["kCBAdvDataLocalName"] != nil {
            return (advertisementData["kCBAdvDataLocalName"] as! String)
        }
        return nil
    }
    
    /**
     Determine if this peripheral is connectable from it's advertisementData packet.
     */
    static func isConnectable(advertisementData: [String: Any]) -> Bool {
        let isConnectable = advertisementData["kCBAdvDataIsConnectable"] as! Bool
        return isConnectable
    }
    
    /**
     RSSI read from peripheral.
     */
    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?) {
        print("RSSI: \(RSSI.stringValue)")
        rssi = RSSI
        delegate?.blePeripheral?(readRssi: rssi, blePeripheral: self)
        
    }
    
    
}

