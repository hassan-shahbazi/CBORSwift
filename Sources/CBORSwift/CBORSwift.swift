import Foundation

public struct CBOR {
    public static func encode<T: CBOREncodable>(_ value: T) throws -> [UInt8] {
        guard let encode = value.encode.data?.bytes else {
            throw CBORError.encodedResultNil
        }
        return encode
    }

    public static func decode<T: CBORDecodable, U: CBOREncodable>(_ value: T) throws -> U {
        guard let decode = value.decode as? U else {
            throw CBORError.decodeResultNil
        }
        return decode
    }
}

public enum CBORError: Error {
    case encodedResultNil
    case decodeResultNil
}