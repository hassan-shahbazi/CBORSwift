//
//  Decoder.swift
//  CBORSwift
//
//  Created by Hassaniiii on 5/4/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

class Decoder: NSObject {
    public class func decode(value: [UInt8]) -> NSObject {
        let header = value[0]
        var decoded = NSObject()
        
        if let type = extractMajorType(Int(header)) {
            if type == .major0 {
                decoded = Decoder.DecodeNumber(data: value)
            }
        }
        return decoded
    }
    
    private class func extractMajorType(_ header: Int) -> MajorType? {
        let major = MajorTypes()
        return major.identify(header.binary)
    }
    
}

extension Decoder {
    private class func DecodeNumber(data: [UInt8]) -> NSNumber {
        let valueLen = Int(data[0])
        
        var value = [UInt8](data[0...0])
        if valueLen == 24 {
            value = [UInt8](data[1...1])
        }
        if valueLen == 25 {
            value = [UInt8](data[1...2])
        }
        if valueLen == 26 {
            value = [UInt8](data[1...4])
        }
        return NSNumber(value: Data(bytes: value).hex.decimal)
    }
}
