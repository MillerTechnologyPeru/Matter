// swift-tools-version: 5.5
import PackageDescription

// Sources copied from CHIP
// SHA 3fafeceff1681d01244c602584da47bd6f3bfd90
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
            name: "Matter",
            targets: ["Matter"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/PureSwift/Bluetooth.git",
            .upToNextMajor(from: "6.0.0")
        )
    ],
    targets: [
        .target(
            name: "Matter",
            dependencies: [
                "CMatter",
                .product(
                    name: "Bluetooth",
                    package: "Bluetooth"
                ),
            ],
            swiftSettings: [
                .unsafeFlags([
                    //"-I", "Sources/CMatter",
                    //"-I", "Sources/CMatter/include",
                    //"-Xfrontend", "-enable-experimental-cxx-interop",
                ])
            ]
        ),
        .target(
            name: "CMatter",
            dependencies: [],
            cSettings: [
                .define("CHIP_HAVE_CONFIG_H"),
                .define("CHIP_ADDRESS_RESOLVE_IMPL_INCLUDE_HEADER", to: "lib/address_resolve/AddressResolve_DefaultImpl.h"),
                .headerSearchPath("."),
            ],
            cxxSettings: [
                .define("CHIP_HAVE_CONFIG_H"),
                .define("CHIP_ADDRESS_RESOLVE_IMPL_INCLUDE_HEADER", to: "lib/address_resolve/AddressResolve_DefaultImpl.h"),
                .headerSearchPath("."),
                .headerSearchPath("deps/nlassert/include"),
            ]
        ),
        .testTarget(
            name: "MatterTests",
            dependencies: ["Matter"]
        ),
    ],
    cLanguageStandard: .gnu11,
    cxxLanguageStandard: .gnucxx14
)
