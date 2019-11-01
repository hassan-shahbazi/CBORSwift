import Foundation

enum MajorType: String {
    case major0 = "000" //unsigned integer
    case major1 = "001" //negative integer
    case major2 = "010" //byte string
    case major3 = "011" //text string
    case major4 = "100" //array of data items
    case major5 = "101" //map of pairs of data items (dictionary)
    case major6 = "110" //optional semantic tagging of other major types
    case major7 = "111" //floating point numbers and simple data types
}

struct MajorTypes {

    private let type: MajorType
    init(_ type: MajorType) {
        self.type = type
    }

    public var typeData: Data {
        let bytes = type.rawValue.byteArrayCharacters
        return Data(bytes[bytes.count-3..<bytes.count])
    }

    public var typeEnum: (([UInt8]) -> MajorType?) = { byteArray in
        return MajorType(rawValue: byteArray[..<3].map { "\($0)" }.joined(separator: ""))
    }
}
