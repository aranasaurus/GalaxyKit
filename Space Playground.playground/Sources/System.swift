public struct System {
    public let star: Star
    public let coordinate: Coordinate
    
    public init(seed: Seed) {
        self.coordinate = Coordinate(seed: seed)
        self.star = Star(seed: seed)
    }
}

extension System: CustomDebugStringConvertible {
    public var debugDescription: String { return "\(star) - (\(coordinate))" }
}
