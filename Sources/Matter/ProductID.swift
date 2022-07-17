//
//  ProductID.swift
//  
//
//  Created by Alsey Coleman Miller on 6/14/22.
//

/**
 A Product ID  is a 16-bit number that uniquely identifies a product of a vendor.
 */
public struct ProductID: RawRepresentable, Equatable, Hashable, Codable {
    
    public let rawValue: UInt16
    
    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }
    
    private init(_ raw: UInt16) {
        self.rawValue = raw
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension ProductID: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt16) {
        self.init(rawValue: value)
    }
}

// MARK: - CustomStringConvertible

extension ProductID: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        rawValue.description
    }
    
    public var debugDescription: String {
        description
    }
}

// MARK: - Definitions

public extension ProductID {
    
    /// Anonymized Product ID as part of device discovery.
    static var any: VendorID { 0x00 }
}
