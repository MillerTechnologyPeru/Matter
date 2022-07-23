//
//  App.swift
//  
//
//  Created by Alsey Coleman Miller on 7/17/22.
//

import Foundation
@_implementationOnly import CMatter

public protocol MatterApp {
    
    associatedtype Configuration: ConfigurationManager
    
    static var configuration: Configuration { get }
    
    associatedtype DeviceInfo: DeviceInstanceInfoProvider
    
    static var deviceInfo: DeviceInfo { get }
    
    //static func main()
}

extension MatterApp {
    
    public static func main() {
        
        // store Swift singleton
        MatterAppCache.app = self
        
        // set C++ singletons
        var deviceInfo = chip.DeviceLayer.DeviceInstanceInfoProviderImpl()
        let setDeviceInstanceInfoProvider = unsafeBitCast(chip.DeviceLayer.SetDeviceInstanceInfoProvider, to: ((UnsafeMutablePointer<chip.DeviceLayer.DeviceInstanceInfoProviderImpl>?) -> Void).self)
        setDeviceInstanceInfoProvider(&deviceInfo)
        
        CHIPSetDiagnosticDataProviderImpl()
        
        // start main loop
        main_chip_app(CommandLine.argc, CommandLine.unsafeArgv)
    }
}

internal struct MatterAppCache {
    
    static var app: (any MatterApp.Type)!
}
