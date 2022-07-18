//
//  App.swift
//  
//
//  Created by Alsey Coleman Miller on 7/17/22.
//

import Foundation

public protocol MatterApp {
    
    associatedtype Configuration: AppConfigurationManager
    
    static var configuration: Configuration { get }
    
    //static func main()
}

extension MatterApp {
    
    public static func main() {
        // store singleton
        MatterAppCache.app = self
        CHIPAppMain()
    }
}

internal struct MatterAppCache {
    
    static var app: (any MatterApp.Type)!
}
