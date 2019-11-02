import XCTest
@testable import CBORSwift

class CBORStructEncoderTests: XCTestCase {

    private struct TestStruct: CBOREncodableStruct {
        let name: String = "Hassan"
        let age: Int = 25
        let type: Bool = SimpleValues.true.rawValue!
    }

    func testEncodeStructures() {
        let structure = TestStruct()
        guard let encoded1 = try? structure.encode() else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0xA3, 0x63, 0x61, 0x67, 0x65,
                        0x18, 0x19,
                        0x64, 0x6E, 0x61, 0x6D, 0x65,
                        0x66, 0x48, 0x61, 0x73, 0x73, 0x61, 0x6E,
                        0x64, 0x74, 0x79, 0x70, 0x65,
                        0xF5], encoded1)
    }

    private struct NullStruct: CBOREncodableStruct {
        let nullable: String? = nil

        enum CodingKeys: String, CodingKey {
            case nullable
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            if nullable != nil { 
                try container.encode(nullable!, forKey: .nullable)
            } else {
                try? container.encodeNil(forKey: .nullable)
            }
        }
    }

    func testEncodeNullableStructures() {
        let structure = NullStruct()
        guard let encoded1 = try? structure.encode() else {
            return XCTFail()
        }
        XCTAssertNotNil(encoded1)
        XCTAssertEqual([0xA1, 0x68, 0x6E, 0x75, 0x6C, 0x6C, 0x61, 0x62, 0x6C, 0x65,
                        0xF6], encoded1)
    }
}