//
//  Kilometer.swift
//  GalaxyKit
//
//  Created by Ryan Arana on 2/18/16.
//  Copyright © 2016 Aranasaurus. All rights reserved.
//

import Foundation

public struct Kilometer: UnitOfLengthType {
    public let value: Double
    
    public init(_ value: Double) {
        self.value = value
    }
    
    public init(integerLiteral value: IntegerLiteralType) {
        self.value = Double(value)
    }
    
    public init(floatLiteral value: FloatLiteralType) {
        self.value = Double(value)
    }
}

extension Kilometer: UnitOfLengthConvertible {
    public static let kilometers = Double(1)
    public static let solarRadii = Double(1) / 6.957e5
    public static let astronomicalUnits = Double(1) / 1.495978707e8
    public static let lightYears = Double(1) / 9.4607304725808e12
    public static let parsecs = Double(1) / 3.0856776e13
    
    public var inKilometers: Double { return value }
    public var inSolarRadii: Double { return value * Kilometer.solarRadii }
    public var inAstronomicalUnits: Double { return value * Kilometer.astronomicalUnits }
    public var inLightYears: Double { return value * Kilometer.lightYears }
    public var inParsecs: Double { return value * Kilometer.parsecs }
}
