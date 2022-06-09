//
//  Error.swift
//  
//
//  Created by Alsey Coleman Miller on 6/8/22.
//

import Foundation

/// Matter framework error
public enum MatterError: Error {
    
    /// Unknown error
    case unknown
    
    /// Invalid string length
    case invalidStringLength
    
    /// Interaction error code
    case interaction(MatterInteractionErrorCode)
}

/// Matter error code
public enum MatterInteractionErrorCode: UInt8 {
    
    case failure = 0x01
}
