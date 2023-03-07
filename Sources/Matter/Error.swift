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
public struct MatterError: Error, Equatable, Hashable {
    
    /// Underlying error code from Matter framework
    public typealias Code = MatterErrorCode
    
    /// Error category
    public typealias Range = MatterErrorRange
    
    /// SDK error
    public typealias SDKErrorType = MatterSDKErrorType
    
    internal typealias CXXObject = CHIP_ERROR
    
    /// Return an integer code for the error.
    public let code: MatterErrorCode
    
    /// File
    //public let file: String
    
    /// Line
    //public let line: UInt
    
    /**
     * Construct a CHIP_ERROR from the underlying storage type.
     *
     * @note
     *  This is intended to be used only in foreign function interfaces.
     */
    public init(
        code: MatterErrorCode
        //file: String = #file,
        //line: UInt = #line
    ) {
        assert(code.rawValue != 0)
        self.code = code
        //self.file = file
        //self.line = line
    }
    
    internal init(_ cxxObject: CXXObject) {
        let code = MatterErrorCode(rawValue: cxxObject.AsInteger())
        self.init(
            code: code
            //file: String(cString: cxxObject.getFile()),
            //line: UInt(cxxObject.GetLine())
        )
    }
    
    internal init(sdk: SDKErrorType, code: UInt8) {
        let cxxSdkPart = CXXObject.SdkPart(sdk)
        let cxxObject = CXXObject(cxxSdkPart, code)
        self.init(cxxObject)
    }
    
    /// Get the Range to which the error belongs.
    public var range: Range {
        let cxxObject = CXXObject(code.rawValue)
        return Range(cxxObject.GetRange())
    }
}

internal extension MatterError.CXXObject {
    
    init(_ error: MatterError) {
        //self.init(code: error.code.rawValue)
        assertionFailure("Not implemented")
        self.init(.application, 0)
    }
    
    static var none: MatterError.CXXObject {
        self.init(.core, 0)
    }
}

internal extension MatterError {
    
    static var none: MatterError {
        MatterError(code: MatterErrorCode(rawValue: 0))
    }
}

extension MatterError: CustomStringConvertible, CustomDebugStringConvertible {
    
    internal static let registerFormatter: Void = {
        chip.RegisterCHIPLayerErrorFormatter()
    }()
    
    public var description: String {
        let _ = Self.registerFormatter
        let cxxObject = CXXObject(code.rawValue)
        return String(cString: cxxObject.AsString())
    }
    
    public var debugDescription: String {
        description
    }
}

internal extension CHIP_ERROR {
    
    #if DEBUG
    func throwError(
        file: StaticString = #file,
        function: StaticString = #function,
        line: UInt = #line
    ) throws {
        guard self.AsInteger() == 0 else {
            #if DEBUG
            NSLog("\(file):\(line):\(function) Matter error 0x\(String(self.AsInteger(), radix: 16))")
            #endif
            throw MatterError(self)
        }
    }
    #else
    func throwError() throws {
        guard self.AsInteger() == 0 else {
            throw MatterError(self)
        }
    }
    #endif
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

public extension MatterErrorCode {
    
    /// Match error code
    static func ~= (lhs: MatterErrorCode, rhs: Error) -> Bool {
        guard let value = rhs as? MatterError else { return false }
        return value.code == lhs
    }
}

public extension MatterErrorCode {
    
    static func sdk(_ sdk: MatterSDKErrorType, code: UInt8) -> MatterErrorCode {
        let cxxSdkPart = MatterError.CXXObject.SdkPart(sdk)
        let cxxObject = MatterError.CXXObject(cxxSdkPart, code)
        return MatterErrorCode(cxxObject.AsInteger())
    }
}

public extension MatterError {
    
    /// A message exceeds the sent limit.
    static var sendingBlocked: MatterErrorCode                          { .sdk(.core, code: 0x01) }
    
    /// A connection has been aborted.
    static var connectionAborted: MatterErrorCode                       { .sdk(.core, code: 0x02) }
    
    /// An unexpected state was encountered.
    static var incorrectState: MatterErrorCode                          { .sdk(.core, code: 0x03) }
    
    /// A message is too long.
    static var messageTooLong: MatterErrorCode                          { .sdk(.core, code: 0x04) }
    
    /// An exchange version is not supported.
    static var unsupportedExchangeVersion: MatterErrorCode              { .sdk(.core, code: 0x05) }
    
    /// The attempt to register an unsolicited message handler failed because the
    /// unsolicited message handler pool is full.
    static var tooManyUnsolicitedMessageHandlers: MatterErrorCode       { .sdk(.core, code: 0x06) }
    
    /// No callback has been registered for handling a connection.
    static var noUnsolicitedMessageHandler: MatterErrorCode             { .sdk(.core, code: 0x07) }
    
    /// A buffer is too small.
    static var bufferTooSmall: MatterErrorCode                          { .sdk(.core, code: 0x19) }
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
    case openThread     = 0x4
    
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

/// SDK Error Type
public enum MatterSDKErrorType: UInt8 {
    
    /// SDK core errors.
    case core                       = 0
    
    /// Inet errors
    case inet                       = 1
    
    /// Device layer errors
    case device                     = 2
    
    /// ASN1 errors
    case asn1                       = 3
    
    /// Bluetooth LE layer errors
    case bluetooth                  = 4
    
    /// Interaction Model global status code
    case interactionModelGlobal     = 5
    
    /// Interaction Model cluster-specific status code.
    case interactionModelCluster    = 6
    
    /// Application-defined errors
    case application                = 7
}

internal extension MatterSDKErrorType {
    
    init(_ sdkPart: CHIP_ERROR.Range) {
        self.init(rawValue: sdkPart.rawValue)!
    }
}

internal extension CHIP_ERROR.SdkPart {
    
    init(_ sdkPart: MatterSDKErrorType) {
        self.init(rawValue: sdkPart.rawValue)!
    }
}
