import XCTest
@testable import CBORSwift

final class CBORSwiftTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(CBORSwift().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
