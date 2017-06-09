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
    
    class Geometry: SCNSphere {
        
        init(star: Star) {
            super.init()
            
            configureForStar(star)
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func configureForStar(_ star: Star) {
            radius = CGFloat(star.radius.converted(to: .solarRadii).value)
            materials = [star.createMaterial()]
        }
    }
}
