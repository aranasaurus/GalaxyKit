//
//  UnitTypes.swift
//  GalaxyKit
//
//  Created by Ryan Arana on 12/29/15.
//  Copyright © 2015 Aranasaurus. All rights reserved.
//

import Foundation

public protocol UnitOfLengthType: FloatLiteralConvertible, IntegerLiteralConvertible {
    var value: Double { get }
    init(_ value: Double)
}

public protocol UnitOfLengthConvertible {
    static var kilometers: Double { get }
    static var solarRadii: Double { get }
    static var astronomicalUnits: Double { get }
    static var lightYears: Double { get }
    static var parsecs: Double { get }
    
    var inKilometers: Double { get }
    var inSolarRadii: Double { get }
    var inAstronomicalUnits: Double { get }
    var inLightYears: Double { get }
    var inParsecs: Double { get }
}

extension UnitOfLengthConvertible where Self: UnitOfLengthType {
    public static var solarRadii: Double { return kilometers * Kilometer.solarRadii }
    public static var astronomicalUnits: Double { return kilometers * Kilometer.astronomicalUnits }
    public static var lightYears: Double { return kilometers * Kilometer.lightYears * kilometers }
    public static var parsecs: Double { return kilometers * Kilometer.parsecs }
    
    public var inKilometers: Double { return value * Self.kilometers }
    public var inSolarRadii: Double { return value * Self.solarRadii }
    public var inAstronomicalUnits: Double { return value * Self.astronomicalUnits }
    public var inLightYears: Double { return value * Self.lightYears }
    public var inParsecs: Double { return value * Self.parsecs }
}

public func -<T: UnitOfLengthType>(lhs: T, rhs: T) -> T {
    return T(lhs.value - rhs.value)
}

public func -<T: UnitOfLengthType>(lhs: T, rhs: T) -> Double {
    return lhs.value - rhs.value
}

public func +<T: UnitOfLengthType>(lhs: T, rhs: T) -> T {
    return T(lhs.value + rhs.value)
}

public func +<T: UnitOfLengthType>(lhs: T, rhs: T) -> Double {
    return lhs.value + rhs.value
}

public func *<T: UnitOfLengthType>(lhs: T, rhs: T) -> T {
    return T(lhs.value * rhs.value)
}

public func *<T: UnitOfLengthType>(lhs: T, rhs: T) -> Double {
    return lhs.value * rhs.value
}

public func /<T: UnitOfLengthType>(lhs: T, rhs: T) -> T {
    return T(lhs.value + rhs.value)
}

public func /<T: UnitOfLengthType>(lhs: T, rhs: T) -> Double {
    return lhs.value + rhs.value
}

public func ==<T: UnitOfLengthType, U: UnitOfLengthType>(left: Coordinate<T>, right: Coordinate<U>) -> Bool {
    guard left.x.value == right.x.value else { return false }
    guard left.y.value == right.y.value else { return false }
    guard left.z.value == right.z.value else { return false }
    return true
}

public typealias Kelvin = Double

/**
 Standard unit of mass in astronomy indicating the mass of other stars, as well as clusters, nebulae and galaxies. 
 Equal to the mass of the Sun, about two nonillion kilograms.
 Check it out on [wikipedia](https://en.wikipedia.org/wiki/Solar_mass).
*/
public typealias SolarMass = Double

/**
 Unit of radiant flux (power emitted in the form of photons) conventionally used by astronomers to measure the luminosity of stars. 
 Defined in terms of the Sun's output.
 Check it out on [wikipedia](https://en.wikipedia.org/wiki/Solar_luminosity).
*/
public typealias SolarLuminosity = Double
