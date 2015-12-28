//
//  SystemViewController.swift
//  GalaxyKit
//
//  Created by Ryan Arana on 12/27/15.
//  Copyright © 2015 Aranasaurus. All rights reserved.
//

import Foundation
import SceneKit

public extension System {
    public var scene: Scene {
        return Scene(system: self)
    }
    
    public class Scene: SCNScene {
        public let system: System
        private var sphere: SCNSphere
        
        public init(system: System) {
            self.sphere = SCNSphere(radius: system.star.normalizedRadius)
            sphere.firstMaterial?.diffuse.contents = system.star.color
            sphere.radius = system.star.normalizedRadius
            self.system = system
            
            let node = SCNNode(geometry: sphere)
            
            super.init()
            
            rootNode.addChildNode(node)
        }

        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

