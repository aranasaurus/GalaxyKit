import GameplayKit

public struct Coordinate<UnitType: UnitOfLengthType> {
    public static var zero: Coordinate<UnitType> { return Coordinate(x: 0, y: 0, z: 0) }
    
    public let x: UnitType
    public let y: UnitType
    public let z: UnitType
    
    public init(randomSource: GKRandomSource, minCoord: UnitType, maxCoord: UnitType) {
        let range = Float(maxCoord.value - minCoord.value)
        self.x = UnitType(Double(randomSource.nextUniform() * range) + minCoord.value)
        self.y = UnitType(Double(randomSource.nextUniform() * range) + minCoord.value)
        self.z = UnitType(Double(randomSource.nextUniform() * range) + minCoord.value)
    }
    
    public init(x: UnitType, y: UnitType, z: UnitType) {
        self.x = x
        self.y = y
        self.z = z
    }
    
    public func quickDistanceTo(other: Coordinate) -> Double {
        let dx = abs(x - other.x)
        let dy = abs(y - other.y)
        let dz = abs(z - other.z)
        return dx * dx + dy * dy + dz * dz
    }
    
    public func distanceTo(other: Coordinate) -> Double {
        return sqrt(quickDistanceTo(other))
    }
}

extension Coordinate: CustomDebugStringConvertible {
    public var debugDescription: String { return "\(x), \(y), \(z)" }
}

extension Coordinate: Equatable { }
