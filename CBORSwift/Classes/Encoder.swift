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
        if value.intValue >= 0 && value.intValue <= 23 {}
        else if value.intValue >= 24 && value.intValue <= 255 { rawBytes = 24.binary }
        else if value.intValue >= 256 && value.intValue <= 65535 { rawBytes = 25.binary }
        else if value.intValue >= 65536 && value.intValue <= 4294967295 { rawBytes = 26.binary }
        rawBytes.append(contentsOf: value.intValue.binary)
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        
        return Data(bytes: encoded).decimal.hex
    }
    
    public class func encode(value: String, header: Data) -> String {
        var encoded = [UInt8]()
        encoded.append(contentsOf: header.binary)
        
        var rawBytes = [UInt8]()
        if value.count >= 0 && value.count <= 23 {}
        else if value.count >= 24 && value.count <= 255 { rawBytes = 24.binary }
        else if value.count >= 256 && value.count <= 65535 { rawBytes = 25.binary }
        else if value.count >= 65536 && value.count <= 4294967295 { rawBytes = 26.binary }
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
        if value.count >= 0 && value.count <= 23 {}
        else if value.count >= 24 && value.count <= 255 { rawBytes = 24.binary }
        else if value.count >= 256 && value.count <= 65535 { rawBytes = 25.binary }
        else if value.count >= 65536 && value.count <= 4294967295 { rawBytes = 26.binary }
        rawBytes.append(contentsOf: value.count.binary)
        
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        return Data(bytes: encoded).decimal.hex
    }
    
    public class func encode(value: NSDictionary, header: Data) -> String {
        var encoded = [UInt8]()
        encoded.append(contentsOf: header.binary)
        
        var rawBytes = [UInt8]()
        if value.allKeys.count >= 0 && value.allKeys.count <= 23 {}
        else if value.allKeys.count >= 24 && value.allKeys.count <= 255 { rawBytes = 24.binary }
        else if value.allKeys.count >= 256 && value.allKeys.count <= 65535 { rawBytes = 25.binary }
        else if value.allKeys.count >= 65536 && value.allKeys.count <= 4294967295 { rawBytes = 26.binary }
        rawBytes.append(contentsOf: value.allKeys.count.binary)
        
        encoded.append(contentsOf: [UInt8](rawBytes[3..<rawBytes.count]))
        return Data(bytes: encoded).decimal.hex
    }
}
