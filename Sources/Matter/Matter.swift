@_implementationOnly import CMatter

/// Matter Version
public struct MatterVersion: Equatable, Hashable {
    
    public let major: UInt
    
    public let minor: UInt
    
    public let patch: UInt
    
    public let versionString: String
    
    public let extraVersionString: String
}

public extension MatterVersion {
    
    /// Current framework version.
    static var current: MatterVersion {
        MatterVersion(
            major: numericCast(CHIP_VERSION_MAJOR),
            minor: numericCast(CHIP_VERSION_MINOR),
            patch: numericCast(CHIP_VERSION_PATCH),
            versionString: CHIP_VERSION_STRING,
            extraVersionString: CHIP_VERSION_EXTRA
        )
    }
}
