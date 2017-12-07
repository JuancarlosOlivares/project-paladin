/*
 Bluetooth connectivity and functionality was informed by following BluetoothLowEnergyIniOSSwift, located at https://github.com/BluetoothLowEnergyIniOSSwift.
 
 Some code from Chapter07, located at https://github.com/BluetoothLowEnergyIniOSSwift/Chapter07 was adapted to fit our purposes.
 */
import Foundation

class Sensor {
    var thresh:Int
    var dist:Int
    
    init() {
        dist = 0
        thresh = -100
    }
    
    init(thresh:Int) {
        dist = 0
        self.thresh = thresh
    }
    
    func isNear() -> Bool{
        return dist >= thresh
    }
}
