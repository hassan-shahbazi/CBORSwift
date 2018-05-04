//
//  Encoder.swift
//  CBORSwift
//
//  Created by Hassaniiii on 5/2/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

class Encoder: NSObject {
    
    public class func encode(value: Any, major: MajorTypes) -> String {
        let major = major.get()
        if let value = value as? NSNumber {
            return value.encode(major: major)
        }
        if let value = value as? String {
            return value.encode(major: major)
        }
        if let value = value as? NSArray {
            return value.encode(major: major)
        }
        if let value = value as? NSDictionary {
            return value.encode(major: major)
        }
        return ""
    }
}

private extension Encoder {
    class func makeRawByte(bytes: inout [UInt8], measure: Int) {
        if measure >= 0 && measure <= 23 {}
        else if measure >= 24 && measure <= 255 { bytes = 24.binary }
        else if measure >= 256 && measure <= 65535 { bytes = 25.binary }
        else if measure >= 65536 && measure <= 4294967295 { bytes = 26.binary }
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

extension NSNumber {
    public func encode(major: Data) -> String {
        var encoded = major.binary

        var rawBytes = [UInt8]()
        Encoder.makeRawByte(bytes: &rawBytes, measure: self.intValue)
        rawBytes.append(contentsOf: self.intValue.binary)
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        
        return Data(bytes: encoded).decimal.hex
    }
}

extension String {
    public func encode(major: Data) -> String {
        var encoded = major.binary
        
        var rawBytes = [UInt8]()
        Encoder.makeRawByte(bytes: &rawBytes, measure: self.count)
        rawBytes.append(contentsOf: self.count.binary)
        
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        let headerData  = Data(bytes: encoded).decimal.hex
        let strData     = Data(bytes: self.hex.data!.binary).hex
        
        return headerData.appending(strData)
    }
}

extension NSArray {
    public func encode(major: Data) -> String {
        var encoded = major.binary
        
        var rawBytes = [UInt8]()
        Encoder.makeRawByte(bytes: &rawBytes, measure: self.count)
        rawBytes.append(contentsOf: self.count.binary)
        
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        return (Data(bytes: encoded).decimal.hex).appending(getItemsEncoding())
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
    public func encode(major: Data) -> String {
        var encoded = major.binary
        
        var rawBytes = [UInt8]()
        Encoder.makeRawByte(bytes: &rawBytes, measure: self.allKeys.count)
        rawBytes.append(contentsOf: self.allKeys.count.binary)
        
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        return (Data(bytes: encoded).decimal.hex).appending(getItemsEncoding())
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
