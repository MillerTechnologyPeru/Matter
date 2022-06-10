//
//  ManualSetupPayloadParser.swift
//  
//
//  Created by Alsey Coleman Miller on 6/10/22.
//

@_implementationOnly import CMatter

internal final class ManualSetupPayloadParser: CXXReference {
    
    typealias CXXObject = chip.ManualSetupPayloadParser
    
    private(set) var cxxObject: CXXObject
    
    init(_ cxxObject: CXXObject) {
        let _ = MemoryAllocator.initialize
        self.cxxObject = cxxObject
    }
    
    init(decimal string: String) {
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
    
    init(manual decimal: String) throws {
        let parser = ManualSetupPayloadParser(decimal: decimal)
        self = try parser.populatePayload()
    }
}
