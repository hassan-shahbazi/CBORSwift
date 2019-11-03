import Foundation

public struct ByteString {
    public let string: String

    public init(_ string: String) {
        self.string = string
    }
}

extension ByteString: Equatable {
    public static func ==(lhs: ByteString, rhs: ByteString) -> Bool {
        return lhs.string == rhs.string
    }
}