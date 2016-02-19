//
//  LightYear.swift
//  GalaxyKit
//
//  Created by Ryan Arana on 2/18/16.
//  Copyright © 2016 Aranasaurus. All rights reserved.
//

import Foundation

public struct LightYear: UnitOfLengthType {
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

extension LightYear: UnitOfLengthConvertible {
    public static let kilometers = Double(1) / Kilometer.lightYears
}
