public struct Seed {
    public var coordSeed: UInt32
    public var starSeed: UInt32
    
    public init(_ coordSeed: UInt32, _ starSeed: UInt32) {
        self.coordSeed = coordSeed
        self.starSeed = starSeed
    }
    
    public mutating func rotateInPlace() {
        var tmp1 = UInt64(coordSeed << 3) | UInt64(coordSeed >> 29)
        let tmp2 = UInt64(coordSeed) + UInt64(starSeed)
        tmp1 += tmp2
        coordSeed = tmp1.uint32Value
    
        starSeed = ((tmp2 << 5) | (tmp2 >> 27)).uint32Value
    }
    
    public func rotate() -> Seed {
        var x = self
        x.rotateInPlace()
        return x
    }
}

extension Seed: CustomDebugStringConvertible {
    public var debugDescription: String { return "\(coordSeed) : \(starSeed)" }
}

