import Foundation

public struct SFTPItem: Identifiable, Hashable, Sendable {
    public let id: UUID
    public let name: String
    public let path: String
    public let isDirectory: Bool
    public let size: UInt64?

    public init(id: UUID = UUID(), name: String, path: String, isDirectory: Bool, size: UInt64?) {
        self.id = id
        self.name = name
        self.path = path
        self.isDirectory = isDirectory
        self.size = size
    }
}
