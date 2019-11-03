import Foundation

extension AnyHashable: CBOREncodable {
    public var encode: String {
        if let value = self as? Bool {
            return value.encode
        } else if let value = self as? Int {
            return value.encode
        } else if let value = self as? ByteString {
            return value.encode
        } else if let value = self as? String {
            return value.encode
        } else if let value = self as? TaggedValue {
            return value.encode
        } else if let value = self as? Dictionary<AnyHashable,AnyHashable> {
            return value.encode
        } else if let value = self as? Array<AnyHashable> {
            return value.encode
        }
        fatalError("Type does not conform to `CBOREncodable` protocol")
    }
}

extension Optional: CBOREncodable where Wrapped == AnyHashable {
    public var encode: String {
        if let notNil = self {
            return notNil.encode
        }
        return SimpleValue(.null).encode
    }
}

extension Int: CBOREncodable {
    public var encode: String {
        var encodedArray = CBOREncoder.byteArray((isNegative) ? .major1 : .major0, (isNegative) ? (self * -1) - 1 : self)
        return CBOREncoder.encodeArray(&encodedArray)
    }

    private var isNegative: Bool {
        return self < 0
    }
}

extension ByteString: CBOREncodable {
    public var encode: String {
        let byteString = stride(from: 0, to: self.string.count, by: 2).map { UInt8(self.string[$0..<$0+2].hex_decimal) }
        return Data(CBOREncoder.byteArray(.major2, byteString.count)).binary_decimal.hex + Data(byteString).hex
    }
}

extension String: CBOREncodable {
    public var encode: String {
        return Data(CBOREncoder.byteArray(.major3, self.count)).binary_decimal.hex + Data(self.ascii_bytes).hex
    }
}

extension Bool: CBOREncodable {
    public var encode: String {
        if self == true {
            return SimpleValue(.true).encode
        }
        return SimpleValue(.false).encode
    }
}

extension Array: CBOREncodable where Element: CBOREncodable {
    private var encodeHeader: String {
        return Data(CBOREncoder.byteArray(.major4, self.count)).binary_decimal.hex
    }

    public var encode: String {
        return encodeHeader + self.map { $0.encode }.joined(separator: "")
    }
}

extension Dictionary: CBOREncodable where Key: CBOREncodable, Value: CBOREncodable {

    private var encodeHeader: String {
        return Data(CBOREncoder.byteArray(.major5, self.keys.count)).binary_decimal.hex
    }

    public var encode: String {
        return encodeHeader + self.map { (key: CBOREncodable, value: CBOREncodable) in
                                            (key.encode, value.encode)
                                    }
                                    .sorted {
                                        if $0.0 != $1.0 {
                                            return $0.0 < $1.0
                                        } else if $0.1 != $1.1 {
                                            return $0.1 < $1.1
                                        }
                                        return $0.0 == $1.0
                                    }
                                    .reduce(into: "") { (result: inout String, dictionary: (String, String)) in
                                        result += dictionary.0 + dictionary.1
                                    }
    }
}

extension TaggedValue: CBOREncodable {
    public var encode: String {
        guard self.tag > 0 else { return "" }
        return Data(CBOREncoder.byteArray(.major6, self.tag)).binary_decimal.hex + self.value.encode
    }
}

extension SimpleValue: CBOREncodable {
    public var encode: String {
        return Data([UInt8](CBOREncoder.byteArray(.major7)[..<3]) + self.valueData.bytes).binary_decimal.hex
    }
}