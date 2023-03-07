//
//  ServiceDiscoveryProtocol.swift
//  
//
//  Created by Alsey Coleman Miller on 3/6/23.
//

import Foundation

public enum ServiceDiscoveryProtocol: UInt8, Codable, CaseIterable {
    
    case udp    = 0
    case tcp    = 1
}

public extension ServiceDiscoveryProtocol {
    
    var stringValue: String {
        switch self {
        case .udp:
            return "._tcp."
        case .tcp:
            return "._udp."
        }
    }
}
