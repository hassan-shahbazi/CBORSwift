//
//  Encoder.swift
//  CBORSwift
//
//  Created by Hassaniiii on 5/2/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

class Encoder: NSObject {
    
    public class func encode(value: NSNumber, header: Data) -> String {
        var encoded = [UInt8]()
        encoded.append(contentsOf: header.binary)
        
        var rawBytes = [UInt8]()
        makeRawByte(bytes: &rawBytes, measure: value.intValue)
        rawBytes.append(contentsOf: value.intValue.binary)
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        
        return Data(bytes: encoded).decimal.hex
    }
    
    public class func encode(value: String, header: Data) -> String {
        var encoded = [UInt8]()
        encoded.append(contentsOf: header.binary)
        
        var rawBytes = [UInt8]()
        makeRawByte(bytes: &rawBytes, measure: value.count)
        rawBytes.append(contentsOf: value.count.binary)
        
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        let headerData  = Data(bytes: encoded).decimal.hex
        let strData     = Data(bytes: value.hex.data!.binary).hex
        
        return headerData.appending(strData)
    }
    
    public class func encode(value: NSArray, header: Data) -> String {
        var encoded = [UInt8]()
        encoded.append(contentsOf: header.binary)
        
        var rawBytes = [UInt8]()
        makeRawByte(bytes: &rawBytes, measure: value.count)
        rawBytes.append(contentsOf: value.count.binary)
        
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        var data  = Data(bytes: encoded).decimal.hex
        
        for item in value {
            let major = MajorTypes()
            if var item = item as? NSNumber {
                if item.intValue > 0 {
                    major.set(type: .major0)
                }
                if item.intValue < 0 {
                    major.set(type: .major1)
                    item = NSNumber(value: (item.intValue * -1) - 1)
                }
                data.append(encode(value: item, header: major.get()))
            }
            if let item = item as? String {
                major.set(type: .major3)
                
                data.append(encode(value: item, header: major.get()))
            }
            if let item = item as? NSArray {
                major.set(type: .major4)
                
                data.append(encode(value: item, header: major.get()))
            }
            if let item = item as? NSDictionary {
                major.set(type: .major5)
                
                data.append(encode(value: item, header: major.get()))
            }
        }
        return data
    }
    
    public class func encode(value: NSDictionary, header: Data) -> String {
        var encoded = [UInt8]()
        encoded.append(contentsOf: header.binary)
        
        var rawBytes = [UInt8]()
        makeRawByte(bytes: &rawBytes, measure: value.allKeys.count)
        rawBytes.append(contentsOf: value.allKeys.count.binary)
        
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        var data  = Data(bytes: encoded).decimal.hex
        
        var key_value = [String:String]()
        for (key, value) in value {
            key_value[getKeyEncoding(key: key)] = getValueEncoding(value: value)
        }
        
        let dic = key_value.valueKeySorted
        for item in dic {
            data.append(item.0)
            data.append(item.1)
        }
        return data
    }
}

private extension Encoder {
    class func makeRawByte(bytes: inout [UInt8], measure: Int) {
        if measure >= 0 && measure <= 23 {}
        else if measure >= 24 && measure <= 255 { bytes = 24.binary }
        else if measure >= 256 && measure <= 65535 { bytes = 25.binary }
        else if measure >= 65536 && measure <= 4294967295 { bytes = 26.binary }
    }
    
    class func getKeyEncoding(key: Any) -> String {
        let major = MajorTypes()
        if var key = key as? NSNumber {
            if key.intValue > 0 {
                major.set(type: .major0)
            }
            if key.intValue < 0 {
                major.set(type: .major1)
                key = NSNumber(value: (key.intValue * -1) - 1)
            }
            return encode(value: key, header: major.get())
        }
        if let key = key as? String {
            major.set(type: .major3)
            
            return encode(value: key, header: major.get())
        }
        if let key = key as? NSArray {
            major.set(type: .major4)
            
            return encode(value: key, header: major.get())
        }
        if let key = key as? NSDictionary {
            major.set(type: .major5)
            
            return encode(value: key, header: major.get())
        }
        return ""
    }
    
    class func getValueEncoding(value: Any) -> String {
        let major = MajorTypes()
        if var value = value as? NSNumber {
            if value.intValue > 0 {
                major.set(type: .major0)
            }
            if value.intValue < 0 {
                major.set(type: .major1)
                value = NSNumber(value: (value.intValue * -1) - 1)
            }
            return encode(value: value, header: major.get())
        }
        if let value = value as? String {
            major.set(type: .major3)
            
            return encode(value: value, header: major.get())
        }
        if let value = value as? NSArray {
            major.set(type: .major4)
            
            return encode(value: value, header: major.get())
        }
        if let value = value as? NSDictionary {
            major.set(type: .major5)
            
            return encode(value: value, header: major.get())
        }
        return ""
    }

}
