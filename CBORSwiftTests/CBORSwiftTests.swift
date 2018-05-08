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
    
    func test_9_FinalComprehensiveTest_Decode() {
        let encoded: [UInt8] = [0xA2,
//                                0x01,
//                                    0x58, 0x20,
//                                        0x68, 0x71, 0x34, 0x96, 0x82, 0x22, 0xEC, 0x17, 0x20, 0x2E, 0x42, 0x50, 0x5F, 0x8E, 0xD2, 0xB1, 0x6A, 0xE2, 0x2F, 0x16, 0xBB, 0x05, 0xB8, 0x8C, 0x25, 0xDB, 0x9E, 0x60, 0x26, 0x45, 0xF1, 0x41,
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
                                    0xA2,
                                        0x62,
                                            0x69, 0x64,
                                        0x64,
                                            0x6E, 0x61, 0x6D, 0x65,
                                        0x71,
                                            0x74, 0x65, 0x73, 0x74, 0x63, 0x74, 0x61, 0x70, 0x40, 0x63, 0x74, 0x61, 0x70, 0x2E, 0x63, 0x6F, 0x6D,
                                        0x68,
                                            0x64, 0x69, 0x73, 0x70, 0x6C, 0x61, 0x79, 0x4E, 0x61, 0x6D, 0x65,
                                        0x69,
                                            0x54, 0x65, 0x73, 0x74, 0x20, 0x43, 0x74, 0x61, 0x70]
        
        let decoded = CBOR.decode(bytes: encoded)
        XCTAssertNotNil(decoded)
        
        let expected: NSDictionary = [
            //1:"687134968222EC17202E42505F8ED2B16AE22F16BB05B88C25DB9E602645F141".lowercased(),
            2: ["id":"test.ctap", "name":"test.ctap"],
            3: [//"id":"01B65EBF914724C5FC50BE4E9FF2E61787FE97F8F0B1544344316ECD24925F01",
                "name":"testctap@ctap.com", "displayName": "Test Ctap"]
            ]
        XCTAssertEqual(expected, decoded as! NSDictionary)
    }

}
