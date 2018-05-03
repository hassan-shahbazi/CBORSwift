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
    }

    //MARK:- Array encoding
    func test_2_encodeArray() {
        var encoded = CBOR.encode(array: ["item0"])
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x81], encoded)
        
        encoded = CBOR.encode(array: ["item0", "item1", "item2"])
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x83], encoded)
        
        var array = NSArray()
        for counter in 0..<47 {
            array = array.adding("item\(counter)") as NSArray
        }
        encoded = CBOR.encode(array: array)
        XCTAssertNotNil(encoded)
        XCTAssertEqual([0x98, 0x2F], encoded)
    }

}
