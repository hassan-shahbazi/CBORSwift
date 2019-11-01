import Foundation

extension Data {
    public var bytes: [UInt8] {
        return [UInt8](self)
    }
    
    public var binary_decimal: Int {
        return Int(self.bytes.map { "\($0)" }.joined(separator: ""), radix: 2)!
    }
    
    public var hex: String {
        return self.bytes.map { String(format: "%02x", UInt($0)) }.joined(separator: "")
    }
    
    public var string: String {
        return String(data: self, encoding: .utf8)!
    }
}