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
            dependencies: ["libssh2", "libssl", "libcrypto", "libtls"]
        ),
        .binaryTarget(
            name: "libssh2",
            url: "https://github.com/SteveShi/libssh2-swift/releases/download/v1.0.1/libssh2.xcframework.zip",
            checksum: "25907c36cdf2eb524c0a60c7cde4352cee6dcf2a8b6c819ec7439ec5f38156ba"
        ),
        .binaryTarget(
            name: "libssl",
            url: "https://github.com/SteveShi/libssh2-swift/releases/download/v1.0.1/libssl.xcframework.zip",
            checksum: "c15613e0d7f55e0417ee5cf435ba9d7ff827b16f5839402e7b192c54b761b87b"
        ),
        .binaryTarget(
            name: "libcrypto",
            url: "https://github.com/SteveShi/libssh2-swift/releases/download/v1.0.1/libcrypto.xcframework.zip",
            checksum: "4b773d28da70fd45c5c01367fa71288793b536d665caabc54fd3745050cebb60"
        ),
        .binaryTarget(
            name: "libtls",
            url: "https://github.com/SteveShi/libssh2-swift/releases/download/v1.0.1/libtls.xcframework.zip",
            checksum: "4978800009870beb150abd3035313190c6dfa6de833d64da125e25314dd6044c"
        )
    ]
)
