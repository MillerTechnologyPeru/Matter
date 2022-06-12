//
//  BluetoothTransportProtocolVersion.swift
//  
//
//  Created by Alsey Coleman Miller on 6/11/22.
//

/// Matter Bluetooth Transport Protocol Version
public struct BluetoothTransportProtocolVersion: RawRepresentable, Equatable, Hashable, Codable {
    
    public let rawValue: UInt8
    
    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
}

// MARK: - CustomStringConvertible

extension BluetoothTransportProtocolVersion: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        "v\(rawValue)"
    }
    
    public var debugDescription: String {
        description
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension BluetoothTransportProtocolVersion: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt8) {
        self.init(rawValue: value)
    }
}

// MARK: - Definitions

public extension BluetoothTransportProtocolVersion {
    
    /// Version 4
    static var v4: BluetoothTransportProtocolVersion { 4 } // BTP as defined by CHIP v1.0
}
