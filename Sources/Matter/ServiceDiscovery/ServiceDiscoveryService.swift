//
//  ServiceDiscoveryService.swift
//  
//
//  Created by Alsey Coleman Miller on 3/6/23.
//

import Foundation
@_implementationOnly import CMatter

public struct ServiceDiscoveryService: Equatable, Hashable {
    
    public let hostName: String
    
    public let type: String
    
    public let name: String
    
    public let port: UInt16
    
    public let `protocol`: ServiceDiscoveryProtocol
    
    public let ttlSeconds: UInt32
    
    public let txtRecord: [String: Data]
}

internal extension ServiceDiscoveryService {
    
    init(_ service: inout CHIPDNSSDService) {
        self.name = withUnsafeBytes(of: &service.mName) {
            String(cString: $0.assumingMemoryBound(to: UInt8.self).baseAddress!)
        }
        self.type = withUnsafeBytes(of: &service.mType) {
            String(cString: $0.assumingMemoryBound(to: UInt8.self).baseAddress!)
        }
        self.port = service.mPort
        self.hostName = withUnsafeBytes(of: &service.mHostName) {
            String(cString: $0.assumingMemoryBound(to: UInt8.self).baseAddress!)
        }
        self.ttlSeconds = service.mTtlSeconds
        self.protocol = .init(rawValue: service.mProtocol.rawValue)!
        var records = [String: Data]()
        records.reserveCapacity(service.mTextEntrySize)
        for i in 0 ..< service.mTextEntrySize {
            let entry = service.mTextEntries[i]
            let key = String(cString: entry.mKey)
            let data = Data(bytes: UnsafeRawPointer(entry.mData!), count: entry.mDataSize)
            records[key] = data
        }
        self.txtRecord = records
    }
}
