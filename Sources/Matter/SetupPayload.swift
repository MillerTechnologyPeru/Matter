//
//  SetupPayload.swift
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

import Foundation
@_implementationOnly import CMatter

public struct SetupPayload {
    
    internal var handle: MutableHandle<ReferenceType>
    
    internal init(_ handle: MutableHandle<ReferenceType>) {
        self.handle = handle
    }
    
    internal init() {
        self.init(MutableHandle(adoptingReference: ReferenceType()))
    }
    
    public var version: UInt8 {
        get { handle.map { $0.version } }
        set { applyMutation { $0.version = newValue } }
    }
    
    public var serial: String {
        get throws {
            try handle.map { try $0.serial }
        }
    }
}

extension SetupPayload: MutableReferenceConvertible {
    
    final class ReferenceType: CXXReference, Duplicatable {
        
        typealias CXXObject = MatterSetupPayload
        
        private(set) var cxxObject: CXXObject
        
        init() {
            self.cxxObject = CXXObject()
        }
        
        init(_ cxxObject: CXXObject) {
            self.cxxObject = cxxObject
        }
        
        func copy() -> ReferenceType {
            let copy = ReferenceType()
            copy.version = self.version
            return copy
        }
        
        var version: UInt8 {
            get { cxxObject.version }
            set { cxxObject.version = newValue }
        }
        
        var serial: String {
            get throws {
                var cxxString = std.string.init()
                let error = cxxObject.getSerialNumber(&cxxString)
                guard error.AsInteger() == 0 else {
                    throw MatterError(error)
                }
                return String(cString: cxxString.c_str())
            }
        }
    }
}
