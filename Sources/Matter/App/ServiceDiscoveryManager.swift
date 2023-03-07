//
//  ServiceDiscoveryManager.swift
//  
//
//  Created by Alsey Coleman Miller on 3/6/23.
//

import Foundation
#if canImport(NetService)
import NetService
#endif
@_implementationOnly import CMatter

public protocol ServiceDiscoveryManager {
    
    func publish(service: ServiceDiscoveryService) async throws
}

public final class NetServiceManager: NSObject, ServiceDiscoveryManager {

    public override init() { }
    
    public func publish(
        service: ServiceDiscoveryService
    ) async throws {
        let netService = NetService(
            domain: service.domain,
            type: service.type,
            name: service.type,
            port: Int32(service.port)
        )
        let txtRecord = NetService.data(fromTXTRecord: service.txtRecord)
        netService.setTXTRecord(txtRecord)
        netService.delegate = self
        netService.publish()
    }
}

// MARK: - NetServiceDelegate

extension NetServiceManager: NetServiceDelegate {
    
}

// MARK: - C Callbacks

/// `extern "C" uint32_t CHIPDNSSDInit(DnssdAsyncReturnCallback initCallback, DnssdAsyncReturnCallback errorCallback, void * context);`
@_silgen_name("CHIPDNSSDInit")
internal func CHIPDNSSDInit(
    initCallback: CHIPDNSSDAsyncReturnCallback,
    errorCallback: CHIPDNSSDAsyncReturnCallback,
    context: UnsafeMutableRawPointer
) -> UInt32 {
    initCallback(context, .none)
    return 0
}

/// `extern "C" uint32_t CHIPDNSSDPublishService(const CHIPDNSSDService * service, CHIPDNSSDPublishCallback callback, void * context)`
@_silgen_name("CHIPDNSSDPublishService")
internal func CHIPDNSSDPublishService(
    service chipService: inout CHIPDNSSDService,
    callback: CHIPDNSSDPublishCallback,
    context: UnsafeMutableRawPointer?
) -> UInt32 {
    let service = ServiceDiscoveryService(&chipService)
    let manager = MatterAppCache.app.serviceDiscovery
    Task {
        try await manager.publish(service: service)
        callback(context, service.type, service.name, .none)
    }
    /*
    Task {
        let matterError: MatterError
        do {
            try await manager.publish(service: service)
            matterError = .none
        }
        catch let error is MatterError {
            matterError = error
        }
        catch {
            matterError = .init(sdk: .application, code: 0)
        }
        //let chipError = MatterError.CXXObject(matterError)
        //callback(chipError)
    }*/
    return 0
}
