// swift-tools-version: 5.5
import PackageDescription

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
                    //"-I", "Sources/CMatter/include",
                    //"-Xfrontend", "-enable-experimental-cxx-interop",
                ])
            ]
        ),
        .target(
            name: "CMatter",
            dependencies: []
        ),
        .testTarget(
            name: "MatterTests",
            dependencies: ["Matter"]
        ),
    ]
)
