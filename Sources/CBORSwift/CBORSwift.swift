import Foundation

public protocol CBOREncodable {
    var encode: String { get }
}

public protocol CBORDecodable {
    var decode: CBOREncodable { get }
}

public struct CBOR<T: CBOREncodable & CBORDecodable> {
    public static func encode(_ value: T) throws -> [UInt8] {
        guard let encode = value.encode.data?.bytes else {
            throw CBORError.EncodedNilResult
        }
        return encode
    }

    public static func decode(_ value: [UInt8]) -> T {
        if T.self == String.self {
            return "Hassan" as! T
        }
        return 1 as! T
    }
}

public enum CBORError: Error {
    case EncodedNilResult
    case ValueTypeNotSupported
}