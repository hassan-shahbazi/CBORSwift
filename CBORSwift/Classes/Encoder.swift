//
//  Encoder.swift
//  CBORSwift
//
//  Created by Hassaniiii on 5/2/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

class Encoder: NSObject {
    
    public class func encode(value: Data, header: Data) -> String {
        var encoded = [UInt8]()
        encoded.append(contentsOf: header.binary)
        encoded.append(contentsOf: [UInt8](value.binary[3..<value.count]))
        
        return Data(bytes: encoded).hex
    }
}
