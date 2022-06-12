//
//  DeviceIdentificationInfo.swift
//  
//
//  Created by Alsey Coleman Miller on 6/11/22.
//

import Foundation
import Bluetooth

/// Matter Bluetooth Device Identification Info
///
/// Defines the over-the-air encoded format of the device identification information block that appears
/// within Matter BLE service advertisement data.
public struct BluetoothDeviceIdentificationInfo: Equatable, Hashable, Codable {
    
    public var version: UInt8
    
    public var descriminator: UInt16 // 12-bit value
    
    public var vendorID: UInt16
    
    public var productID: UInt16
    
    public var additionalData: Bool
}
