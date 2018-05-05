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
import GalaxyKit

extension Sector {
    public class Scene: SCNScene {
        let sector: Sector
        let node: Node
        let cameraNode: SCNNode

        init(sector: Sector, in galaxy: Galaxy? = nil) {
            self.sector = sector
            self.node = Node(sector: sector)
            self.cameraNode = SCNNode()

            let camera = SCNCamera()
            camera.automaticallyAdjustsZRange = true
            cameraNode.camera = camera

            super.init()

            rootNode.addChildNode(node)
            rootNode.addChildNode(cameraNode)

            cameraNode.position = SCNVector3(0, 0, 128)
            cameraNode.constraints = [SCNLookAtConstraint(target: node)]
            cameraNode.constraints = []

            guard let galaxy = galaxy else { return }

            generateNeighbor(-2, -1, in: galaxy)
            generateNeighbor(-2, 0, in: galaxy)
            generateNeighbor(-2, 1, in: galaxy)
            generateNeighbor(-1, -1, in: galaxy)
            generateNeighbor(-1, 0, in: galaxy)
            generateNeighbor(-1, 1, in: galaxy)

            generateNeighbor(0, -1, in: galaxy)
            generateNeighbor(0, 1, in: galaxy)

            generateNeighbor(1, -1, in: galaxy)
            generateNeighbor(1, 0, in: galaxy)
            generateNeighbor(1, 1, in: galaxy)
            generateNeighbor(2, -1, in: galaxy)
            generateNeighbor(2, 0, in: galaxy)
            generateNeighbor(2, 1, in: galaxy)
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func generateNeighbor(_ xMod: Int, _ yMod: Int, in galaxy: Galaxy) {
            let x = UInt(max(Int(sector.x) + xMod, 0))
            let y = UInt(max(Int(sector.y) + yMod, 0))
            if let neighbor = galaxy.sector(at: x, y) {
                let neighborNode = Node(sector: neighbor)
                neighborNode.position = SCNVector3(256 * xMod, 256 * yMod, 0)
                rootNode.addChildNode(neighborNode)
            }
        }
    }

    public class Node: SCNNode {
        let sector: Sector
        public init(sector: Sector) {
            self.sector = sector
            super.init()

            for star in sector.stars {
                let geom = Star.Geometry(star: star)
                let node = SCNNode(geometry: geom)
                node.position = SCNVector3.vectorFromCoordinate(star.coordinate)
                addChildNode(node)
            }
        }

        public required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

fileprivate extension SCNVector3 {
    static func vectorFromCoordinate(_ coord: Coordinate) -> SCNVector3 {
        return SCNVector3(x: Float(coord.x), y: Float(coord.y), z: Float(coord.z))
    }
}
