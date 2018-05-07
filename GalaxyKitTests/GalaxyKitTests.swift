//
//  GalaxyKitTests.swift
//  GalaxyKitTests
//
//  Created by Ryan Arana on 5/6/18.
//  Copyright © 2018 Aranasaurus. All rights reserved.
//

import XCTest

@testable import GalaxyKit

class GalaxyKitTests: XCTestCase {
    func testGalaxyDensityMap() {
        let galaxy = Galaxy(densityMap: [1,2,3], sectorSize: 256, continueGeneratingBeyondMap: false)
        XCTAssertEqual(galaxy.sector(at: 0, 0)?.stars.count, 1)
        XCTAssertEqual(galaxy.sector(at: 0, 1)?.stars.count, 2)
        XCTAssertEqual(galaxy.sector(at: 0, 2)?.stars.count, 3)

        XCTAssertNil(galaxy.sector(at: 0, 3))
    }
}
