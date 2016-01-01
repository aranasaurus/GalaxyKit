public struct Coordinate {
    public let x: Int32
    public let y: Int32
    public let z: Int32
    
    public static let zero = Coordinate(x: 0, y: 0, z: 0)
    
    public init(seed: Seed) {
        self.z = Int32((seed.coordSeed & 0xFF0000) >> 16) - 128
        self.y = Int32((seed.coordSeed & 0x00FF00) >> 8) - 128
        self.x = Int32(seed.coordSeed & 0x0000FF) - 128
    }
    
    public init(x: Int32, y: Int32, z:Int32) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public func quickDistanceTo(other: Coordinate) -> Int32 {
        let dx = abs(x - other.x)
        let dy = abs(y - other.y)
        let dz = abs(z - other.z)
        return dx * dx + dy * dy + dz * dz
    }
    
    public func distanceTo(other: Coordinate) -> Double {
        return sqrt(Double(quickDistanceTo(other)))
    }
}

extension Coordinate: CustomDebugStringConvertible {
    public var debugDescription: String { return "\(x), \(y), \(z)" }
}

extension Coordinate: Equatable { }
public func ==(left: Coordinate, right: Coordinate) -> Bool {
    guard left.x == right.x else { return false }
    guard left.y == right.y else { return false }
    guard left.z == right.z else { return false }
    return true
}
