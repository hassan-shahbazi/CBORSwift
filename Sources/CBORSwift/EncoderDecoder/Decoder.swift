import Foundation

extension Array: CBORDecodable where Element == UInt8 {
    public var decode: CBOREncodable? {
        guard let headerByte = self.first,
                let major = MajorType.typeEnum(Int(headerByte).decimal_binary)
        else { return nil }
        var bodyByteArray = [UInt8](self[1..<self.count])

        switch major {
        case .major0:
            let (decode, newBody) = Int.decode(headerByte, bodyByteArray, baseTag: 32, ofType: Int.self)
            bodyByteArray = newBody
            
            return decode
        case .major1:
            let (decode, newBody) = Int.decode(headerByte, bodyByteArray, baseTag: 32, ofType: Int.self)
            bodyByteArray = newBody

            return (decode + 1) * -1
        case .major2:
            let (decode, newBody) = ByteString.decode(headerByte, bodyByteArray, ofType: ByteString.self)
            bodyByteArray = newBody

            return decode
        case .major3:
            let (decode, newBody) = String.decode(headerByte, bodyByteArray, ofType: String.self)
            bodyByteArray = newBody

            return decode
        case .major4:
            return nil
        case .major5:
            return nil
        case .major6:
            return nil
        case .major7:
            return nil
        }
    }
}

protocol CBORDecodableExtension {
    static func decode<T: CBOREncodable>(_ header: UInt8, _ body: [UInt8], baseTag: Int, ofType type: T.Type) -> (T, [UInt8])
}
extension CBORDecodableExtension {
    static func decode<T: CBOREncodable>(_ header: UInt8, _ body: [UInt8], ofType type: T.Type) -> (T, [UInt8]) {
        return self.decode(header, body, baseTag: 0, ofType: type)
    }
}

extension Int: CBORDecodableExtension {
    static func decode<T>(_ header: UInt8, _ body: [UInt8], baseTag: Int, ofType type: T.Type) -> (T, [UInt8]) {
        return CBORDecoder.extractHeaderBody(header: header, body: body, baseTag: 32) as! (T, [UInt8])
    }
}

extension ByteString: CBORDecodableExtension {
    static func decode<T>(_ header: UInt8, _ body: [UInt8], baseTag: Int, ofType type: T.Type) -> (T, [UInt8]) {
        let (offset, body) = CBORDecoder.extractHeaderBody(header: Int(header) % 64, body: body)
        let value = [UInt8](body[..<offset])
        return (ByteString(Data(value).hex), ([UInt8](body[value.count..<body.count]))) as! (T, [UInt8])
    }
}

extension String: CBORDecodableExtension {
    static func decode<T>(_ header: UInt8, _ body: [UInt8], baseTag: Int, ofType type: T.Type) -> (T, [UInt8]) {
        let (offset, body) = CBORDecoder.extractHeaderBody(header: Int(header) % 96, body: body)
        let value = [UInt8](body[..<offset])
        return (Data(value).string, ([UInt8](body[value.count..<body.count]))) as! (T, [UInt8])
    }
}

// extension Dictionary: CBORDecodable where Key: CBORDecodable, Value: CBORDecodable {
//     public var decode: CBOREncodable {
//         return ["11":"11"]
//     }
// }

// extension SimpleValue: CBORDecodable {
//     public var decode: CBOREncodable {
//         return SimpleValue(.null)
//     }
// }

// extension TaggedValue: CBORDecodable {
//     public var decode: CBOREncodable {
//         return TaggedValue(tag: 5, 10)
//     }
// }

// extension Decodable: CBORDecodable {
//     public var encode: Encodable {
//         return ""
//     }
// }