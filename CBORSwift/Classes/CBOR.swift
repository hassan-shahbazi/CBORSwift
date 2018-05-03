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
        
        return Encoder.encode(value: value, header: major.get()).data?.binary
    }
    
    public class func encode(negative value: NSNumber) -> [UInt8]? {
        let value = NSNumber(value: (value.intValue * -1) - 1)
        let major = MajorTypes()
        major.set(type: .major1)

        return Encoder.encode(value: value, header: major.get()).data?.binary
    }
    
    public class func encode(byteString value: String) {
        let major = MajorTypes()
        major.set(type: .major2)
        
        
    }
    
    public class func encode(textString value: String) -> [UInt8]? {
        let major = MajorTypes()
        major.set(type: .major3)
        
        return Encoder.encode(value: value, header: major.get()).data?.binary
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
