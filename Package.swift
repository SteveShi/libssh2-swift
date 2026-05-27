// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "libssh2-swift",
    platforms: [
        .macOS(.v15)
    ],
    products: [
        .library(
            name: "libssh2-swift",
            targets: ["libssh2-swift"]
        )
    ],
    targets: [
        .target(
            name: "libssh2-swift",
            dependencies: ["Clibssh2"]
        ),
        .target(
            name: "Clibssh2",
            dependencies: ["libssh2"]
        ),
        .binaryTarget(
            name: "libssh2",
            url: "https://github.com/SteveShi/libssh2-swift/releases/download/v1.2.1/libssh2.xcframework.zip",
            checksum: "03ac76d8fd29f1549d3e92716391e54fa39e0ceef64108d8d043d98c71babedb"
        )
    ]
)
