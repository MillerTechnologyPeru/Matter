//
//  VendorID.swift
//  
//
//  Created by Alsey Coleman Miller on 6/14/22.
//


/**
 A Vendor Identifier (Vendor ID or VID) is a 16-bit number that uniquely identifies a particular product manufacturer, vendor, or group thereof.
 
 Each Vendor ID is statically allocated by the [Connectivity Standards Alliance](https://groups.csa-iot.org).
 */
public struct VendorID: RawRepresentable, Equatable, Hashable, Codable {
    
    public let rawValue: UInt16
    
    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }
    
    private init(_ raw: UInt16) {
        self.rawValue = raw
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension VendorID: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt16) {
        self.init(rawValue: value)
    }
}

// MARK: - CustomStringConvertible

extension VendorID: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        rawValue.description
    }
    
    public var debugDescription: String {
        description
    }
}
