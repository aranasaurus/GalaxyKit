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

    public subscript(x: UInt, y: UInt) -> Sector {
        let index = Int(x + y)
        guard continueGeneratingBeyondMap else {
            precondition(index < densityMap.count, "Sector coordinates out of bounds... sorry this Galaxy _does_ have limits")
            return Sector.init(x, y, numStars: densityMap[index])
        }
        
        if index < densityMap.count {
            return Sector(x, y, numStars: densityMap[index])
        }
        
        return Sector(x, y, numStars: UInt(self.densityDistribution.nextInt()))
    }
    
    public init(densityMap: [UInt] = [], continueGeneratingBeyondMap: Bool = false) {
        self.densityMap = densityMap
        self.continueGeneratingBeyondMap = continueGeneratingBeyondMap
    }
}
