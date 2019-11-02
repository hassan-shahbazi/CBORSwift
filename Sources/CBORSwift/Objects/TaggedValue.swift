import Foundation

public struct TaggedValue {
    public let tag: Int
    public let value: CBOREncodable

    public init(tag: Int, _ value: CBOREncodable) {
        self.tag = tag
        self.value = value
    }
}