//
//  StarClassification.swift
//  GalaxyKit
//
//  Created by Ryan Arana on 1/5/16.
//  Copyright © 2016 Aranasaurus. All rights reserved.
//

import UIKit

public extension Star {
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

        var minTemp: Temperature {
            switch self {
            case .O:
                return Temperature(value: 30000, unit: .kelvin)
            case .B:
                return Temperature(value: 10000, unit: .kelvin)
            case .A:
                return Temperature(value: 7500, unit: .kelvin)
            case .F:
                return Temperature(value: 6000, unit: .kelvin)
            case .G:
                return Temperature(value: 5200, unit: .kelvin)
            case .K:
                return Temperature(value: 3700, unit: .kelvin)
            case .M:
                return Temperature(value: 2400, unit: .kelvin)
            }
        }
        var maxTemp: Temperature {
            switch self {
            case .O:
                return Temperature(value: 52000, unit: .kelvin)
            case .B:
                return Temperature(value: 30000, unit: .kelvin)
            case .A:
                return Temperature(value: 10000, unit: .kelvin)
            case .F:
                return Temperature(value: 7500, unit: .kelvin)
            case .G:
                return Temperature(value: 6000, unit: .kelvin)
            case .K:
                return Temperature(value: 5200, unit: .kelvin)
            case .M:
                return Temperature(value: 3700, unit: .kelvin)
            }
        }
        func temperature(_ percentile: Double) -> Temperature {
            return Temperature.measurement(at: percentile, of: minTemp...maxTemp)
        }

        var minMass: Mass {
            switch self {
            case .O:
                return Mass(value: 16, unit: .solarMass)
            case .B:
                return Mass(value: 2, unit: .solarMass)
            case .A:
                return Mass(value: 1.4, unit: .solarMass)
            case .F:
                return Mass(value: 1.04, unit: .solarMass)
            case .G:
                return Mass(value: 0.8, unit: .solarMass)
            case .K:
                return Mass(value: 0.45, unit: .solarMass)
            case .M:
                return Mass(value: 0.08, unit: .solarMass)
            }
        }
        var maxMass: Mass {
            switch self {
            case .O:
                return Mass(value: 90, unit: .solarMass)
            case .B:
                return Mass(value: 16, unit: .solarMass)
            case .A:
                return Mass(value: 2.1, unit: .solarMass)
            case .F:
                return Mass(value: 1.4, unit: .solarMass)
            case .G:
                return Mass(value: 1.04, unit: .solarMass)
            case .K:
                return Mass(value: 0.8, unit: .solarMass)
            case .M:
                return Mass(value: 0.45, unit: .solarMass)
            }
        }
        func mass(_ percentile: Double) -> Mass {
            return Mass.measurement(at: percentile, of: minMass...maxMass)
        }

        var minRadius: Length {
            switch self {
            case .O:
                return Length(value: 6.6, unit: .solarRadii)
            case .B:
                return Length(value: 1.8, unit: .solarRadii)
            case .A:
                return Length(value: 1.4, unit: .solarRadii)
            case .F:
                return Length(value: 1.15, unit: .solarRadii)
            case .G:
                return Length(value: 0.96, unit: .solarRadii)
            case .K:
                return Length(value: 0.7, unit: .solarRadii)
            case .M:
                return Length(value: 0.33, unit: .solarRadii)
            }
        }
        var maxRadius: Length {
            switch self {
            case .O:
                return Length(value: 76, unit: .solarRadii)
            case .B:
                return Length(value: 6.6, unit: .solarRadii)
            case .A:
                return Length(value: 1.8, unit: .solarRadii)
            case .F:
                return Length(value: 1.4, unit: .solarRadii)
            case .G:
                return Length(value: 1.15, unit: .solarRadii)
            case .K:
                return Length(value: 0.96, unit: .solarRadii)
            case .M:
                return Length(value: 0.7, unit: .solarRadii)
            }
        }
        func radius(_ percentile: Double) -> Length {
            return Length.measurement(at: percentile, of: minRadius...maxRadius)
        }

        var minLuminosity: Luminosity {
            switch self {
            case .O:
                return Luminosity(value: 30000, unit: .solarLuminosity)
            case .B:
                return Luminosity(value: 25, unit: .solarLuminosity)
            case .A:
                return Luminosity(value: 5, unit: .solarLuminosity)
            case .F:
                return Luminosity(value: 1.5, unit: .solarLuminosity)
            case .G:
                return Luminosity(value: 0.6, unit: .solarLuminosity)
            case .K:
                return Luminosity(value: 0.08, unit: .solarLuminosity)
            case .M:
                return Luminosity(value: 0.0, unit: .solarLuminosity)
            }
        }
        var maxLuminosity: Luminosity {
            switch self {
            case .O:
                return Luminosity(value: 1000000, unit: .solarLuminosity)
            case .B:
                return Luminosity(value: 30000, unit: .solarLuminosity)
            case .A:
                return Luminosity(value: 25, unit: .solarLuminosity)
            case .F:
                return Luminosity(value: 5, unit: .solarLuminosity)
            case .G:
                return Luminosity(value: 1.5, unit: .solarLuminosity)
            case .K:
                return Luminosity(value: 0.6, unit: .solarLuminosity)
            case .M:
                return Luminosity(value: 0.08, unit: .solarLuminosity)
            }
        }
        func luminosity(_ percentile: Double) -> Luminosity {
            return Luminosity.measurement(at: percentile, of: minLuminosity...maxLuminosity)
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
        
        func color(_ percentile: Double) -> UIColor {
            let ref = referenceColor
            return UIColor(hue: ref.hue, saturation: ref.saturation * CGFloat(1 - percentile + 0.5), brightness: 1, alpha: 1)
        }
        
        init(percentile: Double) {
            precondition(percentile >= 0 && percentile <= 1)
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
}
