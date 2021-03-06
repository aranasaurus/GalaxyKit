import GameplayKit

public struct Coordinate {
    public let x: Int
    public let y: Int
    public let z: Int
    
    public static let zero = Coordinate(x: 0, y: 0, z: 0)
    
    public init(randomSource: GKRandomSource, sectorSize: Int) {
        self.x = randomSource.nextInt(upperBound: sectorSize) - (sectorSize/2)
        self.y = randomSource.nextInt(upperBound: sectorSize) - (sectorSize/2)
        self.z = randomSource.nextInt(upperBound: sectorSize) - (sectorSize/2)
    }
    
    public init(x: Int, y: Int, z:Int) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public func quickDistanceTo(_ other: Coordinate) -> Int {
        let dx = abs(x - other.x)
        let dy = abs(y - other.y)
        let dz = abs(z - other.z)
        return dx * dx + dy * dy + dz * dz
    }
    
    public func distanceTo(_ other: Coordinate) -> Double {
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
