//
//  MatterTool.swift
//  
//
//  Created by Alsey Coleman Miller on 7/10/22.
//

import Foundation
import Matter

@main
struct MatterTool: MatterApp {
    
    static let configuration = AppConfiguration(
        vendorID: 0,
        productID: 0
    )
}

struct AppConfiguration: AppConfigurationManager {
    
    let vendorID: VendorID
    
    let productID: ProductID
}
