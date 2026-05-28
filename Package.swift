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
            dependencies: ["libssh2kit"]
        ),
        .binaryTarget(
            name: "libssh2kit",
            url: "https://github.com/SteveShi/libssh2-swift/releases/download/v1.3.0/libssh2kit.xcframework.zip",
            checksum: "bddf978631cc29534442694a98e7b78ad884e307bfa5955bb53fcbd997aae699"
        )
    ]
)
