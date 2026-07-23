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
  url: "https://github.com/SteveShi/libssh2-swift/releases/download/v1.3.9/libssh2kit.xcframework.zip",
  checksum: "4ccd8a7550e49604db22edcec4a3ca18322a1ba681f3003ce2179cfaba764642"
        )
    ]
)
