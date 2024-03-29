//
//  UnitTypes.swift
//  GalaxyKit
//
//  Created by Ryan Arana on 12/29/15.
//  Copyright © 2015 Aranasaurus. All rights reserved.
//

import Foundation

public typealias Length = Measurement<UnitLength>
public typealias Temperature = Measurement<UnitTemperature>
public typealias Mass = Measurement<UnitMass>
public typealias Luminosity = Measurement<UnitRadiantFlux>

private let solarRadiiPerAU: Double = 215

public extension Measurement {
    static func measurement(at percentage: Double, of range: ClosedRange<Measurement<UnitType>>) -> Measurement<UnitType> {
        let span = range.upperBound - range.lowerBound
        return range.lowerBound + (span * percentage)
    }
}
public extension Measurement where UnitType : Dimension {
    func `in`(_ otherUnit: UnitType) -> Double {
        return converted(to: otherUnit).value
    }
}

public extension UnitMass {
    /**
     Standard unit of mass in astronomy indicating the mass of other stars, as well as clusters, nebulae and galaxies.
     Equal to the mass of the Sun, about two nonillion kilograms.
     Check it out on [wikipedia](https://en.wikipedia.org/wiki/Solar_mass).
    */
    static var solarMass: UnitMass {
        return UnitMass(symbol: "M☉", converter: UnitConverterLinear(coefficient: 1.98855e30))
    }
}

public extension UnitLength {
    /**
     Standard unit of distance used to express the size of stars in astronomy.
     Equal to the current radius of the Sun (aka: 6.955 x 10^5).
     Check it out on [wikipedia](https://en.wikipedia.org/wiki/Solar_radius).
    */
    static var solarRadii: UnitLength {
        return UnitLength(symbol: "R☉", converter: UnitConverterLinear(coefficient: 6.957e8))
    }
}

public class UnitRadiantFlux: UnitPower {
    /**
     Unit of radiant flux (power emitted in the form of photons) conventionally used by astronomers to measure the luminosity of stars.
     Defined in terms of the Sun's output.
     Check it out on [wikipedia](https://en.wikipedia.org/wiki/Solar_luminosity).
    */
    public static let solarLuminosity: UnitRadiantFlux = UnitRadiantFlux(symbol: "L☉", converter: UnitConverterLinear(coefficient: 3.828e26))
}
