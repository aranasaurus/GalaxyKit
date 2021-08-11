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
    enum Classification: Int {
        case o
        case b
        case a
        case f
        case g
        case k
        case m

        var minTemp: Temperature {
            switch self {
            case .o:
                return Temperature(value: 30000, unit: .kelvin)
            case .b:
                return Temperature(value: 10000, unit: .kelvin)
            case .a:
                return Temperature(value: 7500, unit: .kelvin)
            case .f:
                return Temperature(value: 6000, unit: .kelvin)
            case .g:
                return Temperature(value: 5200, unit: .kelvin)
            case .k:
                return Temperature(value: 3700, unit: .kelvin)
            case .m:
                return Temperature(value: 2400, unit: .kelvin)
            }
        }
        var maxTemp: Temperature {
            switch self {
            case .o:
                return Temperature(value: 52000, unit: .kelvin)
            case .b:
                return Temperature(value: 30000, unit: .kelvin)
            case .a:
                return Temperature(value: 10000, unit: .kelvin)
            case .f:
                return Temperature(value: 7500, unit: .kelvin)
            case .g:
                return Temperature(value: 6000, unit: .kelvin)
            case .k:
                return Temperature(value: 5200, unit: .kelvin)
            case .m:
                return Temperature(value: 3700, unit: .kelvin)
            }
        }
        func temperature(_ percentile: Double) -> Temperature {
            return Temperature.measurement(at: percentile, of: minTemp...maxTemp)
        }

        var minMass: Mass {
            switch self {
            case .o:
                return Mass(value: 16, unit: .solarMass)
            case .b:
                return Mass(value: 2, unit: .solarMass)
            case .a:
                return Mass(value: 1.4, unit: .solarMass)
            case .f:
                return Mass(value: 1.04, unit: .solarMass)
            case .g:
                return Mass(value: 0.8, unit: .solarMass)
            case .k:
                return Mass(value: 0.45, unit: .solarMass)
            case .m:
                return Mass(value: 0.08, unit: .solarMass)
            }
        }
        var maxMass: Mass {
            switch self {
            case .o:
                return Mass(value: 90, unit: .solarMass)
            case .b:
                return Mass(value: 16, unit: .solarMass)
            case .a:
                return Mass(value: 2.1, unit: .solarMass)
            case .f:
                return Mass(value: 1.4, unit: .solarMass)
            case .g:
                return Mass(value: 1.04, unit: .solarMass)
            case .k:
                return Mass(value: 0.8, unit: .solarMass)
            case .m:
                return Mass(value: 0.45, unit: .solarMass)
            }
        }
        func mass(_ percentile: Double) -> Mass {
            return Mass.measurement(at: percentile, of: minMass...maxMass)
        }

        var minRadius: Length {
            switch self {
            case .o:
                return Length(value: 6.6, unit: .solarRadii)
            case .b:
                return Length(value: 1.8, unit: .solarRadii)
            case .a:
                return Length(value: 1.4, unit: .solarRadii)
            case .f:
                return Length(value: 1.15, unit: .solarRadii)
            case .g:
                return Length(value: 0.96, unit: .solarRadii)
            case .k:
                return Length(value: 0.7, unit: .solarRadii)
            case .m:
                return Length(value: 0.33, unit: .solarRadii)
            }
        }
        var maxRadius: Length {
            switch self {
            case .o:
                return Length(value: 76, unit: .solarRadii)
            case .b:
                return Length(value: 6.6, unit: .solarRadii)
            case .a:
                return Length(value: 1.8, unit: .solarRadii)
            case .f:
                return Length(value: 1.4, unit: .solarRadii)
            case .g:
                return Length(value: 1.15, unit: .solarRadii)
            case .k:
                return Length(value: 0.96, unit: .solarRadii)
            case .m:
                return Length(value: 0.7, unit: .solarRadii)
            }
        }
        func radius(_ percentile: Double) -> Length {
            return Length.measurement(at: percentile, of: minRadius...maxRadius)
        }

        var minLuminosity: Luminosity {
            switch self {
            case .o:
                return Luminosity(value: 30000, unit: .solarLuminosity)
            case .b:
                return Luminosity(value: 25, unit: .solarLuminosity)
            case .a:
                return Luminosity(value: 5, unit: .solarLuminosity)
            case .f:
                return Luminosity(value: 1.5, unit: .solarLuminosity)
            case .g:
                return Luminosity(value: 0.6, unit: .solarLuminosity)
            case .k:
                return Luminosity(value: 0.08, unit: .solarLuminosity)
            case .m:
                return Luminosity(value: 0.0, unit: .solarLuminosity)
            }
        }
        var maxLuminosity: Luminosity {
            switch self {
            case .o:
                return Luminosity(value: 1000000, unit: .solarLuminosity)
            case .b:
                return Luminosity(value: 30000, unit: .solarLuminosity)
            case .a:
                return Luminosity(value: 25, unit: .solarLuminosity)
            case .f:
                return Luminosity(value: 5, unit: .solarLuminosity)
            case .g:
                return Luminosity(value: 1.5, unit: .solarLuminosity)
            case .k:
                return Luminosity(value: 0.6, unit: .solarLuminosity)
            case .m:
                return Luminosity(value: 0.08, unit: .solarLuminosity)
            }
        }
        func luminosity(_ percentile: Double) -> Luminosity {
            return Luminosity.measurement(at: percentile, of: minLuminosity...maxLuminosity)
        }
        
        var referenceColor: (hue: CGFloat, saturation: CGFloat) {
            switch self {
            case .o:
                return (hue: 0.639, saturation: 0.457)
            case .b:
                return (hue: 0.634, saturation: 0.398)
            case .a:
                return (hue: 0.628, saturation: 0.251)
            case .f:
                return (hue: 0.741, saturation: 0.035)
            case .g:
                return (hue: 0.089, saturation: 0.11)
            case .k:
                return (hue: 0.092, saturation: 0.35)
            case .m:
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
                self = .o
            case percentile where percentile >= 0.9987:
                self = .b
            case percentile where percentile >= 0.994:
                self = .a
            case percentile where percentile >= 0.97:
                self = .f
            case percentile where percentile >= 0.924:
                self = .g
            case percentile where percentile >= 0.879:
                self = .k
            default:
                self = .m
            }
        }
    }
}
