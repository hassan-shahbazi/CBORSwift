//
//  Decoder.swift
//  CBORSwift
//
//  Created by Hassaniiii on 5/4/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

class Decoder: NSObject {
    public class func decode(value: [UInt8]) -> NSObject {
        let header  = value[0]
        let body    = [UInt8](value[1..<value.count])
        
        var decoded = NSObject()
        if let type = extractMajorType(Int(header)) {
            if type == .major0 {
                decoded = Decoder.DecodeNumber(header: header, body: body)
            }
            if type == .major1 {
                let neg = Decoder.DecodeNumber(header: header, body: body).intValue
                decoded = NSNumber(value: (neg + 1) * -1)
            }
        }
        return decoded
    }
    
    private class func extractMajorType(_ header: Int) -> MajorType? {
        let major = MajorTypes()
        return major.identify(header.decimal_binary)
    }
    
}

extension Decoder {
    private class func DecodeNumber(header: UInt8, body: [UInt8]) -> NSNumber {
        var value = [header % 32]
        
        if Int(header) % 32 == 24 {
            value = [UInt8](body[0...0])
        }
        else if Int(header) % 32 == 25 {
            value = [UInt8](body[0...1])
        }
        else if Int(header) % 32 == 26 {
            value = [UInt8](body[0...3])
        }
        return NSNumber(value: Data(bytes: value).hex.hex_decimal)
    }
}
