import Foundation

public protocol CBOREncodable {
    var encode: String { get }
}

struct CBOREncoder {
    private static func headerByteArray(_ measure: Int) -> [UInt8] {
        if measure >= 24 && measure <= UInt8.max { return 24.decimal_binary }
        else if measure > UInt8.max && measure <= UInt16.max { return 25.decimal_binary }
        else if measure > UInt16.max && measure <= UInt32.max { return 26.decimal_binary }
        else if measure > UInt32.max && measure <= UInt64.max { return 27.decimal_binary }

        return []
    }

    static func byteArray(_ major: MajorTypes, _ measure: Int = 0) -> [UInt8] {
        let bytes = headerByteArray(measure) + measure.decimal_binary
        return MajorType(major).typeData.bytes + [UInt8](bytes[3..<bytes.count])
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