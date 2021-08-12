//
//  ViewController.swift
//  Galaxy Machine
//
//  Created by Ryan Arana on 12/27/15.
//  Copyright © 2015 Aranasaurus. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

import GalaxyKit

class ViewController: UIViewController {
    fileprivate var sceneView: ARSCNView! { return view as? ARSCNView }
    fileprivate var config: ARWorldTrackingConfiguration!

    @IBOutlet fileprivate var starLabel: UILabel!
    @IBOutlet fileprivate var sectorLabel: UILabel!
    @IBOutlet fileprivate var temperatureLabel: UILabel!
    @IBOutlet fileprivate var massLabel: UILabel!
    @IBOutlet fileprivate var radiusLabel: UILabel!
    @IBOutlet fileprivate var luminosityLabel: UILabel!

    fileprivate let galaxy: Galaxy

    fileprivate var currentStar: Star? {
        didSet {
            guard let currentStar = currentStar else { return }
            starLabel.text = "\(currentStar.description) (\(currentStar.coordinate))"

            temperatureLabel.text = "temp: \(formatter.string(from: currentStar.temperature))"
            luminosityLabel.text = "lumi: \(formatter.string(from: currentStar.luminosity))"
            massLabel.text = "mass: \(formatter.string(from: currentStar.mass))"
            radiusLabel.text = "rad:  \(formatter.string(from: currentStar.radius))"

            print("\(currentStar.debugDescription)")
        }
    }

    fileprivate var formatter: MeasurementFormatter = {
        let formatter = MeasurementFormatter()
        formatter.unitOptions = [.providedUnit]
        formatter.numberFormatter.usesSignificantDigits = true
        formatter.numberFormatter.minimumSignificantDigits = 4
        formatter.numberFormatter.maximumSignificantDigits = 5
        return formatter
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.galaxy = Galaxy(sectorSize: 256, continueGeneratingBeyondMap: true)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.galaxy = Galaxy(sectorSize: 256, continueGeneratingBeyondMap: true)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        galaxy.minDensity = 64
        galaxy.maxDensity = 64
        
        let sector = galaxy[37, 47] // 37, 47 has a B0 in it!
        sceneView.backgroundColor = .black
        sceneView.autoenablesDefaultLighting = true
        sceneView.showsStatistics = true

        config = ARWorldTrackingConfiguration()
        config.planeDetection = .horizontal
        sceneView.session.run(config)

        configure(for: sector)

        sceneView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(rec:))))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sceneView.session.run(config)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }

    @objc func handleTap(rec: UITapGestureRecognizer) {
        guard rec.state == .ended else { return }
        let location: CGPoint = rec.location(in: sceneView)
        let hits = sceneView.hitTest(location, options: nil)

        guard let node = hits.first(where: { $0.node is Star.Node })?.node as? Star.Node else { return }

        currentStar = node.star
    }
    
    func configure(for sector: Sector) {
        sectorLabel.text = "Sector [\(sector.x), \(sector.y)] (\(sector.stars.count) systems)"
        for star in sector.stars {
            sceneView.scene.rootNode.addChildNode(star.createNode(unit: .solarRadii))
        }
        currentStar = sector.stars.first
    }

    @IBAction private func changeSectorTapped() {
        for node in sceneView.scene.rootNode.childNodes {
            node.removeFromParentNode()
        }

        let x = UInt(arc4random_uniform(64))
        let y = UInt(arc4random_uniform(64))
        configure(for: galaxy[x, y])
    }
}

