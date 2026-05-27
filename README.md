# libssh2-swift (Chinese Version)

`libssh2-swift` 是一个高内聚的 **SSH2 与 SFTP 服务** 的 Swift Package 封装包。

它将底层的 C 静态库（`libssh2`、`openssl`）及头文件封装为二进制 XCFramework，并提供了底层的套接字连接、密钥凭据验证、已知主机库（Known Hosts）校验，以及开箱即用的 SFTP 文件交互 Swift API。

---

## 核心特点

1. **远程二进制依赖**：底层的 `libssh2`、`libssl`、`libcrypto` 和 `libtls` 全都通过 GitHub Release 的 `.binaryTarget` 方式按需下载和缓存，保证 Git 仓库本身极其轻量。
2. **Swift 6 并发安全**：API 完全兼容 Swift 6 Concurrency 并发安全隔离，使用 `actor` 模型和 `Sendable` 保证多线程 SSH/SFTP 通信的数据安全。
3. **高内聚接口**：完全解耦底层 socket 和 C 指针操作，对外暴露优雅的 Swift 强类型 API。
4. **Known Hosts 存储**：提供已知主机的指纹保存与指纹校验功能，防止中间人攻击。

---

## 依赖关系

在您的 `Package.swift` 中引入：

```swift
dependencies: [
    .package(url: "https://github.com/SteveShi/libssh2-swift.git", from: "1.0.0")
]
```

并在相应的 Target 中依赖 `"libssh2-swift"`。

---

## 核心 API 与接口说明

### 1. `SSHSession` (Actor)
负责建立与远程 SSH 主机的 TCP 套接字通道（Socket Channel），进行握手、公钥/密码验证和会话保持。

```swift
public actor SSHSession {
    public enum State: Equatable {
        case disconnected
        case connecting
        case connected
        case failed(String)
    }

    public private(set) var state: State

    /// 开始连接远端服务器并进行 SSH 握手，返回终端数据的 AsyncStream
    public func connect(host: String, port: Int, username: String, auth: SSHAuth, cols: Int = 80, rows: Int = 24) async throws -> AsyncStream<Data>

    /// 接受未知的主机密钥并完成连接
    public func acceptHostKeyAndConnect(auth: SSHAuth, cols: Int = 80, rows: Int = 24) async throws -> AsyncStream<Data>

    /// 向 SSH 会话发送数据（例如输入命令）
    public func send(_ data: Data) async throws

    /// 改变虚拟终端 (PTY) 大小
    public func resize(cols: Int, rows: Int) async

    /// 断开连接并关闭所有 C 资源句柄
    public func disconnect() async

    /// 单次执行命令并返回标准输出内容
    public func executeCommand(_ command: String) async throws -> String
}
```

### 2. `SFTPService` (Actor)
负责在已认证的 `SSHSession` 上打开 SFTP 通道，提供文件上传、下载及目录遍历服务。

```swift
public actor SFTPService {
    /// 构造方法，传入一个已建立连接的 SSHSession 实例
    public init(session: SSHSession)
    
    /// 遍历远端指定目录的文件列表，返回 SFTPItem 数组
    public func list(path: String) async throws -> [SFTPItem]
    
    /// 从远端下载文件到本地指定 URL
    public func download(remotePath: String, localURL: URL) async throws
    
    /// 上传本地文件到远端指定路径
    public func upload(localURL: URL, remotePath: String) async throws
}
```

### 3. 其他公共定义

```swift
public enum HostKeyStatus: Sendable {
    case notFound
    case mismatch
}

public enum SSHAuth {
    case password(String, remember: Bool)
    case publicKey(path: String, passphrase: String?)
}

public struct SFTPItem: Identifiable, Hashable, Sendable {
    public let id: UUID
    public let name: String
    public let path: String
    public let isDirectory: Bool
    public let size: UInt64?
}
```

---
---

# libssh2-swift (English Version)

`libssh2-swift` is a highly cohesive Swift Package wrapper for **SSH2 protocol and SFTP services**.

It encapsulates the underlying C static libraries (`libssh2` and `openssl` components) and headers as binary XCFrameworks, providing high-level Swift APIs for socket connection, credential verification, Known Hosts validation, and directory/file stream manipulations via SFTP.

---

## Core Features

1. **Remote Binary Resolution**: Underlying C frameworks (`libssh2`, `libssl`, `libcrypto`, and `libtls`) are resolved on-demand via SPM's remote `.binaryTarget` from GitHub Release zip assets, keeping the repository extremely lightweight.
2. **Swift 6 Concurrency Safe**: Conforms strictly to Swift 6 Concurrency specifications using the `actor` model and `Sendable` validation, ensuring thread-safe data operations during async socket/SFTP operations.
3. **Decoupled Architecture**: Fully hides socket handling, C pointer allocations, and memory freeing under neat, strong-typed Swift wrappers.
4. **Known Hosts Storage**: Integrated fingerprint storage and host verification API to secure SSH handshakes.

---

## Dependencies

Add this package to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/SteveShi/libssh2-swift.git", from: "1.0.0")
]
```

And depend on `"libssh2-swift"` in your targets.

---

## Core APIs & Interface Descriptions

### 1. `SSHSession` (Actor)
Manages establishing TCP sockets, performing SSH handshakes, executing password/public-key authentications, and maintaining channel buffers.

```swift
public actor SSHSession {
    public enum State: Equatable {
        case disconnected
        case connecting
        case connected
        case failed(String)
    }

    public private(set) var state: State

    /// Connects to the host and performs SSH handshakes, returning an AsyncStream of terminal output data
    public func connect(host: String, port: Int, username: String, auth: SSHAuth, cols: Int = 80, rows: Int = 24) async throws -> AsyncStream<Data>

    /// Accepts an untrusted host key and connects
    public func acceptHostKeyAndConnect(auth: SSHAuth, cols: Int = 80, rows: Int = 24) async throws -> AsyncStream<Data>

    /// Sends input data to the SSH session
    public func send(_ data: Data) async throws

    /// Request a virtual terminal (PTY) resize
    public func resize(cols: Int, rows: Int) async

    /// Closes socket channel and frees C pointer handles
    public func disconnect() async

    /// Executes a single command on the remote host and returns stdout
    public func executeCommand(_ command: String) async throws -> String
}
```

### 2. `SFTPService` (Actor)
Operates on an authenticated `SSHSession` to open SFTP sub-systems for transferring files and directory lookups.

```swift
public actor SFTPService {
    /// Initializer taking an established SSHSession instance
    public init(session: SSHSession)
    
    /// List file attributes inside a directory
    public func list(path: String) async throws -> [SFTPItem]
    
    /// Download file from remote path to local URL
    public func download(remotePath: String, localURL: URL) async throws
    
    /// Upload file from local URL to remote path
    public func upload(localURL: URL, remotePath: String) async throws
}
```

### 3. Other Public Declarations

```swift
public enum HostKeyStatus: Sendable {
    case notFound
    case mismatch
}

public enum SSHAuth {
    case password(String, remember: Bool)
    case publicKey(path: String, passphrase: String?)
}

public struct SFTPItem: Identifiable, Hashable, Sendable {
    public let id: UUID
    public let name: String
    public let path: String
    public let isDirectory: Bool
    public let size: UInt64?
}
```
