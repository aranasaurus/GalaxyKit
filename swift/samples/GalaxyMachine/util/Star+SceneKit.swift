//
//  StarNode.swift
//  GalaxyKit
//
//  Created by Ryan Arana on 12/28/15.
//  Copyright © 2015 Aranasaurus. All rights reserved.
//

import Foundation
import SceneKit

import GalaxyKit

extension Star {
    func createMaterial() -> SCNMaterial {
        let m = SCNMaterial()
        
        m.locksAmbientWithDiffuse = true
        m.diffuse.contents = color
        
        m.cullMode = .back
        return m
    }

    func createNode(unit: UnitLength) -> SCNNode {
        return Node(star: self, unit: unit)
    }

    class Node: SCNNode {
        let star: Star
        
        init(star: Star, unit: UnitLength = .solarRadii) {
            self.star = star
            super.init()

            self.geometry = SCNSphere(radius: CGFloat(star.radius.in(unit)))
            self.geometry?.materials = [star.createMaterial()]
            self.position = SCNVector3(Float(star.coordinate.x), Float(star.coordinate.y), Float(star.coordinate.z))
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
