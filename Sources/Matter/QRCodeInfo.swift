//
//  OptionalQRCodeInfo.swift
//  
//
//  Created by Alsey Coleman Miller on 6/9/22.
//

@_implementationOnly import CMatter

public struct QRCodeInfo: Equatable, Hashable, Codable {
    
    ///
    public var data: QRCodeInfoData
    
    /// The tag number of the optional info
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

extension QRCodeInfoData: Codable {
    
    enum CodingKeys: String, CodingKey {
        case type
        case value
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let type = try container.decode(QRCodeInfoType.self, forKey: .type)
        switch type {
        case .string:
            let value = try container.decode(String.self, forKey: .value)
            self = .string(value)
        case .int32:
            let value = try container.decode(Int32.self, forKey: .value)
            self = .int32(value)
        case .uint32:
            let value = try container.decode(UInt32.self, forKey: .value)
            self = .uint32(value)
        case .int64:
            let value = try container.decode(Int64.self, forKey: .value)
            self = .int64(value)
        case .uint64:
            let value = try container.decode(UInt64.self, forKey: .value)
            self = .uint64(value)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        switch self {
        case let .string(value):
            try container.encode(value, forKey: .value)
        case let .int32(value):
            try container.encode(value, forKey: .value)
        case let .uint32(value):
            try container.encode(value, forKey: .value)
        case let .int64(value):
            try container.encode(value, forKey: .value)
        case let .uint64(value):
            try container.encode(value, forKey: .value)
        }
    }
}

public enum QRCodeInfoType: UInt32, Codable {
    
    case string     = 1
    case int32      = 2
    case int64      = 3
    case uint32     = 4
    case uint64     = 5
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
        let type = QRCodeInfoType(rawValue: cxxObject.type.rawValue)!
        let data: QRCodeInfoData
        switch type {
        case .string:
            data = .string(String(cxxString: cxxObject.data))
        case .int32:
            data = .int32(cxxObject.int32)
        case .int64:
            data = .int32(numericCast(cxxObject.int32))
        case .uint32:
            data = .int32(numericCast(cxxObject.int32))
        case .uint64:
            data = .int32(numericCast(cxxObject.int32))
        }
        self.init(data: data, tag: cxxObject.tag)
    }
}

internal extension chip.OptionalQRCodeInfo {
    
    init(_ value: QRCodeInfo) {
        self.init()
        self.tag = value.tag
        self.type = .init(value.data.type.rawValue)
        switch value.data {
        case let .string(string):
            self.data = .init(string)
        case let .int32(value):
            self.int32 = value
        case let .uint32(value):
            self.int32 = .init(bitPattern: value)
        case let .int64(value):
            self.int32 = numericCast(value)
        case let .uint64(value):
            self.int32 = .init(bitPattern: numericCast(value))
        }
    }
}
