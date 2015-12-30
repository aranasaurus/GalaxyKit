//
//  SectorScene.swift
//  GalaxyKit
//
//  Created by Ryan Arana on 12/28/15.
//  Copyright © 2015 Aranasaurus. All rights reserved.
//

import Foundation
import SceneKit
import QuartzCore

private let angularDiameterOfSunFromEarth = 1.0/3600.0 * 1920.0
private let sunsPerWindow = 10.0
private let fov = angularDiameterOfSunFromEarth * sunsPerWindow // Show stars zoomed such that you could see x stars the size of our Sun side by side.
private let cameraDistance = Float(SolarRadius.solarRadius(au: AU(1)))

public extension Sector {
    public var scene: Scene {
        return Scene(sector: self)
    }
    
    public class Scene: SCNScene {
        public let sector: Sector
        public var focusIndex: Int = 0 {
            didSet {
                if focusIndex >= sector.systems.count {
                    focusIndex = focusIndex % sector.systems.count
                } else if focusIndex < 0 {
                    focusIndex = sector.systems.count - 1
                }
                
                guard oldValue != focusIndex || focusIndex == 0 else { return }
                
                let starNode = starNodes[focusIndex]
                SCNTransaction.begin()
                SCNTransaction.setAnimationDuration(2)
                let constraint = SCNLookAtConstraint(target: starNode)
                camera.constraints = [constraint]
                camera.position = SCNVector3(x: starNode.position.x, y: starNode.position.y, z: starNode.position.z + cameraDistance)
                camera.camera?.focalSize = CGFloat(sector.systems[focusIndex].star.radius * 2.0)
                SCNTransaction.commit()
            }
        }
        private let camera: SCNNode
        private var starNodes = [SCNNode]()
        
        public init(sector: Sector) {
            self.sector = sector
            let cam = SCNCamera()
            cam.automaticallyAdjustsZRange = true
            cam.xFov = fov
            cam.focalDistance = CGFloat(cameraDistance)
            self.camera = SCNNode()
            self.camera.camera = cam
            self.camera.position = SCNVector3(x: 0, y: 0, z: 0)
            
            super.init()
            
            for system in sector.systems {
                let geom = Star.Geometry(star: system.star)
                let node = SCNNode(geometry: geom)
                node.position = SCNVector3.vectorFromCoordinate(system.coordinate)
                rootNode.addChildNode(node)
                starNodes.append(node)
            }
            
            focusIndex = 0
            rootNode.addChildNode(camera)
        }

        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

extension SCNVector3 {
    static func vectorFromCoordinate(coord: Coordinate) -> SCNVector3 {
        return SCNVector3(x: Float(coord.x), y: Float(coord.y), z: Float(coord.z))
    }
}
