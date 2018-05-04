//
//  Data.swift
//  CBORSwift
//
//  Created by Hassaniiii on 5/3/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import Foundation

extension Data {
    public var binary: [UInt8] {
        var bytes = [UInt8](repeating:0, count:self.count)
        self.copyBytes(to: &bytes, count: self.count)
        
        return [UInt8](bytes[0..<bytes.count])
    }
    
    public var decimal: Int {
        var str = ""
        for bit in self.binary {
            str.append("\(bit)")
        }
        return Int(str, radix: 2)!
    }
    
    public var hex: String {
        var str = ""
        for byte in self.binary {
            str = str.appendingFormat("%02x", UInt(byte))
        }
        return str
    }
}

extension Int {
    public var binary: [UInt8] {
        return String(self, radix: 2).bits
    }
    
    public var hex: String {
        var hexStr = String(self, radix: 16).uppercased()
        if hexStr.count == 1 {
            hexStr = "0\(hexStr)"
        }
        return hexStr
    }
}

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
    
    public var bits: [UInt8] {
        var bits = [UInt8]()
        for index in 0..<self.count {
            let chr = self[index..<index+1]
            let chrInt = Int(chr)!
            bits.append(UInt8(chrInt))
        }

        let bitsSize = bits.count % 8
        if bitsSize == 0 {
            return bits
        }
        
        var bitDiff = (bits.count / 8) + 1
        if bitDiff > 2 {
            bitDiff = 4
        }
        
        var bitsArray =  [UInt8](repeating:0, count: (8 * bitDiff) - bits.count)
        bitsArray.append(contentsOf: bits)
        return bitsArray
    }
    
    public var data: Data? {
        let data = NSMutableData(capacity: self.count)
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, options: [], range: NSMakeRange(0, self.count)) { match, flags, stop in
            let byteString = (self as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)
            data?.append(&num, length: 1)
        }
        return data as Data?
    }
    
    public var hex: String {
        return self.utf8.map{ $0 }.reduce("") { $0 + String($1, radix: 16, uppercase: true) }
    }
    
    public var decimal: Int {
        return Int(self, radix: 16)!
    }
}

extension NSString {
    public var hex: String {
        return String(self).utf8.map{ $0 }.reduce("") { $0 + String($1, radix: 16, uppercase: true) }
    }
}

extension Array where Element == UInt8 {
    public var decimal: Int {
        var str = ""
        for bit in self {
            str.append("\(bit)")
        }
        return Int(str, radix: 16)!
    }
}

extension Dictionary where Value: Comparable, Key: Comparable {
    var valueKeySorted: [(Key, Value)] {
        return sorted {
            if $0.0 != $1.0 {
                return $0.0 < $1.0
            }
            else if $0.1 != $1.1 {
                return $0.1 < $1.1
            }
            return $0.0 == $1.0
        }
    }
}
