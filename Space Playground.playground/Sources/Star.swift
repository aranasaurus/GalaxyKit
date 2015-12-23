public struct Star {
    public enum Classification: Int {
        private static let chanceTable = [
            0, 0, 0, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1,
            2, 2, 2, 2, 2, 3, 3, 3,
            3, 4, 4, 4, 5, 6, 7, 8
        ]
        case MFlare
        case MFaint
        case M
        case K
        case G
        case F
        case A
        case WhiteDwarf
        case RedGiant
        case BrightGiant
        case B
        case SuperGiant
        case BlueSuperGiant
        case ContactBinary
        
        init(seed: Seed) {
            self.init(rawValue: Classification.chanceTable.itemWithSeed(Int(seed.starSeed >> 16)))!
        }
    }
    
    public enum MultiType: Int {
        private static let chanceTable = [
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 1, 1,
            1, 1, 1, 2, 2, 2, 2, 2,
            2, 2, 3, 3, 3, 4, 5, 6
        ]
        
        case Single = 1
        case Binary
        case Ternary
        case Quaternary
        case Quintuple
        case Sextuple
        
        init(seed: Seed) {
            self.init(rawValue: MultiType.chanceTable.itemWithSeed(Int(seed.starSeed)))!
        }
    }
    
    public let classification: Classification
    public let multiType: MultiType
    
    public init(seed: Seed) {
        self.classification = Classification(seed: seed)
        self.multiType = MultiType(seed: seed)
    }
}

extension Star: CustomDebugStringConvertible {
    public var debugDescription: String { return "\(multiType) \(classification)" }
}
