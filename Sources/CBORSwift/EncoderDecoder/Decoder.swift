import Foundation

extension Array: CBORDecodable where Element == UInt8 {
    public var decode: CBOREncodable? {
        return decoder.0
    }

    private var decoder: (CBOREncodable?, [UInt8]) {
        guard let headerByte = self.first, let major = MajorType.typeEnum(Int(headerByte).decimal_binary) else { return (nil, []) }
        let bodyByteArray = [UInt8](self[1..<self.count])

        switch major {
        case .major0:
            return Int.decode(headerByte, bodyByteArray, ofType: Int.self)        
        case .major1:
            let (decode, newBody) = Int.decode(headerByte, bodyByteArray, ofType: Int.self)
            return ((decode + 1) * -1, newBody)
        case .major2:
            return ByteString.decode(headerByte, bodyByteArray, ofType: ByteString.self)
        case .major3:
            return String.decode(headerByte, bodyByteArray, ofType: String.self)
        case .major4:
            var (offset, newBody) = CBORDecoder.extractHeaderBody(header: Int(headerByte) % 128, body: bodyByteArray)
            return (Array<Int>(0..<offset).reduce(into: []) { (result: inout [AnyHashable], index: Int) in
                    let (internalResponse, internalNextBodyIteration) = newBody.decoder
                    if let response = internalResponse as? AnyHashable {
                        result.append(response)
                    }
                    if internalNextBodyIteration.count > 0 {
                        newBody = internalNextBodyIteration
                    }
            }, newBody)
        case .major5:
            return (nil, [])
        case .major6:
            return (nil, [])
        case .major7:
            return Bool.decode(headerByte, bodyByteArray, ofType: Bool.self)
        }
    }
}

protocol CBORDecodableExtension {
    static func decode<T: CBOREncodable>(_ header: UInt8, _ body: [UInt8], ofType type: T.Type) -> (T, [UInt8])
}

extension Int: CBORDecodableExtension {
    static func decode<T>(_ header: UInt8, _ body: [UInt8], ofType type: T.Type) -> (T, [UInt8]) {
        let (value, body) = CBORDecoder.extractHeaderBody(header: Int(header) % 32, body: body)
        return (value, ([UInt8](body[..<body.count]))) as! (T, [UInt8])
    }
}

extension ByteString: CBORDecodableExtension {
    static func decode<T>(_ header: UInt8, _ body: [UInt8], ofType type: T.Type) -> (T, [UInt8]) {
        let (offset, body) = CBORDecoder.extractHeaderBody(header: Int(header) % 64, body: body)
        let value = [UInt8](body[..<offset])
        return (ByteString(Data(value).hex), ([UInt8](body[value.count..<body.count]))) as! (T, [UInt8])
    }
}

extension String: CBORDecodableExtension {
    static func decode<T>(_ header: UInt8, _ body: [UInt8], ofType type: T.Type) -> (T, [UInt8]) {
        let (offset, body) = CBORDecoder.extractHeaderBody(header: Int(header) % 96, body: body)
        let value = [UInt8](body[..<offset])
        return (Data(value).string, ([UInt8](body[value.count..<body.count]))) as! (T, [UInt8])
    }
}

extension Bool: CBORDecodableExtension {
    static func decode<T>(_ header: UInt8, _ body: [UInt8], ofType type: T.Type) -> (T, [UInt8]) {
        switch SimpleValue.valueEnum([header]) {
        case .false: return (false, body) as! (T, [UInt8])
        case .true: return (true, body) as! (T, [UInt8])
        default:
            fatalError("Not supported value")
        }
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