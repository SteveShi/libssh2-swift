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
            dependencies: ["libssh2"]
        ),
        .binaryTarget(
            name: "libssh2",
            url: "https://github.com/SteveShi/libssh2-swift/releases/download/v1.1.0/libssh2.xcframework.zip",
            checksum: "488849a2636530c679bda5aabd22e9c807e60987cac1635688b350e28ac35a49"
        )
    ]
)
