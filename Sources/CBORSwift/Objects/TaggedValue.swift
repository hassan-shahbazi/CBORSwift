import Foundation

public struct TaggedValue {
    public let tag: Int
    public let value: AnyHashable

    public init(tag: Int, _ value: AnyHashable) {
        self.tag = tag
        self.value = value
    }
}