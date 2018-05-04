//
//  CBOR.swift
//  CBORSwift
//
//  Created by Hassaniiii on 5/2/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

class CBOR: NSObject {
    
    public class func encode(integer value: NSNumber) -> [UInt8]? {
        return self.Encode(value: value, major: .major0)
    }
    
    public class func encode(negative value: NSNumber) -> [UInt8]? {
        let value = NSNumber(value: (value.intValue * -1) - 1)
        return self.Encode(value: value, major: .major1)
    }
    
    public class func encode(byteString value: String) {}
    
    public class func encode(textString value: String) -> [UInt8]? {
        return self.Encode(value: value, major: .major3)
    }
    
    public class func encode(array value: NSArray) -> [UInt8]? {
        return self.Encode(value: value, major: .major4)
    }
    
    public class func encode(map value: NSDictionary) -> [UInt8]? {
        return self.Encode(value: value, major: .major5)
    }
}

extension CBOR {
    class func Encode(value: Any, major: MajorType) -> [UInt8]? {
        let type = MajorTypes()
        type.set(type: major)
        
        return Encoder.encode(value: value, major: type).data?.binary
    }
}
