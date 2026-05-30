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
  url: "https://github.com/SteveShi/libssh2-swift/releases/download/v1.3.3/libssh2kit.xcframework.zip",
  checksum: "04314de77ce69fe232c677f5a553501d6c415d3f80f29fed6884b4d750ed99e1"
        )
    ]
)
