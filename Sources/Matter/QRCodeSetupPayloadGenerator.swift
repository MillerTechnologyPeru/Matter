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
        self.cxxObject = payload.handle.map { CXXObject($0.cxxObject) }
    }
    
    func generateBase38EncodedString() throws -> String {
        var cxxString = std.string()
        let cxxError = cxxObject.payloadBase38Representation(&cxxString)
        guard cxxError.AsInteger() == 0 else {
            throw MatterError(cxxError)
        }
        return String(cString: cxxString.c_str())
    }
}

public extension SetupPayload {
    
    func generateQRCode() throws -> String {
        let generator = QRCodeSetupPayloadGenerator(payload: self)
        return try generator.generateBase38EncodedString()
    }
}
