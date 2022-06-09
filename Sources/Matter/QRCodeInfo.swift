//
//  OptionalQRCodeInfo.swift
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

@_implementationOnly import CMatter

public struct QRCodeInfo: Equatable, Hashable {
    
    public var data: QRCodeInfoData
    
    public var tag: UInt8
    
    public init(data: QRCodeInfoData, tag: UInt8) {
        self.data = data
        self.tag = tag
    }
}

public enum QRCodeInfoData: Equatable, Hashable {
    
    case string(String)
    case int32(Int32)
    case int64(Int64)
    case uint32(UInt32)
    case uint64(UInt64)
}

public enum QRCodeInfoType: UInt32 {
    
    case string
    case int32
    case int64
    case uint32
    case uint64
}

public extension QRCodeInfoData {
    
    var type: QRCodeInfoType {
        switch self {
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

internal extension QRCodeInfo {
    
    init(_ cxxObject: chip.OptionalQRCodeInfo) {
        fatalError()
    }
}

internal extension chip.OptionalQRCodeInfo {
    
    init(_ value: QRCodeInfo) {
        self.init()
        self.tag = value.tag
        self.type = .init(value.data.type.rawValue)
        /*
        switch value {
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
