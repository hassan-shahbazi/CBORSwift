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
            if let item = item as? String {
                let major = MajorTypes()
                major.set(type: .major3)
                
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
        return Data(bytes: encoded).decimal.hex
    }
}

private extension Encoder {
    class func makeRawByte(bytes: inout [UInt8], measure: Int) {
        if measure >= 0 && measure <= 23 {}
        else if measure >= 24 && measure <= 255 { bytes = 24.binary }
        else if measure >= 256 && measure <= 65535 { bytes = 25.binary }
        else if measure >= 65536 && measure <= 4294967295 { bytes = 26.binary }
    }
}
