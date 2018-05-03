//
//  CBORSwiftTests.swift
//  CBORSwiftTests
//
//  Created by Hassaniiii on 5/2/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import CBORSwift

class CBORSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_0_framework() {
        XCTAssertTrue(true)
    }
    
    func test_1_setMajorType() {
        let major = MajorTypes()
        major.set(type: .major0)
        XCTAssertEqual(Data(bytes: [0x00, 0x00, 0x00]), major.get())
        
        major.set(type: .major1)
        XCTAssertEqual(Data(bytes: [0x00, 0x00, 0x01]), major.get())
        
        major.set(type: .major5)
        XCTAssertEqual(Data(bytes: [0x01, 0x00, 0x01]), major.get())
    }
    
    func test_2_encodeSimpleInt() {
        var encoded = CBOR.encode(integer: NSNumber(value: 0))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("0", encoded)
        XCTAssertEqual([0x00], encoded.data?.binary)
        
        encoded = CBOR.encode(integer: NSNumber(value: 5))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("5", encoded)
        XCTAssertEqual([0x05], encoded.data?.binary)
        
        encoded = CBOR.encode(integer: NSNumber(value: 10))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("A", encoded)
        XCTAssertEqual([0x0A], encoded.data?.binary)
        
        encoded = CBOR.encode(integer: NSNumber(value: 16))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("10", encoded)
        XCTAssertEqual([0x10], encoded.data?.binary)

        encoded = CBOR.encode(integer: NSNumber(value: 23))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("17", encoded)
        XCTAssertEqual([0x17], encoded.data?.binary)
    }
    
    func test_3_encodeStage1Int() {
        var encoded = CBOR.encode(integer: NSNumber(value: 24))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("1818", encoded)
        XCTAssertEqual([0x18, 0x18], encoded.data?.binary)
        
        encoded = CBOR.encode(integer: NSNumber(value: 25))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("1819", encoded)
        XCTAssertEqual([0x18, 0x19], encoded.data?.binary)
        
        encoded = CBOR.encode(integer: NSNumber(value: 125))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("187D", encoded)
        XCTAssertEqual([0x18, 0x7D], encoded.data?.binary)
        
        encoded = CBOR.encode(integer: NSNumber(value: 178))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("18B2", encoded)
        XCTAssertEqual([0x18, 0xB2], encoded.data?.binary)
        
        encoded = CBOR.encode(integer: NSNumber(value: 255))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("18FF", encoded)
        XCTAssertEqual([0x18, 0xFF], encoded.data?.binary)
    }
    
    func test_4_encodeStage2Int() {
        var encoded = CBOR.encode(integer: NSNumber(value: 256))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("190100", encoded)
        XCTAssertEqual([0x19, 0x01, 0x00], encoded.data?.binary)

        encoded = CBOR.encode(integer: NSNumber(value: 300))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("19012C", encoded)
        XCTAssertEqual([0x19, 0x01, 0x2C], encoded.data?.binary)

        encoded = CBOR.encode(integer: NSNumber(value: 1200))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("1904B0", encoded)
        XCTAssertEqual([0x19, 0x04, 0xB0], encoded.data?.binary)

        encoded = CBOR.encode(integer: NSNumber(value: 3428))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("190D64", encoded)
        XCTAssertEqual([0x19, 0x0D, 0x64], encoded.data?.binary)

        encoded = CBOR.encode(integer: NSNumber(value: 65500))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("19FFDC", encoded)
        XCTAssertEqual([0x19, 0xFF, 0xDC], encoded.data?.binary)
    }

    func test_5_encodeStage3Int() {
        var encoded = CBOR.encode(integer: NSNumber(value: 65536))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("1A00010000", encoded)
        XCTAssertEqual([0x1A, 0x00, 0x01, 0x00, 0x00], encoded.data?.binary)

        encoded = CBOR.encode(integer: NSNumber(value: 42949295))
        XCTAssertNotNil(encoded)
        XCTAssertEqual("1A028F5AAF", encoded)
        XCTAssertEqual([0x1A, 0x02, 0x8F, 0x5A, 0xAF], encoded.data?.binary)
    }
}
