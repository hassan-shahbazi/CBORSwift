import Foundation

extension Int: CBORDecodable {
    public var decode: CBOREncodable {
        return 11
    }
}

extension ByteString: CBORDecodable {
    public var decode: CBOREncodable {
        return ByteString("aa")
    }
}

extension String: CBORDecodable {
    public var decode: CBOREncodable {
        return "11"
    }
}

extension Data: CBORDecodable {
    public var decode: CBOREncodable {
        return Data([0x00])
    }
}

extension Array: CBORDecodable where Element: CBORDecodable {
    public var decode: CBOREncodable {
        return [11, 11]
    }
}

extension Dictionary: CBORDecodable where Key: CBORDecodable, Value: CBORDecodable {
    public var decode: CBOREncodable {
        return ["11":"11"]
    }
}
