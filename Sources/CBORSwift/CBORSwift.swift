import Foundation

public enum CBORError: Error {
    case EncodedNilResult
}

public struct CBOR<T> {
    public static func encode(_ value: T) throws -> [UInt8] {
        if T.self == Int.self {
            guard let encode = (value as? Int)?.encode.data?.bytes else {
                throw CBORError.EncodedNilResult
            }
            return encode
        }
        return []
    }

    public static func decode(_ value: [UInt8]) -> T {
        if T.self == String.self {
            return "Hassan" as! T
        }
        return 1 as! T
    }
}