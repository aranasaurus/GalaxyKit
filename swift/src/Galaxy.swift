//
//  Galaxy.swift
//  GalaxyKit
//
//  Created by Ryan Arana on 1/5/16.
//  Copyright © 2016 Aranasaurus. All rights reserved.
//

import Foundation
import GameplayKit

public class Galaxy {
    let densityMap: [UInt]
    let sectorSize: Int
    
    public var continueGeneratingBeyondMap = false
    // All of this density stuff will only be used if `continueGeneratingBeyondMap` is `true` and a sector is requested outside the densityMap.
    public var minDensity = 1
    public var maxDensity = 64
    public lazy var densitySeed: UInt64 = UInt64(Date().timeIntervalSinceReferenceDate)
    public lazy var densityDistribution: GKGaussianDistribution = {
        let source = GKMersenneTwisterRandomSource(seed: self.densitySeed)
        let distribution = GKGaussianDistribution(randomSource: source, lowestValue: self.minDensity, highestValue: self.maxDensity)
        return distribution
    }()

    public init(densityMap: [UInt] = [], sectorSize: Int, continueGeneratingBeyondMap: Bool = false) {
        self.densityMap = densityMap
        self.sectorSize = sectorSize
        self.continueGeneratingBeyondMap = continueGeneratingBeyondMap
    }

    public subscript(x: UInt, y: UInt) -> Sector {
        guard let sector = sector(at: x, y) else {
            preconditionFailure("Sector coordinates out of bounds... sorry this Galaxy _does_ have limits")
        }

        return sector
    }
    
    public func sector(at x: UInt, _ y: UInt) -> Sector? {
        let index = Int(x + y)

        guard index >= densityMap.count else {
            return Sector(x, y, numStars: densityMap[index], sectorSize: sectorSize)
        }

        return continueGeneratingBeyondMap ? Sector(x, y, numStars: UInt(self.densityDistribution.nextInt()), sectorSize: sectorSize) : nil
    }
}
