import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CBORSwiftTests.allTests),
        testCase(CBOREncoderTests.allTests),
    ]
}
#endif
