// swift-tools-version: 5.7
import PackageDescription

// Sources copied from CHIP
// SHA 32fb896f3075418f1dc6d920a90376a1aa3cf239
// https://github.com/project-chip/connectedhomeip

let package = Package(
    name: "Matter",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "MatterPackage",
            targets: ["MatterPackage"]
        ),
        .executable(
            name: "MatterTool",
            targets: ["MatterTool"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/PureSwift/Bluetooth.git",
            .upToNextMajor(from: "6.0.0")
        ),
        .package(
            url: "https://github.com/PureSwift/GATT.git",
            branch: "master"
        ),
        .package(
            url: "https://github.com/Bouke/NetService.git",
            from: "0.8.1"
        )
    ],
    targets: [
        .target(
            name: "MatterPackage",
            dependencies: [
                "CMatter",
                "COpenSSL",
                "CAvahi",
                .product(
                    name: "Bluetooth",
                    package: "Bluetooth"
                ),
                .product(
                    name: "GATT",
                    package: "GATT"
                ),
                .product(
                    name: "NetService",
                    package: "NetService",
                    condition: .when(platforms: [.linux])
                ),
            ],
            path: "Sources/Matter",
            swiftSettings: [
                .unsafeFlags([
                    "-Xfrontend", "-enable-cxx-interop",
                    "-I", "Sources/CMatter",
                    "-I", "Sources/CMatter/include",
                    "-I", "Sources/CMatter/deps/nlassert/include",
                    "-I", "Sources/CMatter/deps/nlio/include",
                ]),
            ]
        ),
        .target(
            name: "CMatter",
            dependencies: [],
            cSettings: [
                .define("CHIP_HAVE_CONFIG_H"),
                .define("CHIP_MINMDNS_HIGH_VERBOSITY"),
                .headerSearchPath("."),
            ],
            cxxSettings: [
                .define("CHIP_HAVE_CONFIG_H"),
                .define("CHIP_MINMDNS_HIGH_VERBOSITY"),
                .define("CHIP_ADDRESS_RESOLVE_IMPL_INCLUDE_HEADER", to: #""lib/address_resolve/AddressResolve_DefaultImpl.h""#),
                .headerSearchPath("."),
                .headerSearchPath("deps"),
                .headerSearchPath("deps/nlassert/include"),
                .headerSearchPath("deps/nlio/include"),
                .headerSearchPath("app-main"),
                .unsafeFlags([
                    "-I", "/opt/homebrew/Cellar/openssl@3/3.0.8/include",
                ], .when(platforms: [.macOS])),
                .unsafeFlags([
                    "-I", "/usr/lib/swift",
                    "-I", "/usr/local/lib/swift",
                    "-I", "/usr/libexec/swift/lib/swift",
                ], .when(platforms: [.linux])),
            ]
        ),
        .systemLibrary(
            name: "COpenSSL",
            pkgConfig: "openssl",
            providers: [
                .brew(["openssl"]),
                .apt(["openssl libssl-dev"]),
            ]
        ),
        .systemLibrary(
            name: "CAvahi",
            pkgConfig: "avahi-client",
            providers: [
                .brew(["avahi"]),
                .apt(["libavahi-client-dev"]),
            ]
        ),
        .executableTarget(
            name: "MatterTool",
            dependencies: [
                "MatterPackage",
            ]
        ),
        .testTarget(
            name: "MatterTests",
            dependencies: [
                "MatterPackage",
            ]
        ),
    ],
    cLanguageStandard: .gnu11,
    cxxLanguageStandard: .gnucxx14
)
