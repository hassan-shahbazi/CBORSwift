import Foundation

extension Dictionary where Value: Comparable, Key: Comparable {
    var sortedKeyValue: [(Key, Value)] {
        return sorted {
            if $0.0 != $1.0 {
                return $0.0 < $1.0
            }
            else if $0.1 != $1.1 {
                return $0.1 < $1.1
            }
            return $0.0 == $1.0
        }
    }
}
