//
//  GroupID.swift
//  
//
//  Created by Alsey Coleman Miller on 6/14/22.
//

/// A Group ID is a 16-bit number that identifies a set of Nodes across a Fabric at the message layer.
public struct GroupID: RawRepresentable, Equatable, Hashable, Codable {
    
    public let rawValue: UInt16
    
    public init(rawValue: UInt16) {
        self.rawValue = rawValue
    }
    
    private init(_ raw: UInt16) {
        self.rawValue = raw
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension GroupID: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt16) {
        self.init(rawValue: value)
    }
}

// MARK: - CustomStringConvertible

extension GroupID: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        rawValue.description
    }
    
    public var debugDescription: String {
        description
    }
}
