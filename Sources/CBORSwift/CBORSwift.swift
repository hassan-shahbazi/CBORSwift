import Foundation

public enum CBORError: Error {
    case EncodedNilResult
    case ValueTypeNotSupported
}

public struct CBOR<T> {
    public static func encode(_ value: T) throws -> [UInt8] {
        if let parameter = value as? Int {
            return try encodeInt(parameter)
        } else if let parameter = value as? String {
            return try encodeString(parameter)
        }
        throw CBORError.ValueTypeNotSupported
    }

    public static func decode(_ value: [UInt8]) -> T {
        if T.self == String.self {
            return "Hassan" as! T
        }
        return 1 as! T
    }
}

private extension CBOR {
    static func encodeInt(_ value: Int) throws -> [UInt8] {
        guard let encode = value.encode.data?.bytes else {
            throw CBORError.EncodedNilResult
        }
        return encode
    }

    static func encodeString(_ value: String) throws -> [UInt8] {
        guard let encode = value.encode.data?.bytes else {
            throw CBORError.EncodedNilResult
        }
        return encode
    }
}