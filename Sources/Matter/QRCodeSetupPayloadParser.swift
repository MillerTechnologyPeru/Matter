//
//  SetupPayloadParser.swift
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

@_implementationOnly import CMatter

internal final class QRCodeSetupPayloadParser: CXXReference {
    
    typealias CXXObject = chip.QRCodeSetupPayloadParser
    
    private(set) var cxxObject: CXXObject
    
    init(_ cxxObject: CXXObject) {
        let _ = MemoryAllocator.initialize
        self.cxxObject = cxxObject
    }
    
    init(base38Encoded string: String) {
        let _ = MemoryAllocator.initialize
        let cxxString = string.withCString { cString -> std.string in
            var cxxString = std.string()
            cxxString.append(cString)
            return cxxString
        }
        self.cxxObject = CXXObject(cxxString)
    }
    
    func populatePayload() throws -> SetupPayload {
        var cxxPayload = MatterSetupPayloadCreate()
        try cxxObject.populatePayload(&cxxPayload).throwError()
        return SetupPayload(.init(cxxPayload))
    }
}

public extension SetupPayload {
    
    init(qrCode base38Encoded: String) throws {
        let parser = QRCodeSetupPayloadParser(base38Encoded: base38Encoded)
        self = try parser.populatePayload()
    }
}
