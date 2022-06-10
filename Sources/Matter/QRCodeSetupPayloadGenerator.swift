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
    
    func generateBase38EncodedString() throws -> String {
        var cxxString = std.string()
        try cxxObject.payloadBase38Representation(&cxxString).throwError()
        return String(cString: cxxString.c_str())
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
