//
//  CBOR.swift
//  CBORSwift
//
//  Created by Hassaniiii on 5/2/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

class CBOR: NSObject {
    
    public class func encode(integer value: NSNumber) -> [UInt8]? {
        let major = MajorTypes()
        major.set(type: .major0)
        let header = major.get()
        
        var rawBytes = [UInt8]()
        if value.intValue >= 0 && value.intValue <= 23 {}
        else if value.intValue >= 24 && value.intValue <= 255 {
            rawBytes = 24.binary
        }
        else if value.intValue >= 256 && value.intValue <= 65535 {
            rawBytes = 25.binary
        }
        else if value.intValue >= 65536 && value.intValue <= 4294967295 {
            rawBytes = 26.binary
        }
        
        rawBytes.append(contentsOf: value.intValue.binary)
        let rawData = Data(bytes: rawBytes)
        return Encoder.encode(value: rawData, header: header).data?.binary
    }
    
    public class func encode(negative value: NSNumber) -> [UInt8]? {
        let value = (value.intValue * -1) - 1
        let major = MajorTypes()
        major.set(type: .major1)
        let header = major.get()
        
        var rawBytes = [UInt8]()
        if value >= 0 && value <= 23 {}
        else if value >= 24 && value <= 255 {
            rawBytes = 24.binary
        }
        else if value >= 256 && value <= 65535 {
            rawBytes = 25.binary
        }
        else if value >= 65536 && value <= 4294967295 {
            rawBytes = 26.binary
        }
        
        rawBytes.append(contentsOf: value.binary)
        let rawData = Data(bytes: rawBytes)
        return Encoder.encode(value: rawData, header: header).data?.binary
    }
    
    public class func encode(byteString value: Data) {
        let major = MajorTypes()
        major.set(type: .major2)
    }
    
    public class func encode(textString value: String) {
        let major = MajorTypes()
        major.set(type: .major3)
    }
    
    public class func encode(array value: NSArray) {
        let major = MajorTypes()
        major.set(type: .major4)
    }
    
    public class func encode(map value: NSDictionary) {
        let major = MajorTypes()
        major.set(type: .major5)
    }
}

extension CBOR {
    
}
