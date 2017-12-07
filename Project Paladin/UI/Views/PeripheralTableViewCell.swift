/*
 Bluetooth connectivity and functionality was informed by following BluetoothLowEnergyIniOSSwift, located at https://github.com/BluetoothLowEnergyIniOSSwift.
 
 Some code from Chapter07, located at https://github.com/BluetoothLowEnergyIniOSSwift/Chapter07 was adapted to fit our purposes.
 */
import UIKit
import CoreBluetooth

/**
 Peripheral Table View Cell
 */
class PeripheralTableViewCell: UITableViewCell {
    
    // MARK: UI elements
    @IBOutlet weak var advertisedNameLabel: UILabel!
    @IBOutlet weak var identifierLabel: UILabel!
    @IBOutlet weak var rssiLabel: UILabel!
    
    var rssiValue:Int?
    
    /**
     Render Cell with Peripheral properties
     */
    func renderPeripheral(_ blePeripheral: BlePeripheral) {
        advertisedNameLabel.text = blePeripheral.advertisedName
        identifierLabel.text = blePeripheral.peripheral.identifier.uuidString
       // rssiLabel.text = blePeripheral.rssi.stringValue
       // rssiValue = (Int)(blePeripheral.rssi.stringValue)
       // print(rssiValue!)
    }
    
    
    
}

