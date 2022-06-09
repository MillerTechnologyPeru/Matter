//
//  SetupPayload.swift
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

import Foundation
@_implementationOnly import CMatter

public final class SetupPayload {
    
    internal typealias CPPObject = chip.SetupPayload
    
    internal let cppObject: CPPObject
    
    internal init(_ cppObject: CPPObject) {
        self.cppObject = cppObject
    }
}
