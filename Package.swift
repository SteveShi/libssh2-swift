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
  url: "https://github.com/SteveShi/libssh2-swift/releases/download/v1.3.7/libssh2kit.xcframework.zip",
  checksum: "3a9fdccdf45a640dc4e2d03b13190b48123833bb9443cdcf46a052a1dfa20d87"
        )
    ]
)
