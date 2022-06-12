//
//  BluetoothUUID.swift
//  
//
//  Created by Alsey Coleman Miller on 6/11/22.
//

import Foundation
import Bluetooth

public extension BluetoothUUID {
    
    static var matterService: BluetoothUUID { BluetoothUUID(rawValue: "0000FFF6-0000-1000-8000-00805F9B34FB")! }
    
    static var matterCharacteristic1: BluetoothUUID { BluetoothUUID(rawValue: "18EE2EF5-263D-4559-959F-4F9C429F9D11")! }
    
    static var matterCharacteristic2: BluetoothUUID { BluetoothUUID(rawValue: "18EE2EF5-263D-4559-959F-4F9C429F9D12")! }
    
    static var matterCharacteristic3: BluetoothUUID { BluetoothUUID(rawValue: "64630238-8772-45F2-B87D-748A83218F04")! }
}
