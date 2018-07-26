//
//  CBOREncoderTests.swift
//  CBORSwiftTests
//
//  Created by Hassan Shahbazi on 5/4/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import CBORSwift

// All tests are verified using http://cbor.me/ tool
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
        var encoded = CBOR.encode(NSNumber(value: 0))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x00], encoded)
        
        encoded = CBOR.encode(NSNumber(value: 5))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x05], encoded)
        
        encoded = CBOR.encode(NSNumber(value: 10))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x0A], encoded)
        
        encoded = CBOR.encode(NSNumber(value: 16))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x10], encoded)
        
        encoded = CBOR.encode(NSNumber(value: 23))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x17], encoded)
    }
    
    func test_3_encodeStage1Int() {
        var encoded = CBOR.encode(NSNumber(value: 24))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x18, 0x18], encoded)
        
        encoded = CBOR.encode(NSNumber(value: 25))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x18, 0x19], encoded)
        
        encoded = CBOR.encode(NSNumber(value: 125))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x18, 0x7D], encoded)
        
        encoded = CBOR.encode(NSNumber(value: 178))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x18, 0xB2], encoded)
        
        encoded = CBOR.encode(NSNumber(value: 255))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x18, 0xFF], encoded)
    }
    
    func test_4_encodeStage2Int() {
        var encoded = CBOR.encode(NSNumber(value: 256))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x19, 0x01, 0x00], encoded)
        
        encoded = CBOR.encode(NSNumber(value: 300))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x19, 0x01, 0x2C], encoded)
        
        encoded = CBOR.encode(NSNumber(value: 1200))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x19, 0x04, 0xB0], encoded)
        
        encoded = CBOR.encode(NSNumber(value: 3428))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x19, 0x0D, 0x64], encoded)
        
        encoded = CBOR.encode(NSNumber(value: 65500))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x19, 0xFF, 0xDC], encoded)
    }
    
    func test_5_encodeStage3Int() {
        var encoded = CBOR.encode(NSNumber(value: 65536))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x1A, 0x00, 0x01, 0x00, 0x00], encoded)
        
        encoded = CBOR.encode(NSNumber(value: 42949295))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x1A, 0x02, 0x8F, 0x5A, 0xAF], encoded)
    }
    
    func test_6_encodeBigIntegers() {
        var encoded = CBOR.encode(NSNumber(value: 1531842146400))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x1B, 0x00, 0x00, 0x01, 0x64, 0xA8, 0xE8, 0x30, 0x60], encoded)
        
        encoded = CBOR.encode(NSNumber(value: 999999999999999999))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x1B, 0x0D, 0xE0, 0xB6, 0xB3, 0xA7, 0x63, 0xFF, 0xFF], encoded)
    }
    
    //MARK:- Negative integer encoding
    func test_2_encodeSimpleNeg() {
        var encoded = CBOR.encode(NSNumber(value: -1))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x20], encoded)
        
        encoded = CBOR.encode(NSNumber(value: -7))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x26], encoded)
        
        encoded = CBOR.encode(NSNumber(value: -16))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x2F], encoded)
        
        encoded = CBOR.encode(NSNumber(value: -24))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x37], encoded)
    }
    
    func test_3_encodeStage1Neg() {
        var encoded = CBOR.encode(NSNumber(value: -25))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x38, 0x18], encoded)
        
        encoded = CBOR.encode(NSNumber(value: -96))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x38, 0x5F], encoded)
        
        encoded = CBOR.encode(NSNumber(value: -160))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x38, 0x9F], encoded)
        
        encoded = CBOR.encode(NSNumber(value: -256))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x38, 0xFF], encoded)
    }
    
    func test_4_encodeStage2Neg() {
        var encoded = CBOR.encode(NSNumber(value: -257))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x39, 0x01, 0x00], encoded)
        
        encoded = CBOR.encode(NSNumber(value: -382))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x39, 0x01, 0x7D], encoded)
        
        encoded = CBOR.encode(NSNumber(value: -3428))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x39, 0x0D, 0x63], encoded)
        
        encoded = CBOR.encode(NSNumber(value: -65500))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x39, 0xFF, 0xDB], encoded)
    }
    
    func test_5_encodeStage3Neg() {
        var encoded = CBOR.encode(NSNumber(value: -65537))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x3A, 0x00, 0x01, 0x00, 0x00], encoded)
        
        encoded = CBOR.encode(NSNumber(value: -42949295))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x3A, 0x02, 0x8F, 0x5A, 0xAE], encoded)
    }
    
    //MARK:- Byte string encoding
    func test_2_encodeByteString() {
        var str = NSByteString("2525")
        var encoded = CBOR.encode(str)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x42, 0x25, 0x25], encoded)
        
        str = NSByteString("25253015")
        encoded = CBOR.encode(str)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x44, 0x25, 0x25, 0x30, 0x15], encoded)
        
        str = NSByteString("687134968222EC17202E42505F8ED2B16AE22F16BB05B88C25DB9E602645F141")
        encoded = CBOR.encode(str)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x58, 0x20, 0x68, 0x71, 0x34, 0x96, 0x82, 0x22,
                        0xEC, 0x17, 0x20, 0x2E, 0x42, 0x50, 0x5F, 0x8E, 0xD2, 0xB1,
                        0x6A, 0xE2, 0x2F, 0x16, 0xBB, 0x05, 0xB8, 0x8C, 0x25, 0xDB,
                        0x9E, 0x60, 0x26, 0x45, 0xF1, 0x41], encoded)
    }
    
    //MARK:- Text string encoding
    func test_2_encodeTextString() {
        var encoded = CBOR.encode("hello" as NSString)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F], encoded)
        
        encoded = CBOR.encode("name" as NSString)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x64, 0x6E, 0x61, 0x6D, 0x65], encoded)
        
        encoded = CBOR.encode("let's do a more complex test" as NSString)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x78, 0x1C, 0x6C, 0x65, 0x74, 0x27, 0x73, 0x20, 0x64, 0x6F,
                        0x20, 0x61, 0x20, 0x6D, 0x6F, 0x72, 0x65, 0x20, 0x63, 0x6F,
                        0x6D, 0x70, 0x6C, 0x65, 0x78, 0x20, 0x74, 0x65, 0x73, 0x74], encoded)
        
        encoded = CBOR.encode("a simple string with a large length, trying to test all possible situations. Thus, I have to double this string. a simple string with a large length, trying to test all possible situations. Thus, I have to double this string. a simple string with a large length, trying to test all possible situations. Thus, I have to double this string"  as NSString)
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
        var encoded = CBOR.encode(["hello"] as NSArray)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x81, 0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F], encoded)
        
        encoded = CBOR.encode(["hello", "my", "friend"] as NSArray)
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
        
        encoded = CBOR.encode(array as NSArray)
        XCTAssertNotNil(encoded)
        XCTAssertEqual(hexArray, encoded)
    }
    
    func test_3_encodeNumberArray() {
        var encoded = CBOR.encode([10] as NSArray)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x81, 0x0A], encoded)
        
        encoded = CBOR.encode([10, 15, -9] as NSArray)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x83, 0x0A, 0x0F, 0x28], encoded)
    }
    
    func test_4_encodeArrayArray() {
        var encoded = CBOR.encode([[10]] as NSArray)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x81, 0x81, 0x0A], encoded)
        
        encoded = CBOR.encode([[10], [-9, 0]] as NSArray)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x82, 0x81, 0x0A, 0x82, 0x28, 0x00], encoded)
    }
    
    func test_5_encodeMapArray() {
        let encoded = CBOR.encode([["surename":"shahbazi", "name":"hassan", "age":27]] as NSArray)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x81, 0xA3, 0x63, 0x61, 0x67, 0x65,
                        0x18, 0x1B,
                        0x64, 0x6E, 0x61, 0x6D, 0x65,
                        0x66, 0x68, 0x61, 0x73, 0x73, 0x61, 0x6E,
                        0x68, 0x73, 0x75, 0x72, 0x65, 0x6E, 0x61, 0x6D, 0x65,
                        0x68, 0x73, 0x68, 0x61, 0x68, 0x62, 0x61, 0x7A, 0x69], encoded)
        
    }
    
    //MARK:- Map encoding
    func test_2_encodeMap() {
        var encoded = CBOR.encode(["hello": "world"] as NSDictionary)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0xA1, 0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F,
                        0x65, 0x77, 0x6F, 0x72, 0x6C, 0x64], encoded)
        
        encoded = CBOR.encode(["sure":"shahbazi", "name":"hassan"] as NSDictionary)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0xA2, 0x64, 0x6E, 0x61, 0x6D, 0x65,
                        0x66, 0x68, 0x61, 0x73, 0x73, 0x61, 0x6E,
                        0x64, 0x73, 0x75, 0x72, 0x65,
                        0x68, 0x73, 0x68, 0x61, 0x68, 0x62, 0x61, 0x7A, 0x69], encoded)
        
        encoded = CBOR.encode(["item0": 127, "item1": "string", 5: "number", 18: 98] as NSDictionary)
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
    
    //MARK:- Tagged Value encoding
    func test_2_encodeTaggedValue() {
        var tag = NSTag(tag: 5, NSNumber(value: 10))
        var encoded = CBOR.encode(tag)
        XCTAssertEqual(encoded, [0xC5, 0x0A])
        
        tag = NSTag(tag: 921, NSByteString("687134968222EC17202E42505F8ED2B16AE22F16BB05B88C25DB9E602645F141"))
        encoded = CBOR.encode(tag)
        XCTAssertEqual(encoded, [0xD9, 0x03, 0x99,
                                 0x58, 0x20,
                                 0x68, 0x71, 0x34, 0x96, 0x82, 0x22, 0xEC, 0x17, 0x20, 0x2E,
                                 0x42, 0x50, 0x5F, 0x8E, 0xD2, 0xB1, 0x6A, 0xE2, 0x2F, 0x16,
                                 0xBB, 0x05, 0xB8, 0x8C, 0x25, 0xDB, 0x9E, 0x60, 0x26, 0x45, 0xF1, 0x41])
        
        tag = NSTag(tag: 74300, ["sure":"shahbazi", "name":"hassan"] as NSDictionary)
        encoded = CBOR.encode(tag)
        XCTAssertEqual(encoded, [0xDA, 0x00, 0x01, 0x22, 0x3c,
                                 0xA2, 0x64, 0x6E, 0x61, 0x6D, 0x65,
                                 0x66, 0x68, 0x61, 0x73, 0x73, 0x61, 0x6E,
                                 0x64, 0x73, 0x75, 0x72, 0x65,
                                 0x68, 0x73, 0x68, 0x61, 0x68, 0x62, 0x61, 0x7A, 0x69])
        
        tag = NSTag(tag: -2, NSNumber(value: 10))
        XCTAssertEqual(tag.encode(), [])
    }
    
    //MARK:- Simple Value encoding
    func test_2_encodeSimpleBool() {
        var encoded = CBOR.encode(NSSimpleValue(false))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0xF4], encoded)
        
        encoded = CBOR.encode(NSSimpleValue(true))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0xF5], encoded)
        
        encoded = CBOR.encode(NSSimpleValue(nil))
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0xF6], encoded)
    }

}
