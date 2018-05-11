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

class NSByteString: NSObject {
    private var value: String = ""
    
    init(_ value: String) {
        super.init()
        self.value = value
    }
    
    @objc override func encode(major: Data) -> String {
        var encoded = major.bytes
        
        var rawBytes = [UInt8]()
        var byteArray = [UInt8]()
        for offset in stride(from: 0, to: self.value.count, by: 2) {
            let byte = value[offset..<offset+2].hex_decimal
            byteArray.append(UInt8(byte))
        }
        Encoder.makeRawByte(bytes: &rawBytes, measure: byteArray.count)
        rawBytes.append(contentsOf: byteArray.count.decimal_binary)
        
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        let headerData  = Data(bytes: encoded).binary_decimal.hex
        let byteData    = Data(bytes: byteArray).hex
        
        return headerData.appending(byteData)
    }
}

class Encoder: NSObject {

    class func makeRawByte(bytes: inout [UInt8], measure: Int) {
        if measure >= 0 && measure <= 23 {}
        else if measure >= 24 && measure <= 255 { bytes = 24.decimal_binary }
        else if measure >= 256 && measure <= 65535 { bytes = 25.decimal_binary }
        else if measure >= 65536 && measure <= 4294967295 { bytes = 26.decimal_binary }
    }
    
    class func prepareByteArray(major: Data, measure: Int) -> [UInt8] {
        var encoded = major.bytes
        
        var rawBytes = [UInt8]()
        Encoder.makeRawByte(bytes: &rawBytes, measure: measure)
        rawBytes.append(contentsOf: measure.decimal_binary)
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        
        return encoded
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
        if let item = item as? NSByteString {
            major.set(type: .major2)
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
}

extension NSNumber {
    @objc override func encode(major: Data) -> String {
        let encodedArray = Encoder.prepareByteArray(major: major, measure: self.intValue)
        return Data(bytes: encodedArray).binary_decimal.hex
    }
}

extension NSString {
    @objc override func encode(major: Data) -> String {
        let encodedArray = Encoder.prepareByteArray(major: major, measure: self.length)
        let headerData  = Data(bytes: encodedArray).binary_decimal.hex
        let strData     = Data(bytes: self.ascii_bytes).hex
        
        return headerData.appending(strData)
    }
}

extension NSArray {
    @objc override func encode(major: Data) -> String {
        let encodedArray = Encoder.prepareByteArray(major: major, measure: self.count)
        return (Data(bytes: encodedArray).binary_decimal.hex).appending(getItemsEncoding())
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
        let encodedArray = Encoder.prepareByteArray(major: major, measure: self.allKeys.count)
        return (Data(bytes: encodedArray).binary_decimal.hex).appending(getItemsEncoding())
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

extension NSData {
    @objc override func encode(major: Data) -> String {
        let data = self as Data
        let encodedArray = Encoder.prepareByteArray(major: major, measure: data.count)
        return Data(bytes: encodedArray).binary_decimal.hex
    }
}
