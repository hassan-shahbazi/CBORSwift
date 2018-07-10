//
//  CBORSwiftTests.swift
//  CBORSwiftTests
//
//  Created by Hassan Shahbazi on 5/2/18.
//  Copyright © 2018 Hassan Shahbazi. All rights reserved.
//

import XCTest
@testable import CBORSwift

// All tests are verified using http://cbor.me/ tool
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
    
    func test_9_FinalComprehensiveTest_Encode() {
        let id_1 = NSByteString("687134968222EC17202E42505F8ED2B16AE22F16BB05B88C25DB9E602645F141".lowercased())
        
        let dic2: NSDictionary = ["id":"test.ctap", "name":"test.ctap"]
        
        let id_3 = NSByteString("01B65EBF914724C5FC50BE4E9FF2E61787FE97F8F0B1544344316ECD24925F01".lowercased())
        let dic3: NSDictionary = ["id": id_3,"name":"testctap@ctap.com", "displayName": "Test Ctap"]
        
        let dic4_1: NSDictionary = ["alg": -7, "type": "public-key"]
        let dic4_2: NSDictionary = ["alg": -257, "type": "public-key"]
        let dic4_3: NSDictionary = ["alg": -37, "type": "public-key"]
        let dic4: NSArray = NSArray(array: [dic4_1, dic4_2, dic4_3])
        
        let decoded: NSDictionary = [1: id_1, 2:dic2, 3:dic3, 4:dic4]
        let encoded_functional:[UInt8]? = CBOR.encode(decoded as NSDictionary)
        let encoded_extentional: [UInt8]? = decoded.encode()
        
        XCTAssertNotNil(encoded_functional)
        XCTAssertNotNil(encoded_extentional)
        XCTAssertEqual(encoded_functional, encoded_extentional)
        
        let expected: [UInt8] = [0xA4, 0x01, 0x58, 0x20, 0x68, 0x71, 0x34, 0x96, 0x82, 0x22,
                                0xEC, 0x17, 0x20, 0x2E, 0x42, 0x50, 0x5F, 0x8E, 0xD2, 0xB1,
                                0x6A, 0xE2, 0x2F, 0x16, 0xBB, 0x05, 0xB8, 0x8C, 0x25, 0xDB,
                                0x9E, 0x60, 0x26, 0x45, 0xF1, 0x41, 0x02, 0xA2, 0x62, 0x69,
                                0x64, 0x69, 0x74, 0x65, 0x73, 0x74, 0x2E, 0x63, 0x74, 0x61,
                                0x70, 0x64, 0x6E, 0x61, 0x6D, 0x65, 0x69, 0x74, 0x65, 0x73,
                                0x74, 0x2E, 0x63, 0x74, 0x61, 0x70, 0x03, 0xA3, 0x62, 0x69,
                                0x64, 0x58, 0x20, 0x01, 0xB6, 0x5E, 0xBF, 0x91, 0x47, 0x24,
                                0xC5, 0xFC, 0x50, 0xBE, 0x4E, 0x9F, 0xF2, 0xE6, 0x17, 0x87,
                                0xFE, 0x97, 0xF8, 0xF0, 0xB1, 0x54, 0x43, 0x44, 0x31, 0x6E,
                                0xCD, 0x24, 0x92, 0x5F, 0x01, 0x64, 0x6E, 0x61, 0x6D, 0x65,
                                0x71, 0x74, 0x65, 0x73, 0x74, 0x63, 0x74, 0x61, 0x70, 0x40,
                                0x63, 0x74, 0x61, 0x70, 0x2E, 0x63, 0x6F, 0x6D, 0x6B, 0x64,
                                0x69, 0x73, 0x70, 0x6C, 0x61, 0x79, 0x4E, 0x61, 0x6D, 0x65,
                                0x69, 0x54, 0x65, 0x73, 0x74, 0x20, 0x43, 0x74, 0x61, 0x70,
                                0x04, 0x83, 0xA2, 0x63, 0x61, 0x6C, 0x67, 0x26, 0x64, 0x74,
                                0x79, 0x70, 0x65, 0x6A, 0x70, 0x75, 0x62, 0x6C, 0x69, 0x63,
                                0x2D, 0x6B, 0x65, 0x79, 0xA2, 0x63, 0x61, 0x6C, 0x67, 0x39,
                                0x01, 0x00, 0x64, 0x74, 0x79, 0x70, 0x65, 0x6A, 0x70, 0x75,
                                0x62, 0x6C, 0x69, 0x63, 0x2D, 0x6B, 0x65, 0x79, 0xA2, 0x63,
                                0x61, 0x6C, 0x67, 0x38, 0x24, 0x64, 0x74, 0x79, 0x70, 0x65,
                                0x6A, 0x70, 0x75, 0x62, 0x6C, 0x69, 0x63, 0x2D, 0x6B, 0x65, 0x79
        ]
        XCTAssertEqual(encoded_functional, expected)
    }
    
    func test_9_FinalComprehensiveTest_Decode() {
        let encoded: [UInt8] = [0xA4,
                                0x01,
                                    0x58, 0x20,
                                        0x68, 0x71, 0x34, 0x96, 0x82, 0x22, 0xEC, 0x17, 0x20, 0x2E, 0x42, 0x50, 0x5F, 0x8E, 0xD2, 0xB1, 0x6A, 0xE2, 0x2F, 0x16, 0xBB, 0x05, 0xB8, 0x8C, 0x25, 0xDB, 0x9E, 0x60, 0x26, 0x45, 0xF1, 0x41,
                                0x02,
                                    0xA2,
                                        0x62,
                                            0x69, 0x64,
                                        0x69,
                                            0x74, 0x65, 0x73, 0x74, 0x2E, 0x63, 0x74, 0x61, 0x70,
                                        0x64,
                                            0x6E, 0x61, 0x6D, 0x65,
                                        0x69,
                                            0x74, 0x65, 0x73, 0x74, 0x2E, 0x63, 0x74, 0x61, 0x70,
                                0x03,
                                    0xA3,
                                        0x62,
                                            0x69, 0x64,
                                        0x58, 0x20,
                                            0x01, 0xB6, 0x5E, 0xBF, 0x91, 0x47, 0x24, 0xC5, 0xFC, 0x50, 0xBE, 0x4E, 0x9F, 0xF2, 0xE6, 0x17, 0x87, 0xFE, 0x97, 0xF8, 0xF0, 0xB1, 0x54, 0x43, 0x44, 0x31, 0x6E, 0xCD, 0x24, 0x92, 0x5F, 0x01,
                                        0x64,
                                            0x6E, 0x61, 0x6D, 0x65,
                                        0x71,
                                            0x74, 0x65, 0x73, 0x74, 0x63, 0x74, 0x61, 0x70, 0x40, 0x63, 0x74, 0x61, 0x70, 0x2E, 0x63, 0x6F, 0x6D,
                                        0x6B,
                                            0x64, 0x69, 0x73, 0x70, 0x6C, 0x61, 0x79, 0x4E, 0x61, 0x6D, 0x65,
                                        0x69,
                                            0x54, 0x65, 0x73, 0x74, 0x20, 0x43, 0x74, 0x61, 0x70,
                                0x04,
                                0x83,
                                    0xA2,
                                        0x63,
                                            0x61, 0x6C, 0x67,
                                        0x26,
                                        0x64,
                                            0x74, 0x79, 0x70, 0x65,
                                        0x6A,
                                            0x70, 0x75, 0x62, 0x6C, 0x69, 0x63, 0x2D, 0x6B, 0x65, 0x79,
                                    0xA2,
                                        0x63,
                                            0x61, 0x6C, 0x67,
                                        0x39, 0x01, 0x00,
                                        0x64,
                                            0x74, 0x79, 0x70, 0x65,
                                        0x6A,
                                            0x70, 0x75, 0x62, 0x6C, 0x69, 0x63, 0x2D, 0x6B, 0x65, 0x79,
                                    0xA2,
                                        0x63,
                                            0x61, 0x6C, 0x67,
                                        0x38, 0x24,
                                        0x64,
                                            0x74, 0x79, 0x70, 0x65,
                                        0x6A,
                                            0x70, 0x75, 0x62, 0x6C, 0x69, 0x63, 0x2D, 0x6B, 0x65, 0x79]
        
        let decoded_functional = CBOR.decode(encoded)
        let decoded_extentional = encoded.decode()
        
        XCTAssertNotNil(decoded_functional)
        XCTAssertNotNil(decoded_extentional)
        XCTAssertEqual(decoded_functional, decoded_extentional)
        
        let dic2: NSDictionary = ["id":"test.ctap", "name":"test.ctap"]
        let dic3: NSDictionary = ["id":"01B65EBF914724C5FC50BE4E9FF2E61787FE97F8F0B1544344316ECD24925F01".lowercased(),
                                  "name":"testctap@ctap.com", "displayName": "Test Ctap"]
        let dic4_1: NSDictionary = ["alg": -7, "type": "public-key"]
        let dic4_2: NSDictionary = ["alg": -257, "type": "public-key"]
        let dic4_3: NSDictionary = ["alg": -37, "type": "public-key"]
        let dic4: NSArray = NSArray(array: [dic4_1, dic4_2, dic4_3])
        
        let expected: NSDictionary = [1: "687134968222EC17202E42505F8ED2B16AE22F16BB05B88C25DB9E602645F141".lowercased(),
                                      2:dic2,
                                      3:dic3,
                                      4:dic4]
        XCTAssertEqual(expected, decoded_functional as! NSDictionary)
    }

}
