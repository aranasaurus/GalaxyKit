//
//  StarNode.swift
//  GalaxyKit
//
//  Created by Ryan Arana on 12/28/15.
//  Copyright © 2015 Aranasaurus. All rights reserved.
//

import Foundation
import SceneKit

public extension Star {
    public class Geometry: SCNSphere {
        
        public init(star: Star) {
            super.init()
            
            configureForStar(star)
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public func configureForStar(star: Star) {
            radius = CGFloat(star.radius)
            firstMaterial?.diffuse.contents = star.color
        }
    }
}