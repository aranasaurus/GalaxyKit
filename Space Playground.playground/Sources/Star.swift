import UIKit
import XCPlayground

public typealias Kelvin = Int

/**
 Standard unit of mass in astronomy indicating the mass of other stars, as well as clusters, nebulae and galaxies. 
 Equal to the mass of the Sun, about two nonillion kilograms.
 Check it out on [wikipedia](https://en.wikipedia.org/wiki/Solar_mass).
*/
public typealias SolarMass = Double

/** 
 Standard unit of distance used to express the size of stars in astronomy.
 Equal to the current radius of the Sun (aka: 6.955 x 10^5).
 Check it out on [wikipedia](https://en.wikipedia.org/wiki/Solar_radius).
*/
public typealias SolarRadius = Double

/**
 Unit of radiant flux (power emitted in the form of photons) conventionally used by astronomers to measure the luminosity of stars. 
 Defined in terms of the Sun's output.
 Check it out on [wikipedia](https://en.wikipedia.org/wiki/Solar_luminosity).
*/
public typealias SolarLuminosity = Double

protocol Numeric {}
extension Double: Numeric {}
extension Int: Numeric {}

public struct Star {
    /**
     The classification of a star. Based primarily on [this wikipedia page](https://en.wikipedia.org/wiki/Stellar_classification#Harvard_spectral_classification).
     */
    public enum Classification: Int {
        case O
        case B
        case A
        case F
        case G
        case K
        case M
        
        var tempRange: (min: Kelvin, max: Kelvin) {
            switch self {
            case .O:
                return (min: 30000, max: Kelvin.max)
            case .B:
                return (min: 10000, max: 30000)
            case .A:
                return (min: 7500, max: 10000)
            case .F:
                return (min: 6000, max: 7500)
            case .G:
                return (min: 5200, max: 6000)
            case .K:
                return (min: 3700, max: 5200)
            case .M:
                return (min: 2400, max: 3700)
            }
        }
        private func temperature(percentile: Double) -> Kelvin {
            let range = tempRange
            return Kelvin(doubleFromRange(Double(range.min), max: Double(range.max), percentile: percentile))
        }
        
        var massRange: (min: SolarMass, max: SolarMass) {
            switch self {
            case .O:
                return (min: 16, max: SolarMass.infinity)
            case .B:
                return (min: 2.1, max: 16)
            case .A:
                return (min: 1.4, max: 2.1)
            case .F:
                return (min: 1.04, max: 1.4)
            case .G:
                return (min: 0.8, max: 1.04)
            case .K:
                return (min: 0.45, max: 0.8)
            case .M:
                return (min: 0.08, max: 0.45)
            }
        }
        private func mass(percentile: Double) -> SolarMass {
            let range = massRange
            return SolarMass(doubleFromRange(range.min, max: range.max, percentile: percentile))
        }
        
        var radiusRange: (min: SolarRadius, max: SolarRadius) {
            switch self {
            case .O:
                return (min: 6.6, max: SolarRadius.infinity)
            case .B:
                return (min: 1.8, max: 6.6)
            case .A:
                return (min: 1.4, max: 1.8)
            case .F:
                return (min: 1.15, max: 1.4)
            case .G:
                return (min: 0.96, max: 1.15)
            case .K:
                return (min: 0.07, max: 0.96)
            case .M:
                return (min: 0, max: 0.7)
            }
        }
        private func radius(percentile: Double) -> SolarRadius {
            let range = radiusRange
            return SolarRadius(doubleFromRange(range.min, max: range.max, percentile: percentile))
        }
        
        var luminosityRange: (min: SolarLuminosity, max: SolarLuminosity) {
            switch self {
            case .O:
                return (min: 30000, max: SolarLuminosity.infinity)
            case .B:
                return (min: 25, max: 30000)
            case .A:
                return (min: 5, max: 25)
            case .F:
                return (min: 1.5, max: 5)
            case .G:
                return (min: 0.6, max: 1.5)
            case .K:
                return (min: 0.08, max: 0.6)
            case .M:
                return (min: 0, max: 0.8)
            }
        }
        private func luminosity(percentile: Double) -> SolarLuminosity {
            let range = luminosityRange
            return SolarLuminosity(doubleFromRange(range.min, max: range.max, percentile: percentile))
        }
        
        private func doubleFromRange(min: Double, max: Double, percentile: Double) -> Double {
            let range = max - min
            return min + (range * percentile)
        }
        
        var referenceColor: (hue: CGFloat, saturation: CGFloat) {
            switch self {
            case .O:
                return (hue: 0.639, saturation: 0.457)
            case .B:
                return (hue: 0.634, saturation: 0.398)
            case .A:
                return (hue: 0.628, saturation: 0.251)
            case .F:
                return (hue: 0.741, saturation: 0.035)
            case .G:
                return (hue: 0.089, saturation: 0.11)
            case .K:
                return (hue: 0.092, saturation: 0.35)
            case .M:
                return (hue: 0.086, saturation: 0.636)
            }
        }
        
        func color(percentile: Double) -> UIColor {
            let ref = referenceColor
            return UIColor(hue: ref.hue, saturation: ref.saturation * CGFloat(1 - percentile + 0.5), brightness: 1, alpha: 1)
        }
        
        init(percentile: Double) {
            switch percentile {
            case percentile where percentile >= 0.9999997:
                self = .O
            case percentile where percentile >= 0.9987:
                self = .B
            case percentile where percentile >= 0.994:
                self = .A
            case percentile where percentile >= 0.97:
                self = .F
            case percentile where percentile >= 0.924:
                self = .G
            case percentile where percentile >= 0.879:
                self = .K
            default:
                self = .M
            }
        }
    }
    
    public var classification: Classification { return Classification(percentile: classificationPercentile) }
    public var temperature: Kelvin { return classification.temperature(attributesPercentile) }
    public var mass: SolarMass { return classification.mass(attributesPercentile) }
    public var radius: SolarRadius { return classification.radius(attributesPercentile) }
    public var luminosity: SolarLuminosity { return classification.luminosity(attributesPercentile) }
    
    // TODO: This should change based on percentile as well
    public var color: UIColor { return classification.color(attributesPercentile) }
    
    private let classificationPercentile: Double
    private let attributesPercentile: Double
    
    public init(seed: Seed) {
        self.classificationPercentile = Double(seed.starSeed) / Double(UInt32.max)
        self.attributesPercentile = Double(seed.rotate().starSeed) / Double(UInt32.max)
    }
}

extension Star: CustomStringConvertible {
    public var description: String { return "\(classification)" }
}

extension Star: CustomDebugStringConvertible {
    public var debugDescription: String { return "class: \(classification), temp: \(temperature), mass: \(mass), rad: \(radius), luminosity: \(luminosity), percentiles: [\(classificationPercentile), \(attributesPercentile)]" }
}

