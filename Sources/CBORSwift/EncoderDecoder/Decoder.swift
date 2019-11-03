import Foundation

extension Array: CBORDecodable where Element == UInt8 {
    public var decode: CBOREncodable? {
        guard let headerByte = self.first,
                let major = MajorType.typeEnum(Int(headerByte).decimal_binary)
        else { return nil }
        let bodyByteArray = [UInt8](self[1..<self.count])


        switch major {
        case .major0:
            let (decode, _) = Int.decode(headerByte, bodyByteArray, baseTag: 32, ofType: Int.self)
            return decode
        case .major1:
            let (decode, _) = Int.decode(headerByte, bodyByteArray, baseTag: 32, ofType: Int.self)
            return (decode + 1) * -1
        case .major2:
            return nil
        case .major3:
            return nil
        case .major4:
            return nil
        case .major5:
            return nil
        case .major6:
            return nil
        case .major7:
            return nil
        }
        fatalError("Undefined header byte")
    }
}

protocol CBORDecodableExtension {
    static func decode<T: CBOREncodable>(_ header: UInt8, _ body: [UInt8], baseTag: Int, ofType _: T.Type) -> (T, [UInt8])
}

extension Int: CBORDecodableExtension {
    static func decode<T>(_ header: UInt8, _ body: [UInt8], baseTag: Int, ofType _: T.Type) -> (T, [UInt8]) {
        return CBORDecoder.extractHeaderBody(header: header, body: body, baseTag: 32) as! (T, [UInt8])
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