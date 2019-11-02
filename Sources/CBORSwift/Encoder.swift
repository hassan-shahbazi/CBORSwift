import Foundation

private struct CBOREncoder {
    private static func headerByteArray(_ measure: Int) -> [UInt8] {
        if measure >= 24 && measure <= UInt8.max { return 24.decimal_binary }
        else if measure > UInt8.max && measure <= UInt16.max { return 25.decimal_binary }
        else if measure > UInt16.max && measure <= UInt32.max { return 26.decimal_binary }
        else if measure > UInt32.max && measure <= UInt64.max { return 27.decimal_binary }

        return []
    }

    static func byteArray(_ major: MajorType, _ measure: Int = 0) -> [UInt8] {
        let bytes = headerByteArray(measure) + measure.decimal_binary
        return MajorTypes(major).typeData.bytes + [UInt8](bytes[3..<bytes.count])
    }
    
    static func encodeArray(_ array: inout [UInt8]) -> String {
        var response = ""
        while array.count > 64 {
            response += [UInt8](array[..<64]).binary_decimal.hex
            array = [UInt8](array[64..<array.count])
        }
        return response + array.binary_decimal.hex
    }
}

extension Int {
    var encode: String {
        var encodedArray = CBOREncoder.byteArray((isNegative) ? .major1 : .major0, (isNegative) ? (self * -1) - 1 : self)
        return CBOREncoder.encodeArray(&encodedArray)
    }

    private var isNegative: Bool {
        return self < 0
    }
}

extension String {
    var encode: String {
        return Data(CBOREncoder.byteArray(.major3, self.count)).binary_decimal.hex + Data(self.ascii_bytes).hex
    }
}

extension Data {

}

extension Array {

}

extension Dictionary {

}
// extension NSNumber {
//     @objc override func encode() -> String {
        
//     }
// }

// extension NSString {
//     @objc override func encode() -> String {
//         let encodedArray = Encoder.prepareByteArray(major: .major3, measure: self.length)
//         let headerData  = Data(bytes: encodedArray).binary_decimal.hex
//         let strData     = Data(bytes: self.ascii_bytes).hex
        
//         return headerData.appending(strData)
//     }
// }

// extension NSArray {
//     @objc override func encode() -> String {
//         let encodedArray = Encoder.prepareByteArray(major: .major4, measure: self.count)
//         return (Data(bytes: encodedArray).binary_decimal.hex).appending(getItemsEncoding())
//     }
    
//     private func getItemsEncoding() -> String {
//         var data = ""
//         for item in self {
//             data.append(Encoder.getIncludedEncodings(item: item as AnyObject))
//         }
//         return data
//     }
// }

// extension NSDictionary {
//     @objc override func encode() -> String {
//         let encodedArray = Encoder.prepareByteArray(major: .major5, measure: self.allKeys.count)
//         return (Data(bytes: encodedArray).binary_decimal.hex).appending(getItemsEncoding())
//     }
    
//     private func getItemsEncoding() -> String {
//         var data = ""
//         var key_value = [String:String]()
//         for (key, value) in self {
//             key_value[Encoder.getIncludedEncodings(item: key as AnyObject)] = Encoder.getIncludedEncodings(item: value as AnyObject)
//         }
        
//         let dic = key_value.valueKeySorted
//         for item in dic {
//             data.append(item.0)
//             data.append(item.1)
//         }
//         return data
//     }
// }

// extension NSData {
//     @objc override func encode() -> String {
//         let data = self as Data
//         let encodedArray = Encoder.prepareByteArray(major: .major2, measure: data.count)
//         return Data(bytes: encodedArray).binary_decimal.hex
//     }
// }
