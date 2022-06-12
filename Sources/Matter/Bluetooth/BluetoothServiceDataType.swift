//
//  ServiceDataType.swift
//  
//
//  Created by Alsey Coleman Miller on 6/11/22.
//

import Foundation
import Bluetooth

/// Matter Bluetooth Service DataType
public enum BluetoothServiceDataType: UInt8, Codable {
    
    /// Device Identification Info
    case deviceIdentificationInfo   = 0x00
    
    /// Token Identification Info
    case tokenIdentificationInfo    = 0x01
}
