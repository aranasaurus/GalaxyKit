import UIKit

public struct System {
    public let star: Star
    public let coordinate: Coordinate
    
    public init(seed: Seed) {
        self.coordinate = Coordinate(seed: seed)
        self.star = Star(seed: seed)
    }
    
    public init(star: Star, coordinate: Coordinate) {
        self.coordinate = coordinate
        self.star = star
    }
}

extension System: CustomStringConvertible {
    public var description: String { return "\(star) [\(coordinate)]" }
}

extension System: CustomDebugStringConvertible {
    public var debugDescription: String { return "\(star.debugDescription) [\(coordinate.debugDescription)]" }
}

