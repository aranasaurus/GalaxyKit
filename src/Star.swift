import GameplayKit

public struct Star {
    public var classification: Classification
    public var subclass: Int
    public var temperature: Temperature
    public var mass: Mass
    public var radius: Length
    public var luminosity: SolarLuminosity
    public let coordinate: Coordinate
    
    public var color: UIColor { return classification.color(temperature.converted(to: .kelvin).value / classification.maxTemp.converted(to: .kelvin).value) }
    
    public init(randomSource: GKRandomSource, coordinate: Coordinate) {
        self.coordinate = coordinate
        let classificationPercentile = Double(randomSource.nextUniform())
        let attributesPercentile = Double(randomSource.nextUniform())
        self.classification = Classification(percentile: classificationPercentile)
        self.subclass = abs(Int(attributesPercentile * 100) / 10 - 9) // from 0 - 9 (0 is brighter/hotter)
        self.temperature = classification.temperature(attributesPercentile)
        self.mass = classification.mass(attributesPercentile)
        self.radius = classification.radius(attributesPercentile)
        self.luminosity = classification.luminosity(attributesPercentile)
    }
    
    public init(classification: Classification, subclass: Int, temperature: Temperature, mass: Mass, radius: Length, luminosity: SolarLuminosity, coordinate: Coordinate) {
        self.coordinate = coordinate
        self.classification = classification
        self.subclass = subclass
        self.temperature = temperature
        self.mass = mass
        self.radius = radius
        self.luminosity = luminosity
    }
}

extension Star: CustomStringConvertible {
    public var description: String {
        return "\(classification)\(subclass)"
    }
}

extension Star: CustomDebugStringConvertible {
    public var debugDescription: String { return "class: \(classification)\(subclass), temp: \(temperature), mass: \(mass), rad: \(radius), luminosity: \(luminosity)" }
}

