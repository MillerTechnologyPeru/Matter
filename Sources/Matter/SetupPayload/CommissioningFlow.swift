//
//  CommissioningFlow.swift
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

@_implementationOnly import CMatter

/// Matter Commissioning Flow type.
public enum CommissioningFlow: UInt8, Codable, CaseIterable {
    
    /// Device automatically enters pairing mode upon power-up.
    case standard               = 0
    
    /// Device requires a user interaction to enter pairing mode.
    case userActionRequired     = 1
    
    /// Commissioning steps should be retrieved from the distributed compliance ledger.
    case custom                 = 2
}

internal extension CommissioningFlow {
    
    init(_ cxxValue: chip.CommissioningFlow) {
        self.init(rawValue: cxxValue.rawValue)!
    }
}

internal extension chip.CommissioningFlow {
    
    init(_ value: CommissioningFlow) {
        self.init(rawValue: value.rawValue)!
    }
}
