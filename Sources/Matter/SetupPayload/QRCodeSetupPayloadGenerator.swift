//
//  QRCodeSetupPayloadGenerator.swift
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

@_implementationOnly import CMatter

internal final class QRCodeSetupPayloadGenerator: CXXReference {
    
    typealias CXXObject = chip.QRCodeSetupPayloadGenerator
    
    private(set) var cxxObject: CXXObject
    
    init(_ cxxObject: CXXObject) {
        let _ = MemoryAllocator.initialize
        self.cxxObject = cxxObject
    }
    
    init(payload: SetupPayload) {
        let _ = MemoryAllocator.initialize
        let payloadObject = SetupPayload.ReferenceType(payload)
        self.cxxObject = CXXObject(payloadObject.cxxObject)
    }
    
    /// This function is called to encode the binary data of a payload to a base38 null-terminated string using CHIP TLV encoding scheme.
    func generateBase38EncodedString() throws -> String {
        var cxxString = std.string()
        var data = [UInt8]()
        data.reserveCapacity(128)
        try cxxObject.payloadBase38Representation(&cxxString, &data, UInt32(data.capacity)).throwError()
        return String(cxxString: cxxString)
    }
    
    func setAllowInvalidPayload(_ allow: Bool = true) {
        cxxObject.SetAllowInvalidPayload(allow)
    }
}

public extension SetupPayload {
    
    func generateQRCode() throws -> String {
        return try generateQRCode(allowInvalid: true)
    }
    
    internal func generateQRCode(allowInvalid: Bool) throws -> String {
        let generator = QRCodeSetupPayloadGenerator(payload: self)
        generator.setAllowInvalidPayload(allowInvalid)
        return try generator.generateBase38EncodedString()
    }
}
