//
//  AppConfigManager.swift
//  
//
//  Created by Alsey Coleman Miller on 7/17/22.
//

import Foundation
@_implementationOnly import CMatter

// CHIP_ERROR CHIPConfigurationManagerGetVendorId(uint16_t & vendorId);
@_cdecl("CHIPConfigurationManagerGetVendorId")
internal func CHIPConfigurationManagerGetVendorId(_ vendorId: UnsafeMutablePointer<UInt16>) -> CHIP_ERROR {
    vendorId.pointee = VendorID.matter.rawValue
    return CHIP_ERROR(0)
}
