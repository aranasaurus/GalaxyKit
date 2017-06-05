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
        case o
        case b
        case a
        case f
        case g
        case k
        case m
        
        var tempRange: (min: Kelvin, max: Kelvin) {
            switch self {
            case .o:
                return (min: 30000, max: 52000)
            case .b:
                return (min: 10000, max: 30000)
            case .a:
                return (min: 7500, max: 10000)
            case .f:
                return (min: 6000, max: 7500)
            case .g:
                return (min: 5200, max: 6000)
            case .k:
                return (min: 3700, max: 5200)
            case .m:
                return (min: 2400, max: 3700)
            }
        }
        func temperature(_ percentile: Double) -> Kelvin {
            let range = tempRange
            return Kelvin(doubleFromRange(Double(range.min), max: Double(range.max), percentile: percentile))
        }
        
        var massRange: (min: SolarMass, max: SolarMass) {
            switch self {
            case .o:
                return (min: 16, max: 90)
            case .b:
                return (min: 2.1, max: 16)
            case .a:
                return (min: 1.4, max: 2.1)
            case .f:
                return (min: 1.04, max: 1.4)
            case .g:
                return (min: 0.8, max: 1.04)
            case .k:
                return (min: 0.45, max: 0.8)
            case .m:
                return (min: 0.08, max: 0.45)
            }
        }
        func mass(_ percentile: Double) -> SolarMass {
            let range = massRange
            return SolarMass(doubleFromRange(range.min, max: range.max, percentile: percentile))
        }
        
        var radiusRange: (min: SolarRadius, max: SolarRadius) {
            switch self {
            case .o:
                return (min: 6.6, max: 76)
            case .b:
                return (min: 1.8, max: 6.6)
            case .a:
                return (min: 1.4, max: 1.8)
            case .f:
                return (min: 1.15, max: 1.4)
            case .g:
                return (min: 0.96, max: 1.15)
            case .k:
                return (min: 0.7, max: 0.96)
            case .m:
                return (min: 0.33, max: 0.7)
            }
        }
        func radius(_ percentile: Double) -> SolarRadius {
            let range = radiusRange
            return SolarRadius(doubleFromRange(range.min, max: range.max, percentile: percentile))
        }
        
        var luminosityRange: (min: SolarLuminosity, max: SolarLuminosity) {
            switch self {
            case .o:
                return (min: 30000, max: 1000000)
            case .b:
                return (min: 25, max: 30000)
            case .a:
                return (min: 5, max: 25)
            case .f:
                return (min: 1.5, max: 5)
            case .g:
                return (min: 0.6, max: 1.5)
            case .k:
                return (min: 0.08, max: 0.6)
            case .m:
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
    
