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
private let sunsPerWindow = 6.0
private let fov = angularDiameterOfSunFromEarth * sunsPerWindow // Show stars zoomed such that you could see x stars the size of our Sun side by side.
private let cameraDistance = Float(SolarRadius.solarRadius(au: AU(1)))

public extension Sector {
    public var scene: Scene {
        return Scene(sector: self)
    }
    
    public class Scene: SCNScene {
        public let sector: Sector
        private var focusedIndex: Int {
            didSet {
                if focusedIndex >= sortedStars.count {
                    focusedIndex = 0
                } else if focusedIndex < 0 {
                    focusedIndex = sortedStars.count - 1
                }
                
                SCNTransaction.begin()
                SCNTransaction.setAnimationDuration(2)
                let node = starNodes[focusedIndex]
                let constraint = SCNLookAtConstraint(target: node)
                camera.constraints = [constraint]
                camera.position = SCNVector3(x: node.position.x, y: node.position.y, z: node.position.z + cameraDistance)
                camera.camera?.focalSize = CGFloat(focusedStar.radius * 2.0)
                SCNTransaction.commit()
            }
        }
        public var focusedStar: Star {
            return sortedStars[focusedIndex]
        }
        private var sortedStars: [Star]
        private let sortByX: (a: Star, b: Star) -> Bool = { a, b in
            if a.coordinate.x == b.coordinate.x {
                if a.coordinate.z == b.coordinate.z {
                    return a.coordinate.y < b.coordinate.y
                }
                return a.coordinate.z < b.coordinate.z
            }
            return a.coordinate.x < b.coordinate.x
        }
        private let sortByDistanceToZero: (a: Star, b: Star) -> Bool = { a, b in
            return a.coordinate.quickDistanceTo(Coordinate.zero) < b.coordinate.quickDistanceTo(Coordinate.zero)
        }
        private let sortByMass: (a: Star, b: Star) -> Bool = { a, b in
            return a.mass > b.mass
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
            self.sortedStars = sector.stars.sort(sortByX)
            self.focusedIndex = sortedStars.count - 1
            
            super.init()
            
            for star in sortedStars {
                let geom = Star.Geometry(star: star)
                let node = SCNNode(geometry: geom)
                node.position = SCNVector3.vectorFromCoordinate(star.coordinate)
                rootNode.addChildNode(node)
                starNodes.append(node)
            }
            
            rootNode.addChildNode(camera)
            self.focusNextStar()
        }

        required public init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        public func focusNextStar() -> Star {
            focusedIndex += 1
            return focusedStar
        }
        
        public func focusPrevStar() -> Star {
            focusedIndex -= 1
            return focusedStar
        }
    }
}

extension SCNVector3 {
    static func vectorFromCoordinate(coord: Coordinate) -> SCNVector3 {
        return SCNVector3(x: Float(coord.x), y: Float(coord.y), z: Float(coord.z))
    }
}
