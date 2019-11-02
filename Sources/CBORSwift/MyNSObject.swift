import Foundation


/*
public class NSSimpleValue: NSObject {
    private static let FALSECode: UInt8   = 0x14
    private static let TRUECode: UInt8    = 0x15
    private static let NILCode: UInt8     = 0x16
    private var value: Bool?
    
    public init(_ value: NSNumber?) {
        super.init()
        self.value = value?.boolValue
    }
    
    public func stringValue() -> Bool {
        return self.value!
    }
    
    @objc internal override func encode() -> String {
        var byte = NSSimpleValue.NILCode
        if value != nil {
            byte = (value!) ? NSSimpleValue.TRUECode : NSSimpleValue.FALSECode
        }
        var encodedArray = Encoder.prepareByteArray(major: .major7, measure: 0)
        encodedArray = [UInt8](encodedArray[0..<3])
        
        var byteArray = Data(bytes: [byte]).hex.hex_binary
        byteArray = [UInt8](byteArray[3..<byteArray.count])
        
        encodedArray.append(contentsOf: byteArray)
        return Data(bytes: encodedArray).binary_decimal.hex
    }
    
    public class func decode(header: Int) -> NSNumber? {
        let header = header + Int(0x14)
        
        if header == FALSECode {
            return NSNumber(value: false)
        }
        if header == TRUECode {
            return NSNumber(value: true)
        }
        return nil
    }
}

public class NSTag: NSObject {
    private var tag: Int! = -1
    private var value: NSObject!
    
    public init(tag: Int, _ value: NSObject) {
        super.init()
        
        self.tag = tag
        self.value = value
    }
    
    @objc internal override func encode() -> String {
        if tag > 0 {
            let encodedArray = Encoder.prepareByteArray(major: .major6, measure: self.tag)
            let headerData   = Data(bytes: encodedArray).binary_decimal.hex
            let encodedValue = Data(bytes: self.value.encode()!).hex
            
            return headerData.appending(encodedValue)
        }
        return ""
    }
    
    public func tagValue() -> Int {
        return self.tag
    }
    
    public func objectValue() -> NSObject {
        return self.value
    }
}

*/