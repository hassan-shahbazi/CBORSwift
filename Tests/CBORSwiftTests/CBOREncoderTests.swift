import XCTest
@testable import CBORSwift

// All tests are verified using http://cbor.me/ tool
class CBOREncoderTests: XCTestCase {
    
    //MARK:- Unsigned integer encoding
    func testEncodeSimpleInt() {
        guard let encoded1 = try? CBOR.encode(0) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0x00], encoded1)
        
        guard let encoded2 = try? CBOR.encode(5) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded2)
        XCTAssertEqual([0x05], encoded2)
        
        guard let encoded3 = try? CBOR.encode(10) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded3)
        XCTAssertEqual([0x0A], encoded3)
        
        guard let encoded4 = try? CBOR.encode(16) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded4)
        XCTAssertEqual([0x10], encoded4)
        
        guard let encoded5 = try? CBOR.encode(23) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded5)
        XCTAssertEqual([0x17], encoded5)
    }
    
    func testEncodeStage1Int() {
        guard let encoded1 = try? CBOR.encode(24) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0x18, 0x18], encoded1)
        
        guard let encoded2 = try? CBOR.encode(25) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded2)
        XCTAssertEqual([0x18, 0x19], encoded2)
        
        guard let encoded3 = try? CBOR.encode(125) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded3)
        XCTAssertEqual([0x18, 0x7D], encoded3)
        
        guard let encoded4 = try? CBOR.encode(178) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded4)
        XCTAssertEqual([0x18, 0xB2], encoded4)
        
        guard let encoded5 = try? CBOR.encode(255) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded5)
        XCTAssertEqual([0x18, 0xFF], encoded5)
    }
    
    func testEncodeStage2Int() {
        guard let encoded1 = try? CBOR.encode(256) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0x19, 0x01, 0x00], encoded1)
        
        guard let encoded2 = try? CBOR.encode(300) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded2)
        XCTAssertEqual([0x19, 0x01, 0x2C], encoded2)
        
        guard let encoded3 = try? CBOR.encode(1200) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded3)
        XCTAssertEqual([0x19, 0x04, 0xB0], encoded3)
        
        guard let encoded4 = try? CBOR.encode(3428) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded4)
        XCTAssertEqual([0x19, 0x0D, 0x64], encoded4)
        
        guard let encoded5 = try? CBOR.encode(65500) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded5)
        XCTAssertEqual([0x19, 0xFF, 0xDC], encoded5)
    }

    func testEncodeStage3Int() {
        guard let encoded1 = try? CBOR.encode(65536) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0x1A, 0x00, 0x01, 0x00, 0x00], encoded1)
        
        guard let encoded2 = try? CBOR.encode(42949295) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded2)
        XCTAssertEqual([0x1A, 0x02, 0x8F, 0x5A, 0xAF], encoded2)
    }

    func testEncodeBigIntegers() {
        guard let encoded1 = try? CBOR.encode(1531842146400) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0x1B, 0x00, 0x00, 0x01, 0x64, 0xA8, 0xE8, 0x30, 0x60], encoded1)
        
        guard let encoded2 = try? CBOR.encode(999999999999999999) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded2)
        XCTAssertEqual([0x1B, 0x0D, 0xE0, 0xB6, 0xB3, 0xA7, 0x63, 0xFF, 0xFF], encoded2)
    }

    //MARK:- Negative integer encoding
    func testEncodeSimpleNeg() {
        guard let encoded1 = try? CBOR.encode(-1) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0x20], encoded1)
        
        guard let encoded2 = try? CBOR.encode(-7) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded2)
        XCTAssertEqual([0x26], encoded2)
        
        guard let encoded3 = try? CBOR.encode(-16) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded3)
        XCTAssertEqual([0x2F], encoded3)
        
        guard let encoded4 = try? CBOR.encode(-24) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded4)
        XCTAssertEqual([0x37], encoded4)
    }
    
    func testEncodeStage1Neg() {
        guard let encoded1 = try? CBOR.encode(-25) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0x38, 0x18], encoded1)
        
        guard let encoded2 = try? CBOR.encode(-96) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded2)
        XCTAssertEqual([0x38, 0x5F], encoded2)
        
        guard let encoded3 = try? CBOR.encode(-160) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded3)
        XCTAssertEqual([0x38, 0x9F], encoded3)
        
        guard let encoded4 = try? CBOR.encode(-256) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded4)
        XCTAssertEqual([0x38, 0xFF], encoded4)
    }
    
    func testEncodeStage2Neg() {
        guard let encoded1 = try? CBOR.encode(-257) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0x39, 0x01, 0x00], encoded1)
        
        guard let encoded2 = try? CBOR.encode(-382) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded2)
        XCTAssertEqual([0x39, 0x01, 0x7D], encoded2)
        
        guard let encoded3 = try? CBOR.encode(-3428) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded3)
        XCTAssertEqual([0x39, 0x0D, 0x63], encoded3)
        
        guard let encoded4 = try? CBOR.encode(-65500) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded4)
        XCTAssertEqual([0x39, 0xFF, 0xDB], encoded4)
    }
    
    func testEncodeStage3Neg() {
        guard let encoded1 = try? CBOR.encode(-65537) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0x3A, 0x00, 0x01, 0x00, 0x00], encoded1)
        
        guard let encoded2 = try? CBOR.encode(-42949295) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded2)
        XCTAssertEqual([0x3A, 0x02, 0x8F, 0x5A, 0xAE], encoded2)
    }
    
    //MARK:- Byte string encoding
    func testEncodeByteString() {
        guard let encoded1 = try? CBOR.encode(ByteString("2525")) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0x42, 0x25, 0x25], encoded1)
        
        guard let encoded2 = try? CBOR.encode(ByteString("25253015")) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded2)
        XCTAssertEqual([0x44, 0x25, 0x25, 0x30, 0x15], encoded2)
        
        guard let encoded3 = try? CBOR.encode(ByteString("687134968222EC17202E42505F8ED2B16AE22F16BB05B88C25DB9E602645F141")) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded3)
        XCTAssertEqual([0x58, 0x20, 0x68, 0x71, 0x34, 0x96, 0x82, 0x22,
                        0xEC, 0x17, 0x20, 0x2E, 0x42, 0x50, 0x5F, 0x8E, 0xD2, 0xB1,
                        0x6A, 0xE2, 0x2F, 0x16, 0xBB, 0x05, 0xB8, 0x8C, 0x25, 0xDB,
                        0x9E, 0x60, 0x26, 0x45, 0xF1, 0x41], encoded3)
    }
    
    //MARK:- Text string encoding
    func testEncodeTextString() {
        guard let encoded1 = try? CBOR.encode("hello") else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F], encoded1)
        
        guard let encoded2 = try? CBOR.encode("name") else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded2)
        XCTAssertEqual([0x64, 0x6E, 0x61, 0x6D, 0x65], encoded2)
        
        guard let encoded3 = try? CBOR.encode("let's do a more complex test") else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded3)
        XCTAssertEqual([0x78, 0x1C, 0x6C, 0x65, 0x74, 0x27, 0x73, 0x20, 0x64, 0x6F,
                        0x20, 0x61, 0x20, 0x6D, 0x6F, 0x72, 0x65, 0x20, 0x63, 0x6F,
                        0x6D, 0x70, 0x6C, 0x65, 0x78, 0x20, 0x74, 0x65, 0x73, 0x74], encoded3)
        
        guard let encoded4 = try? CBOR.encode("a simple string with a large length, trying to test all possible situations. Thus, I have to double this string. a simple string with a large length, trying to test all possible situations. Thus, I have to double this string. a simple string with a large length, trying to test all possible situations. Thus, I have to double this string") else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded4)
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
                        0x20, 0x73, 0x74, 0x72, 0x69, 0x6E, 0x67], encoded4)
    }
    
    //MARK:- Array encoding
    func testEncodeStringArray() {
        guard let encoded1 = try? CBOR.encode(["hello"]) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0x81, 0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F], encoded1)
        
        guard let encoded2 = try? CBOR.encode(["hello", "my", "friend"]) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded2)
        XCTAssertEqual([0x83, 0x65, 0x68, 0x65, 0x6C, 0x6C, 0x6F,
                        0x62, 0x6D, 0x79,
                        0x66, 0x66, 0x72, 0x69, 0x65, 0x6E, 0x64], encoded2)
    }
    
    func testEncodeNumberArray() {
        guard let encoded1 = try? CBOR.encode([10]) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0x81, 0x0A], encoded1)
        
        guard let encoded2 = try? CBOR.encode([10, 15, -9]) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded2)
        XCTAssertEqual([0x83, 0x0A, 0x0F, 0x28], encoded2)
    }
 
    func test_4_encodeArrayArray() {
        guard let encoded1 = try? CBOR.encode([[10]]) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0x81, 0x81, 0x0A], encoded1)
        
        guard let encoded2 = try? CBOR.encode([[10], [-9, 0]]) else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded2)
        XCTAssertEqual([0x82, 0x81, 0x0A, 0x82, 0x28, 0x00], encoded2)
    }
/*    
    func testEncodeMapArray() {
        guard let encoded = try? CBOR.encode([["surename":"shahbazi", "name":"hassan", "age":27]]) else {
            return XCTFail()
        }
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

    */
}
