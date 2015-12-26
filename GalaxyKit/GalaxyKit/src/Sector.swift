public struct Sector {
    public let x: UInt32
    public let y: UInt32
    public let systems: Array<System>
    
    public init(_ x: UInt32, _ y: UInt32, numSystems: UInt8) {
        self.x = x
        self.y = y
        
        let coordSeed = (x << 16) + y
        let starSeed = (y << 16) + x
        
        var seed = Seed(coordSeed, starSeed)
        seed.rotateInPlace()
        seed.rotateInPlace()
        seed.rotateInPlace()
        
        var systems = [System]()
        for _ in 0..<numSystems {
            seed.rotateInPlace()
            systems.append(System(seed: seed))
        }
        self.systems = systems
    }
}

extension Sector: CustomDebugStringConvertible {
    public var debugDescription: String { return "[\(x), \(y)]: \(systems)" }
}

