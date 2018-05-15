//
//  Decoder.swift
//  CBORSwift
//
//  Created by Hassan Shahbazi on 5/4/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

class Decoder: NSObject {
    private var body = [UInt8]()
    
    override init() {
        super.init()
    }
    
    init(_ bytes: [UInt8]) {
        super.init()
        self.body = bytes
    }
    
    public func decode() -> NSObject {
        let header  = body[0]
        self.body   = [UInt8](self.body[1..<self.body.count])
        
        var decoded = NSObject()
        if let type = extractMajorType(Int(header)) {
            if type == .major0 {
                decoded = DecodeNumber(header: header)
            }
            if type == .major1 {
                let neg = DecodeNumber(header: header).intValue
                decoded = NSNumber(value: (neg + 1) * -1)
            }
            if type == .major2 {
                decoded = DecodeString(header: header, isByteString: true)
            }
            if type == .major3 {
                decoded = DecodeString(header: header, isByteString: false)
            }
            if type == .major4 {
                decoded = DecodeArray(header: header)
            }
            if type == .major5 {
                decoded = DecodeMap(header: header)
            }
            if type == .major7 {
                decoded = DecodeSimpleValue(header: header) ?? NSObject()
            }
        }
        return decoded
    }
    
    private func extractMajorType(_ header: Int) -> MajorType? {
        let major = MajorTypes()
        return major.identify(header.decimal_binary)
    }
}

extension Decoder {
    private func DecodeNumber(header: UInt8) -> NSNumber {
        var value = [header % 32]
        
        if Int(header) % 32 == 24 {
            value = [UInt8](body[0...0])
            self.body = [UInt8](body[1..<body.count])
        }
        else if Int(header) % 32 == 25 {
            value = [UInt8](body[0...1])
            self.body = [UInt8](body[2..<body.count])
        }
        else if Int(header) % 32 == 26 {
            value = [UInt8](body[0...3])
            self.body = [UInt8](body[4..<body.count])
        }
        return NSNumber(value: Data(bytes: value).hex.hex_decimal)
    }

    private func DecodeString(header: UInt8, isByteString: Bool) -> NSString {
        let header = (isByteString) ? Int(header) % 64 : Int(header) % 96
        var len = 0
        var offset = 0
        get(len: &len, offset: &offset, header: header)

        let value = [UInt8](body[0..<len])
        let data = Data(bytes: value)
        self.body = [UInt8](body[value.count..<self.body.count])
        
        return ((isByteString) ? data.hex : data.string) as NSString
    }

    private func DecodeArray(header: UInt8) -> NSArray {
        let header = Int(header) % 128
        var len = 0
        var offset = 0
        get(len: &len, offset: &offset, header: header)

        var value = [NSObject]()
        for _ in 0..<len {
            let object = decode()
            value.append(object)
        }

        return value as NSArray
    }

    private func DecodeMap(header: UInt8) -> NSDictionary {
        let header = Int(header) % 160
        var len = 0
        var offset = 0
        get(len: &len, offset: &offset, header: header)

        var dict = Dictionary<NSObject, NSObject>()
        for _ in 0..<len {
            let key = decode()
            let value = decode()
            dict[key] = value
        }

        return dict as NSDictionary
    }

    private func DecodeSimpleValue(header: UInt8) -> NSNumber? {
        let header = Int(header) % 244
        return NSSimpleValue.decode(header: header)
    }
    
    private func get(len: inout Int, offset: inout Int, header: Int) {
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
        
        self.body = [UInt8](self.body[offset..<self.body.count])
    }
}

