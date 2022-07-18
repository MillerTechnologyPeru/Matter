//
//  AppConfigManager.swift
//  
//
//  Created by Alsey Coleman Miller on 7/17/22.
//

import Foundation

public protocol ConfigurationManager {
    
    var vendorID: VendorID { get throws }
    
    var productID: ProductID { get throws }
}

// MARK: - Callbacks

@_silgen_name("CHIPConfigurationManagerGetVendorId")
internal func CHIPConfigurationManagerGetVendorId(_ vendorId: UnsafeMutablePointer<UInt16>) -> UInt32 {
    do {
        vendorId.pointee = try MatterAppCache.app.configuration.vendorID.rawValue
    }
    catch let error as MatterError {
        return error.code.rawValue
    }
    catch {
        return MatterErrorCode.sdk(.application, code: 0).rawValue
    }
    return 0
}

@_silgen_name("CHIPConfigurationManagerGetProductId")
internal func CHIPConfigurationManagerGetProductId(_ productId: UnsafeMutablePointer<UInt16>) -> UInt32 {
    do {
        productId.pointee = try MatterAppCache.app.configuration.productID.rawValue
    }
    catch let error as MatterError {
        return error.code.rawValue
    }
    catch {
        return MatterErrorCode.sdk(.application, code: 0).rawValue
    }
    return 0
}
