//
//  CBOR.swift
//  CBORSwift
//
//  Created by Hassaniiii on 5/2/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

public class CBOR: NSObject {
    
    //MARK:- Encoder
    public class func encode(_ value: NSObject) -> [UInt8]? {
        return value.encode().data?.bytes
    }

    //MARK:- Decoder
    public class func decode(bytes value: [UInt8]) -> NSObject? {
        let decoder = Decoder(value)
        return decoder.decode()
    }
}
