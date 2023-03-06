//
//  SetupDiscriminator.swift
//  
//
//  Created by Alsey Coleman Miller on 3/6/23.
//

import Foundation
@_implementationOnly import CMatter

/// Setup Discriminator
public enum SetupDiscriminator: Equatable, Hashable, Codable {
    
    /// Short Value
    case short(UInt8)
    
    /// Long Value
    case long(UInt16)
}

// MARK: - CustomStringConvertible

extension SetupDiscriminator: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case let .short(value):
            return "0x" + value.toHexadecimal()
        case let .long(value):
            return "0x" + value.toHexadecimal()
        }
    }
}

// MARK: - CXX Interop

internal extension SetupDiscriminator {
    
    init(_ chip: chip.SetupDiscriminator) {
        if chip.IsShortDiscriminator() {
            let value = chip.GetShortValue()
            self = .short(value)
        } else {
            let value = chip.GetLongValue()
            self = .long(value)
        }
    }
}

internal extension chip.SetupDiscriminator {
    
    init(_ descriminator: SetupDiscriminator) {
        self.init()
        switch descriminator {
        case let .short(value):
            self.SetShortValue(value)
        case let .long(value):
            self.SetLongValue(value)
        }
    }
}
