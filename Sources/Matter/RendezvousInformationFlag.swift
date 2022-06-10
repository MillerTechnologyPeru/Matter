//
//  RendezvousInformationFlags.swift
//  
//
//  Created by Alsey Coleman Miller on 6/10/22.
//

@_implementationOnly import CMatter

/// Matter Rendezvous Information Flags
public struct RendezvousInformationFlags: OptionSet, Hashable, Codable {
    
    public var rawValue: UInt8
    
    public init(rawValue: UInt8) {
        self.rawValue = rawValue
    }
    
    private init(_ raw: UInt8) {
        self.init(rawValue: raw)
    }
}

public extension RendezvousInformationFlags {
    
    /// Device supports Wi-Fi softAP
    static var softAP: RendezvousInformationFlags        { RendezvousInformationFlags(0x01) }
    
    /// Device supports BLE
    static var bluetooth: RendezvousInformationFlags     { RendezvousInformationFlags(0x02) }
    
    /// Device supports Setup on network
    static var onNetwork: RendezvousInformationFlags     { RendezvousInformationFlags(0x04) }
}

internal extension chip.RendezvousInformationFlags {
    
    init(_ flag: RendezvousInformationFlags) {
        self.init(flag.rawValue)
    }
}

internal extension RendezvousInformationFlags {
    
    init(_ flag: RendezvousInformationFlags) {
        self.init(rawValue: flag.rawValue)
    }
}
