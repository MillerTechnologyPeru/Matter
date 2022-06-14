//
//  NodeID.swift
//  
//
//  Created by Alsey Coleman Miller on 6/14/22.
//

/**
 A Node ID is a 64-bit number that uniquely identifies an individual Node or a group of Nodes on a Fabric.
 */
public struct NodeID: RawRepresentable, Equatable, Hashable, Codable {
    
    public let rawValue: UInt64
    
    public init(rawValue: UInt64) {
        self.rawValue = rawValue
    }
    
    private init(_ raw: UInt64) {
        self.rawValue = raw
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension NodeID: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt64) {
        self.init(rawValue: value)
    }
}

// MARK: - CustomStringConvertible

extension NodeID: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        rawValue.description
    }
    
    public var debugDescription: String {
        description
    }
}
