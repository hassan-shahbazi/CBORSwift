//
//  CBORDecoderTests.swift
//  CBORSwiftTests
//
//  Created by Hassaniiii on 5/4/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import CBORSwift

class CBORDecoderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_1_identifyMajor() {
        let major = MajorTypes()
        
        var type:[UInt8] = [0x00, 0x00, 0x00]
        XCTAssertNotNil(major.identify(type))
        XCTAssertEqual(MajorType.major0, major.identify(type))
        
        type = [0x00, 0x00, 0x01]
        XCTAssertNotNil(major.identify(type))
        XCTAssertEqual(MajorType.major1, major.identify(type))
        
        type = [0x01, 0x00, 0x01]
        XCTAssertNotNil(major.identify(type))
        XCTAssertEqual(MajorType.major5, major.identify(type))
    }
    
    //MARK:- Unsigned integer decoding
    func test_2_decodeSimpleInt() {
        var decoded = CBOR.decode(bytes: [0x00])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(0, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x05])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(5, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x0A])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(10, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x10])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(16, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x17])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(23, (decoded as? NSNumber)?.intValue)
    }
    
    func test_3_decodeStage1Int() {
        var decoded = CBOR.decode(bytes: [0x18, 0x18])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(24, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x18, 0x19])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(25, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x18, 0x7D])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(125, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x18, 0xB2])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(178, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x18, 0xFF])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(255, (decoded as? NSNumber)?.intValue)
    }
    
    func test_4_decodeStage2Int() {
        var decoded = CBOR.decode(bytes: [0x19, 0x01, 0x00])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(256, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x19, 0x01, 0x2C])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(300, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x19, 0x04, 0xB0])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(1200, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x19, 0x0D, 0x64])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(3428, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x19, 0xFF, 0xDC])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(65500, (decoded as? NSNumber)?.intValue)
    }
    
    func test_5_decodeStage3Int() {
        var decoded = CBOR.decode(bytes: [0x1A, 0x00, 0x01, 0x00, 0x00])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(65536, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x1A, 0x02, 0x8F, 0x5A, 0xAF])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(42949295, (decoded as? NSNumber)?.intValue)
    }
    
    //MARK:- Negative integer encoding
    func test_2_decodeSimpleNeg() {
        var decoded = CBOR.decode(bytes: [0x20])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-1, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x26])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-7, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x2F])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-16, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x37])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-24, (decoded as? NSNumber)?.intValue)
    }
    
    func test_3_decodeStage1Neg() {
        var decoded = CBOR.decode(bytes: [0x38, 0x18])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-25, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x38, 0x5F])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-96, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x38, 0x9F])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-160, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x38, 0xFF])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-256, (decoded as? NSNumber)?.intValue)
    }
    
    func test_4_decodeStage2Neg() {
        var decoded = CBOR.decode(bytes: [0x39, 0x01, 0x00])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-257, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x39, 0x01, 0x7D])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-382, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x39, 0x0D, 0x63])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-3428, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x39, 0xFF, 0xDB])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-65500, (decoded as? NSNumber)?.intValue)
    }
    
    func test_5_decodeStage3Neg() {
        var decoded = CBOR.decode(bytes: [0x3A, 0x00, 0x01, 0x00, 0x00])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-65537, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(bytes: [0x3A, 0x02, 0x8F, 0x5A, 0xAE])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-42949295, (decoded as? NSNumber)?.intValue)
    }


    //MARK:- Text string encoding
    func test_2_decodeTextString() {
        var decoded = CBOR.decode(bytes: [0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F])
        XCTAssertNotNil(decoded)
        XCTAssertEqual("hello", decoded as? String)
        
        decoded = CBOR.decode(bytes: [0x78, 0x18, 0x61, 0x20, 0x73, 0x69, 0x6D, 0x70, 0x6C, 0x65, 0x20, 0x73,
                                      0x74, 0x72, 0x69, 0x6E, 0x67, 0x20, 0x77, 0x69, 0x74, 0x68, 0x20, 0x6C,
                                      0x65, 0x6E])
        XCTAssertNotNil(decoded)
        XCTAssertEqual("a simple string with len", decoded as? String)
        
        decoded = CBOR.decode(bytes: [0x78, 0x19, 0x61, 0x20, 0x73, 0x69, 0x6D, 0x70, 0x6C, 0x65, 0x20, 0x73,
                                      0x74, 0x72, 0x69, 0x6E, 0x67, 0x20, 0x77, 0x69, 0x74, 0x68, 0x20, 0x6C,
                                      0x65, 0x6E, 0x32])
        XCTAssertNotNil(decoded)
        XCTAssertEqual("a simple string with len2", decoded as? String)
        
        decoded = CBOR.decode(bytes: [0x78, 0x1C, 0x6C, 0x65, 0x74, 0x27, 0x73, 0x20, 0x64, 0x6F,
                                      0x20, 0x61, 0x20, 0x6D, 0x6F, 0x72, 0x65, 0x20, 0x63, 0x6F,
                                      0x6D, 0x70, 0x6C, 0x65, 0x78, 0x20, 0x74, 0x65, 0x73, 0x74])
        XCTAssertNotNil(decoded)
        XCTAssertEqual("let's do a more complex test", decoded as? String)
        
        decoded = CBOR.decode(bytes: [0x79, 0x01, 0x51, 0x61, 0x20, 0x73, 0x69, 0x6D, 0x70,
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
                                      0x20, 0x73, 0x74, 0x72, 0x69, 0x6E, 0x67])
        XCTAssertNotNil(decoded)
        XCTAssertEqual("a simple string with a large length, trying to test all possible situations. Thus, I have to double this string. a simple string with a large length, trying to test all possible situations. Thus, I have to double this string. a simple string with a large length, trying to test all possible situations. Thus, I have to double this string", decoded as? String)
    }
}
