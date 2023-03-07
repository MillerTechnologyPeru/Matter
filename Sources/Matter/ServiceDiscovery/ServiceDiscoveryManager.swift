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

public final class NetServiceManager: ServiceDiscoveryManager {

    public init() {
        #if DEBUG
        self.log = { print($0) }
        #endif
        let _ = self.delegate
    }
    
    public var log: ((String) -> ())?
        
    private lazy var delegate = Delegate(self)
    
    private let storage = Storage()
    
    public func publish(
        service: ServiceDiscoveryService
    ) async throws {
        let (object, publish) = await storage.update {
            let netService = NetService(
                domain: "local",
                type: service.type + service.protocol.stringValue,
                name: service.name,
                port: Int32(service.port)
            )
            let txtRecord = NetService.data(fromTXTRecord: service.txtRecord)
            netService.setTXTRecord(txtRecord)
            netService.delegate = delegate
            $0.services.insert(netService)
            let publish = { netService.publish() }
            let object = ObjectIdentifier(netService)
            return (object, publish)
        }
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Swift.Error>) in
            Task {
                await storage.update {
                    $0.continuation.publish[object] = continuation
                    publish() // execute
                }
            }
        }
    }
}

public extension NetServiceManager {
    
    enum Error: Swift.Error {
        
        case publish([String: NSNumber])
    }
}

internal extension NetServiceManager {
    
    actor Storage {
        
        init() { }
        
        var state = InternalState()
        
        func update<T>(_ block: (inout InternalState) -> (T)) -> T {
            return block(&state)
        }
    }
    
    struct InternalState {
        
        var continuation = Continuation()
        
        var services = Set<NetService>()
    }
    
    struct Continuation {
        
        var publish = [ObjectIdentifier: CheckedContinuation<Void, Swift.Error>]()
    }
}

// MARK: - NetServiceDelegate

extension NetServiceManager {
    
    final class Delegate: NSObject, NetServiceDelegate {
        
        weak var manager: NetServiceManager!
        
        init(_ manager: NetServiceManager) {
            self.manager = manager
        }
        
        func log(_ message: String) {
            self.manager?.log?(message)
        }
        
        func netServiceWillPublish(_ sender: NetService) {
            log("Will publish \(sender.domain).\(sender.type):\(sender.name)")
        }
        
        func netServiceDidPublish(_ sender: NetService) {
            log("Did publish \(sender.domain).\(sender.type):\(sender.name)")
            let object = ObjectIdentifier(sender)
            Task {
                await manager.storage.update {
                    $0.continuation.publish[object]?.resume()
                    $0.continuation.publish[object] = nil
                }
            }
        }
        
        func netService(_ sender: NetService, didNotPublish errorDict: [String : NSNumber]) {
            log("Did not publish \(sender.domain).\(sender.type):\(sender.name)")
            let error = NetServiceManager.Error.publish(errorDict)
            let object = ObjectIdentifier(sender)
            Task {
                await manager.storage.update {
                    $0.continuation.publish[object]?.resume(throwing: error)
                    $0.continuation.publish[object] = nil
                }
            }
        }
    }
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
    print(service)
    Task {
        let matterError: MatterError.CXXObject
        do {
            try await manager.publish(service: service)
            matterError = .none
        } catch {
            matterError = .none
            print(error)
        }
        callback(context, service.type, service.name, matterError)
    }
    return 0
}
