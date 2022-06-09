//
//  Error.swift
//  
//
//  Created by Alsey Coleman Miller on 6/8/22.
//

import Foundation
@_implementationOnly import CMatter

/// Matter framework error
public struct MatterError: Error {
    
    public typealias Code = MatterErrorCode
    
    public typealias Range = MatterErrorRange
    
    internal let cppObject: CHIP_ERROR
    
    internal init(_ cppObject: CHIP_ERROR) {
        self.cppObject = cppObject
    }
    
    public init(_ code: Code, range: Range, file: StaticString = #file, line: UInt = #line) {
        let error = file.withUTF8Buffer { fileBuffer in
            CHIP_ERROR(CHIP_ERROR.Range(range), code.rawValue, fileBuffer.baseAddress, numericCast(line))
        }
        self.init(error)
    }
    
    public init(_ code: Code) {
        self.init(CHIP_ERROR(code.rawValue))
    }
    
    public var code: Code {
        return Code(rawValue: cppObject.AsInteger())
    }
    
    public var message: String {
        return String(cString: cppObject.AsString())
    }
}

extension MatterError: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return message
    }
    
    public var debugDescription: String {
        return message
    }
}

// Use "hidden" entry points for `NSError` bridging
extension MatterError {
    
    public var _code: Int { Int(code.rawValue) }

    public var _domain: String { "MatterErrorDomain" }
}

// MARK: - Error Code

public struct MatterErrorCode: RawRepresentable, Equatable, Hashable {
    
    public let rawValue: UInt32
    
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }
    
    private init(_ raw: UInt32) {
        self.init(rawValue: raw)
    }
}

extension MatterErrorCode: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt32) {
        self.init(rawValue: value)
    }
}

public extension MatterError {
    
    /// A message exceeds the sent limit.
    static var sendingBlocked: MatterErrorCode { 0x01 }
}

public extension MatterErrorCode {
    
    /// Match error code
    static func ~= (lhs: MatterErrorCode, rhs: Error) -> Bool {
        guard let value = rhs as? MatterError else { return false }
        return value.code == lhs
    }
}

// MARK: - Range

public enum MatterErrorRange: UInt8, CaseIterable {
    
    /// CHIP SDK errors.
    case sdk            = 0x0
    
    /// Encapsulated OS errors, other than POSIX errno.
    case os             = 0x1
    
    /// Encapsulated POSIX errno values.
    case posix          = 0x2
    
    /// Encapsulated LwIP errors.
    case lwIP           = 0x3
    
    /// Encapsulated OpenThread errors.
    case cpenThread     = 0x4
    
    /// Platform-defined encapsulation.
    case platform       = 0x5
}

internal extension MatterErrorRange {
    
    init(_ range: CHIP_ERROR.Range) {
        self.init(rawValue: range.rawValue)!
    }
}

internal extension CHIP_ERROR.Range {
    
    init(_ range: MatterErrorRange) {
        self.init(rawValue: range.rawValue)!
    }
}
