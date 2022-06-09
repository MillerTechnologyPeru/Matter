//
//  Error.swift
//  
//
//  Created by Alsey Coleman Miller on 6/8/22.
//

import Foundation
@_implementationOnly import CMatter

/**
 * This class represents CHIP errors.
 *
 * At the top level, an error belongs to a Range and has an integral Value whose meaning depends on the Range.
 * One, Range::kSDK, is used for the CHIP SDK's own errors; others encapsulate error codes from external sources
 * (e.g. libraries, OS) into a CHIP_ERROR.
 *
 * CHIP SDK errors inside Range::kSDK consist of a component identifier given by SdkPart and an arbitrary small
 * integer Code.
 */
public struct MatterError: Error {
    
    public typealias Code = MatterErrorCode
    
    public typealias Range = MatterErrorRange
    
    internal let object: ReferenceType
    
    internal init(_ object: ReferenceType) {
        self.object = object
    }
    
    internal init(_ object: ReferenceType.CXXObject) {
        self.object = ReferenceType(object)
    }
    
    /**
     * Construct a CHIP_ERROR from the underlying storage type.
     *
     * @note
     *  This is intended to be used only in foreign function interfaces.
     */
    internal init(_ code: Code) {
        self.object = ReferenceType(code)
    }
    
    internal init(_ code: Code, range: Range, file: StaticString = #file, line: UInt = #line) {
        self.object = ReferenceType(code, range: range, file: file, line: line)
    }
    
    /// Return an integer code for the error.
    public var code: Code {
        return object.code
    }
    
    /// Get the Range to which the error belongs.
    public var range: Range {
        return object.range
    }
    
    /// Format an error as a string for printing.
    internal var message: String {
        return object.message
    }
}
/*
extension MatterError: Equatable {
    
    public static func == (lhs: MatterError, rhs: MatterError) -> Bool {
        lhs.object.cxxObject == rhs.object.cxxObject
    }
}
*/
extension MatterError: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        return message
    }
    
    public var debugDescription: String {
        return message
    }
}

extension MatterError: ReferenceConvertible {
    
    final class ReferenceType: CXXReference {
        
        typealias CXXObject = CHIP_ERROR
        
        let cxxObject: CXXObject
        
        init(_ cxxObject: CXXObject) {
            self.cxxObject = cxxObject
        }
        
        init(_ code: Code, range: Range, file: StaticString = #file, line: UInt = #line) {
            let cxxObject = file.withUTF8Buffer { fileBuffer in
                CHIP_ERROR(CHIP_ERROR.Range(range), code.rawValue, fileBuffer.baseAddress, numericCast(line))
            }
            self.cxxObject = cxxObject
        }
        
        init(_ code: Code) {
            self.cxxObject = CHIP_ERROR(code.rawValue)
        }
        
        /// Return an integer code for the error.
        var code: Code {
            return Code(rawValue: cxxObject.AsInteger())
        }
        
        /// Get the Range to which the error belongs.
        
        var range: Range {
            return Range(cxxObject.GetRange())
        }
        
        /// Format an error as a string for printing.
        var message: String {
            return String(cString: cxxObject.AsString())
        }
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

/**
 * Top-level error classification.
 *
 * Every error belongs to a Range and has an integral Value whose meaning depends on the Range.
 * All native CHIP SDK errors belong to the kSDK range. Other ranges are used to encapsulate error
 * codes from other subsystems (e.g. platform or library) used by the CHIP SDK.
 */
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
