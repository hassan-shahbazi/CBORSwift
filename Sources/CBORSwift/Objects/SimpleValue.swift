import Foundation

public enum SimpleValues {
    public typealias RawValue = Bool?
    case `false`
    case `true`
    case null
    
    public init?(rawValue: RawValue) {
        switch rawValue {
        case false: self = .false
        case true: self = .true
        default: self = .null
        }
    }

    public var rawValue: RawValue {
        switch self {
        case .false: return false
        case .true: return true
        default: return nil
        }
    }

    public var code: String {
        switch self {
        case .false: return "10100"
        case .true: return "10101"
        case .null: return "10110"
        }
    }
}

public struct SimpleValue {
    private let value: SimpleValues
    public init(_ value: SimpleValues) {
        self.value = value
    }

    public var valueData: Data {
        let bytes = value.code.byteArrayCharacters
        return Data(bytes[3..<bytes.count])
    }

    public static var valueEnum: (([UInt8])-> SimpleValues?) = { byteArray in
        let bytes = Data(byteArray).hex.hex_decimal.decimal_binary
        switch (bytes[3..<bytes.count].map { "\($0)" }.joined(separator: "")) {
        case SimpleValues.false.code:
            return SimpleValues.false
        case SimpleValues.true.code:
            return SimpleValues.true
        default:
            return SimpleValues.null
        }
    }
}