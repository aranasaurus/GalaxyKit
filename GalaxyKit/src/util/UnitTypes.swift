//
//  UnitTypes.swift
//  GalaxyKit
//
//  Created by Ryan Arana on 12/29/15.
//  Copyright © 2015 Aranasaurus. All rights reserved.
//

import Foundation

private let auPerParsec: Double = 648000 / M_PI
private let lyPerParsec: Double = 3.26156
private let auPerLightYear = auPerParsec / lyPerParsec
private let solarRadiiPerAU: Double = 215

public typealias Parsec = Double
public extension Parsec {
    public static func parsec(au au: AU) -> Parsec {
        return Parsec(au / auPerParsec)
    }
    
    public static func parsec(lightYears lightYears: LightYear) -> Parsec {
        return Parsec(lightYears / lyPerParsec)
    }
    
    public static func parsec(solarRadii solarRadii: SolarRadius) -> Parsec {
        let au = AU.au(solarRadii: solarRadii)
        return Parsec(au / auPerParsec)
    }
}

public typealias AU = Double
public extension AU {
    public static func au(parsec parsec: Parsec) -> AU {
        return AU(parsec * auPerParsec)
    }
    
    public static func au(lightYears lightYears: LightYear) -> AU {
        return AU(lightYears * auPerLightYear)
    }
    
    public static func au(solarRadii solarRadii: SolarRadius) -> AU {
        return AU(solarRadii / solarRadiiPerAU)
    }
}

public typealias LightYear = Double
public extension LightYear {
    public static func lightYear(au au: AU) -> LightYear {
        return LightYear(au / auPerLightYear)
    }
    
    public static func lightYear(parsec parsec: Parsec) -> LightYear {
        return LightYear(parsec * lyPerParsec)
    }
}

public typealias Kelvin = Double

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
public extension SolarRadius {
    public static func solarRadius(au au: AU) -> SolarRadius {
        return SolarRadius(au * solarRadiiPerAU)
    }
}

/**
 Unit of radiant flux (power emitted in the form of photons) conventionally used by astronomers to measure the luminosity of stars. 
 Defined in terms of the Sun's output.
 Check it out on [wikipedia](https://en.wikipedia.org/wiki/Solar_luminosity).
*/
public typealias SolarLuminosity = Double

