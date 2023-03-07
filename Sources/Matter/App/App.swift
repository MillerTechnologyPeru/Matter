//
//  App.swift
//  
//
//  Created by Alsey Coleman Miller on 7/17/22.
//

import Foundation
@_implementationOnly import CMatter

/// Matter Application Protocol
public protocol MatterApp {
    
    associatedtype Configuration: ConfigurationManager
    
    static var configuration: Configuration { get }
    
    associatedtype DeviceInfo: DeviceInstanceInfoProvider
    
    static var deviceInfo: DeviceInfo { get }
    
    associatedtype ServiceDiscovery: ServiceDiscoveryManager
    
    static var serviceDiscovery: ServiceDiscovery { get }
}

extension MatterApp {
    
    public static func main() {
        
        // store Swift singleton
        MatterAppCache.app = self
        
        // start main loop
        main_chip_app(CommandLine.argc, CommandLine.unsafeArgv)
    }
}

internal struct MatterAppCache {
    
    static var app: (any MatterApp.Type)!
}
