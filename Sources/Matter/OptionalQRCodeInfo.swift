//
//  OptionalQRCodeInfo.swift
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

import Foundation
@_implementationOnly import CMatter

public enum QRCodeInfo: Equatable, Hashable {
    
    case unknown
    case string(String)
    case int32(Int32)
    case int64(Int64)
    case uint32(UInt32)
    case uint64(UInt64)
}

public enum QRCodeInfoType: UInt32 {
    
    case unknown
    case string
    case int32
    case int64
    case uint32
    case uint64
}

public extension QRCodeInfo {
    
    var type: QRCodeInfoType {
        switch self {
        case .unknown:
            return .unknown
        case .string:
            return .string
        case .int32:
            return .int32
        case .int64:
            return .int64
        case .uint32:
            return .uint32
        case .uint64:
            return .uint64
        }
    }
}

internal extension chip.OptionalQRCodeInfo {
    
    init(_ value: QRCodeInfo, tag: UInt8) {
        self.init()
        /*
        self.tag = tag
        self.type = .init(value.type.rawValue)
        switch value {
        case .unknown:
            break
        case let .string(string):
            self.type = .init(QRCodeInfoType.string.rawValue)
            string.withCString { cString in
                self.data = std.string.init(cString)
            }
        case let .int32(value):
            //self.int32 = value
            break
        case let .uint32(value):
            //self.uint32 = numericCast(value)
            break
        case let .int64(value):
            //self.int64 = value
            break
        case let .uint64(value):
            //self.uint64 = value
            break
        }*/
    }
}
