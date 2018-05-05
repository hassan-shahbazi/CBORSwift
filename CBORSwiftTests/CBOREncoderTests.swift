//
//  CBOREncoderTests.swift
//  CBORSwiftTests
//
//  Created by Hassaniiii on 5/4/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import CBORSwift

class CBOREncoderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //MARK:- Unsigned integer encoding
    func test_2_encodeSimpleInt() {
        var encoded = CBOR.encode(integer: NSNumber(value: 0))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x00], encoded)
        
        encoded = CBOR.encode(integer: NSNumber(value: 5))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x05], encoded)
        
        encoded = CBOR.encode(integer: NSNumber(value: 10))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x0A], encoded)
        
        encoded = CBOR.encode(integer: NSNumber(value: 16))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x10], encoded)
        
        encoded = CBOR.encode(integer: NSNumber(value: 23))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x17], encoded)
    }
    
    func test_3_encodeStage1Int() {
        var encoded = CBOR.encode(integer: NSNumber(value: 24))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x18, 0x18], encoded)
        
        encoded = CBOR.encode(integer: NSNumber(value: 25))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x18, 0x19], encoded)
        
        encoded = CBOR.encode(integer: NSNumber(value: 125))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x18, 0x7D], encoded)
        
        encoded = CBOR.encode(integer: NSNumber(value: 178))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x18, 0xB2], encoded)
        
        encoded = CBOR.encode(integer: NSNumber(value: 255))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x18, 0xFF], encoded)
    }
    
    func test_4_encodeStage2Int() {
        var encoded = CBOR.encode(integer: NSNumber(value: 256))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x19, 0x01, 0x00], encoded)
        
        encoded = CBOR.encode(integer: NSNumber(value: 300))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x19, 0x01, 0x2C], encoded)
        
        encoded = CBOR.encode(integer: NSNumber(value: 1200))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x19, 0x04, 0xB0], encoded)
        
        encoded = CBOR.encode(integer: NSNumber(value: 3428))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x19, 0x0D, 0x64], encoded)
        
        encoded = CBOR.encode(integer: NSNumber(value: 65500))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x19, 0xFF, 0xDC], encoded)
    }
    
    func test_5_encodeStage3Int() {
        var encoded = CBOR.encode(integer: NSNumber(value: 65536))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x1A, 0x00, 0x01, 0x00, 0x00], encoded)
        
        encoded = CBOR.encode(integer: NSNumber(value: 42949295))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x1A, 0x02, 0x8F, 0x5A, 0xAF], encoded)
    }
    
    //MARK:- Negative integer encoding
    func test_2_encodeSimpleNeg() {
        var encoded = CBOR.encode(negative: NSNumber(value: -1))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x20], encoded)
        
        encoded = CBOR.encode(negative: NSNumber(value: -7))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x26], encoded)
        
        encoded = CBOR.encode(negative: NSNumber(value: -16))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x2F], encoded)
        
        encoded = CBOR.encode(negative: NSNumber(value: -24))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x37], encoded)
    }
    
    func test_3_encodeStage1Neg() {
        var encoded = CBOR.encode(negative: NSNumber(value: -25))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x38, 0x18], encoded)
        
        encoded = CBOR.encode(negative: NSNumber(value: -96))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x38, 0x5F], encoded)
        
        encoded = CBOR.encode(negative: NSNumber(value: -160))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x38, 0x9F], encoded)
        
        encoded = CBOR.encode(negative: NSNumber(value: -256))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x38, 0xFF], encoded)
    }
    
    func test_4_encodeStage2Neg() {
        var encoded = CBOR.encode(negative: NSNumber(value: -257))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x39, 0x01, 0x00], encoded)
        
        encoded = CBOR.encode(negative: NSNumber(value: -382))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x39, 0x01, 0x7D], encoded)
        
        encoded = CBOR.encode(negative: NSNumber(value: -3428))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x39, 0x0D, 0x63], encoded)
        
        encoded = CBOR.encode(negative: NSNumber(value: -65500))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x39, 0xFF, 0xDB], encoded)
    }
    
    func test_5_encodeStage3Neg() {
        var encoded = CBOR.encode(negative: NSNumber(value: -65537))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x3A, 0x00, 0x01, 0x00, 0x00], encoded)
        
        encoded = CBOR.encode(negative: NSNumber(value: -42949295))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x3A, 0x02, 0x8F, 0x5A, 0xAE], encoded)
    }
    
    //MARK:- Byte string encoding
    func test_2_encodeByteString() {
        //        CBOR.encode(byteString: <#T##[String]#>)
    }
    
    //MARK:- Text string encoding
    func test_2_encodeTextString() {
        var encoded = CBOR.encode(textString: "hello")
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F], encoded)
        
        encoded = CBOR.encode(textString: "name")
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x64, 0x6E, 0x61, 0x6D, 0x65], encoded)
        
        encoded = CBOR.encode(textString: "let's do a more complex test")
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x78, 0x1C, 0x6C, 0x65, 0x74, 0x27, 0x73, 0x20, 0x64, 0x6F,
                        0x20, 0x61, 0x20, 0x6D, 0x6F, 0x72, 0x65, 0x20, 0x63, 0x6F,
                        0x6D, 0x70, 0x6C, 0x65, 0x78, 0x20, 0x74, 0x65, 0x73, 0x74], encoded)
        
        encoded = CBOR.encode(textString: "a simple string with a large length, trying to test all possible situations. Thus, I have to double this string. a simple string with a large length, trying to test all possible situations. Thus, I have to double this string. a simple string with a large length, trying to test all possible situations. Thus, I have to double this string")
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x79, 0x01, 0x51, 0x61, 0x20, 0x73, 0x69, 0x6D, 0x70,
                        0x6C, 0x65, 0x20, 0x73, 0x74, 0x72, 0x69, 0x6E, 0x67,
                        0x20, 0x77, 0x69, 0x74, 0x68, 0x20, 0x61, 0x20, 0x6C,
                        0x61, 0x72, 0x67, 0x65, 0x20, 0x6C, 0x65, 0x6E, 0x67,
                        0x74, 0x68, 0x2C, 0x20, 0x74, 0x72, 0x79, 0x69, 0x6E,
                        0x67, 0x20, 0x74, 0x6F, 0x20, 0x74, 0x65, 0x73, 0x74,
                        0x20, 0x61, 0x6C, 0x6C, 0x20, 0x70, 0x6F, 0x73, 0x73,
                        0x69, 0x62, 0x6C, 0x65, 0x20, 0x73, 0x69, 0x74, 0x75,
                        0x61, 0x74, 0x69, 0x6F, 0x6E, 0x73, 0x2E, 0x20, 0x54,
                        0x68, 0x75, 0x73, 0x2C, 0x20, 0x49, 0x20, 0x68, 0x61,
                        0x76, 0x65, 0x20, 0x74, 0x6F, 0x20, 0x64, 0x6F, 0x75,
                        0x62, 0x6C, 0x65, 0x20, 0x74, 0x68, 0x69, 0x73, 0x20,
                        0x73, 0x74, 0x72, 0x69, 0x6E, 0x67, 0x2E, 0x20, 0x61,
                        0x20, 0x73, 0x69, 0x6D, 0x70, 0x6C, 0x65, 0x20, 0x73,
                        0x74, 0x72, 0x69, 0x6E, 0x67, 0x20, 0x77, 0x69, 0x74,
                        0x68, 0x20, 0x61, 0x20, 0x6C, 0x61, 0x72, 0x67, 0x65,
                        0x20, 0x6C, 0x65, 0x6E, 0x67, 0x74, 0x68, 0x2C, 0x20,
                        0x74, 0x72, 0x79, 0x69, 0x6E, 0x67, 0x20, 0x74, 0x6F,
                        0x20, 0x74, 0x65, 0x73, 0x74, 0x20, 0x61, 0x6C, 0x6C,
                        0x20, 0x70, 0x6F, 0x73, 0x73, 0x69, 0x62, 0x6C, 0x65,
                        0x20, 0x73, 0x69, 0x74, 0x75, 0x61, 0x74, 0x69, 0x6F,
                        0x6E, 0x73, 0x2E, 0x20, 0x54, 0x68, 0x75, 0x73, 0x2C,
                        0x20, 0x49, 0x20, 0x68, 0x61, 0x76, 0x65, 0x20, 0x74,
                        0x6F, 0x20, 0x64, 0x6F, 0x75, 0x62, 0x6C, 0x65, 0x20,
                        0x74, 0x68, 0x69, 0x73, 0x20, 0x73, 0x74, 0x72, 0x69,
                        0x6E, 0x67, 0x2E, 0x20, 0x61, 0x20, 0x73, 0x69, 0x6D,
                        0x70, 0x6C, 0x65, 0x20, 0x73, 0x74, 0x72, 0x69, 0x6E,
                        0x67, 0x20, 0x77, 0x69, 0x74, 0x68, 0x20, 0x61, 0x20,
                        0x6C, 0x61, 0x72, 0x67, 0x65, 0x20, 0x6C, 0x65, 0x6E,
                        0x67, 0x74, 0x68, 0x2C, 0x20, 0x74, 0x72, 0x79, 0x69,
                        0x6E, 0x67, 0x20, 0x74, 0x6F, 0x20, 0x74, 0x65, 0x73,
                        0x74, 0x20, 0x61, 0x6C, 0x6C, 0x20, 0x70, 0x6F, 0x73,
                        0x73, 0x69, 0x62, 0x6C, 0x65, 0x20, 0x73, 0x69, 0x74,
                        0x75, 0x61, 0x74, 0x69, 0x6F, 0x6E, 0x73, 0x2E, 0x20,
                        0x54, 0x68, 0x75, 0x73, 0x2C, 0x20, 0x49, 0x20, 0x68,
                        0x61, 0x76, 0x65, 0x20, 0x74, 0x6F, 0x20, 0x64, 0x6F,
                        0x75, 0x62, 0x6C, 0x65, 0x20, 0x74, 0x68, 0x69, 0x73,
                        0x20, 0x73, 0x74, 0x72, 0x69, 0x6E, 0x67], encoded)
    }
    
    //MARK:- Array encoding
    func test_2_encodeStringArray() {
        var encoded = CBOR.encode(array: ["hello"])
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x81, 0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F], encoded)
        
        encoded = CBOR.encode(array: ["hello", "my", "friend"])
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x83, 0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F,
                        0x62, 0x6D, 0x79,
                        0x66, 0x66, 0x72, 0x69, 0x65, 0x6E, 0x64], encoded)
        
        var array = [String]()
        for _ in 0..<8 {
            array.append("hello")
            array.append("my")
            array.append("friend")
        }
        
        var hexArray:[UInt8] = [0x98, 0x18]
        for _ in 0..<8 {
            hexArray.append(contentsOf: [0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F])
            hexArray.append(contentsOf: [0x62, 0x6D, 0x79])
            hexArray.append(contentsOf: [0x66, 0x66, 0x72, 0x69, 0x65, 0x6E, 0x64])
        }
        
        encoded = CBOR.encode(array: array as NSArray)
        XCTAssertNotNil(encoded)
        XCTAssertEqual(hexArray, encoded)
    }
    
    func test_3_encodeNumberArray() {
        var encoded = CBOR.encode(array: [10])
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x81, 0x0A], encoded)
        
        encoded = CBOR.encode(array: [10, 15, -9])
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x83, 0x0A, 0x0F, 0x28], encoded)
    }
    
    func test_4_encodeArrayArray() {
        var encoded = CBOR.encode(array: [[10]])
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x81, 0x81, 0x0A], encoded)
        
        encoded = CBOR.encode(array: [[10], [-9, 0]])
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x82, 0x81, 0x0A, 0x82, 0x28, 0x00], encoded)
    }
    
    func test_5_encodeMapArray() {
        let encoded = CBOR.encode(array: [["surename":"shahbazi", "name":"hassan", "age":27]])
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x81, 0xA3, 0x63, 0x61, 0x67, 0x65,
                        0x18, 0x1B,
                        0x64, 0x6E, 0x61, 0x6D, 0x65,
                        0x66, 0x68, 0x61, 0x73, 0x73, 0x61, 0x6E,
                        0x68, 0x73, 0x75, 0x72, 0x65, 0x6E, 0x61, 0x6D, 0x65,
                        0x68, 0x73, 0x68, 0x61, 0x68, 0x62, 0x61, 0x7A, 0x69], encoded)
        
    }
    
    //MARK: Map encoding
    func test_2_encodeMap() {
        var encoded = CBOR.encode(map: ["hello": "world"])
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0xA1, 0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F,
                        0x65, 0x77, 0x6F, 0x72, 0x6C, 0x64], encoded)
        
        encoded = CBOR.encode(map: ["sure":"shahbazi", "name":"hassan"])
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0xA2, 0x64, 0x6E, 0x61, 0x6D, 0x65,
                        0x66, 0x68, 0x61, 0x73, 0x73, 0x61, 0x6E,
                        0x64, 0x73, 0x75, 0x72, 0x65,
                        0x68, 0x73, 0x68, 0x61, 0x68, 0x62, 0x61, 0x7A, 0x69], encoded)
        
        encoded = CBOR.encode(map: ["item0": 127, "item1": "string", 5: "number", 18: 98])
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0xA4, 0x05, 0x66, 0x6E, 0x75, 0x6D, 0x62, 0x65, 0x72,
                        0x12, 0x18, 0x62,
                        0x65, 0x69, 0x74, 0x65, 0x6D, 0x30,
                        0x18, 0x7F,
                        0x65, 0x69, 0x74, 0x65, 0x6D, 0x31,
                        0x66, 0x73, 0x74, 0x72, 0x69, 0x6E, 0x67], encoded)
    }
    
    func test_3_sortMapItems() {
        let dict: Dictionary = ["67": "776f726c64", "65": "68656c6c6f"]
        let sorted = dict.valueKeySorted
        
        XCTAssertEqual(sorted[0].1, "68656c6c6f")
        XCTAssertEqual(sorted[1].1, "776f726c64")
    }
    
}
