import GameplayKit

public struct Sector {
    public let x: UInt
    public let y: UInt
    public let stars: [Star]
    
    public init(_ x: UInt, _ y: UInt, numStars: UInt) {
        self.x = x
        self.y = y
        
        let coordSource = GKMersenneTwisterRandomSource(seed: UInt64((x << 16) + y))
        let starSource = GKMersenneTwisterRandomSource(seed: UInt64((y << 16) + x))
        
        // Advance the sources by a few... just for fun.
        coordSource.nextInt()
        coordSource.nextInt()
        coordSource.nextInt()
        starSource.nextInt()
        starSource.nextInt()
        starSource.nextInt()
        
        var stars = [Star]()
        for _ in 0..<numStars {
            stars.append(Star(randomSource: starSource, coordinate: Coordinate(randomSource: coordSource, minCoord: 0, maxCoord: 520)))
        }
        self.stars = stars
    }
}

extension Sector: CustomDebugStringConvertible {
    public var debugDescription: String { return "[\(x), \(y)]: \(stars)" }
}

