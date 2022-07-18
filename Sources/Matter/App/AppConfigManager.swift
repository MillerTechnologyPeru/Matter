//
//  AppConfigManager.swift
//  
//
//  Created by Alsey Coleman Miller on 7/17/22.
//

import Foundation

public protocol AppConfigurationManager {
    
    var vendorID: VendorID { get }
    
    var productID: ProductID { get }
}

// MARK: - Callbacks

@_silgen_name("CHIPConfigurationManagerGetVendorId")
internal func CHIPConfigurationManagerGetVendorId(_ vendorId: UnsafeMutablePointer<UInt16>) -> UInt32 {
    vendorId.pointee = MatterAppCache.app.configuration.vendorID.rawValue
    return 0
}

@_silgen_name("CHIPConfigurationManagerGetProductId")
internal func CHIPConfigurationManagerGetProductId(_ productId: UnsafeMutablePointer<UInt16>) -> UInt32 {
    productId.pointee = MatterAppCache.app.configuration.productID.rawValue
    return 0
}
