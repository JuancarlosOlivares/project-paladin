/*
 Bluetooth connectivity and functionality was informed by following BluetoothLowEnergyIniOSSwift, located at https://github.com/BluetoothLowEnergyIniOSSwift.
 
 Some code from Chapter07, located at https://github.com/BluetoothLowEnergyIniOSSwift/Chapter07 was adapted to fit our purposes.
 */
import UIKit
import CoreBluetooth

/**
 BlePeripheral relays important status changes from BlePeripheral
 */
@objc protocol BlePeripheralDelegate: class {
    /**
     RSSI was read for a Peripheral
     
     - Parameters:
     - rssi: the RSSI
     - blePeripheral: the BlePeripheral
     */
    @objc optional func blePeripheral(readRssi rssi: NSNumber, blePeripheral: BlePeripheral)
}

