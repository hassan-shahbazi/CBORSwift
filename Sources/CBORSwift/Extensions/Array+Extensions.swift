import Foundation

extension Array where Element == UInt8 {
    public var hex_decimal: Int {
        return Int(self.map { "\($0)" }.joined(separator: ""), radix: 16)!
    }
    
    public var binary_decimal: Int {
        return Int(self.map { "\($0)" }.joined(separator: ""), radix: 2)!
    }
}
