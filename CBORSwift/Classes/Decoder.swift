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
            if type == .major2 {
                
            }
            if type == .major3 {
                decoded = Decoder.DecodeString(header: header, body: body)
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

    private class func DecodeString(header: UInt8, body: [UInt8]) -> NSString {
        let header = Int(header) % 96
        var len = 0
        var value = [UInt8]()
        
        if header < 24 {
            len = header
            value = [UInt8](body[0..<len])
        }
        if header == 24 {
            len = Int(body[0])
            value = [UInt8](body[1...len])
        }
        else if header == 25 {
            let hexLen = Int(body[0]).hex.appending(Int(body[1]).hex)
            len = hexLen.hex_decimal
            value = [UInt8](body[2...len+1])
        }
        else if header == 26 {
            let hexLen = Int(body[0]).hex.appending(Int(body[1]).hex).appending(Int(body[2]).hex).appending(Int(body[3]).hex)
            len = hexLen.hex_decimal
            value = [UInt8](body[3...len+2])
        }
        return Data(bytes: value).string as NSString
    }
}

