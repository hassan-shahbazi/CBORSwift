//
//  Decoder.swift
//  CBORSwift
//
//  Created by Hassaniiii on 5/4/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

class Decoder: NSObject {
    public class func decode(header: UInt8? = nil, value: [UInt8]) -> NSObject {
        let header  = header ?? value[0]
        let body    = [UInt8](value[1..<value.count])
        
        var decoded = NSObject()
        if let type = extractMajorType(Int(header)) {
            if type == .major0 {
                decoded = DecodeNumber(header: header, body: body)
            }
            if type == .major1 {
                let neg = DecodeNumber(header: header, body: body).intValue
                decoded = NSNumber(value: (neg + 1) * -1)
            }
            if type == .major2 {
                decoded = DecodeString(header: header, body: body, isByteString: true)
            }
            if type == .major3 {
                decoded = DecodeString(header: header, body: body, isByteString: false)
            }
            if type == .major4 {
                decoded = DecodeArray(header: header, body: body)
            }
            if type == .major5 {
                decoded = DecodeMap(header: header, body: body)
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

    private class func DecodeString(header: UInt8, body: [UInt8], isByteString: Bool) -> NSString {
        let header = (isByteString) ? Int(header) % 64 : Int(header) % 96
        var len = 0
        var offset = 0
        get(len: &len, offset: &offset, header: header, body: body)
        
        let value = [UInt8](body[offset..<len+offset])
        let data = Data(bytes: value)
        return ((isByteString) ? data.hex : data.string) as NSString
    }

    private class func DecodeArray(header: UInt8, body: [UInt8]) -> NSArray {
        let header = Int(header) % 128
        var len = 0
        var offset = 0
        get(len: &len, offset: &offset, header: header, body: body)


        var value = [NSObject]()
        for _ in 0..<len {
            let header = body[offset]
            let object = decode(header: header, value: [UInt8](body[offset..<body.count]))
            value.append(object)
            offset += object.len + 1
        }
        
        return value as NSArray
    }
    
    private class func DecodeMap(header: UInt8, body: [UInt8]) -> NSDictionary {
        let header = Int(header) % 160
        var len = 0
        var offset = 0
        get(len: &len, offset: &offset, header: header, body: body)
        
        
        var dict = Dictionary<NSObject, NSObject>()
        for _ in 0..<len {
            var header = body[offset]
            let key = decode(header: header, value: [UInt8](body[offset..<body.count]))
            offset += key.len + 1
            
            header = body[offset]
            let value = decode(header: header, value: [UInt8](body[offset..<body.count]))
            offset += value.len + 1
            
            dict[key] = value
        }
        
        return dict as NSDictionary
    }
    
    class func get(len: inout Int, offset: inout Int, header: Int, body: [UInt8]) {
        if header < 24 {
            len = header
            offset = 0
        }
        if header == 24 {
            len = Int(body[0])
            offset = 1
        }
        else if header == 25 {
            let hexLen = Int(body[0]).hex.appending(Int(body[1]).hex)
            len = hexLen.hex_decimal
            offset = 2
        }
        else if header == 26 {
            let hexLen = Int(body[0]).hex.appending(Int(body[1]).hex).appending(Int(body[2]).hex).appending(Int(body[3]).hex)
            len = hexLen.hex_decimal
            offset = 3
        }
    }
}

