//
//  StarClassification.swift
//  GalaxyKit
//
//  Created by Ryan Arana on 1/5/16.
//  Copyright © 2016 Aranasaurus. All rights reserved.
//

import Foundation

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
        
        var tempRange: (min: Kelvin, max: Kelvin) {
            switch self {
            case .O:
                return (min: 30000, max: 52000)
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
        func temperature(_ percentile: Double) -> Kelvin {
            let range = tempRange
            return Kelvin(doubleFromRange(Double(range.min), max: Double(range.max), percentile: percentile))
        }
        
        var massRange: (min: SolarMass, max: SolarMass) {
            switch self {
            case .O:
                return (min: 16, max: 90)
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
        func mass(_ percentile: Double) -> SolarMass {
            let range = massRange
            return SolarMass(doubleFromRange(range.min, max: range.max, percentile: percentile))
        }
        
        var radiusRange: (min: SolarRadius, max: SolarRadius) {
            switch self {
            case .O:
                return (min: 6.6, max: 76)
            case .B:
                return (min: 1.8, max: 6.6)
            case .A:
                return (min: 1.4, max: 1.8)
            case .F:
                return (min: 1.15, max: 1.4)
            case .G:
                return (min: 0.96, max: 1.15)
            case .K:
                return (min: 0.7, max: 0.96)
            case .M:
                return (min: 0.33, max: 0.7)
            }
        }
        func radius(_ percentile: Double) -> SolarRadius {
            let range = radiusRange
            return SolarRadius(doubleFromRange(range.min, max: range.max, percentile: percentile))
        }
        
        var luminosityRange: (min: SolarLuminosity, max: SolarLuminosity) {
            switch self {
            case .O:
                return (min: 30000, max: 1000000)
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
                return (min: 0.0, max: 0.08)
            }
        }
        func luminosity(_ percentile: Double) -> SolarLuminosity {
            let range = luminosityRange
            return SolarLuminosity(doubleFromRange(range.min, max: range.max, percentile: percentile))
        }
        
        fileprivate func doubleFromRange(_ min: Double, max: Double, percentile: Double) -> Double {
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
        
        func color(_ percentile: Double) -> UIColor {
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
}
    
