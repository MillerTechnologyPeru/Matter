//
//  FabricID.swift
//  
//
//  Created by Alsey Coleman Miller on 6/14/22.
//

/**
 Fabric ID is a 64-bit number that uniquely identifies the Fabric within the scope of a particular root CA.
 */
public struct FabricID: RawRepresentable, Equatable, Hashable, Codable {
    
    public let rawValue: UInt64
    
    public init(rawValue: UInt64) {
        self.rawValue = rawValue
    }
    
    private init(_ raw: UInt64) {
        self.rawValue = raw
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension FabricID: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt64) {
        self.init(rawValue: value)
    }
}

// MARK: - CustomStringConvertible

extension FabricID: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        rawValue.description
    }
    
    public var debugDescription: String {
        description
    }
}

// MARK: - Definitions

public extension FabricID {
    
    /**
     Fabric ID `0` is reserved across all fabric root public key scopes.
     
     This fabric ID SHALL NOT be used as the identifier of a fabric.
     */
    static var none: FabricID { 0x00 }
}
