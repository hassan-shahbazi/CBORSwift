import Foundation

extension Int {
    public var decimal_binary: [UInt8] {
        return String(self, radix: 2).byteArrayCharacters
    }

    public var hex: String {
        let hexStr = String(self, radix: 16).uppercased()
        if hexStr.count == 1 {
            return "0\(hexStr)"
        }
        return hexStr
    }
}