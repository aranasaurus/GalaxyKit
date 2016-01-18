//
//  GalaxyScene.swift
//  GalaxyKit
//
//  Created by Ryan Arana on 1/11/16.
//  Copyright © 2016 Aranasaurus. All rights reserved.
//

import Foundation
import SceneKit

public class GalaxyScene: SCNScene {
    public var galaxy: Galaxy
    public var focusedSector: Sector
    public var focusedSectorNode: SectorNode {
        didSet {
            oldValue.removeFromParentNode()
            self.rootNode.addChildNode(focusedSectorNode)
            populateNearbySectorNodes()
        }
    }
    
    private let cameraNode: SCNNode
    private var camera: SCNCamera { return cameraNode.camera! }
    
    public init(galaxy: Galaxy) {
        self.galaxy = galaxy
        self.focusedSector = galaxy[10, 10]
        self.focusedSectorNode = SectorNode(focusedSector)
        self.cameraNode = SCNNode()
        self.cameraNode.camera = SCNCamera()
        super.init()
        
        self.rootNode.addChildNode(cameraNode)
        self.rootNode.addChildNode(focusedSectorNode)
        self.populateNearbySectorNodes()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func populateNearbySectorNodes() {
        let lx = focusedSector.x - 1
        let rx = focusedSector.x + 1
        let x = focusedSector.x
        let uy = focusedSector.y + 1
        let by = focusedSector.y - 1
        let y = focusedSector.y
        let hCoords = [lx, x, rx]
        let vCoords = [by, y, uy]
        var nearbyCoords = [[UInt]]()
        for h in hCoords {
            for v in vCoords {
                nearbyCoords.append([h, v])
            }
        }
        
        for coords in nearbyCoords {
            let sector = galaxy[coords[0], coords[1]]
            self.focusedSectorNode.addChildNode(SectorNode(sector))
        }
    }
}

public class SectorNode: SCNNode {
    public var sector: Sector
    
    public init(_ sector: Sector) {
        self.sector = sector
        super.init()
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}