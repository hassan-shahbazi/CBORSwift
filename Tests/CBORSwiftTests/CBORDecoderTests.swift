//
//  CBORDecoderTests.swift
//  CBORSwiftTests
//
//  Created by Hassan Shahbazi on 5/4/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import CBORSwift

// All tests are verified using http://cbor.me/ tool
class CBORDecoderTests: XCTestCase {
    
    func testGeteMajorType() {
        let type1 = MajorType.typeEnum([0x00, 0x00, 0x00])
        XCTAssertNotNil(type1)
        XCTAssertEqual(MajorTypes.major0, type1)
        
        let type2 = MajorType.typeEnum([0x00, 0x00, 0x01])
        XCTAssertNotNil(type2)
        XCTAssertEqual(MajorTypes.major1, type2)
        
        let type3 = MajorType.typeEnum([0x01, 0x00, 0x01])
        XCTAssertNotNil(type3)
        XCTAssertEqual(MajorTypes.major5, type3)
    }
    
    //MARK:- Unsigned integer decoding
    func testDecodeSimpleInt() {
        guard let decoded1 = try? CBOR.decode([0x00]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded1)
        XCTAssertEqual(0, decoded1 as? Int)
        
        guard let decoded2 = try? CBOR.decode([0x05]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded2)
        XCTAssertEqual(5, decoded2 as? Int)
        
        guard let decoded3 = try? CBOR.decode([0x0A]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded3)
        XCTAssertEqual(10, decoded3 as? Int)
        
        guard let decoded4 = try? CBOR.decode([0x10]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded4)
        XCTAssertEqual(16, decoded4 as? Int)

        guard let decoded5 = try? CBOR.decode([0x17]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded5)
        XCTAssertEqual(23, decoded5 as? Int)
    }
  
    func testDecodeStage1Int() {
        guard let decoded1 = try? CBOR.decode([0x18, 0x18]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded1)
        XCTAssertEqual(24, decoded1 as? Int)

        guard let decoded2 = try? CBOR.decode([0x18, 0x19]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded2)
        XCTAssertEqual(25, decoded2 as? Int)
        
        guard let decoded3 = try? CBOR.decode([0x18, 0x7D]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded3)
        XCTAssertEqual(125, decoded3 as? Int)

        guard let decoded4 = try? CBOR.decode([0x18, 0xB2]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded4)
        XCTAssertEqual(178, decoded4 as? Int)

        guard let decoded5 = try? CBOR.decode([0x18, 0xFF]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded5)
        XCTAssertEqual(255, decoded5 as? Int)
    }

    func testDecodeStage2Int() {
        guard let decoded1 = try? CBOR.decode([0x19, 0x01, 0x00]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded1)
        XCTAssertEqual(256, decoded1 as? Int)

        guard let decoded2 = try? CBOR.decode([0x19, 0x01, 0x2C]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded2)
        XCTAssertEqual(300, decoded2 as? Int)

        guard let decoded3 = try? CBOR.decode([0x19, 0x04, 0xB0]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded3)
        XCTAssertEqual(1200, decoded3 as? Int)

        guard let decoded4 = try? CBOR.decode([0x19, 0x0D, 0x64]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded4)
        XCTAssertEqual(3428, decoded4 as? Int)

        guard let decoded5 = try? CBOR.decode([0x19, 0xFF, 0xDC]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded5)
        XCTAssertEqual(65500, decoded5 as? Int)
    }
   
    func testDecodeStage3Int() {
        guard let decoded1 = try? CBOR.decode([0x1A, 0x00, 0x01, 0x00, 0x00]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded1)
        XCTAssertEqual(65536, decoded1 as? Int)

        guard let decoded2 = try? CBOR.decode([0x1A, 0x02, 0x8F, 0x5A, 0xAF]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded2)
        XCTAssertEqual(42949295, decoded2 as? Int)
    }

    //MARK:- Negative integer decoding
    func testDecodeSimpleNeg() {
        guard let decoded1 = try? CBOR.decode([0x20]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded1)
        XCTAssertEqual(-1, decoded1 as? Int)

        guard let decoded2 = try? CBOR.decode([0x26]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded2)
        XCTAssertEqual(-7, decoded2 as? Int)

        guard let decoded3 = try? CBOR.decode([0x2F]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded3)
        XCTAssertEqual(-16, decoded3 as? Int)

        guard let decoded4 = try? CBOR.decode([0x37]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded4)
        XCTAssertEqual(-24, decoded4 as? Int)
    }
    
    func testDecodeStage1Neg() {
        guard let decoded1 = try? CBOR.decode([0x38, 0x18]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded1)
        XCTAssertEqual(-25, decoded1 as? Int)

        guard let decoded2 = try? CBOR.decode([0x38, 0x5F]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded2)
        XCTAssertEqual(-96, decoded2 as? Int)

        guard let decoded3 = try? CBOR.decode([0x38, 0x9F]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded3)
        XCTAssertEqual(-160, decoded3 as? Int)

        guard let decoded4 = try? CBOR.decode([0x38, 0xFF]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded4)
        XCTAssertEqual(-256, decoded4 as? Int)
    }
    
    func testDecodeStage2Neg() {
        guard let decoded1 = try? CBOR.decode([0x39, 0x01, 0x00]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded1)
        XCTAssertEqual(-257, decoded1 as? Int)

        guard let decoded2 = try? CBOR.decode([0x39, 0x01, 0x7D]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded2)
        XCTAssertEqual(-382, decoded2 as? Int)

        guard let decoded3 = try? CBOR.decode([0x39, 0x0D, 0x63]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded3)
        XCTAssertEqual(-3428, decoded3 as? Int)

        guard let decoded4 = try? CBOR.decode([0x39, 0xFF, 0xDB]) else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded4)
        XCTAssertEqual(-65500, decoded4 as? Int)
    }

    func testDecodeStage3Neg() {
        guard let decoded1 = try? CBOR.decode([0x3A, 0x00, 0x01, 0x00, 0x00]) as Int else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded1)
        XCTAssertEqual(-65537, decoded1)

        guard let decoded2 = try? CBOR.decode([0x3A, 0x02, 0x8F, 0x5A, 0xAE]) as Int else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded2)
        XCTAssertEqual(-42949295, decoded2)
    }

    //MARK:- Byte string dencoding
    func testDecodeByteString() {
        guard let decoded1 = try? CBOR.decode([0x42, 0x25, 0x25]) as ByteString else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded1)
        XCTAssertEqual(ByteString("2525"), decoded1)

        guard let decoded2 = try? CBOR.decode([0x44, 0x25, 0x25, 0x30, 0x15]) as ByteString else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded2)
        XCTAssertEqual(ByteString("25253015"), decoded2)

        guard let decoded3 = try? CBOR.decode([0x48, 0x33, 0x30, 0x38, 0x32, 0x30, 0x31, 0x39, 0x33]) as ByteString else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded3)
        XCTAssertEqual(ByteString("3330383230313933"), decoded3)
    }

    //MARK:- Text string decoding
    func testDecodeTextString() {
        guard let decoded1 = try? CBOR.decode([0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F]) as String else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded1)
        XCTAssertEqual("hello", decoded1)

        guard let decoded2 = try? CBOR.decode([0x78, 0x18, 0x61, 0x20, 0x73, 0x69, 0x6D, 0x70, 0x6C, 0x65, 0x20, 0x73,
                                      0x74, 0x72, 0x69, 0x6E, 0x67, 0x20, 0x77, 0x69, 0x74, 0x68, 0x20, 0x6C,
                                      0x65, 0x6E]) as String else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded2)
        XCTAssertEqual("a simple string with len", decoded2)

        guard let decoded3 = try? CBOR.decode([0x79, 0x01, 0x51, 0x61, 0x20, 0x73, 0x69, 0x6D, 0x70,
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
                                      0x20, 0x73, 0x74, 0x72, 0x69, 0x6E, 0x67]) as String else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded3)
        XCTAssertEqual("a simple string with a large length, trying to test all possible situations. Thus, I have to double this string. a simple string with a large length, trying to test all possible situations. Thus, I have to double this string. a simple string with a large length, trying to test all possible situations. Thus, I have to double this string", decoded3)
    }

    //MARK:- Array decoding
    func testDecodeStringArray() {
        guard let decoded1 = try? CBOR.decode([0x81, 0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F]) as [String] else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded1)
        XCTAssertEqual(["hello"], decoded1)

        guard let decoded2 = try? CBOR.decode([0x83, 0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F,
                                                0x62, 0x6D, 0x79,
                                                0x66, 0x66, 0x72, 0x69, 0x65, 0x6E, 0x64]) as [String] else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded2)
        XCTAssertEqual(["hello", "my", "friend"], decoded2)
    }
    
    func test_3_decodeNumberArray() {
        guard let decoded1 = try? CBOR.decode([0x81, 0x0A]) as [Int] else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded1)
        XCTAssertEqual([10], decoded1)

        guard let decoded2 = try? CBOR.decode([0x83, 0x0A, 0x0F, 0x28]) as [Int] else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded2)
        XCTAssertEqual([10, 15, -9], decoded2)
    }
    
    func test_3_decodeArrayArray() {
        guard let decoded1 = try? CBOR.decode([0x81, 0x81, 0x0A]) as [[Int]] else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded1)
        XCTAssertEqual([[10]], decoded1)
        
        guard let decoded2 = try? CBOR.decode([0x82, 0x81, 0x0A, 0x82, 0x28, 0x00]) as [[Int]] else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded2)
        XCTAssertEqual([[10], [-9, 0]], decoded2)
    }
/*
    //MARK:- Map decoding
    func test_2_decodeMap() {
        var decoded = CBOR.decode([0xA1, 0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F,
                                          0x65, 0x77, 0x6F, 0x72, 0x6C, 0x64])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(["hello": "world"], decoded as? NSDictionary)

        decoded = CBOR.decode([0xA2, 0x64, 0x6E, 0x61, 0x6D, 0x65,
                                      0x66, 0x68, 0x61, 0x73, 0x73, 0x61, 0x6E,
                                      0x64, 0x73, 0x75, 0x72, 0x65,
                                      0x68, 0x73, 0x68, 0x61, 0x68, 0x62, 0x61, 0x7A, 0x69])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(["sure":"shahbazi", "name":"hassan"], decoded as? NSDictionary)

        decoded = CBOR.decode([0xA4, 0x05, 0x66, 0x6E, 0x75, 0x6D, 0x62, 0x65, 0x72,
                                      0x12, 0x18, 0x62,
                                      0x65, 0x69, 0x74, 0x65, 0x6D, 0x30,
                                      0x18, 0x7F,
                                      0x65, 0x69, 0x74, 0x65, 0x6D, 0x31,
                                      0x66, 0x73, 0x74, 0x72, 0x69, 0x6E, 0x67])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(["item0": 127, "item1": "string", 5: "number", 18: 98], decoded as? NSDictionary)
    }

    //MARK:- Tagged Value decoding
    func test_2_decodeTaggedValue() {
        var decoded = CBOR.decode([0xC5, 0x0A])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(5, (decoded as? NSTag)?.tagValue())
        XCTAssertEqual(NSNumber(value: 10), (decoded as? NSTag)?.objectValue())
        
        decoded = CBOR.decode([0xD9, 0x02, 0x6D, 0x18, 0xE9])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(621, (decoded as? NSTag)?.tagValue())
        XCTAssertEqual(NSNumber(value: 233), (decoded as? NSTag)?.objectValue())
        
        decoded = CBOR.decode([0xDA, 0x00, 0x01, 0x22, 0x3c,
                               0xA2, 0x64, 0x6E, 0x61, 0x6D, 0x65,
                               0x66, 0x68, 0x61, 0x73, 0x73, 0x61, 0x6E,
                               0x64, 0x73, 0x75, 0x72, 0x65,
                               0x68, 0x73, 0x68, 0x61, 0x68, 0x62, 0x61, 0x7A, 0x69])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(74300, (decoded as? NSTag)?.tagValue())
        XCTAssertEqual(["sure":"shahbazi", "name":"hassan"] as NSDictionary, (decoded as? NSTag)?.objectValue())
        
        decoded = CBOR.decode([0xD9, 0x03, 0x99,
                               0x58, 0x20,
                               0x68, 0x71, 0x34, 0x96, 0x82, 0x22, 0xEC, 0x17, 0x20, 0x2E,
                               0x42, 0x50, 0x5F, 0x8E, 0xD2, 0xB1, 0x6A, 0xE2, 0x2F, 0x16,
                               0xBB, 0x05, 0xB8, 0x8C, 0x25, 0xDB, 0x9E, 0x60, 0x26, 0x45, 0xF1, 0x41])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(921, (decoded as? NSTag)?.tagValue())
        XCTAssertEqual("687134968222EC17202E42505F8ED2B16AE22F16BB05B88C25DB9E602645F141".lowercased() as NSString, (decoded as? NSTag)?.objectValue())
    }
 */

    //MARK:- Simple Value encoding
    func testDecodeSimpleBool() {
        guard let decoded1 = try? CBOR.decode([0xF4]) as Bool else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded1)
        XCTAssertFalse(decoded1)

        guard let decoded2 = try? CBOR.decode([0xF5]) as Bool else {
            return XCTFail()
        }
        XCTAssertNotNil(decoded2)
        XCTAssertTrue(decoded2)
    }

}
