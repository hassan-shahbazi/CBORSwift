import Foundation

public enum SimpleValues: String {
    case `false`  = "10100"
    case `true`   = "10101"
    case null   = "10110"
}

public struct SimpleValue {
    private let value: SimpleValues
    public init(_ value: SimpleValues) {
        self.value = value
    }

    public var valueData: Data {
        let bytes = value.rawValue.byteArrayCharacters
        return Data(bytes[3..<bytes.count])
    }
}