public struct Coordinate {
    public let x: Int32
    public let y: Int32
    public let z: Int32
    
    public init(seed: Seed) {
//        print("Generating Coordinate with seed: \(seed.coordSeed) : \(seed.coordSeed.binaryString)")
        self.z = Int32((seed.coordSeed & 0xFF0000) >> 16) - 128
        self.y = Int32((seed.coordSeed & 0x00FF00) >> 8) - 128
        self.x = Int32(seed.coordSeed & 0x0000FF) - 128
    }
}

extension Coordinate: CustomDebugStringConvertible {
    public var debugDescription: String { return "\(x), \(y), \(z)" }
}
