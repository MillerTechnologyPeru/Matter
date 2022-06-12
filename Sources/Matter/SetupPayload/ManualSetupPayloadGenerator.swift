//
//  ManualSetupPayloadGenerator.swift
//  
//
//  Created by Alsey Coleman Miller on 6/10/22.
//

@_implementationOnly import CMatter

internal final class ManualSetupPayloadGenerator: CXXReference {
    
    typealias CXXObject = chip.ManualSetupPayloadGenerator
    
    private(set) var cxxObject: CXXObject
    
    init(_ cxxObject: CXXObject) {
        let _ = MemoryAllocator.initialize
        self.cxxObject = cxxObject
    }
    
    init(payload: SetupPayload) {
        let _ = MemoryAllocator.initialize
        let cxxPayload = chip.PayloadContents(payload)
        self.cxxObject = CXXObject(cxxPayload)
    }
    
    func generateDecimalString() throws -> String {
        var cxxString = std.string()
        try cxxObject.payloadDecimalStringRepresentation(&cxxString).throwError()
        return String(cxxString: cxxString)
    }
    
    func setAllowInvalidPayload(_ allow: Bool = true) {
        cxxObject.SetAllowInvalidPayload(allow)
    }
}

public extension SetupPayload {
    
    func generateManualCode() throws -> String {
        return try generateManualCode(allowInvalid: true)
    }
    
    internal func generateManualCode(allowInvalid: Bool) throws -> String {
        let generator = ManualSetupPayloadGenerator(payload: self)
        generator.setAllowInvalidPayload(allowInvalid)
        return try generator.generateDecimalString()
    }
}
