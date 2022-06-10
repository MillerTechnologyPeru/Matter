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
    
    public var vendorID: UInt16 {
        get { handle.map { $0.vendorID } }
        set { applyMutation { $0.vendorID = newValue } }
    }
    
    public var productID: UInt16 {
        get { handle.map { $0.productID } }
        set { applyMutation { $0.productID = newValue } }
    }
    
    public var commissioningFlow: CommissioningFlow {
        get { handle.map { $0.commissioningFlow } }
        set { applyMutation { $0.commissioningFlow = newValue } }
    }
    
    public var rendezvousInformation: RendezvousInformationFlags {
        get { handle.map { $0.rendezvousInformation } }
        set { applyMutation { $0.rendezvousInformation = newValue } }
    }
    
    public var discriminator: UInt16 {
        get { handle.map { $0.discriminator } }
        set { applyMutation { $0.discriminator = newValue } }
    }
    
    public var setupPinCode: UInt32 {
        get { handle.map { $0.setupPinCode } }
        set { applyMutation { $0.setupPinCode = newValue } }
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
            self.cxxObject = MatterSetupPayloadCreate()
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
        
        var vendorID: UInt16 {
            get { cxxObject.vendorID }
            set { cxxObject.vendorID = newValue }
        }
        
        var productID: UInt16 {
            get { cxxObject.productID }
            set { cxxObject.productID = newValue }
        }
        
        var commissioningFlow: CommissioningFlow {
            get { .init(cxxObject.commissioningFlow) }
            set { cxxObject.commissioningFlow = .init(newValue) }
        }
        
        var rendezvousInformation: RendezvousInformationFlags {
            get { .init(cxxObject.rendezvousInformation) }
            set { cxxObject.rendezvousInformation = .init(newValue) }
        }
        
        var discriminator: UInt16 {
            get { cxxObject.discriminator }
            set { cxxObject.discriminator = newValue }
        }
        
        var setupPinCode: UInt32 {
            get { cxxObject.setupPinCode }
            set { cxxObject.setupPinCode = newValue }
        }
        
        var isValidQRCodePayload: Bool {
            return cxxObject.isValidQRCodePayload
        }
        
        var isValidManualCode: Bool {
            return cxxObject.isValidManualCode
        }
        
        var serialNumber: String {
            get throws {
                var cxxString = std.string.init()
                try cxxObject.getSerialNumber(&cxxString).throwError()
                return String(cString: cxxString.c_str())
            }
        }
        
        var allOptionalVendorData: [QRCodeInfo] {
            let cxxVector = cxxObject.getAllOptionalVendorData()
            let count = cxxVector.size()
            return (0 ..< count)
                .map { QRCodeInfo(cxxVector[$0]) }
        }
        /*
        func addOptionalVendorData(_ string: String, tag: UInt8) throws {
            try string.withCString {
                try cxxObject.addOptionalVendorData(tag, std.string($0)).throwError()
            }
        }
        
        func addOptionalVendorData(_ value: Int32, tag: UInt8) throws {
            try cxxObject.addOptionalVendorData(tag, value).throwError()
        }
        
        func removeOptionalVendorData(for tag: UInt8) throws {
            try cxxObject.removeOptionalVendorData(tag).throwError()
        }
        
        func addSerialNumber(_ serialNumber: String) throws {
            try serialNumber.withCString {
                try cxxObject.addSerialNumber(std.string($0)).throwError()
            }
        }*/
    }
}
