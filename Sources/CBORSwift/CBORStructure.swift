import Foundation

protocol CBOREncodableStruct: Encodable {
    func encode() throws -> [UInt8]
}

extension CBOREncodableStruct {
    func dictionary(from data: Data) throws -> Dictionary<AnyHashable,AnyHashable?> {
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<AnyHashable,AnyHashable?> else {
            throw CBORError.EncodedNilResult
        }
        return dictionary
    }

    func encode() throws -> [UInt8] {
        let encodedStructure = try JSONEncoder().encode(self)
        guard let encode = try dictionary(from: encodedStructure).encode.data?.bytes else {
            throw CBORError.EncodedNilResult
        }
        return encode
    }
}