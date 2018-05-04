//
//  CBOR.swift
//  CBORSwift
//
//  Created by Hassaniiii on 5/2/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

class CBOR: Encoder {
    
    public class func encode(integer value: NSNumber) -> [UInt8]? {
        let major = MajorTypes()
        major.set(type: .major0)
        
        return value.encode(major: major.get()).data?.binary
    }
    
    public class func encode(negative value: NSNumber) -> [UInt8]? {
        let value = NSNumber(value: (value.intValue * -1) - 1)
        let major = MajorTypes()
        major.set(type: .major1)

        return value.encode(major: major.get()).data?.binary
    }
    
    public class func encode(byteString value: String) {
        let major = MajorTypes()
        major.set(type: .major2)
    }
    
    public class func encode(textString value: String) -> [UInt8]? {
        let major = MajorTypes()
        major.set(type: .major3)
        
        return value.encode(major: major.get()).data?.binary
    }
    
    public class func encode(array value: NSArray) -> [UInt8]? {
        let major = MajorTypes()
        major.set(type: .major4)
        
        return value.encode(major: major.get()).data?.binary
    }
    
    public class func encode(map value: NSDictionary) -> [UInt8]? {
        let major = MajorTypes()
        major.set(type: .major5)
        
        return value.encode(major: major.get()).data?.binary
    }
}
