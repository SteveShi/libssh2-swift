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
            url: "https://github.com/SteveShi/libssh2-swift/releases/download/v1.0.2/libssh2.xcframework.zip",
            checksum: "1d88e4f5b2c4b660d38294eb6b18f5f152f230566bbe9a96ef65c43be35f3e1c"
        ),
        .binaryTarget(
            name: "libssl",
            url: "https://github.com/SteveShi/libssh2-swift/releases/download/v1.0.2/libssl.xcframework.zip",
            checksum: "0c3111e3e5dd7276265fbac665f80d3a97dce37fb3499b53b18ae2da145bc0e1"
        ),
        .binaryTarget(
            name: "libcrypto",
            url: "https://github.com/SteveShi/libssh2-swift/releases/download/v1.0.2/libcrypto.xcframework.zip",
            checksum: "a041f0804c7bdbd2057bc15e24b555b02abb1be9aed93a9b9c36d6d73584a8ca"
        ),
        .binaryTarget(
            name: "libtls",
            url: "https://github.com/SteveShi/libssh2-swift/releases/download/v1.0.2/libtls.xcframework.zip",
            checksum: "a481c4ccb6ed144bcbc6df4253d051ebc905a7dcc4a4cdabf2b45835a330e163"
        )
    ]
)
