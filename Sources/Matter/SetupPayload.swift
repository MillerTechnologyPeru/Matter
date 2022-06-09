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
    
    internal init(_ cxxObject: ReferenceType.CXXObject) {
        self.init(MutableHandle(adoptingReference: ReferenceType(cxxObject)))
    }
    
    public var version: UInt8 {
        get { handle.map { $0.version } }
        set { applyMutation { $0.version = newValue } }
    }
    
    public var serialNumber: String {
        get throws {
            try handle.map { try $0.serialNumber }
        }
    }
}

// MARK: - Equatable

extension SetupPayload: Equatable {
    
    public static func == (lhs: SetupPayload, rhs: SetupPayload) -> Bool {
        return lhs.handle.uncopiedReference() == rhs.handle.uncopiedReference()
    }
}

// MARK: - CustomStringConvertible

extension SetupPayload: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        "SetupPayload()" // TODO: description string
    }
    
    public var debugDescription: String {
        description
    }
}

// MARK: - MutableReferenceConvertible

extension SetupPayload: MutableReferenceConvertible {
    
    final class ReferenceType: CXXReference, Duplicatable, Equatable {
        
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
            assert(copy == self, "Duplicate \(String(describing: ReferenceType.self)) instance is not equal to original")
            return copy
        }
        
        static func == (lhs: ReferenceType, rhs: ReferenceType) -> Bool {
            return lhs.cxxObject.isEqual(rhs.cxxObject)
        }
        
        var version: UInt8 {
            get { cxxObject.version }
            set { cxxObject.version = newValue }
        }
        
        var serialNumber: String {
            get throws {
                var cxxString = std.string.init()
                let error = cxxObject.getSerialNumber(&cxxString)
                guard error.AsInteger() == 0 else {
                    throw MatterError(error)
                }
                return String(cString: cxxString.c_str())
            }
        }
        
        func addOptionalVendorData(_ vendorData: QRCodeInfo) throws {
            
        }
        
        func removeOptionalVendorData(for tag: UInt8) throws {
            
        }
        
        var allOptionalVendorData: [QRCodeInfo] {
            let cxxVector = cxxObject.getAllOptionalVendorData()
            let count = cxxVector.size()
            return (0 ..< count)
                .lazy
                .map { cxxVector[$0] }
                .map { QRCodeInfo($0) }
        }
        
        func addSerialNumber(_ serialNumber: String) throws {
            
        }
    }
}
