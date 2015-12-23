import UIKit
import XCPlayground

public struct Star {
    public enum Classification: Int {
        private static let chanceTable = [
            0, 0, 10, 11, 12, 1, 1, 1,
            1, 1, 1, 1, 1, 1, 2, 2,
            2, 2, 2, 3, 3, 3, 3, 3,
            4, 4, 4, 5, 6, 7, 8, 9
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
        
        var color: UIColor {
            switch self {
            case .MFlare, .MFaint, .M, .RedGiant:
                return UIColor(red: 200.0/255.0, green: 0, blue: 0, alpha: 1.0)
            case .K:
                return UIColor(red: 200.0/255.0, green: 136.0/255.0, blue: 0, alpha: 1.0)
            case .G:
                return UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 0, alpha: 1.0)
            case .F, .A, .WhiteDwarf, .BrightGiant, .ContactBinary:
                return UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1.0)
            case .B, .BlueSuperGiant:
                return UIColor(red: 168.0/255.0, green: 200.0/255.0, blue: 232.0/255.0, alpha: 1.0)
            case .SuperGiant:
                return UIColor(red: 192.0/255.0, green: 136.0/255.0, blue: 0, alpha: 1.0)
            }
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
    public var color: UIColor { return classification.color }
    
    public init(seed: Seed) {
        self.classification = Classification(seed: seed)
        self.multiType = MultiType(seed: seed)
    }
}

extension Star: CustomDebugStringConvertible {
    public var debugDescription: String { return "\(multiType) \(classification)" }
}

