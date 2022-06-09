//
//  MemoryAllocator.swift
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

@_implementationOnly import CMatter

internal struct MemoryAllocator {
    
    static let initialize: Void = {
        chip.Platform.MemoryInit(nil, 0)
    }()
}
