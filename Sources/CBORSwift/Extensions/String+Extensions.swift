import Foundation

extension String {
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
    public var byteArrayCharacters: [UInt8] {
        let byteArray: [UInt8] = self.map { UInt8(Int(String($0))!) }
        if byteArray.count % 8 == 0 { 
            return byteArray
        }
        
        var byteDiff = (byteArray.count / 8) + 1
        if byteDiff > 8 {
            byteDiff = 16
        } else if byteDiff > 4 {
            byteDiff = 8
        } else if byteDiff > 2 {
            byteDiff = 4
        }
        return [UInt8](repeating:0, count: (8 * byteDiff) - byteArray.count) + byteArray
    }

    public var data: Data? {
        guard let regex = try? NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive) else {
            return nil
        }
        let data = NSMutableData(capacity: self.count)
        regex.enumerateMatches(in: self, options: [], range: NSMakeRange(0, self.count)) { match, flags, stop in
            let byteString = (self as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)
            data?.append(&num, length: 1)
        }
        return data as Data?
    }
    
    public var hex: String {
        return self.utf8.map{ $0 }
                        .reduce("") {
                            $0 + String($1, radix: 16, uppercase: true) 
                        }
    }
    
    public var hex_ascii: String {
        let chr: [Character] = self.map { $0 }
        return stride(from: 0, to: chr.count, by: 2).map {
                    strtoul(String(chr[$0 ..< $0+2]), nil, 16)
                }.map {
                    String(UnicodeScalar(Int($0))!)
                }.joined(separator: "")
    }
    
    public var ascii_bytes: [UInt8] {
        return self.data(using: .ascii)!.bytes
    }
    
    public var hex_decimal: Int {
        return Int(self, radix: 16)!
    }
    
    public var hex_binary: [UInt8] {
        return String(Int(self, radix: 16)!, radix: 2).byteArrayCharacters
    }
}