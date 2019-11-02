import Foundation

public protocol CBOREncodable {
    var encode: String { get }
}

public protocol CBORDecodable {
    var decode: CBOREncodable { get }
}

public struct CBOR {
    public static func encode<T: CBOREncodable>(_ value: T) throws -> [UInt8] {
        guard let encode = value.encode.data?.bytes else {
            throw CBORError.EncodedNilResult
        }
        return encode
    }

    public static func decode<T: CBORDecodable, U: CBOREncodable>(_ value: T) -> U.Type {
        if T.self == String.self {
            return "Hassan" as! U.Type
        }
        return 1 as! U.Type
    }
}

public enum CBORError: Error {
    case EncodedNilResult
    case ValueTypeNotSupported
}