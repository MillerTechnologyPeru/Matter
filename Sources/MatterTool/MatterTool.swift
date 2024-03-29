//
//  MatterTool.swift
//  
//
//  Created by Alsey Coleman Miller on 7/10/22.
//

import Foundation
import MatterPackage
#if canImport(NetService)
import NetService
#endif

@main
struct MatterTool: MatterApp {
    
    static let configuration = AppConfiguration(
        vendorID: 0,
        productID: 0
    )
    
    static let deviceInfo = AppDeviceInfo(
        serialNumber: "123456789",
        manufacturingDate: (year: 2022, month: 0, day: 1),
        hardwareVersion: 0x01
    )
    
    static let serviceDiscovery = NetServiceManager()
}

struct AppConfiguration: ConfigurationManager {
    
    let vendorID: VendorID
    
    let productID: ProductID
}

struct AppDeviceInfo: DeviceInstanceInfoProvider {
    
    let serialNumber: String
    
    let manufacturingDate: (year: UInt16, month: UInt8, day: UInt8)
    
    let hardwareVersion: UInt16
}
