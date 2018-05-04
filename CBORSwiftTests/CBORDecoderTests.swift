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
        var decoded = CBOR.decode(integer: [0x00])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(0, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x05])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(5, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x0A])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(10, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x10])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(16, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x17])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(23, (decoded as? NSNumber)?.intValue)
    }
    
    func test_3_decodeStage1Int() {
        var decoded = CBOR.decode(integer: [0x18, 0x18])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(24, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x18, 0x19])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(25, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x18, 0x7D])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(125, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x18, 0xB2])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(178, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x18, 0xFF])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(255, (decoded as? NSNumber)?.intValue)
    }
    
    func test_4_decodeStage2Int() {
        var decoded = CBOR.decode(integer: [0x19, 0x01, 0x00])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(256, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x19, 0x01, 0x2C])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(300, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x19, 0x04, 0xB0])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(1200, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x19, 0x0D, 0x64])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(3428, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x19, 0xFF, 0xDC])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(65500, (decoded as? NSNumber)?.intValue)
    }
    
    func test_5_decodeStage3Int() {
        var decoded = CBOR.decode(integer: [0x1A, 0x00, 0x01, 0x00, 0x00])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(65536, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x1A, 0x02, 0x8F, 0x5A, 0xAF])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(42949295, (decoded as? NSNumber)?.intValue)
    }
    
    //MARK:- Negative integer encoding
    func test_2_decodeSimpleNeg() {
        var decoded = CBOR.decode(integer: [0x20])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-1, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x26])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-7, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x2F])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-16, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x37])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-24, (decoded as? NSNumber)?.intValue)
    }
    
    func test_3_decodeStage1Neg() {
        var decoded = CBOR.decode(integer: [0x38, 0x18])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-25, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x38, 0x5F])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-96, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x38, 0x9F])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-160, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x38, 0xFF])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-256, (decoded as? NSNumber)?.intValue)
    }
    
    func test_4_decodeStage2Neg() {
        var decoded = CBOR.decode(integer: [0x39, 0x01, 0x00])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-257, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x39, 0x01, 0x7D])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-382, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x39, 0x0D, 0x63])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-3428, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x39, 0xFF, 0xDB])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-65500, (decoded as? NSNumber)?.intValue)
    }
    
    func test_5_decodeStage3Neg() {
        var decoded = CBOR.decode(integer: [0x3A, 0x00, 0x01, 0x00, 0x00])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-65537, (decoded as? NSNumber)?.intValue)
        
        decoded = CBOR.decode(integer: [0x3A, 0x02, 0x8F, 0x5A, 0xAE])
        XCTAssertNotNil(decoded)
        XCTAssertEqual(-42949295, (decoded as? NSNumber)?.intValue)
    }
}
