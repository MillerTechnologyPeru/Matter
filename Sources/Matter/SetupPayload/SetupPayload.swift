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
    
    public var rendezvousInformation: RendezvousInformationFlags?
    
    public var discriminator: UInt16
    
    public var setupPinCode: UInt32
    
    public var serialNumber: String?
    
    public var vendorData: [QRCodeInfo]
    
    init(version: UInt8,
         vendorID: UInt16,
         productID: UInt16,
         commissioningFlow: CommissioningFlow = .standard,
         rendezvousInformation: RendezvousInformationFlags?,
         discriminator: UInt16,
         setupPinCode: UInt32,
         serialNumber: String? = nil,
         vendorData: [QRCodeInfo] = []
    ) {
        self.version = version
        self.vendorID = vendorID
        self.productID = productID
        self.commissioningFlow = commissioningFlow
        self.rendezvousInformation = rendezvousInformation
        self.discriminator = discriminator
        self.setupPinCode = setupPinCode
        self.serialNumber = serialNumber
        self.vendorData = vendorData
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
        
        var rendezvousInformation: RendezvousInformationFlags? {
            get { cxxObject.rendezvousInformation.HasValue() ? .init(cxxObject.rendezvousInformation.Value().pointee) : nil }
            set { cxxObject.rendezvousInformation = newValue.flatMap { .init(.init(.init($0))) } ?? .Missing() }
        }
        
        var discriminator: UInt16 {
            get { cxxObject.discriminator.longValue }
            set {
                var descriminator = chip.SetupDiscriminator()
                descriminator.SetLongValue(newValue)
                cxxObject.discriminator = descriminator
            }
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
            try cxxObject.addSerialNumber(serialNumber.toCXX()).throwError()
        }
        
        func addOptionalVendorData(_ string: String, tag: UInt8) throws {
            try cxxObject.addOptionalVendorData(tag, serialNumber.toCXX()).throwError()
        }
        
        func addOptionalVendorData(_ value: Int32, tag: UInt8) throws {
            try cxxObject.addOptionalVendorData(tag, value).throwError()
        }
        
        func addOptionalVendorData(_ value: QRCodeInfoData, tag: UInt8) throws {
            switch value {
            case let .string(value):
                try addOptionalVendorData(value, tag: tag)
            case let .int32(value):
                try addOptionalVendorData(value, tag: tag)
            case let .uint32(value):
                try addOptionalVendorData(.init(bitPattern: value), tag: tag)
            case let .int64(value):
                try addOptionalVendorData(numericCast(value), tag: tag)
            case let .uint64(value):
                try addOptionalVendorData(numericCast(Int64(bitPattern: value)), tag: tag)
            }
        }
        
        func removeOptionalVendorData(for tag: UInt8) throws {
            try cxxObject.removeOptionalVendorData(tag).throwError()
        }
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
        self.vendorData = object.allOptionalVendorData
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
        value.vendorData.forEach {
            do { try self.addOptionalVendorData($0.data, tag: $0.tag) }
            catch { assertionFailure("Unable to add optional vendor data. \(error)") }
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
            rendezvousInformation: value.rendezvousInformation.flatMap { .init(.init(.init($0))) } ?? .Missing(),
            discriminator: {
                var descriminator = chip.SetupDiscriminator()
                descriminator.SetLongValue(value.discriminator)
                return descriminator
            }(),
            setUpPINCode: value.setupPinCode
        )
    }
}
