//
//  Encoder.swift
//  CBORSwift
//
//  Created by Hassaniiii on 5/2/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//
protocol CBOREncoder {
    static func encode(value: NSObject, major: MajorType) -> [UInt8]?
}

class Encoder: NSObject {

    class func makeRawByte(bytes: inout [UInt8], measure: Int) {
        if measure >= 0 && measure <= 23 {}
        else if measure >= 24 && measure <= 255 { bytes = 24.decimal_binary }
        else if measure >= 256 && measure <= 65535 { bytes = 25.decimal_binary }
        else if measure >= 65536 && measure <= 4294967295 { bytes = 26.decimal_binary }
    }
    
    class func getIncludedEncodings(item: Any) -> String {
        var data = ""
        let major = MajorTypes()
        
        if var item = item as? NSNumber {
            major.set(type: .major0)
            if item.intValue < 0 {
                item =  NSNumber(value: (item.intValue * -1) - 1)
                major.set(type: .major1)
            }
            data.append(item.encode(major: major.get()))
        }
        if let item = item as? String {
            major.set(type: .major3)
            data.append(item.encode(major: major.get()))
        }
        if let item = item as? NSArray {
            major.set(type: .major4)
            data.append(item.encode(major: major.get()))
        }
        if let item = item as? NSDictionary {
            major.set(type: .major5)
            data.append(item.encode(major: major.get()))
        }
        return data
    }
}

extension NSObject: Any {
    @objc internal func encode(major: Data) -> String {
        return self.encode(major: major)
    }
    
    public var len: Int {
        if let obj = self as? NSNumber {
            if abs(obj.intValue) < 24 {
                return 0
            }
            else if abs(obj.intValue) < 256 {
                return 1
            }
            else if abs(obj.intValue) < 65536 {
                return 2
            }
            else if abs(obj.intValue) < 4294967296 {
                return 4
            }
        }
        if let obj = self as? NSString {
            return obj.length
        }
        if let obj = self as? NSArray {
            return obj.count
        }
        if let obj = self as? NSDictionary {
            return obj.allKeys.count
        }
        return 0
    }
}

extension NSNumber {
    @objc override func encode(major: Data) -> String {
        var encoded = major.bytes

        var rawBytes = [UInt8]()
        Encoder.makeRawByte(bytes: &rawBytes, measure: self.intValue)
        rawBytes.append(contentsOf: self.intValue.decimal_binary)
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        
        return Data(bytes: encoded).binary_decimal.hex
    }
}

extension NSString {
    @objc override func encode(major: Data) -> String {
        var encoded = major.bytes
        
        var rawBytes = [UInt8]()
        Encoder.makeRawByte(bytes: &rawBytes, measure: self.length)
        rawBytes.append(contentsOf: self.length.decimal_binary)
        
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        let headerData  = Data(bytes: encoded).binary_decimal.hex
        
        let isByteString = self.data(using: String.Encoding.ascii.rawValue) != nil
        let strData      = (isByteString) ? Data(bytes: self.hex.data!.bytes).hex : Data(bytes: self.ascii_bytes).hex
        
        return headerData.appending(strData)
    }
}

extension NSArray {
    @objc override func encode(major: Data) -> String {
        var encoded = major.bytes
        
        var rawBytes = [UInt8]()
        Encoder.makeRawByte(bytes: &rawBytes, measure: self.count)
        rawBytes.append(contentsOf: self.count.decimal_binary)
        
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        return (Data(bytes: encoded).binary_decimal.hex).appending(getItemsEncoding())
    }
    
    private func getItemsEncoding() -> String {
        var data = ""
        for item in self {
            data.append(Encoder.getIncludedEncodings(item: item))
        }
        return data
    }
}

extension NSDictionary {
    @objc override func encode(major: Data) -> String {
        var encoded = major.bytes
        
        var rawBytes = [UInt8]()
        Encoder.makeRawByte(bytes: &rawBytes, measure: self.allKeys.count)
        rawBytes.append(contentsOf: self.allKeys.count.decimal_binary)
        
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        return (Data(bytes: encoded).binary_decimal.hex).appending(getItemsEncoding())
    }
    
    private func getItemsEncoding() -> String {
        var data = ""
        var key_value = [String:String]()
        for (key, value) in self {
            key_value[Encoder.getIncludedEncodings(item: key)] = Encoder.getIncludedEncodings(item: value)
        }
        
        let dic = key_value.valueKeySorted
        for item in dic {
            data.append(item.0)
            data.append(item.1)
        }
        return data
    }
}
