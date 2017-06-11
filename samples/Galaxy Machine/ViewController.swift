//
//  ViewController.swift
//  Galaxy Machine
//
//  Created by Ryan Arana on 12/27/15.
//  Copyright © 2015 Aranasaurus. All rights reserved.
//

import UIKit
import SceneKit
import GalaxyKit

class ViewController: UIViewController {
    fileprivate var sceneView: SCNView! { return view as? SCNView }
    fileprivate var sectorScene: Sector.Scene? { return sceneView.scene as? Sector.Scene }

    @IBOutlet fileprivate var starLabel: UILabel!
    @IBOutlet fileprivate var sectorLabel: UILabel!
    @IBOutlet fileprivate var temperatureLabel: UILabel!
    @IBOutlet fileprivate var massLabel: UILabel!
    @IBOutlet fileprivate var radiusLabel: UILabel!
    @IBOutlet fileprivate var luminosityLabel: UILabel!

    fileprivate let galaxy: Galaxy

    fileprivate var currentStarIndex: Int? {
        didSet {
            guard let currentStar = currentStar else { return }
            starLabel.text = "\(currentStarIndex!): \(currentStar.description) (\(currentStar.coordinate))"

            temperatureLabel.text = "temp: \(formatter.string(from: currentStar.temperature))"
            luminosityLabel.text = "lumi: \(formatter.string(from: currentStar.luminosity))"
            massLabel.text = "mass: \(formatter.string(from: currentStar.mass))"
            radiusLabel.text = "rad:  \(formatter.string(from: currentStar.radius))"
            
            print("[\(currentStarIndex!)]\(currentStar.debugDescription)")
        }
    }
    fileprivate var currentStar: Star? {
        guard let index = currentStarIndex, index <= sectorScene?.sector.stars.endIndex ?? -1 else { return nil }
        return sectorScene?.sector.stars[index]
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
        self.galaxy = Galaxy(continueGeneratingBeyondMap: true)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.galaxy = Galaxy(continueGeneratingBeyondMap: true)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        galaxy.minDensity = 64
        galaxy.maxDensity = 64
        
        let sector = galaxy[37, 47] // 37, 47 has a B0 in it!
        sceneView.backgroundColor = .black
        sceneView.autoenablesDefaultLighting = true
        sceneView.allowsCameraControl = true
        sceneView.showsStatistics = true

        configure(for: sector)
    }
    
    func configure(for sector: Sector) {
        sectorLabel.text = "Sector [\(sector.x), \(sector.y)] (\(sector.stars.count) systems)"
        sceneView.scene = Sector.Scene(sector: sector, in: galaxy)
        currentStarIndex = sectorScene?.sector.stars.startIndex
    }
    
    @IBAction private func nextButtonTapped() {
        guard let stars = sectorScene?.sector.stars else { return }
        guard let currentIndex = currentStarIndex else {
            currentStarIndex = stars.startIndex
            return
        }

        var nextIndex = stars.index(after: currentIndex)
        if nextIndex == stars.endIndex {
            nextIndex = stars.startIndex
        }
        currentStarIndex = nextIndex
    }

    @IBAction private func prevButtonTapped() {
        guard let stars = sectorScene?.sector.stars else { return }
        guard let currentIndex = currentStarIndex else {
            currentStarIndex = stars.startIndex
            return
        }

        guard currentIndex != stars.startIndex else {
            currentStarIndex = stars.index(before: stars.endIndex)
            return
        }
        currentStarIndex = stars.index(before: currentIndex)
    }

    @IBAction private func changeSectorTapped() {
        let x = UInt(arc4random_uniform(64))
        let y = UInt(arc4random_uniform(64))
        configure(for: galaxy[x, y])
    }
}

