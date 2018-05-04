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

}
