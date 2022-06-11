//
//  SetupPayload.swift
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

import Foundation
@_implementationOnly import CMatter

public struct SetupPayload: Equatable, Hashable, Codable {
    
    public var version: UInt8
    
    public var vendorID: UInt16
    
    public var productID: UInt16
    
    public var commissioningFlow: CommissioningFlow
    
    public var rendezvousInformation: RendezvousInformationFlags
    
    public var discriminator: UInt16
    
    public var setupPinCode: UInt32
    
    public var serialNumber: String?
    
    init(version: UInt8,
         vendorID: UInt16,
         productID: UInt16,
         commissioningFlow: CommissioningFlow = .standard,
         rendezvousInformation: RendezvousInformationFlags = [],
         discriminator: UInt16,
         setupPinCode: UInt32,
         serialNumber: String? = nil
    ) {
        self.version = version
        self.vendorID = vendorID
        self.productID = productID
        self.commissioningFlow = commissioningFlow
        self.rendezvousInformation = rendezvousInformation
        self.discriminator = discriminator
        self.setupPinCode = setupPinCode
        self.serialNumber = serialNumber
    }
}

// MARK: - MutableReferenceConvertible

extension SetupPayload: ReferenceConvertible {
    
    final class ReferenceType: CXXReference, Equatable {
        
        typealias CXXObject = MatterSetupPayload
        
        private(set) var cxxObject: CXXObject
        
        init() {
            self.cxxObject = MatterSetupPayloadCreate()
        }
        
        init(_ cxxObject: CXXObject) {
            self.cxxObject = cxxObject
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
                var cxxString = std.string()
                try cxxObject.getSerialNumber(&cxxString).throwError()
                return String(cxxString: cxxString)
            }
        }
        
        var allOptionalVendorData: [QRCodeInfo] {
            let cxxVector = cxxObject.getAllOptionalVendorData()
            return (0 ..< cxxVector.size())
                .map { QRCodeInfo(cxxVector[$0]) }
        }
        
        func addSerialNumber(_ serialNumber: String) throws {
            try cxxObject.addSerialNumber(std.string(serialNumber)).throwError()
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
        
        */
    }
}

internal extension SetupPayload {
    
    init(_ object: ReferenceType) {
        self.version = object.version
        self.vendorID = object.vendorID
        self.productID = object.productID
        self.commissioningFlow = object.commissioningFlow
        self.rendezvousInformation = object.rendezvousInformation
        self.discriminator = object.discriminator
        self.setupPinCode = object.setupPinCode
        self.serialNumber = try? object.serialNumber
    }
}

internal extension SetupPayload.ReferenceType {
    
    convenience init(_ value: SetupPayload) {
        self.init()
        self.version = value.version
        self.vendorID = value.vendorID
        self.productID = value.productID
        self.commissioningFlow = value.commissioningFlow
        self.rendezvousInformation = value.rendezvousInformation
        self.discriminator = value.discriminator
        self.setupPinCode = value.setupPinCode
        if let serialNumber = value.serialNumber {
            do { try self.addSerialNumber(serialNumber) }
            catch { assertionFailure("Unable to add serial number. \(error)") }
        }
    }
}

internal extension chip.PayloadContents {
    
    init(_ value: SetupPayload) {
        self.init(
            version: value.version,
            vendorID: value.vendorID,
            productID: value.productID,
            commissioningFlow: .init(value.commissioningFlow),
            rendezvousInformation: .init(value.rendezvousInformation),
            discriminator: value.discriminator,
            setUpPINCode: value.setupPinCode,
            isShortDiscriminator: false // TODO: isShortDiscriminator
        )
    }
}
