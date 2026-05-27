import Foundation

public enum SSHAuth {
    case password(String, remember: Bool)
    case publicKey(path: String, passphrase: String?)
}

